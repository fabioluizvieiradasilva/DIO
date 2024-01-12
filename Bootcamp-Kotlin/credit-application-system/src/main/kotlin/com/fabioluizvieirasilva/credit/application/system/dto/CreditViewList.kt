package com.fabioluizvieirasilva.credit.application.system.dto

import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID

data class CreditViewList(
    val creditCode: UUID,
    val creditValue: BigDecimal,
    val numberOfInstallment: Int = 0,
) {
    constructor(credit: Credits): this (
        creditCode = credit.creditCode,
        creditValue = credit.creditValue,
        numberOfInstallment = credit.numberOfInstallment
    )
}
