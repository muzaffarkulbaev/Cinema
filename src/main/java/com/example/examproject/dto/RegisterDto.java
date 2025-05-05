package com.example.examproject.dto;

import jakarta.servlet.http.HttpServletRequest;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegisterDto {

    private String firstName;
    private String lastName;
    private String phoneNumber;
    private String email;
    private String password;
    private String passwordRepeat;
    private Integer attachmentId;
    private Integer otp;

    public RegisterDto(HttpServletRequest request){
        this.firstName = request.getParameter("firstName");
        this.lastName = request.getParameter("lastName");
        this.phoneNumber = request.getParameter("phone");
        this.email = request.getParameter("email");
        this.password = request.getParameter("password");
        this.passwordRepeat = request.getParameter("passwordRepeat");
    }

}
