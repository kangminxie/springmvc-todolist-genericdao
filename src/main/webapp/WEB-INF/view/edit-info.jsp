<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>
<%@ page import="com.kangmin.todolist.util.ModelAttributes" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
    <title>Edit-Information</title>
    <jsp:include page="frag/_style-external-links.jsp"/>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <jsp:include page="frag/_navi_common.jsp"/>
    <header id="edit-info-main-header" class="mt-0">
        <div class="mx-auto">
            <div class="bg-dark text-white">
                <div class="h2 text-center py-3">
                    <span class="fa fa-envelope"></span> Edit My Information
                </div>
            </div>
        </div>
    </header>
    <div class="container mt-3 col-lg-6 col-md-6 col-sm-8 col-xsm-12">
        <!-- check if any more message-->
        <%--@elvariable id="edit_error" type="java.lang.String"--%>
        <c:if test="${!(empty edit_error)}">
            <div class="alert alert-danger alert-dismissible col-sm-12">
                <button class="close" type="button" data-dismiss="alert">
                    <span>&times;</span>
                </button>
                <i class="alert">${edit_error}</i>
            </div>
        </c:if>

        <%--@elvariable id="${ModelAttributes.USER}" type="java"--%>
        <%--@elvariable id="user_dto" type="com.kangmin.todolist.model.dto.UserEditInfoDto"--%>
        <form:form class="form-horizontal"
                   action="${contextPath}/${UrlMappings.ACCOUNT_BASE}/${UrlMappings.EDIT_INFORMATION}"
                   modelAttribute="${ModelAttributes.USER}" method="POST">

            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="firstName">First Name</label><br>
                    <form:input class="form-control" type="text" path="firstName"
                                name="firstName" id="firstName" value="${user.firstName}"/>
                    <form:errors path="firstName" cssClass="error" />
                </div>
                <div class="col-sm-6">
                    <label for="lastName">Last Name</label><br>
                    <form:input class="form-control" type="text" path="lastName"
                                name="lastName" id="lastName" value="${user.lastName}"/>
                    <form:errors path="lastName" cssClass="error" />
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="username"><i class="fas fa-user-circle"></i>&nbsp;Username</label><br>
                    <input class="form-control" type="text" name="username"
                                id="username" value="${user.username}" readonly="readonly"/>
                </div>
                <div class="col-sm-6">
                    <label for="email">
                        <i class="fas fa-envelope-square"></i>&nbsp;Email</label><br>
                    <form:input class="form-control" type="text" path="email"
                                name="email" id="email" value="${user.email}"/>
                    <form:errors path="email" cssClass="error" />
                </div>
            </div>

            <div class="remind">
                <p>(* fields above are required)</p>
            </div>
            <hr>
            <div class="form-group row">
                <div class="form-group col-md-7">
                    <label for="userInputAddressLine1">Address Line 1</label>
                    <form:input type="text" path="addressLine1" class="form-control"
                           id="userInputAddressLine1" value="${user.addressLine1}" />
                </div>
                <div class="form-group col-md-5">
                    <label for="userInputAddressLine2">Address Line 2</label>
                    <form:input type="text" path="addressLine2" class="form-control"
                           id="userInputAddressLine2" value="${user.addressLine2}" />
                </div>
            </div>

            <div class="form-group row">
                <div class="form-group col-lg-4">
                    <label for="userInputCity">City</label>
                    <form:input type="text" path="city" class="form-control"
                           id="userInputCity" value="${user.city}" />
                </div>
                <div class="form-group col-lg-4">
                    <label for="userInputState">State</label>
                    <form:select path="state" id="userInputState" class="form-control">
                        <form:options items="${user.stateOptions}" />
                    </form:select>
                </div>
                <div class="form-group col-lg-4">
                    <label for="userInputZipCode">ZipCode (eg. 78750)</label>
                    <form:input type="text" path="zipCode" class="form-control"
                                id="userInputZipCode" value="${user.zipCode}" />
                </div>
            </div>
            <div class="form-group row">
                <div class="form-group col-lg-6">
                    <label for="userInputCountry">Country</label>
                    <form:select path="country" id="userInputCountry" class="form-control">
                        <form:options items="${user.countryOptions}" />
                    </form:select>
                </div>
                <div class="form-group col-lg-6">
                    <label for="userInputPhoneNumber">Phone number (eg. 888-123-4567)</label>
                    <form:input type="text" path="phoneNumber" class="form-control"
                                id="userInputPhoneNumber" value="${user.phoneNumber}"/>
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-12">
                    <input type="submit" name="confirmEditButton"
                           class="form-control btn btn-success btn-lg pull-right my-big-button"
                           id="confirmEditButton" value="Confirm Your Edit"/>
                </div>
            </div>
        </form:form>
        <br><br>
    </div>
    <%@ include file="frag/_scripts-external-links.jsp" %>
    <%@ include file="frag/_footer_pre.jsp" %>
    <%@ include file="frag/_footer.jsp" %>
</body>
</html>
