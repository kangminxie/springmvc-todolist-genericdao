<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <title>ToDoList-Index</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <%@ include file="frag/_style-external-links.jsp" %>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <%@ include file="frag/_navi_common.jsp" %>
    <header id="main-header" class="mt-0 pt-0">
        <div class="row">
            <div class="col mt-1 py-2 bg-dark text-center text-white">
                <h1>Spring-MVC To-Do-List App</h1>
            </div>
        </div>
    </header>
    <div class="container col-lg-8 col-md-10 col-sm-12 col-xsm-12">
        <%--@elvariable id="welcome_message" type="java.lang.String"--%>
        <!-- Hero Section-->
        <section class="bg-light">
            <div class="container">
                <div class="row pt-3 pb-2">
                    <div class="col-lg-8 order-2 order-lg-1">
                        <h1 class="welcome"><i>${welcome_message}</i></h1>
                        <p>
                            This is the app for managing your daily tasks after creating your secure account.<br>
                            You will be able to edit it in any time.
                        </p>
                        <p>
                            If you are admin user, you will also be able to manager current users.
                        </p>
                        <p>
                            <a href="${contextPath}/${UrlMappings.REGISTER}/"
                               class="btn btn-primary shadow mr-2">
                                Register new account</a>
                            <a href="${contextPath}/${UrlMappings.ABOUT}/"
                               class="btn btn-outline-primary">
                                Learn more about this app</a>
                        </p>
                    </div>
                    <br>
                    <%--<div class="col-lg-8 order-1 order-lg-2">--%>
                        <%--<img src="img/macbook.png" alt="..." class="img-fluid">--%>
                    <%--</div>--%>
                </div>
            </div>
        </section>

        <!-- only NOT log-in user can see -->
        <c:if test="${empty pageContext.request.userPrincipal.name}">
            <section class="jumbotron my-2">
                <div class="row">
                    <div class="container mt-1">
                        <div>
                            <h5>Existing User?</h5>
                            <p>Click the button to the right to Login to your Home page:
                                <a class="btn btn-success btn-lg"
                                   href="${contextPath}/${UrlMappings.LOGIN}/">Login</a>
                                <br>
                            </p>

                            <%--<h5>Feel Interested?</h5>--%>
                            <%--<p>Click here for new account's Registration:--%>
                                <%--&lt;%&ndash;<a href="${contextPath}/${UrlMappings.REGISTER}/">Register</a>&ndash;%&gt;--%>
                                <%--<button type="button" class="btn btn-primary btn-md"--%>
                                    <%--onclick="location.href='${contextPath}/${UrlMappings.REGISTER}/'" >--%>
                                <%--Register</button>--%>
                            <%--</p>--%>

                            <h5>Administrator User?</h5>
                            <p>Click the button to the right to Login to Admin Home page:
                                <a class="btn btn-outline-info btn-md"
                                href="${contextPath}/${UrlMappings.ADMIN_BASE}/">AdminLogin</a>
                            </p>
                        </div>
                        <!-- All logged-out users can see -->
                        <security:authorize access="!isAuthenticated()">
                            <div class="remind container">
                                <h5><i>Wish you enjoy a happy journey here !</i></h5>
                            </div>
                        </security:authorize>
                    </div>
                </div>
            </section>
        </c:if>

        <security:authorize access="hasRole('ADMIN')">
            <div class="bg-light">
                <div class="row">
                    <div class="col-lg-8 order-2 order-lg-1">
                        <!-- Only specified logged-in user - ADMIN can see -->
                        <!-- use security -->
                        <div class="bg-light">
                            <br>
                            <h5>Developing or Debugging?</h5>
                            Click here go to Form-Test set for Spring 5:
                            <a class="btn btn-info btn-md"
                               href="${contextPath}/${UrlMappings.FORM_TEST_BASE}/">Form-Tests</a><br><br>

                            <h5>Emojis Concern in MySQL?</h5>
                            Click here go to find references:
                            <a class="btn btn-secondary btn-md"
                               href="https://confluence.atlassian.com/jirakb/emojis-and-special-characters-for-jira-with-mysql-952604493.html">
                                Emojis and Special Characters for Jira with MySQL</a><br><br>

                            <h5>Look for more resources?</h5>
                            This link gives references to CSRF in Spring:
                            <a class="btn btn-success btn-md"
                               href="https://docs.spring.io/spring-security/site/docs/5.0.x/reference/html/csrf.html">
                                CSRF related link</a><br>

                            This link gives some references for Spring MVC - Passing Data To the Redirect Target:
                            <a class="btn btn-success btn-md"
                               href="https://www.logicbig.com/tutorials/spring-framework/spring-web-mvc/redirect-passing-data.html">
                                Passing Data for Redirecting</a><br>
                        </div>
                        <!-- if use userPrincipal in JSP-->
                        <%--<c:choose>--%>
                        <%--<c:when test="${pageContext.request.userPrincipal.authenticated}">--%>
                        <%--</c:when>--%>
                        <%--<c:otherwise>--%>
                        <%--</c:otherwise>--%>
                        <%--</c:choose>--%>
                    </div>
                </div>
            </div>
        </security:authorize>

        <security:authorize access="isAuthenticated()">
            <section class="bg-light">
                <div class="row">
                    <div class="col-lg-8 order-2 order-lg-1">
                        <!-- All logged-in users can see -->
                        <div class="bg-light">
                                <%--<br>Hi, <security:authentication property="principal.username" />!<br>--%>
                            <br><br>
                            <h5>Something To be done:</h5>
                            <ul>
                                <li>Page: Edit Information</li>
                                <li>Page: Reset Password FrontEnd</li>
                                <li>Font By Self</li>
                                <li>Another G-cloud support</li>
                            </ul>

                            <br>
                            <h5><i>You can click the button below to Logout:</i></h5>
                            <form:form action="${contextPath}/logout" method="POST">
                                <button type="submit" class="btn btn-warning btn-md"
                                        onclick="location.href='${contextPath}/${UrlMappings.LOGOUT}/'" >
                                    &nbsp;&nbsp;Logout&nbsp;&nbsp;</button>
                            </form:form>
                        </div>
                    </div>
                </div>
            </section>
        </security:authorize>
    </div><br>
    <%@ include file="frag/_scripts-external-links.jsp" %>
    <%@ include file="frag/_footer_pre.jsp" %>
    <%@ include file="frag/_footer.jsp" %>
</body>
</html>
