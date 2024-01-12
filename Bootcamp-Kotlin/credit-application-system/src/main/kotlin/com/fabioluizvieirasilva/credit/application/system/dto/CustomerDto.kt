package com.fabioluizvieirasilva.credit.application.system.dto

import com.fabioluizvieirasilva.credit.application.system.entity.Address
import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import java.math.BigDecimal


data class CustomerDto(

    val firstName: String,
    val lastName: String,
    val cpf: String,
    val email: String,
    val password: String,
    val address: Address,
    val zipCode: String,
    val street: String,
    val income: BigDecimal

) {

    fun toEntity(): Customer = Customer(
        firstName = this.firstName,
        lastName = this.lastName,
        cpf = this.cpf,
        email = this.email,
        password = this.password,
        address = Address(
            zipCode = this.zipCode,
            street = this.street
        ),
        income = this.income,
    )
}
