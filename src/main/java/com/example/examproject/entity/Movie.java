package com.example.examproject.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Movie extends TemplateEntity{

    @Column(unique = true, nullable = false)
    private String name;

    @ManyToOne
    private Attachment attachment;

    private Integer duration;
}
