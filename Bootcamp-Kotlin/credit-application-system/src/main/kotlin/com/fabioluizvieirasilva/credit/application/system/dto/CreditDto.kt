package com.fabioluizvieirasilva.credit.application.system.dto

import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import jakarta.validation.constraints.Future
import jakarta.validation.constraints.Max
import jakarta.validation.constraints.Min
import jakarta.validation.constraints.NotEmpty
import jakarta.validation.constraints.NotNull
import jakarta.validation.constraints.Size
import java.math.BigDecimal
import java.time.LocalDate

data class CreditDto(
    @field:NotNull(message = "Input invalid")
    val creditValue: BigDecimal,
    @field:Future(message = "Input invalid")
    val dayFirstInstallment: LocalDate,
    @field:Min(value = 1,  message = "Input invalid")
    @field:Max(value = 12, message = "Inout invalid")
    val numberOfInstallment: Int = 1,
    @field:NotNull(message = "Input invalid")
    val customerId: Long
) {

    fun toEntity(): Credits = Credits(
        creditValue = this.creditValue,
        dayFirstInstallment = this.dayFirstInstallment,
        numberOfInstallment = this.numberOfInstallment,
        customer = Customer(id = this.customerId)
    )
}
