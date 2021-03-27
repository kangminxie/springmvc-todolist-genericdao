package com.kangmin.todolist.model.dto;

import com.kangmin.todolist.model.entity.User;
import lombok.Data;
import org.springframework.stereotype.Component;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.LinkedHashMap;

@Data
@Component
public final class UserEditInfoDto {

    private LinkedHashMap<String, String> stateOptions;
    private LinkedHashMap<String, String> countryOptions;

    public UserEditInfoDto() {
        initUserStateOption();
        initUserCountryOption();
    }

    public UserEditInfoDto(final User u) {
        initUserStateOption();
        initUserCountryOption();
        this.setUsername(u.getUsername());
        this.setFirstName(u.getFirstName());
        this.setLastName(u.getLastName());
        this.setEmail(u.getEmail());
        this.setAddressLine1(u.getAddressLine1());
        this.setAddressLine2(u.getAddressLine2());
        this.setCity(u.getCity());
        this.setState(u.getState());
        this.setCountry(u.getCountry());
        this.setZipCode(u.getZipCode());
        this.setPhoneNumber(u.getPhoneNumber());
    }

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

    private String addressLine1;
    private String addressLine2;
    private String city;
    private String state;
    private String country;

//    @Nullable
//    @Pattern(regexp = "^[a-zA-Z0-9]{5}", message = "only allow 5 digits")
    private String zipCode;

//    @Nullable
//    @Pattern(regexp = "^[0-9]{3}-[0-9]{3}-[0-9]{4,5}", message = "only allow 10-11 digits")
    private String phoneNumber;

    private void initUserStateOption() {
        this.stateOptions = new LinkedHashMap<>();
        stateOptions.put("Unknown", "Unknown");
        stateOptions.put("PA", "PA");
        stateOptions.put("SC", "SC");
        stateOptions.put("TX", "TX");
    }

    private void initUserCountryOption() {
        this.countryOptions = new LinkedHashMap<>();
        countryOptions.put("Unknown", "Unknown");
        countryOptions.put("China", "China");
        countryOptions.put("England", "England");
        countryOptions.put("Japan", "Japan");
        countryOptions.put("United State", "United State");
    }
}
