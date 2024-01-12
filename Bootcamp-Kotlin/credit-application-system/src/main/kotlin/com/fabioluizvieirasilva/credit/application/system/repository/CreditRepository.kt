package com.fabioluizvieirasilva.credit.application.system.repository

import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.UUID

@Repository
interface CreditRepository: JpaRepository<Credits, Long> {
    fun findByCreditCode(creditCode: UUID): Credits

    @Query(value = "select * from Credit where customer_id = ?1", nativeQuery = true)
    fun findAllByCustomerId(customerId: Long): List<Credits>
}