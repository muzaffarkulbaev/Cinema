package com.example.examproject.dto;

import com.example.examproject.entity.Session;

import java.util.List;

public record SessionTotalPage(List<Session> sessions, int totalPage) {
}
