package com.fabioluizvieirasilva.credit.application.system.service.impl

import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import com.fabioluizvieirasilva.credit.application.system.exception.BusinessException
import com.fabioluizvieirasilva.credit.application.system.repository.CreditRepository
import com.fabioluizvieirasilva.credit.application.system.service.ICreditService
import org.springframework.stereotype.Service
import java.util.*

@Service
class CreditService(
    private val creditRepository: CreditRepository,
    private val customerService: CustomerService
): ICreditService {
    override fun save(credit: Credits): Credits {
        credit.apply {
            customer = customerService.findById(credit.customer?.id!!)
        }
        return this.creditRepository.save(credit)
    }

    override fun findAllByCustomer(customerId: Long): List<Credits> {
        return this.creditRepository.findAllByCustomerId(customerId)
    }


    override fun findByCreditCode(customerId: Long, creditCode: UUID): Credits {
        val credit: Credits = this.creditRepository.findByCreditCode(creditCode)
            ?: throw BusinessException("CretidCode ${creditCode} not found")
        return if (credit.customer?.id!! == customerId) credit else throw IllegalArgumentException("Contact Admin")
    }
}