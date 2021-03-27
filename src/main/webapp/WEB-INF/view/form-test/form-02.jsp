<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Form-02</title>
</head>
<body>
    <h1>GET Form-02</h1>
    <p>Please fill the form below</p>
    <form action="${pageContext.request.contextPath}/form-test/form-02" method="POST">
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
