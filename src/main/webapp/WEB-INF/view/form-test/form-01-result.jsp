<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Form-01</title>
</head>
<body>
    <h1>POST Form-01</h1>
    <p>Hi ${param.firstName} ${param.lastName}</p>

    Click here back to GET:
    <a href="${pageContext.request.contextPath}/form-test/form-01"> form-01 </a>
    <br>
    Click here back to home:
    <a href="${pageContext.request.contextPath}/form-test/"> Form Home </a>
    <br>
    Click here back to home:
    <a href="${pageContext.request.contextPath}/"> Home </a>
</body>
</html>
