package com.kangmin.todolist.model.dto;

import lombok.Data;
import org.springframework.stereotype.Component;

import javax.validation.constraints.*;
import java.util.LinkedHashMap;

@Data
@Component
public class StudentDto {

    @NotNull
    @Size(min = 1, message = "is required")
    private String firstName;

    @NotNull
    @Size(min = 1, message = "is required")
    private String lastName;

    private String maxDegree;

    @Min(value = 0, message = "must be greater than or equals to zero")
    @Max(value = 99, message = "must be less than or equals to 99")
    private Integer yearOfExperience;

    private String email;
    private String homeCountry;

    @Pattern(regexp = "^[a-zA-Z0-9]{5}", message = "only allow 5 digits")
    private String zipCode;

    private LinkedHashMap<String, String> countryOptions;
    private String[] operationSystems;

    public StudentDto() {
        initCountryOption();
    }

    @Override
    public final String toString() {
        return "[StudentDTO: " + this.firstName + "\t" + this.lastName
                + ", from " + this.homeCountry + " and email is:" + this.email
                + " ]";
    }

    private void initCountryOption() {
        this.countryOptions = new LinkedHashMap<>();
        countryOptions.put("CH", "China");
        countryOptions.put("EN", "England");
        countryOptions.put("JP", "Japan");
        countryOptions.put("US", "United State");
    }
}
