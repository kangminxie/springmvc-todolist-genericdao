<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Form-03</title>
</head>
<body>
    <h1>POST Form-03</h1>
    <p>Hi ${userFullName} !</p>

    Click here back to GET:
    <a href="${contextPath}/form-test/form-03"> form-03 </a>
    <br>
    Click here back to home:
    <a href="${contextPath}/form-test/"> Form Home </a>
    <br>
    Click here back to home:
    <a href="${contextPath}/"> Home </a>
</body>
</html>
