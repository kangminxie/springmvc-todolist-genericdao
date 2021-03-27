<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <title>ToDoList - AdminHome</title>
    <%@ include file="../frag/_style-external-links.jsp" %>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
    <%@ include file="../frag/_navi_common.jsp" %>
    <header id="main-header" class="mt-0">
        <div class="row">
            <div class="col mt-1 py-2 bg-dark text-center text-white">
                <h1>ToDoList App - Admin Page</h1>
            </div>
        </div>
    </header>
    <div class="container mt-3 col-md-10 col-sm-12 col-xsm-12">
        <h1 style="text-align: center">Admin Home for
            <i><security:authentication property="principal.username" /></i>
        </h1>
        <hr>
        <!-- only admin user can see -->
        <security:authorize access="hasAnyRole('ADMIN')">
            <div>
                <h5>Current registered users are listed here:</h5>
                <!-- Users Table -->
                <table id="showUsersTable" class="table table-striped table-bordered">
                    <thead class="thead-dark">
                    <tr>
                        <th>Id</th>
                        <th>Username</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>CreatedOn</th>
                        <th>LastActive</th>
                        <th>Disable</th>
                        <th>Remove</th>
                    </tr>
                    </thead>
                    <tbody>
                        <%--@elvariable id="${ModelAttributes.ACTIVE_USERS}" type="com.kangmin.todolist.model.entity.User[]"--%>
                        <%--@elvariable id="active_users" type="java"--%>
                        <c:forEach var="each" items="${active_users}">
                            <tr>
                                <td>${each.id}</td>
                                <td>${each.username}</td>
                                <td><a href="${contextPath}/private/admin/user-detail/${each.id}">
                                            ${each.lastName}, ${each.firstName}</a></td>
                                <td>${each.email}</td>
                                <td>${each.role}</td>
                                <td>
                                    <i> <fmt:formatDate value="${each.createdDay}" type="both"
                                                        pattern="MMM/dd/yyyy"/> </i>
                                </td>
                                <td>
                                    <i> <fmt:formatDate value="${each.lastActiveDay}" type="both"
                                                        pattern="MMM/dd/yyyy"/> </i>
                                </td>
                                <td>
                                    <form:form method="POST" action="${contextPath}/private/admin/disable/${each.id}">
                                        <i class="fas fa-arrow-circle-down"></i>
                                        <input class="btn btn-warning btn-sm" type="submit" value="Disable"
                                               onclick="if (!(confirm('Are you sure want to disable this entry?')))
                                           return false" />
                                    </form:form>
                                </td>
                                <td>
                                    <form:form method="POST" action="${contextPath}/private/admin/terminate/${each.id}">
                                        <i class="fas fa-user-minus"></i>
                                        <input class="btn btn-danger btn-sm" type="submit" value="Remove"
                                               onclick="if (!(confirm('Are you sure want to remove this user?')))
                                           return false" />
                                    </form:form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>

                    <!-- check if any error message -->
                        <%--@elvariable id="error" type="java"--%>
                    <c:if test="${!(empty admin_home_error)}">
                        <div class="alert alert-danger alert-dismissible col-sm-12">
                            <button class="close" type="button" data-dismiss="alert">
                                <span>&times;</span>
                            </button>
                            <i class="alert">${admin_home_error}</i>
                        </div>
                    </c:if>

                    <!-- check if any more message-->
                        <%--@elvariable id="admin_home_message" type="java.lang.String"--%>
                    <c:if test="${!(empty admin_home_message)}">
                        <div class="alert alert-success alert-dismissible col-sm-12">
                            <button class="close" type="button" data-dismiss="alert">
                                <span>&times;</span>
                            </button>
                            <i class="alert">${admin_home_message}</i>
                        </div>
                    </c:if>
                </table>
            </div>
        </security:authorize>
        <form:form action="${pageContext.request.contextPath}/account/register" method="GET">
            <button type="submit" class="btn btn-success btn-md" >
                <i class="fas fa-user-plus"></i>&nbsp;Register Another User&nbsp;</button>
        </form:form>

        <br><br>
        <h5>Current disabled users</h5>
        <!-- Users Table -->
        <table id="showDisabledUsersTable" class="table table-striped table-bordered">
            <thead class="thead-light">
            <tr>
                <th>Id</th>
                <th>Username</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>CreatedOn</th>
                <th>LastActive</th>
                <th>Reactive</th>
                <th>Remove</th>
            </tr>
            </thead>
            <tbody>
            <%--@elvariable id="${ModelAttributes.DISABLED_USERS}" type="com.kangmin.todolist.model.entity.User[]"--%>
            <%--@elvariable id="diasbled_users" type="java"--%>
            <c:forEach var="each" items="${disabled_users}">
                <tr>
                    <td>${each.id}</td>
                    <td>${each.username}</td>
                    <td><a href="${contextPath}/private/admin/user-detail/${each.id}">
                            ${each.lastName}, ${each.firstName}</a></td>
                    <td>${each.email}</td>
                    <td>${each.role}</td>
                    <td>
                        <i> <fmt:formatDate value="${each.createdDay}" type="both"
                                            pattern="MMM/dd/yyyy"/> </i>
                    </td>
                    <td>
                        <i> <fmt:formatDate value="${each.lastActiveDay}" type="both"
                                            pattern="MMM/dd/yyyy"/> </i>
                    </td>
                    <td>
                        <form:form method="POST" action="${contextPath}/private/admin/disable/${each.id}">
                            <input class="btn btn-outline-primary btn-sm" type="submit" value="Re-Active" />
                        </form:form>
                    </td>
                    <td>
                        <form:form method="POST" action="${contextPath}/private/admin/terminate/${each.id}">
                            <i class="fas fa-user-minus"></i>
                            <input class="btn btn-danger btn-sm" type="submit" value="Remove"
                                   onclick="if (!(confirm('Are you sure want to remove this user?')))
                                           return false" />
                        </form:form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <br>
        <form:form action="${contextPath}/logout" method="POST">
            <h6>Click this button to Logout:</h6>
            <button type="submit" class="btn btn-warning btn-md" >
                &nbsp;&nbsp;Logout&nbsp;&nbsp;</button>
        </form:form>
        <br><br>
    </div>
    <%@ include file="../frag/_scripts-external-links.jsp" %>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#showUsersTable').DataTable({})
            // $('#showDisabledUsersTable').DataTable({})
        });
    </script>
    <%@ include file="../frag/_footer_pre.jsp" %>
    <%@ include file="../frag/_footer.jsp" %>
</body>
</html>
