<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ include file="frag/_style-external-links.jsp" %>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <%--<jsp:include page="frag/_navi_blank.jsp"/>--%>
    <%@ include file="frag/_navi_blank.jsp" %>
    <header id="main-header" class="mt-0">
        <div class="row">
            <div class="col mt-1 py-2 bg-dark text-center text-white">
                <h1>ToDoList App - Login Page</h1>
            </div>
        </div>
    </header>
    <div class="container mt-3 col-lg-5 col-md-8 col-sm-10 col-xsm-12">
        <h3>Please Sign In Here</h3>
        <h5>请您在此登录</h5>
        <hr>
        <form:form class="form-horizontal" method="POST"
                   action="${contextPath}/authenticateTheUser">

            <!-- check for login error -->
            <c:if test="${param.error != null}">
                <div class="alert alert-danger alert-dismissible col-sm-10">
                    <button class="close" type="button" data-dismiss="alert">
                        <span>&times;</span>
                    </button>
                    <i class="alert">Sorry! Invalid username/password.</i>
                </div>
            </c:if>

            <!-- check for logout info -->
            <c:if test="${param.logout != null}">
                <div class="alert alert-success alert-dismissible col-sm-10">
                    <button class="close" type="button" data-dismiss="alert">
                        <span>&times;</span>
                    </button>
                    <i class="alert">You have been logout successfully.</i>
                </div>
            </c:if>

            <!-- check if any more message-->
            <%--@elvariable id="login_message" type="java.lang.String"--%>
            <c:if test="${!(empty login_message)}">
                <div class="alert alert-success col-sm-10" role="alert">
                    <%--@elvariable id="${ModelAttributes.LOGIN_MESSAGE}" type="java"--%>
                    <i class="alert">${login_message}</i>
                </div>
            </c:if>

            <!-- Username -->
            <div class="form-group row">
                <div class="col-sm-10 my-2">
                    <label class="control-label my-right-align" for="username">
                        <i class="fas fa-user-circle"></i>&nbsp;
                        <b>Username</b></label>
                    <input type="text" name="username" class="form-control" id="username"
                           placeholder="Type username here..." required/>
                </div>
            </div>

            <!-- Password-->
            <div class="form-group row">
                <div class="col-sm-10 my-2">
                    <label class="control-label my-right-align" for="userInputPassword">
                        <i class="fas fa-key"></i>&nbsp;
                        <b>Password</b></label>
                    <input type="password" name="password" class="form-control"
                           id="userInputPassword" placeholder="Type password here..." required/>
                </div>
            </div>

            <!-- Submit-->
            <div class="form-group row">
                <div class="col-sm-10">
                    <input type="submit" name="loginButton"
                           class="form-control btn btn-success btn-lg pull-right my-big-button"
                           id="loginSubmit" value="Login to Home Page" required/>
                </div>
            </div>
        </form:form>

        <br><br><br>
        <div>
            <h5 style="color: orange"><em>Feel Interested?</em></h5>
            <p>Click the button in the right side for New User Registration:&nbsp;
                <a class="btn btn-primary btn-md" href="${contextPath}/${UrlMappings.REGISTER}">
                &nbsp;Register&nbsp;</a></p>
            <%--<p>--%>
                <%--<h5>Forget Password?</h5> Click to reset it via registered email--%>
                <%--<a href="${contextPath}/${UrlMappings.CONTACT}">Reset Password</a>--%>
            <%--</p>--%>
        </div>
    </div>
    <%@ include file="frag/_scripts-external-links.jsp" %>
    <%@ include file="frag/_footer_pre.jsp" %>
    <%@ include file="frag/_footer.jsp" %>
</body>
</html>
