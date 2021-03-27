<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Form-02</title>
</head>
<body>
    <h1>POST Form-02</h1>
    <p>Hi ${userFullName} !</p>

    Click here back to GET:
    <a href="${pageContext.request.contextPath}/form-test/form-02"> form-02 </a>
    <br>
    Click here back to home:
    <a href="${pageContext.request.contextPath}/form-test/"> Form Home </a>
    <br>
    Click here back to home:
    <a href="${pageContext.request.contextPath}/"> Home </a>
</body>
</html>
