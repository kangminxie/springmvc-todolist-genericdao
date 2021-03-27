<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Form-04</title>
</head>
<body>
    <h1>GET Form-04</h1>
    <p>Please fill the form below</p>
    <form:form action="${contextPath}/form-test/form-04"
               modelAttribute="student" method="POST">

        <label for="firstName">First Name</label><br>
        <form:input type="text" path="firstName"
                    name="firstName" id="firstName" placeholder="John"/><br>

        <label for="lastName">Last Name</label><br>
        <form:input type="text" path="lastName"
                    name="lastName" id="lastName" placeholder="Smith"/><br>

        <label for="email">Email</label><br>
        <form:input type="text" path="email"
                    name="email" id="email" placeholder="${student.email}"/><br>

        <label>Highest Degree</label><br>
        Bachelor's<form:radiobutton path="maxDegree" value="BS" /><br>
        Masters'<form:radiobutton path="maxDegree" value="MS" /><br>
        Doctoral's<form:radiobutton path="maxDegree" value="PhD" /><br>
        <br>

        <label for="homeCountry">Home Country</label><br>
        <form:select path="homeCountry" id="homeCountry">
            <form:option value="China" label="CH" />
            <form:options items="${student.countryOptions}" />
        </form:select>
        <br>

        <label>Operating System</label><br>
        Windows<form:checkbox path="operationSystems" value="Windows10" /><br>
        Linux<form:checkbox path="operationSystems" value="Linux" /><br>
        MacOS<form:checkbox path="operationSystems" value="MacOS" /><br>

        <input type="submit" value="Submit" />
    </form:form>
</body>
</html>
