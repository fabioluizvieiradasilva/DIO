package com.fabioluizvieirasilva.credit.application.system.service

import com.fabioluizvieirasilva.credit.application.system.entity.Address
import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import com.fabioluizvieirasilva.credit.application.system.enummeration.Status
import com.fabioluizvieirasilva.credit.application.system.repository.CreditRepository
import com.fabioluizvieirasilva.credit.application.system.service.impl.CreditService
import com.fabioluizvieirasilva.credit.application.system.service.impl.CustomerService
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import io.mockk.verify
import org.assertj.core.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.test.context.ActiveProfiles
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID

@ActiveProfiles("test")
@ExtendWith(MockKExtension::class)
class CreditServiceTest {

    @MockK lateinit var creditRepository: CreditRepository
    @MockK lateinit var customerService: CustomerService
    @InjectMockKs lateinit var creditService: CreditService

    @Test
    fun `should create credit`(){

        //given
        val fakeCredits: Credits = buildCredit()
        val customerId: Long = 1L

        every { customerService.findById(customerId) } returns fakeCredits.customer!!
        every { creditRepository.save(any()) } returns fakeCredits

        //when
        val actual: Credits = creditService.save(fakeCredits)

        //then
        verify(exactly = 1) { customerService.findById(customerId) }
        verify(exactly = 1) { creditRepository.save(fakeCredits) }

        Assertions.assertThat(actual).isNotNull()
        Assertions.assertThat(actual).isSameAs(fakeCredits)
    }

    @Test
    fun `should find all credits by customer`(){
        val customerId: Long = 1L
        val listCredits: List<Credits> = listOf(buildCredit(), buildCredit(), buildCredit())

        every { creditRepository.findAllByCustomerId(customerId) } returns listCredits

        val actual: List<Credits> = creditService.findAllByCustomer(customerId)

        Assertions.assertThat(actual).isNotNull
        Assertions.assertThat(actual).isNotEmpty
        Assertions.assertThat(actual).isSameAs(listCredits)

        verify(exactly = 1){creditRepository.findAllByCustomerId(customerId)}
    }

    private fun buildCredit(
        creditCode: UUID = UUID.randomUUID(),
        creditValue: BigDecimal = BigDecimal.valueOf(1000.00),
        dayFirstInstallment: LocalDate = LocalDate.now(),
        numberOfInstallment: Int = 10,
        status: Status = Status.IN_PROGRESS,
        customer: Customer = Customer(
            firstName = "Fabio Luiz",
            lastName = "Vieira da Silva",
            cpf = "34381442040",
            email = "fabio@email.com",
            password = "213456",
            address = Address(
                zipCode="23456879",
                street="Rua do Fabio, n147",
            ),
            id = 1L,
            income = BigDecimal.valueOf(1000.0),
            credits = mutableListOf()
        ),
        id: Long = 1L


    ) = Credits(
        creditCode = creditCode,
        creditValue = creditValue,
        dayFirstInstallment = dayFirstInstallment,
        numberOfInstallment = numberOfInstallment,
        status = status,
        customer = customer,
        id = id
    )


}