package com.example.examproject.service;

import com.example.examproject.dto.ValidationError;

import java.util.List;

public class ValidationService {
    public static String getErrorMessage(List<ValidationError> errors,String field) {
        for (ValidationError error : errors) {
            if (error.getField().equals(field)) {
                return error.getMessage();
            }
        }
        return "";
    }

    public static String getInvalidValue(List<ValidationError> errors,String field) {
        for (ValidationError error : errors) {
            if (error.getField().equals(field)) {
                return error.getValue();
            }
        }
        return "";
    }

}
