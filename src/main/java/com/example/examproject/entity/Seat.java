package com.example.examproject.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
@Table(name = "seats")
public class Seat extends TemplateEntity{

    private Boolean isBooked;

    @ManyToOne
    private Hall hall;
}
