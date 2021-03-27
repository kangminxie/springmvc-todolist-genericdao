<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <title>Home 04-28</title>
</head>
<body>
    <h1>This is the Home for Form Test</h1>

    <security:authorize access="isAuthenticated()">
       You are authenticated as <security:authentication property="principal.username" />
    </security:authorize>
    <br>

    You are authenticated as:<security:authentication property="principal.authorities"/><br>
    Helpful link:
    <a href="https://dzone.com/articles/spring-security-5-form-login-with-database-provide">
        Dzone.com's login-with-database-provider
    </a><br>


    Click each link to go to each version of form<br>

    Form-01: (Basic RequestParam):
    <a href="${contextPath}/form-test/form-01">form-01</a><br>

    Form-02: (Model and HttpServletRequest)
    <a href="${contextPath}/form-test/form-02">form-02</a><br>

    Form-03: (RequestParam, Model)(contextPath in short)
    <a href="${contextPath}/form-test/form-03">form-03</a><br>

    Form-04: (ModelAttribute) (Spring Form Tags)
    <a href="${contextPath}/form-test/form-04">form-04</a><br>

    Form-05: (Validation and Bindings, Errors)
    <a href="${contextPath}/form-test/form-05">form-05</a><br>

    Form-06: (UrlMapping, Relative Path, ModelAttributesMapping, c:url)
    <a href="${contextPath}/${UrlMappings.FORM_TEST_BASE}/${UrlMappings.FORM_06}">form-06[abs]</a>
    or
    <c:url var="form06link" value="${UrlMappings.FORM_06}">
        <c:param name="id" value="" />
    </c:url>
    <a href="${form06link}">form-06[relative]</a>

    <br>
    <a href="https://docs.spring.io/spring-security/site/docs/5.0.x/reference/html/csrf.html">CSRF link</a>
    <!-- Logout Form -->
    <form:form action="/logout" method="POST">
        <input type="submit" value="Logout" />
    </form:form>
</body>
</html>
