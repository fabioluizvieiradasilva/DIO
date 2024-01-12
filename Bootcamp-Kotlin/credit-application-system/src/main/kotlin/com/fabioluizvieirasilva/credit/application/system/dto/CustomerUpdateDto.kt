package com.fabioluizvieirasilva.credit.application.system.dto

import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import java.math.BigDecimal

data class CustomerUpdateDto(
    val firstName: String,
    val lastName: String,
    val zipCode: String,
    val street: String,
    var income: BigDecimal
) {

    fun toEntity(customer: Customer): Customer{
        customer.firstName = this.firstName
        customer.lastName = this.lastName
        customer.address.zipCode = this.zipCode
        customer.address.street = this.street
        customer.income = this.income

        return customer
    }


}
