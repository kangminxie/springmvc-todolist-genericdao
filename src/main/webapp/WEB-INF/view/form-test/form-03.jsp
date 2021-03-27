<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Form-03</title>
</head>
<body>
    <h1>GET Form-03</h1>
    <p>Please fill the form below</p>
    <form action="${contextPath}/form-test/form-03" method="POST">
        <label>What's Your Name</label><br>
        <input type="text" name="firstName" placeholder="John"/>
        <br>
        <input type="text" name="lastName" placeholder="Smith"/>
        <br>
        <input type="submit" value="Submit Name" />
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>
    </form>
</body>
</html>
