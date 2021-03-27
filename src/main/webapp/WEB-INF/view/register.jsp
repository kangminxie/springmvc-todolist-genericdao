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
    <title>ToDoList - Register</title>
    <jsp:include page="frag/_style-external-links.jsp"/>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body onload="isPrivacyTermsAccepted(); isAgreeChecked()">
    <%@ include file="frag/_navi_register.jsp" %>
    <header id="main-header" class="mt-0">
        <div class="row">
            <div class="col mt-1 py-2 bg-dark text-center text-white">
                <h1>ToDoList App - Register Page</h1>
            </div>
        </div>
    </header>

    <div class="container mt-3 col-lg-6 col-md-6 col-sm-8 col-xsm-12">
        <h2>New User Registration</h2>
        <hr>
        <div class="remind">
            <p>(* all fields are required)</p>
        </div>

        <!-- check if any more message-->
        <%--@elvariable id="register_error" type="java.lang.String"--%>
        <c:if test="${!(empty register_error)}">
            <div class="alert alert-danger alert-dismissible col-sm-12">
                <button class="close" type="button" data-dismiss="alert">
                    <span>&times;</span>
                </button>
                <i class="alert">${register_error}</i>
            </div>
        </c:if>

        <%--@elvariable id="${ModelAttributes.USER_DTO}" type="java"--%>
        <%--@elvariable id="user_dto" type="com.kangmin.todolist.model.dto.UserRegisterDto"--%>
        <form:form class="form-horizontal"
                   action="${contextPath}/${UrlMappings.REGISTER}/"
                   modelAttribute="${ModelAttributes.USER_DTO}" method="POST">

            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="firstName">First Name</label><br>
                    <form:input class="form-control" type="text" path="firstName" required="required"
                                name="firstName" id="firstName" value="${user_dto.firstName}"/>
                    <form:errors path="firstName" cssClass="error" />
                </div>
                <div class="col-sm-6">
                    <label for="lastName">Last Name</label><br>
                    <form:input class="form-control" type="text" path="lastName" required="required"
                                name="lastName" id="lastName" value="${user_dto.lastName}"/>
                    <form:errors path="lastName" cssClass="error" />
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="username"><i class="fas fa-user-circle"></i>&nbsp;Username</label><br>
                    <form:input class="form-control" type="text" path="username" required="required"
                                name="username" id="username" value="${user_dto.username}"/>
                    <form:errors path="username" cssClass="error" />
                </div>
                <div class="col-sm-6">
                    <label for="email">
                        <i class="fas fa-envelope-square"></i>&nbsp;Email</label><br>
                    <form:input class="form-control" type="text" path="email" required="required"
                                name="email" id="email" value="${user_dto.email}"/>
                    <form:errors path="email" cssClass="error" />
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="password"><i class="fas fa-key"></i>&nbsp;Password</label><br>
                    <form:input class="form-control" type="password" path="password" required="required"
                                name="password" id="password" value="${user_dto.password}"/>
                    <form:errors path="password" cssClass="error" />
                </div>
                <div class="col-sm-6">
                    <label for="password2"><i class="fas fa-key"></i>&nbsp;Password Confirm</label><br>
                    <form:input class="form-control" type="password" path="password2" required="required"
                                name="password2" id="password2"/>
                    <form:errors path="password2" cssClass="error" />
                </div>
            </div>

            <security:authorize access="hasAnyRole('ADMIN')">
                <div class="form-group row">
                    <div class="col-sm-6">
                        <label for="role"><em>Assign Role as</em></label><br>
                        <form:select path="role" id="role" class="my-big-select" required="required">
                            <form:option value="NORMAL" label="Regular User" />
                            <form:option value="ADMIN" label="Admin User" />
                        </form:select>
                    </div>
                </div>
            </security:authorize>

            <%--<div class="form-group row">--%>
                <%--<div class="col-sm-8 radio-inline">--%>
                    <%--<label><input type="radio" name="privacy" checked>--%>
                        <%--I Agree with this Privacy Policy Agreement</label>--%>
                <%--</div>--%>
                <%--<div class="col-sm-8 radio-inline">--%>
                    <%--<label><input type="radio" name="privacy">--%>
                        <%--I disagree</label>--%>
                <%--</div>--%>
            <%--</div>--%>

            <br>
            <div class="checkbox my-checkbox">
                <form:checkbox path="agree" id="agreeCheckbox" value="agree" class="my-big-checkbox"
                    onclick="isAgreeChecked()"/>
                    &nbsp; Agree with our Privacy Policy:
                    <a href="#" class="col-sm-6" data-toggle="modal" data-target="#registerModalCenter">
                        <b>Privacy Policy &amp; User Agreement Link</b>
                    </a>
                <form:errors path="agree" cssClass="error" />
            </div>

            <!-- Modal Privacy Policy -->
            <%@ include file="frag/_privacy-modal.jsp" %>
            <div class="form-group row">
                <div class="col-sm-12">
                    <input type="submit" name="registerButton"
                           class="form-control btn btn-success btn-lg pull-right my-big-button"
                           id="registerButton" value="Confirm Your Registration"/>
                </div>
            </div>
        </form:form>

        <br>
        <h6><i>Not Ready yet?</i></h6>
        <%--<a href="${contextPath}/home">&nbsp;&nbsp;Back Home</a>--%>
        <button type="button" class="btn btn-warning btn-lg" style="color: white"
                onclick="location.href='${contextPath}/${UrlMappings.INDEX}/'" >
            &nbsp;&nbsp;Return Landing Page</button>
        <br><br><br>
    </div>
    <%@ include file="frag/_scripts-external-links.jsp" %>
    <script>
        function isPrivacyTermsAccepted() {
            if (document.getElementById("modalCheckForAgree").checked === true){
                document.getElementById("agreeButton").disabled = false;
                document.getElementById("registerButton").disabled = false;
                document.getElementById("disagreeButton").disabled = true;
            } else {
                document.getElementById("agreeButton").disabled = true;
                document.getElementById("registerButton").disabled = true;
                document.getElementById("disagreeButton").disabled = false;
            }
        }
        function isAgreeChecked() {
            if (document.getElementById("agreeCheckbox").checked === true) {
                document.getElementById("registerButton").disabled = false;
                document.getElementById("modalCheckForAgree").checked = true
            } else {
                document.getElementById("registerButton").disabled = true;
                document.getElementById("modalCheckForAgree").checked = false;
            }
        }
        // function passAgreeToCheckbox() {
        //     document.getElementById("agreeCheckbox").checked = true;
        //     document.getElementById("registerButton").disabled = false;
        // }
    </script>
    <%@ include file="frag/_footer_pre.jsp" %>
    <%@ include file="frag/_footer.jsp" %>
</body>
</html>
