package com.fabioluizvieirasilva.credit.application.system.entity

import jakarta.persistence.*
import java.math.BigDecimal

@Entity
@Table(name = "Customer")
data class Customer(
    @Column(nullable = false)
    var firstName: String = "",
    @Column(nullable = false)
    var lastName: String = "",
    @Column(nullable = false, unique = true)
    var cpf: String = "",
    @Column(nullable = false, unique = true)
    var email: String = "",
    @Column(nullable = false)
    var password: String = "",
    @Column(nullable = false)
    @Embedded
    var address: Address = Address(),
    @Column(nullable = false)
    @OneToMany(fetch = FetchType.LAZY, cascade = arrayOf(CascadeType.REMOVE, CascadeType.PERSIST),
        mappedBy = "customer")
    var credits: List<Credits> = mutableListOf(),
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,
    @Column(nullable = false)
    var income: BigDecimal = BigDecimal.ZERO
)
