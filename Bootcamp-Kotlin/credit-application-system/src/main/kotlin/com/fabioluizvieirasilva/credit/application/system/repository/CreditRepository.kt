package com.fabioluizvieirasilva.credit.application.system.repository

import com.fabioluizvieirasilva.credit.application.system.entity.Credits
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface CreditRepository: JpaRepository<Credits, Long>