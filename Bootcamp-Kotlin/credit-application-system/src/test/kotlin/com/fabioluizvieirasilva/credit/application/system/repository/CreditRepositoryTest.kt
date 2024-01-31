package com.fabioluizvieirasilva.credit.application.system.repository

import com.fabioluizvieirasilva.credit.application.system.entity.Address
import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import org.assertj.core.api.Assertions
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager
import org.springframework.test.context.ActiveProfiles
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID

@ActiveProfiles("test")
@DataJpaTest
@AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE)
class CreditRepositoryTest {
    @Autowired lateinit var creditRepository: CreditRepository
    @Autowired lateinit var testEntityManager: TestEntityManager

    private lateinit var customer: Customer
    private lateinit var credit1: Credits
    private lateinit var credit2: Credits
    @BeforeEach fun setup(){
        customer = testEntityManager.persist(buildCustomer())
        credit1 = testEntityManager.persist(buildCredit(customer = customer))
        credit2 = testEntityManager.persist(buildCredit(customer = customer))
    }

    @Test
    fun `should find credit by credit code`(){
        //given
        val creditCode1 = UUID.fromString("59b60d58-5ca3-41c0-9ce7-2ad46e6172ac")
        val creditCode2 = UUID.fromString("a884e091-356e-4017-bb0c-715be2abec06")

        credit1.creditCode = creditCode1
        credit2.creditCode = creditCode2

        //when
        val fakeCredit1: Credits = creditRepository.findByCreditCode(creditCode1)!!
        val fakeCredit2: Credits = creditRepository.findByCreditCode(creditCode2)!!

        //then
        Assertions.assertThat(fakeCredit1).isNotNull
        Assertions.assertThat(fakeCredit2).isNotNull

        Assertions.assertThat(fakeCredit1).isSameAs(credit1)
        Assertions.assertThat(fakeCredit2).isSameAs(credit2)

    }

    @Test
    fun `should find all credits by customer id`(){
        //given
        val customerId: Long = 1L

        //when
        val creditList: List<Credits> = creditRepository.findAllByCustomerId(customerId)

        //then
        Assertions.assertThat(creditList).isNotEmpty
        Assertions.assertThat(creditList.size).isEqualTo(2)
        Assertions.assertThat(creditList).contains(credit1, credit2)
    }

    private fun buildCredit(

        creditValue: BigDecimal = BigDecimal.valueOf(1000.00),
        dayFirstInstallment: LocalDate = LocalDate.now(),
        numberOfInstallment: Int = 10,
        customer: Customer
    ) = Credits(
        creditValue = creditValue,
        dayFirstInstallment = dayFirstInstallment,
        numberOfInstallment = numberOfInstallment,
        customer = customer
    )

    private fun buildCustomer(
        firstName: String = "Fabio Luiz",
        lastName: String = "Vieira da Silva",
        cpf: String = "34381442040",
        email: String = "fabio@email.com",
        password: String = "213456",
        zipCode: String="23456879",
        street:String="Rua do Fabio, n147",
        income: BigDecimal = BigDecimal.valueOf(1000.0)
    )= Customer(
        firstName = firstName,
        lastName = lastName,
        cpf = cpf,
        email = email,
        password = password,
        address = Address(
            zipCode = zipCode,
            street = street
        ),
        income = income
    )
}