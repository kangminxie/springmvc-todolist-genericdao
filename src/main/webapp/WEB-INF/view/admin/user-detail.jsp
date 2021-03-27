<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <title>User Detail</title>
    <%@ include file="../frag/_style-external-links.jsp" %>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <%@ include file="../frag/_navi_common.jsp"%>
    <div class="container col-lg-6 col-md-8 col-sm-10 col-xsm-12">
        <%--@elvariable id="user" type="java"--%>
        <h3 style="text-align: center">Detailed Information for user: <i>${user.username}</i></h3>
        <hr>
        <div class="form-group row my-user-detail">
            <div class="col-sm-3">
                <label for="fullName">
                    <i class="fas fa-user-circle"></i>&nbsp;Full Name:</label>
            </div>
            <div id="fullName" class="col-sm-9">
                ${user.firstName} ${user.lastName}
            </div>
        </div>

        <div class="form-group row my-user-detail">
            <div class="col-sm-3">
                <label for="email">
                    <i class="fas fa-envelope-square"></i>&nbsp;Email Address:</label>
            </div>
            <div id="email" class="col-sm-9">
                ${user.email}
            </div>
        </div>

        <div class="form-group row my-user-detail">
            <div class="col-sm-3">
                <label for="userRole">
                    <i class="fas fa-medal"></i>&nbsp;User Role:</label>
            </div>
            <div id="userRole" class="col-sm-9">
                ${user.role}
            </div>
        </div>

        <div class="form-group row my-user-detail">
            <div class="col-sm-3">
                <label for="userStatus">
                    <i class="fas fa-star-half-alt"></i>
                    Account Status:</label>
            </div>
            <div id="userStatus" class="col-sm-9">
                <c:if test="${!(user.disabled)}">
                    <p class="welcome"><b>Active</b></p>
                </c:if>
                <c:if test="${user.disabled}">
                    <p class="remind secondary-text">Disabled</p>
                </c:if>
            </div>
        </div>

        <hr>

        <div class="form-group row my-user-detail">
            <div class="form-group col-sm-3">
                <label for="userAddress">
                    <i class="fas fa-home"></i>
                    Mail Address:</label>
            </div>
            <div id="userAddress" class="col-sm-9">
                ${user.addressLine1}, ${user.addressLine2}<br>
                ${user.city}, ${user.state}<br>
                ${user.country} ${user.zipCode}
            </div>
        </div>

        <div class="form-group row my-user-detail">
            <div class="col-sm-3">
                <label for="userPhoneNumber">
                    <i class="fas fa-mobile-alt"></i>&nbsp;Phone Number:</label>
            </div>
            <div id="userPhoneNumber" class="col-sm-9">
                ${user.phoneNumber}
            </div>
        </div>

        <hr>

        <div class="form-group row my-user-detail">
            <div class="col-sm-3">
                <label for="userCreatedOn">Created Date:</label>
            </div>
            <div id="userCreatedOn" class="col-sm-9">
                <i> <fmt:formatDate value="${user.createdDay}" type="both"
                                    pattern="MMM/dd/yyyy hh:mm:ss aa"/> </i>
            </div>
        </div>

        <div class="form-group row my-user-detail">
            <div class="col-sm-3">
                <label for="userLastActiveOn">Last Login Date:</label>
            </div>
            <div id="userLastActiveOn" class="col-sm-9">
                <i> <fmt:formatDate value="${user.lastActiveDay}" type="both"
                                    pattern="MMM/dd/yyyy hh:mm:ss aa"/> </i>
            </div>
        </div><br><br>

        <div class="container my-user-detail">
            <a class="btn btn-warning btn-lg"
               href="${contextPath}/${UrlMappings.ADMIN_BASE}/">
                Back To Admin Home</a>
        </div>
        <br><br>
    </div>
    <%@ include file="../frag/_footer.jsp" %>
</body>
</html>
