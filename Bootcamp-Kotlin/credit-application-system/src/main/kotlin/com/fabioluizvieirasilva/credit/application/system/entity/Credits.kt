package com.fabioluizvieirasilva.credit.application.system.entity

import com.fabioluizvieirasilva.credit.application.system.enummeration.Status
import jakarta.persistence.*
import java.math.BigDecimal
import java.time.LocalDate
import java.util.UUID

@Entity
@Table(name = "Credit")
data class Credits(
    @Column(nullable = false, unique = true)
    val creditCode: UUID = UUID.randomUUID(),
    @Column(nullable = false)
    val creditValue: BigDecimal = BigDecimal.ZERO,
    @Column(nullable = false)
    val dayFirstInstallment: LocalDate,
    @Column(nullable = false)
    val numberOfInstallment: Int = 0,
    @Column(nullable = false)
    @Enumerated
    val status: Status = Status.IN_PROGRESS,
    @ManyToOne()
    var customer: Customer? = null,
    @Column(nullable = false)
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null
)