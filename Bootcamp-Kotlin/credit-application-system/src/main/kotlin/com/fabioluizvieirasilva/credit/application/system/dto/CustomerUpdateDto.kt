package com.fabioluizvieirasilva.credit.application.system.dto

import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.NotNull
import java.math.BigDecimal

data class CustomerUpdateDto(

    @field:NotEmpty(message = "Input invalid")
    val firstName: String,
    @field:NotEmpty(message = "Input invalid")
    val lastName: String,
    @field:NotEmpty(message = "Input invalid")
    val zipCode: String,
    @field:NotEmpty(message = "Input invalid")
    val street: String,
    @field:NotNull(message = "Input invalid")
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
