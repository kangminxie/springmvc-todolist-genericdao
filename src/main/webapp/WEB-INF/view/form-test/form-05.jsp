<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <title>Form-05</title>
    <style>
        .error {
            color:red
        }
    </style>
</head>
<body>
    <h1>GET Form-05</h1>
    <p>Please fill the form below</p>
    <%--@elvariable id="${ModelAttributes.STUDENT}" type="java"--%>
    <form:form action="${contextPath}/form-test/form-05"
               modelAttribute="student" method="POST">

        <label for="firstName">First Name</label><br>
        <form:input type="text" path="firstName"
                    name="firstName" id="firstName" placeholder="${student.firstName}"/>
        <form:errors path="firstName" cssClass="error" /><br>

        <label for="lastName">Last Name</label><br>
        <form:input type="text" path="lastName"
                    name="lastName" id="lastName" placeholder="${student.lastName}"/>
        <form:errors path="lastName" cssClass="error" /><br>

        <label for="email">Email</label><br>
        <form:input type="text" path="email"
                    name="email" id="email" placeholder="${student.email}"/><br>

        <br>
        <label>Highest Degree</label><br>
        Bachelor's<form:radiobutton path="maxDegree" value="BS" /><br>
        Masters'<form:radiobutton path="maxDegree" value="MS" /><br>
        Doctoral's<form:radiobutton path="maxDegree" value="PhD" /><br>
        <br>

        <br>
        <label>Years of Experience</label><br>
        <form:input type="txt" path="yearOfExperience" />
        <form:errors path="yearOfExperience" cssClass="error" /><br>
        <br>

        <label for="homeCountry">Home Country</label><br>
        <form:select path="homeCountry" id="homeCountry">
            <form:option value="United States" label="US" />
            <form:options items="${student.countryOptions}" />
        </form:select>
        <br>

        <label>Zip Code</label><br>
        <form:input type="text" path="zipCode" />
        <form:errors path="zipCode" cssClass="error" /><br>

        <label>Operating System</label><br>
        Windows<form:checkbox path="operationSystems" value="Windows10" /><br>
        Linux<form:checkbox path="operationSystems" value="Linux" /><br>
        MacOS<form:checkbox path="operationSystems" value="MacOS" /><br>

        <br>
        <input type="submit" value="Submit" />
    </form:form>
</body>
</html>
