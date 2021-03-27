package com.kangmin.todolist.model.entity;

import com.kangmin.todolist.model.dto.UserEditInfoDto;
import org.genericdao.PrimaryKey;

import java.util.Date;

@PrimaryKey("id")
public class User {

    private long id;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private String email;
    private String role;
    private Date createdDay;
    private Date lastActiveDay;
    private boolean disabled;

    public final long getId() {
        return id;
    }

    public final String getIdStr() {
        return String.valueOf(id);
    }

    public final String getUsername() {
        return username;
    }

    public final String getPassword() {
        return password;
    }

    public final String getFirstName() {
        return firstName;
    }

    public final String getLastName() {
        return lastName;
    }

    public final String getEmail() {
        return email;
    }

    public final String getRole() {
        return role;
    }

    public final Date getCreatedDay() {
        return createdDay;
    }

    public final Date getLastActiveDay() {
        return lastActiveDay;
    }

    public final void setId(final long i) {
        id = i;
    }

    public final void setUsername(final String s) {
        username = s;
    }

    public final void setPassword(final String s) {
        password = s;
    }

    public final void setFirstName(final String s) {
        firstName = s;
    }

    public final void setLastName(final String s) {
        lastName = s;
    }

    public final void setEmail(final String s) {
        email = s;
    }

    public final void setRole(final String s) {
        role = s;
    }

    public final void setCreatedDay(final Date createdDay) {
        this.createdDay = createdDay;
    }

    public final void setLastActiveDay(final Date lastActiveDay) {
        this.lastActiveDay = lastActiveDay;
    }

    public final boolean isDisabled() {
        return disabled;
    }

    public final void setDisabled(final boolean disabled) {
        this.disabled = disabled;
    }

    @Override
    public final String toString() {
        return "[User, id=" + id + ", " + firstName + " " + lastName
                + " (" + username + ", " + email + "), "
                + "simple role=" + role + ", created on " + createdDay
                + ", last active on " + this.getLastActiveDay() + "]";
    }


    ////////////////////////////////////////////////////////////
    // User's details, not for registration
    ////////////////////////////////////////////////////////////

    private String addressLine1;
    private String addressLine2;
    private String city;
    private String state;
    private String country;
    private String zipCode;
    private String phoneNumber;

    public final String getAddressLine1() {
        return addressLine1;
    }

    public final String getAddressLine2() {
        return addressLine2;
    }

    public final String getCity() {
        return city;
    }

    public final String getState() {
        return state;
    }

    public final String getCountry() {
        return country;
    }

    public final String getZipCode() {
        return zipCode;
    }

    public final String getPhoneNumber() {
        return phoneNumber;
    }

    public final void setAddressLine1(final String s) {
        addressLine1 = s;
    }

    public final void setAddressLine2(final String s) {
        addressLine2 = s;
    }

    public final void setCity(final String s) {
        city = s;
    }

    public final void setState(final String s) {
        state = s;
    }

    public final void setCountry(final String s) {
        country = s;
    }

    public final void setZipCode(final String s) {
        zipCode = s;
    }

    public final void setPhoneNumber(final String s) {
        phoneNumber = s;
    }

    public final void updateInfoFromEditDto(final UserEditInfoDto dto) {
        this.setFirstName(dto.getFirstName());
        this.setLastName(dto.getLastName());
        this.setEmail(dto.getEmail());
        this.setAddressLine1(dto.getAddressLine1());
        this.setAddressLine2(dto.getAddressLine2());
        this.setCity(dto.getCity());
        this.setState(dto.getState());
        this.setCountry(dto.getCountry());
        this.setZipCode(dto.getZipCode());
        this.setPhoneNumber(dto.getPhoneNumber());
    }
}
