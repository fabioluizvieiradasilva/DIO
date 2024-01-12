package com.fabioluizvieirasilva.credit.application.system.dto

import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import java.math.BigDecimal
import java.time.LocalDate

data class CreditDto(
    val creditValue: BigDecimal,
    val dayFirstInstallment: LocalDate,
    val numberOfInstallment: Int = 0,
    val customerId: Long
) {

    fun toEntity(): Credits = Credits(
        creditValue = this.creditValue,
        dayFirstInstallment = this.dayFirstInstallment,
        numberOfInstallment = this.numberOfInstallment,
        customer = Customer(id = this.customerId)
    )
}
