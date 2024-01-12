package com.fabioluizvieirasilva.credit.application.system.controller

import com.fabioluizvieirasilva.credit.application.system.dto.CreditDto
import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import com.fabioluizvieirasilva.credit.application.system.service.impl.CreditService
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/credits")
class CreditController(
    private val creditService: CreditService
) {

    @PostMapping
    fun saveCredit(@RequestBody creditDto: CreditDto): String{
        val credit: Credits = this.creditService.save(creditDto.toEntity())
        return "Credit ${credit.creditCode} for customer ${credit.customer?.firstName} was saved!"
    }
}