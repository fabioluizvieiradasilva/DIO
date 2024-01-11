package com.fabioluizvieirasilva.credit.application.system.entity

import jakarta.persistence.Column
import jakarta.persistence.Embeddable

@Embeddable
data class Address(
    @Column(nullable = false)
    val zipCode: String,
    @Column(nullable = false)
    val street: String
)
