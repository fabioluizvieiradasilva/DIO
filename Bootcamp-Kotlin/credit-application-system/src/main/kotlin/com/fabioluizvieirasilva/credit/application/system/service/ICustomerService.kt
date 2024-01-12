package com.fabioluizvieirasilva.credit.application.system.service

import com.fabioluizvieirasilva.credit.application.system.entity.Customer

interface ICustomerService {
    fun save(customer: Customer): Customer
    fun findById(id: Long): Customer
    fun delete(id: Long)

}