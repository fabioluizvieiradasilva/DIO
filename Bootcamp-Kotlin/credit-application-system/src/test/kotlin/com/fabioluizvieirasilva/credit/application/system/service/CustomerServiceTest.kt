package com.fabioluizvieirasilva.credit.application.system.service

import com.fabioluizvieirasilva.credit.application.system.entity.Address
import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import com.fabioluizvieirasilva.credit.application.system.exception.BusinessException
import com.fabioluizvieirasilva.credit.application.system.repository.CustomerRepository
import com.fabioluizvieirasilva.credit.application.system.service.impl.CustomerService
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.junit5.MockKExtension
import io.mockk.just
import io.mockk.runs
import io.mockk.verify
import org.assertj.core.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.test.context.ActiveProfiles
import java.math.BigDecimal
import java.util.*


@ActiveProfiles("test")
@ExtendWith(MockKExtension::class)
class CustomerServiceTest {

    @MockK lateinit var customerRepository: CustomerRepository
    @InjectMockKs lateinit var customerService: CustomerService

    @Test
    fun `should create customer`(){

        //given - dado
        val fakeCustomer: Customer = buildCustomer()
        every { customerRepository.save(any()) } returns fakeCustomer

        //when - quando
        val actual: Customer = customerService.save(fakeCustomer)

        //then - então

        //verificando se o objeto não é nulo
        Assertions.assertThat(actual).isNotNull()

        //verificando se o objeto actual é o mesmo do fakeCustomer
        Assertions.assertThat(actual).isSameAs(fakeCustomer)

        //verificando se de fato o customer está salvando somente uma vez no banco sem repetir
        verify(exactly = 1) { customerRepository.save(fakeCustomer) }

    }

    @Test
    fun `should find customer by id`(){

        //given
        val fakeId = Random().nextLong()
        val fakeCustomer: Customer = buildCustomer(id = fakeId)
        every { customerRepository.findById(fakeId) } returns Optional.of(fakeCustomer)

        //when
        val actual: Customer = customerService.findById(fakeId)

        //then
        Assertions.assertThat(actual).isNotNull
        Assertions.assertThat(actual).isExactlyInstanceOf(Customer::class.java)
        Assertions.assertThat(actual).isSameAs(fakeCustomer)
        verify(exactly = 1) { customerRepository.findById(fakeId) }

    }

    @Test
    fun `should not find customer invalid id and throw BusinessException`(){
        //given
        val fakeId = Random().nextLong()
        every { customerRepository.findById(fakeId) } returns Optional.empty()

        //when and then
        Assertions.assertThatExceptionOfType(BusinessException::class.java)
            .isThrownBy { customerService.findById(fakeId) }
            .withMessage("Id ${fakeId} not found")

        verify(exactly = 1) { customerRepository.findById(fakeId) }
    }

    @Test
    fun `should delete by id`(){
        //given
        val fakeId: Long = Random().nextLong()
        val fakeCustomer: Customer = buildCustomer(id = fakeId)
        every { customerRepository.findById(fakeId) } returns Optional.of(fakeCustomer)
        every { customerRepository.delete(fakeCustomer) } just runs

        //when
        customerService.delete(fakeId)

        //then
        verify(exactly = 1) { customerRepository.findById(fakeId) }
        verify(exactly = 1) { customerRepository.delete(fakeCustomer) }

    }

    private fun buildCustomer(
        firstName: String = "Fabio Luiz",
        lastName: String = "Vieira da Silva",
        cpf: String = "34381442040",
        email: String = "fabio@email.com",
        password: String = "213456",
        zipCode: String="23456879",
        street:String="Rua do Fabio, n147",
        id: Long = 1L,
        income: BigDecimal = BigDecimal.valueOf(1000.0)
    )=Customer(
        firstName = firstName,
        lastName = lastName,
        cpf = cpf,
        email = email,
        password = password,
        address = Address(
            zipCode = zipCode,
            street = street
        ),
        id = id,
        income = income
    )
}