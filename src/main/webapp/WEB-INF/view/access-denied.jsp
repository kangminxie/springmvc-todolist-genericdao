<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <title>Access Issue</title>
    <jsp:include page="frag/_style-external-links.jsp"/>
</head>
<body>
    <jsp:include page="frag/_navi_blank.jsp"/>
    <div class="container">
        <br>
        <h1>Access Denied - You are not authorized</h1>
        <hr>

        <%--@elvariable id="unauthorized_message" type="java.lang.String"--%>
        <div class="alert alert-danger col-sm-12" role="alert">
            <c:if test="${!(empty unauthorized_message)}">
                <h3> ${unauthorized_message}</h3>
            </c:if>
        </div>

        <div>
            <a href="${pageContext.request.contextPath}/${UrlMappings.HOME}">
                Click here to back Home</a><br>
        </div>
    </div>
    <jsp:include page="frag/_scripts-external-links.jsp"/>
    <%@ include file="frag/_footer_pre.jsp" %>
    <jsp:include page="frag/_footer.jsp"/>
</body>
</html>
