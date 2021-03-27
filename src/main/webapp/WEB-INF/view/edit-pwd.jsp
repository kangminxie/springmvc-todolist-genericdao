<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>
<%@ page import="com.kangmin.todolist.util.ModelAttributes" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
    <title>Edit-Pwd</title>
    <jsp:include page="frag/_style-external-links.jsp"/>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <jsp:include page="frag/_navi_common.jsp"/>
    <header id="edit-info-main-header" class="mt-0">
        <div class="mx-auto">
            <div class="bg-dark text-white">
                <div class="h2 text-center py-3">
                    <span class="fa fa-envelope"></span> Change My Password
                </div>
            </div>
        </div>
    </header>
    <div class="container mt-3 col-lg-5 col-md-6 col-sm-8 col-xsm-12">
        <div class="remind">
            <p>(* all fields are required)</p>
        </div>
        <!-- check if any more message-->
        <%--@elvariable id="edit_error" type="java.lang.String"--%>
        <c:if test="${!(empty edit_error)}">
            <div class="alert alert-danger alert-dismissible col-sm-12">
                <button class="close" type="button" data-dismiss="alert">
                    <span>&times;</span>
                </button>
                <i class="alert">${edit_error}</i>
            </div>
        </c:if>

        <%--@elvariable id="${ModelAttributes.USER_DTO_PWD}" type="java"--%>
        <%--@elvariable id="user_dto_pwd" type="com.kangmin.todolist.model.dto.UserEditPwdDto"--%>
        <form:form class="form-horizontal"
                   action="${contextPath}/${UrlMappings.ACCOUNT_BASE}/change-pwd"
                   modelAttribute="${ModelAttributes.USER_DTO_PWD}" method="POST">

            <div class="form-group row">
                <div class="col-sm-12">
                    <label for="password"><i class="fas fa-key"></i>&nbsp;Previous Password</label><br>
                    <form:input class="form-control" type="password" path="password"
                                name="password" id="password" value="${user_dto_pwd.password}"/>
                    <form:errors path="password" cssClass="error" />
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-12">
                    <label for="newPassword"><i class="fas fa-key"></i>&nbsp;New Password</label><br>
                    <form:input class="form-control" type="password" path="newPassword"
                                name="newPassword" id="newPassword" value="${user_dto_pwd.newPassword}"/>
                    <form:errors path="newPassword" cssClass="error" />
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-12">
                    <label for="newPassword2"><i class="fas fa-key"></i>&nbsp;New Password Confirm</label><br>
                    <form:input class="form-control" type="password" path="newPassword2"
                                name="newPassword2" id="newPssword2"/>
                    <form:errors path="newPassword2" cssClass="error" />
                </div>
            </div>

            <div class="form-group row">
                <div class="col-sm-12">
                    <input type="submit" name="confirmEditPwdButton"
                           class="form-control btn btn-success btn-lg pull-right my-big-button"
                           id="confirmEditPwdButton" value="Confirm to Change Password"/>
                </div>
            </div>
        </form:form>
        <br><br>
    </div>
    <%@ include file="frag/_scripts-external-links.jsp" %>
    <%@ include file="frag/_footer_pre.jsp" %>
    <%@ include file="frag/_footer.jsp" %>
</body>
</html>
