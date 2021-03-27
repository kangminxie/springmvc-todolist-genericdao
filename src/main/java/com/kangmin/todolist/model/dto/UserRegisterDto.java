package com.kangmin.todolist.model.dto;

import lombok.Data;
import org.springframework.stereotype.Component;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Data
@Component
public final class UserRegisterDto {

    @NotNull
    @Size(min = 1, message = "first name is required")
    private String firstName;

    @NotNull
    @Size(min = 1, message = "last name is required")
    private String lastName;

    @NotNull
    @Size(min = 1, message = "username is required")
    private String username;

    @NotNull
    @Size(min = 1, message = "an valid email is required")
    private String email;

    private String role;

    @NotNull
    @Size(min = 1, message = "agree to User-Agreement is required")
    private String agree;

    @NotNull
    @Size(min = 1, message = "password is required")
    private String password;

    @NotNull
    @Size(min = 1, message = "password confirm is required")
    private String password2;
}
