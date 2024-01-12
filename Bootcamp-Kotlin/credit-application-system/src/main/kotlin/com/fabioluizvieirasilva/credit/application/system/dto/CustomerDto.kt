package com.fabioluizvieirasilva.credit.application.system.dto

import com.fabioluizvieirasilva.credit.application.system.entity.Address
import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import jakarta.validation.constraints.Email
import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.NotNull
import org.hibernate.validator.constraints.br.CPF
import java.math.BigDecimal


data class CustomerDto(

    @field:NotEmpty(message = "Input invalid")
    val firstName: String,
    @field:NotEmpty(message = "Input invalid")
    val lastName: String,
    @field:NotEmpty(message = "Input invalid")
    @field:CPF(message = "CPF invalid")
    val cpf: String,
    @field:NotEmpty(message = "Input invalid")
    @field:Email(message = "Email invalid")
    val email: String,
    @field:NotEmpty(message = "Input invalid")
    val password: String,
    @field:NotEmpty(message = "Input invalid")
    val zipCode: String,
    @field:NotEmpty(message = "Input invalid")
    val street: String,
    @field:NotNull(message = "Input invalid")
    val income: BigDecimal

) {

    fun toEntity(): Customer = Customer(
        firstName = this.firstName,
        lastName = this.lastName,
        cpf = this.cpf,
        email = this.email,
        password = this.password,
        address = Address(
            this.zipCode,
            this.street
        ),
        income = this.income,
    )
}
