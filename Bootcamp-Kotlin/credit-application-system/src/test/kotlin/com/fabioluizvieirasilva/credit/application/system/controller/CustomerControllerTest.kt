package com.fabioluizvieirasilva.credit.application.system.controller

import com.fabioluizvieirasilva.credit.application.system.dto.CustomerDto
import com.fabioluizvieirasilva.credit.application.system.dto.CustomerUpdateDto
import com.fabioluizvieirasilva.credit.application.system.entity.Address
import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import com.fabioluizvieirasilva.credit.application.system.repository.CustomerRepository
import com.fasterxml.jackson.databind.ObjectMapper
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.http.MediaType
import org.springframework.test.context.ActiveProfiles
import org.springframework.test.context.ContextConfiguration
import org.springframework.test.web.servlet.MockMvc
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders
import org.springframework.test.web.servlet.result.MockMvcResultHandlers
import org.springframework.test.web.servlet.result.MockMvcResultMatchers
import java.math.BigDecimal

@SpringBootTest
@ActiveProfiles("test")
@AutoConfigureMockMvc
@ContextConfiguration
class CustomerControllerTest {

    @Autowired private lateinit var customerRepository: CustomerRepository
    @Autowired private lateinit var mockMvc: MockMvc
    @Autowired private lateinit var objectMapper: ObjectMapper

    companion object {
        const val URL: String = "/api/customers"
    }

    @BeforeEach fun setup() = customerRepository.deleteAll()
    @AfterEach fun tearDown() = customerRepository.deleteAll()

    @Test
    fun `should create a customer and return 201 status`(){
        //given
        val customerDto: CustomerDto = builderCustomerDto()
        val valueAsString: String = objectMapper.writeValueAsString(customerDto)

        mockMvc.perform(MockMvcRequestBuilders.post(URL)
            .contentType(MediaType.APPLICATION_JSON)
            .content(valueAsString))
            .andExpect(MockMvcResultMatchers.status().isCreated)
            .andExpect(MockMvcResultMatchers.jsonPath("$.firstName").value("Fabio Luiz"))
            .andDo(MockMvcResultHandlers.print())
    }

    @Test
    fun `should not save a customer with same CPF and return 409 status`(){
        //given
        customerRepository.save(builderCustomerDto().toEntity())
        val customerDto: CustomerDto = builderCustomerDto()
        val valueAsString: String = objectMapper.writeValueAsString(customerDto)

        //when
        //then
        mockMvc.perform(MockMvcRequestBuilders.post(URL)
            .contentType(MediaType.APPLICATION_JSON)
            .content(valueAsString))
            .andExpect(MockMvcResultMatchers.status().isConflict)
            .andExpect(MockMvcResultMatchers.jsonPath("$.title").value("Bad Request! Consult the documentation"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.timestamp").exists())
            .andExpect(MockMvcResultMatchers.jsonPath("$.status").value("409"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.exception").value("class org.springframework.dao.DataIntegrityViolationException"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)

    }

    @Test
    fun `should not save a customer with firstName empty and return 400 status`(){
        val customerDto: CustomerDto = builderCustomerDto(firstName = "")
        val valueAsString: String = objectMapper.writeValueAsString(customerDto)

        //when
        //then
        mockMvc.perform(MockMvcRequestBuilders.post(URL)
            .contentType(MediaType.APPLICATION_JSON)
            .content(valueAsString))
            .andExpect(MockMvcResultMatchers.status().isBadRequest)
            .andExpect(MockMvcResultMatchers.jsonPath("$.title").value("Bad Request! Consult the documentation"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.timestamp").exists())
            .andExpect(MockMvcResultMatchers.jsonPath("$.status").value("400"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.exception").value("class org.springframework.web.bind.MethodArgumentNotValidException"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)
    }

    @Test
    fun `should find customer by id and return 200 status`(){
        val customer: Customer = customerRepository.save(builderCustomerDto().toEntity())

        mockMvc.perform(MockMvcRequestBuilders.get("$URL/${customer.id}")
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(MockMvcResultMatchers.status().isOk)
            .andExpect(MockMvcResultMatchers.jsonPath("$.firstName").value("Fabio Luiz"))
    }

    @Test
    fun `should not find customer by id and return 400 status`(){
        val invalidId: Long = 2L

        mockMvc.perform(MockMvcRequestBuilders.get("$URL/${invalidId}")
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(MockMvcResultMatchers.status().isBadRequest)
            .andExpect(MockMvcResultMatchers.jsonPath("$.title").value("Bad Request! Consult the documentation"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.timestamp").exists())
            .andExpect(MockMvcResultMatchers.jsonPath("$.status").value("400"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.exception").value("class com.fabioluizvieirasilva.credit.application.system.exception.BusinessException"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)
    }

    @Test
    fun `should delete customer by id and return 204 status`(){
        //given
        val customer: Customer = customerRepository.save(builderCustomerDto().toEntity())

        mockMvc.perform(MockMvcRequestBuilders.delete("$URL/${customer.id}")
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(MockMvcResultMatchers.status().isNoContent)
    }

    @Test
    fun `should not delete customer by id and return 400 status`(){
        //given
        val invalidId: Long = 2L

        mockMvc.perform(MockMvcRequestBuilders.delete("$URL/${invalidId}")
            .accept(MediaType.APPLICATION_JSON))
            .andExpect(MockMvcResultMatchers.status().isBadRequest)
            .andExpect(MockMvcResultMatchers.jsonPath("$.title").value("Bad Request! Consult the documentation"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.timestamp").exists())
            .andExpect(MockMvcResultMatchers.jsonPath("$.status").value("400"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.exception").value("class com.fabioluizvieirasilva.credit.application.system.exception.BusinessException"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)
    }

    @Test
    fun `should updated customer and return 200 status`(){
        val customer: Customer = customerRepository.save(builderCustomerDto().toEntity())
        val customerUpdateDto: CustomerUpdateDto = builderCustomerUpDateDto()
        val valueAsString: String = objectMapper.writeValueAsString(customerUpdateDto)

        mockMvc.perform(MockMvcRequestBuilders.patch("$URL?customerId=${customer.id}")
            .contentType(MediaType.APPLICATION_JSON)
            .content(valueAsString))
            .andExpect(MockMvcResultMatchers.status().isOk)
            .andExpect(MockMvcResultMatchers.jsonPath("$.firstName").value("Fabio Luiz update"))

    }

    @Test
    fun `should not updated customer and return 400 status`(){
        val invalidId: Long = 2L
        val customerUpdateDto: CustomerUpdateDto = builderCustomerUpDateDto()
        val valueAsString: String = objectMapper.writeValueAsString(customerUpdateDto)

        mockMvc.perform(MockMvcRequestBuilders.patch("$URL?customerId=${invalidId}")
            .contentType(MediaType.APPLICATION_JSON)
            .content(valueAsString))
            .andExpect(MockMvcResultMatchers.status().isBadRequest)
            .andExpect(MockMvcResultMatchers.jsonPath("$.title").value("Bad Request! Consult the documentation"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.timestamp").exists())
            .andExpect(MockMvcResultMatchers.jsonPath("$.status").value("400"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.exception").value("class com.fabioluizvieirasilva.credit.application.system.exception.BusinessException"))
            .andExpect(MockMvcResultMatchers.jsonPath("$.details[*]").isNotEmpty)
    }

    private fun builderCustomerDto(
        firstName: String = "Fabio Luiz",
        lastName: String = "Vieira da Silva",
        cpf: String = "34381442040",
        email: String = "fabio@email.com",
        password: String = "213456",
        zipCode: String="23456879",
        street:String="Rua do Fabio, n147",
        id: Long = 1L,
        income: BigDecimal = BigDecimal.valueOf(1000.0)
    )= CustomerDto(
        firstName = firstName,
        lastName = lastName,
        cpf = cpf,
        email = email,
        password = password,
        zipCode = zipCode,
        street = street,
        income = income
    )

    private fun builderCustomerUpDateDto(
        firstName: String = "Fabio Luiz update",
        lastName: String = "Vieira da Silva update",
        zipCode: String="23456879",
        street: String="Rua do Fabio, n147 update",
        income: BigDecimal = BigDecimal.valueOf(5000.0)
    )= CustomerUpdateDto(
        firstName = firstName,
        lastName = lastName,
        zipCode = zipCode,
        street = street,
        income = income
    )
}