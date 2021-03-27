<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Form-04</title>
</head>
<body>
    <h1>POST Form-04</h1>
    <p>Hi Student: ${student.firstName} ${student.lastName} !!<br>
        You are from: ${student.homeCountry}<br>
        Your email is: ${student.email}<br>
        You highest education degree is: ${student.maxDegree}<br>
    </p>
        Your skilled operating systems:
        <ul>
            <c:forEach var="each" items="${student.operationSystems}">
            <li>${each}</li>
            </c:forEach>
        </ul>

    Click here back to GET:
    <a href="${contextPath}/form-test/form-04"> form-04 </a>
    <br>
    Click here back to home:
    <a href="${contextPath}/form-test/"> Form Home </a>
    <br>
    Click here back to home:
    <a href="${contextPath}/"> Home </a>
</body>
</html>
