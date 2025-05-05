package com.example.examproject.dto;

import com.example.examproject.entity.Attachment;
import com.example.examproject.entity.Hall;
import com.example.examproject.entity.Movie;

public record SessionDto(Movie movie,String time, Integer price, Hall hall) {
}
