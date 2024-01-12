package com.fabioluizvieirasilva.credit.application.system.service.impl

import com.fabioluizvieirasilva.credit.application.system.entity.Customer
import com.fabioluizvieirasilva.credit.application.system.repository.CustomerRepository
import com.fabioluizvieirasilva.credit.application.system.service.ICustomerService
import org.springframework.stereotype.Service

@Service
class CustomerService(
    private val customerRepository: CustomerRepository
): ICustomerService {
    override fun save(customer: Customer): Customer {
        return this.customerRepository.save(customer)
    }

    override fun findById(id: Long): Customer {
        return this.customerRepository.findById(id).orElseThrow{
            throw RuntimeException("Id ${id} not found")
        }
    }

    override fun delete(id: Long) {
        this.customerRepository.deleteById(id)
    }
}