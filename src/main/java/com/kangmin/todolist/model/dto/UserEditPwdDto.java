package com.kangmin.todolist.model.dto;

import lombok.Data;
import org.springframework.stereotype.Component;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Data
@Component
public final class UserEditPwdDto {

    @NotNull
    @Size(min = 1, message = "password is required")
    private String password;

    @NotNull
    @Size(min = 1, message = "password confirm is required")
    private String newPassword;

    @NotNull
    @Size(min = 1, message = "password confirm is required")
    private String newPassword2;
}
