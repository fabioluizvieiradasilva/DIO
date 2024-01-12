package com.fabioluizvieirasilva.credit.application.system.service

import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import java.util.UUID

interface ICreditService {
    fun save (credit: Credits): Credits
    fun findAllByCustomer(customerId: Long): List<Credits>
    fun findByCreditCode(customerId: Long,creditCode: UUID): Credits
}