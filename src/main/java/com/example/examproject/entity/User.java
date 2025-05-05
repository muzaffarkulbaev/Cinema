package com.example.examproject.entity;

import com.example.examproject.dto.RegisterDto;
import com.example.examproject.entity.enums.Role;
import jakarta.persistence.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.*;
import lombok.experimental.SuperBuilder;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Objects;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
@Table(name = "users")
public class User extends TemplateEntity{

    @Size(min = 3, max = 50)
    @NotBlank(message = "Enter firstName")
    @Column(nullable = false)
    private String firstName;

    @Size(min = 3, max = 50)
    @NotBlank(message = "Enter lastName")
    @Column(nullable = false)
    private String lastName;

    @NotBlank(message = "Enter email")
    @Email(message = "Incorrect email")
    @Column(unique = true, nullable = false)
    private String email;

    @Size(min = 3, max = 50)
    @NotBlank(message = "Enter password")
    @Column(nullable = false)
    private String password;

    @Size(min = 9, max = 50)
    @NotBlank(message = "Enter phone")
    @Column(nullable = false)
    private String phoneNumber;

    private Boolean isVerified = false;

    @OneToMany
    private List<Ticket> ticket;

    @Enumerated(EnumType.STRING)
    private Role role;


    @ManyToOne
    private Attachment attachment;

    public User(RegisterDto registerDto){
        this.firstName = registerDto.getFirstName();
        this.lastName = registerDto.getLastName();
        this.email = registerDto.getEmail();
        this.password = registerDto.getPassword();
        this.phoneNumber = registerDto.getPhoneNumber();
        this.isVerified = true;
        this.role = Role.USER;
    }

    public User(HttpServletRequest request){
        this.firstName = Objects.requireNonNullElse(request.getParameter("firstName"),"");
        this.lastName = Objects.requireNonNullElse(request.getParameter("lastName"),"");
        this.phoneNumber = Objects.requireNonNullElse(request.getParameter("phone"),"");
        this.email = Objects.requireNonNullElse(request.getParameter("email"),"");
        this.password = Objects.requireNonNullElse(request.getParameter("password"),"");
    }

    public User(ResultSet resultSet) throws SQLException {
        this.id = resultSet.getInt("id");
        this.email = resultSet.getString("email");
        this.password = resultSet.getString("password");
        this.firstName = resultSet.getString("first_name");
        this.lastName = resultSet.getString("last_name");
        this.isVerified = resultSet.getBoolean("verified");
    }

    public String getFullName(){
        return this.firstName + " " + this.lastName;
    }

    public String toString(){
        return this.firstName + " " + this.lastName + " " + this.email + " " + this.role + " " + this.isVerified + " " + this.phoneNumber;
    }

}
