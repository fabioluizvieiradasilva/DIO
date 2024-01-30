package com.fabioluizvieirasilva.credit.application.system.service

import com.fabioluizvieirasilva.credit.application.system.entity.Address
import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import com.fabioluizvieirasilva.credit.application.system.enummeration.Status
import com.fabioluizvieirasilva.credit.application.system.exception.BusinessException
import com.fabioluizvieirasilva.credit.application.system.repository.CreditRepository
import com.fabioluizvieirasilva.credit.application.system.service.impl.CreditService
import com.fabioluizvieirasilva.credit.application.system.service.impl.CustomerService
import io.mockk.core.ValueClassSupport.boxedValue
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import io.mockk.verify
import org.assertj.core.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.mockito.internal.matchers.Null
import org.springframework.test.context.ActiveProfiles
import java.math.BigDecimal
import java.time.LocalDate
import java.util.Optional
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

    @Test
    fun `should return credit for a valid customer and credit code`(){
        //given
        val customerId: Long = 1L
        val creditCode: UUID = UUID.randomUUID()
        val credit: Credits = buildCredit( customer = Customer(id = customerId))

        every { creditRepository.findByCreditCode(creditCode) } returns credit

        //when
        val actual: Credits = creditService.findByCreditCode(customerId, creditCode)

        //then
        Assertions.assertThat(actual).isNotNull
        Assertions.assertThat(actual).isSameAs(credit)

        verify(exactly = 1){creditRepository.findByCreditCode(creditCode)}
    }

    @Test
    fun`should throw BusinessException for invalid credit code`(){
        //given
        val customerId: Long = 1L
        val invalidCreditCode: UUID = UUID.randomUUID()

        every { creditRepository.findByCreditCode(invalidCreditCode) } returns null

        //when

        //then
        Assertions.assertThatThrownBy{creditService.findByCreditCode(customerId, invalidCreditCode)}
            .isInstanceOf(BusinessException::class.java)
            .hasMessage("CretidCode ${invalidCreditCode} not found")

        verify(exactly = 1){creditRepository.findByCreditCode(invalidCreditCode)}
    }

    @Test
    fun `should throw IllegalArgumentException for different customer ID`(){
        //given
        val customerId: Long = 1L
        val creditCode: UUID = UUID.randomUUID()
        val credit: Credits = buildCredit(customer = Customer(id = 2L))

        every { creditRepository.findByCreditCode(creditCode) } returns credit

        //when

        //then
        Assertions.assertThatThrownBy { creditService.findByCreditCode(customerId, creditCode) }
            .isInstanceOf(IllegalArgumentException::class.java)
            .hasMessage("Contact Admin")

        verify(exactly = 1){creditRepository.findByCreditCode(creditCode)}
    }

    companion object{
        private fun buildCredit(

            creditValue: BigDecimal = BigDecimal.valueOf(1000.00),
            dayFirstInstallment: LocalDate = LocalDate.now(),
            numberOfInstallment: Int = 10,
            customer: Customer = CustomerServiceTest.buildCustomer()
        ) = Credits(
            creditValue = creditValue,
            dayFirstInstallment = dayFirstInstallment,
            numberOfInstallment = numberOfInstallment,
            customer = customer

        )

    }


}