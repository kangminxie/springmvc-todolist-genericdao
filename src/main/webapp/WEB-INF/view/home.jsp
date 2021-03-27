<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.kangmin.todolist.util.ModelAttributes" %>
<%@ page import="com.kangmin.todolist.util.UrlMappings" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
    <title>ToDoList-Home</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <%@ include file="frag/_style-external-links.jsp" %>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <%@ include file="frag/_navi_common.jsp" %>
    <header id="main-header" class="mt-0">
        <div class="row">
            <div class="col mt-1 py-2 bg-dark text-center text-white">
                <h1>ToDoList App - Home Page</h1>
            </div>
        </div>
    </header>
    <div class="container mt-3 col-lg-10 col-md-10 col-sm-12 col-xsm-12">
        <!-- check if any home message-->
        <c:if test="${!(empty home_message)}">
            <div class="alert alert-success alert-dismissible col-sm-12">
                <button class="close" type="button" data-dismiss="alert">
                    <span>&times;</span>
                </button>
                <i class="alert">${home_message}</i>
            </div>
        </c:if>
        <!-- check if any home error -->
        <c:if test="${!(empty home_error)}">
            <div class="alert alert-danger alert-dismissible col-sm-12">
                <button class="close" type="button" data-dismiss="alert">
                    <span>&times;</span>
                </button>
                <i class="alert">${home_error}</i>
            </div>
        </c:if>

        <div class="row">
            <div class="col-sm-10 col-md-8 col-lg-6">
                <h3>Dashboard for <i>${user.username}</i></h3>
                <hr/>
                <h5>You have ${number_of_to_do_items} active to-do items </h5>
                <div class="card text-center bg-primary text-white mb-3 mr-5" style="width: 40%">
                    <div class="card-body">
                        <h3>To-Do-Items</h3>
                        <h4 class="display-4">
                            <i class="fas fa-pencil-alt"></i> ${number_of_to_do_items}
                        </h4>
                        <a href="${contextPath}/todolist" class="btn btn-outline-light btn-sm">View</a>
                    </div>
                </div>

                <h5>You have ${number_of_inactive_items} in active to-do items </h5>
                <div class="card text-center bg-info text-white mb-3 mr-5" style="width: 40%">
                    <div class="card-body">
                        <h3>Backlog-Items</h3>
                        <h4 class="display-4">
                            <i class="fas fa-archive"></i> ${number_of_inactive_items}
                        </h4>
                        <a href="${contextPath}/todolist" class="btn btn-outline-light btn-sm">View</a>
                    </div>
                </div>

                <div>
                    <ul>
                        <li>Click <a href="${contextPath}/todolist">Here</a> to visit ToDoList</li>
                        <li>Click <a href="${contextPath}/">Here</a> to back Index Page</li>
                    </ul>
                </div>
            </div>
            <div class="col-sm-10 col-md-8 col-lg-6">
                <h3>My Account Information</h3>
                <hr />
                <%--                <security:authorize access="isAuthenticated()">--%>
                <%--                    authenticated as <security:authentication property="principal.username" />--%>
                <%--                </security:authorize>--%>

                <%--                <security:authentication property="principal.authorities" var="authorities" />--%>
                <%--                    <c:forEach items="${authorities}" var="authority" varStatus="vs">--%>
                <%--                        <p>${authority.authority}</p>--%>
                <%--                    </c:forEach>--%>
                <div class="form-group row mt-3 my-user-detail">
                    <div class="col-sm-4">
                        <label for="fullName">
                            <i class="fas fa-user-circle"></i>&nbsp;Full Name:</label>
                    </div>
                    <div id="fullName" class="col-sm-8">
                        ${user.firstName} ${user.lastName}
                    </div>
                </div>

                <div class="form-group row my-user-detail">
                    <div class="col-sm-4">
                        <label for="email">
                            <i class="fas fa-envelope-square"></i>&nbsp;Email Address:</label>
                    </div>
                    <div id="email" class="col-sm-8">
                        ${user.email}
                    </div>
                </div>

                <div class="form-group row my-user-detail">
                    <div class="col-sm-4">
                        <label for="userRole">
                            <i class="fas fa-medal"></i>&nbsp;My Role:</label>
                    </div>
                    <div id="userRole" class="col-sm-8">
                        ${user.role}
                    </div>
                </div>
                <hr>

                <div class="form-group row my-user-detail">
                    <div class="form-group col-sm-4">
                        <label for="userAddress">
                            <i class="fas fa-home"></i>
                            Mail Address:</label>
                    </div>
                    <div id="userAddress" class="col-sm-8">
                        ${user.addressLine1}, ${user.addressLine2}<br>
                        ${user.city}, ${user.state}<br>
                        ${user.country} ${user.zipCode}
                    </div>
                </div>

                <div class="form-group row my-user-detail">
                    <div class="col-sm-4">
                        <label for="userPhoneNumber">
                            <i class="fas fa-mobile-alt"></i>&nbsp;Phone Number:</label>
                    </div>
                    <div id="userPhoneNumber" class="col-sm-8">
                        ${user.phoneNumber}
                    </div>
                </div>

                <hr>

                <div class="form-group row my-user-detail">
                    <div class="col-sm-4">
                        <label for="userCreatedOn">Join date:</label>
                    </div>
                    <div id="userCreatedOn" class="col-sm-8">
                        <i> <fmt:formatDate value="${user.createdDay}" type="both"
                                            pattern="MMM/dd/yyyy hh:mm:ss aa"/> </i>
                    </div>
                </div>

                <div class="form-group row my-user-detail">
                    <div class="col-sm-4">
                        <label for="userLastActiveOn">Last login date:</label>
                    </div>
                    <div id="userLastActiveOn" class="col-sm-8">
                        <i> <fmt:formatDate value="${user.lastActiveDay}" type="both"
                                            pattern="MMM/dd/yyyy hh:mm:ss aa"/> </i>
                    </div>
                </div>

                <br /><br />

                <div class="text-center">
                    <a class="btn btn-warning btn-md" href="${contextPath}/account/edit">
                        <span class="fa fa-edit"></span>&nbsp;Edit My Information</a>
                </div>
            </div>
        </div>

    </div>
    <%@ include file="frag/_scripts-external-links.jsp" %>
    <%@ include file="frag/_footer_pre.jsp" %>
    <%@ include file="frag/_footer.jsp" %>
</body>
</html>
