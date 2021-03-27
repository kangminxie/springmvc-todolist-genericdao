<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Form-05</title>
</head>
<body>
    <h1>POST Form-05</h1>
    <p>Hi Student: ${student.firstName} ${student.lastName} !!<br>
        You are from: ${student.homeCountry} (zipCode: ${student.zipCode})<br>
        Your email is: ${student.email}<br>
        You highest education degree is: ${student.maxDegree}<br>
        With ${student.yearOfExperience} Years of Experience<br>

        <br>
        Testing service: ${helloMessage}
    </p>
        Your skilled operating systems:
        <ul>
            <c:forEach var="each" items="${student.operationSystems}">
            <li>${each}</li>
            </c:forEach>
        </ul>

    Click here back to GET:
    <a href="${contextPath}/form-test/form-05"> form-05 </a>
    <br>
    Click here back to home:
    <a href="${contextPath}/form-test/"> Form Home </a>
    <br>
    Click here back to home:
    <a href="${contextPath}/"> Home </a>
</body>
</html>
