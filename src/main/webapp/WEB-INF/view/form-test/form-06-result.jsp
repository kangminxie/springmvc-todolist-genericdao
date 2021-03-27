<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<%@ page import="com.kangmin.todolist.util.ModelAttributes" %>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>

<html>
<head>
    <title>Form-06</title>
</head>
<body>
    <h1>POST Form-06</h1>
    <p>Hi Student: ${student.firstName} ${student.lastName} !!<br>
        You are from: ${student.homeCountry} (zipCode: ${student.zipCode})<br>
        Your email is: ${student.email}<br>
        You highest education degree is: ${student.maxDegree}<br>
        With ${student.yearOfExperience} Years of Experience<br>

        <br>
        Testing service: ${ModelAttributes.STUDENT_HELLO_MESSAGE}
    </p>
        Your skilled operating systems:
        <ul>
            <c:forEach var="each" items="${student.operationSystems}">
            <li>${each}</li>
            </c:forEach>
        </ul>

    Click here back to GET:
    <a href="${contextPath}/${UrlMappings.FORM_TEST_BASE}/${UrlMappings.FORM_06}"> form-06 </a>
    <br>
    Click here back to home:
    <a href="${contextPath}/${UrlMappings.FORM_TEST_BASE}/"> Form Home </a>
    <br>
    Click here back to home:
    <a href="${contextPath}/"> Home </a>
</body>
</html>
