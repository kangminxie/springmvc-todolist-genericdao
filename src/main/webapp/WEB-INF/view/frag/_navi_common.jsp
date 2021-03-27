<%@ page import="com.kangmin.todolist.util.UrlMappings" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<nav class="navbar navbar-light navbar-expand-lg fixed-top shadow-sm bg-light">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/index">
        <i class="fas fa-seedling"></i>&nbsp;MyToDoList</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav mr-auto">

            <security:authorize access="hasAnyRole('ADMIN', 'NORMAL')">
                <li class="nav-item active">
                    <a class="nav-link" href="${contextPath}/${UrlMappings.HOME}">
                        <i class="fas fa-home"></i>&nbsp;Home
                    </a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="${contextPath}/${UrlMappings.TO_DO_LIST}">
                        <i class="fas fa-pencil-alt"></i>&nbsp;ToDoList
                    </a>
                </li>
            </security:authorize>

            <li class="nav-item active">
                <a class="nav-link" href="${contextPath}/about">
                    <i class="fas fa-leaf"></i>&nbsp;About
                </a>
            </li>

            <li class="nav-item active">
                <a class="nav-link" href="${contextPath}/contact">
                    <i class="fas fa-at"></i>&nbsp;Contact
                </a>
            </li>

            <%--<security:authorize access="hasAnyRole('NORMAL', 'ADMIN')">--%>
                <%--<li class="nav-item active">--%>
                    <%--<a class="nav-link" href="${pageContext.request.contextPath}/memo">--%>
                        <%--<i class="fas fa-at"></i>&nbsp;ToDoList--%>
                    <%--</a>--%>
                <%--</li>--%>
            <%--</security:authorize>--%>

            <security:authorize access="hasAnyRole('ROLE_ADMIN')">
                <li class="nav-item active">
                    <a class="nav-link" href="${pageContext.request.contextPath}/private/admin/">
                        <i class="fas fa-dragon"></i>&nbsp;AdminHome
                    </a>
                </li>
            </security:authorize>

            <%--<li class="nav-item dropdown">--%>
                <%--<a class="nav-link dropdown-toggle" href="#" id="dropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
                    <%--Dropdown link--%>
                <%--</a>--%>
                <%--<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">--%>
                    <%--<a class="dropdown-item" href="#">Action</a>--%>
                    <%--<a class="dropdown-item" href="#">Another action</a>--%>
                    <%--<a class="dropdown-item" href="#">Something else here</a>--%>
                <%--</div>--%>
            <%--</li>--%>
        </ul>

        <!-- Right aligned -->
            <%--<li class="nav-item active dropdown">--%>
                <%--<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
                    <%--<span class="fa fa-cog"></span> Settings--%>
                <%--</a>--%>
                <%--<div class="dropdown-menu container" aria-labelledby="navbarDropdown">--%>
                    <%--<a class="dropdown-item" href="#"><span class="fa fa-edit"></span>Edit My Information</a>--%>
                    <%--<a class="dropdown-item" href="#"><span class="fa fa-edit"></span>Change Password</a>--%>
                    <%--<div class="dropdown-divider"></div>--%>
                    <%--<a class="dropdown-item" href="#"><span class="fa fa-sign-out-alt"></span>Logout</a>--%>
                <%--</div>--%>
            <%--</li>--%>
        <ul class="navbar-nav">
            <security:authorize access="hasAnyRole('NORMAL', 'ADMIN')">
                <li class="nav-item active dropdown show">
                    <a class="btn btn-light dropdown-toggle" role="button" id="dropdownMenuLink"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <i class="fas fa-cog"></i>&nbsp;Account Settings
                    </a>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/account/edit">
                            <span class="fa fa-edit"></span>&nbsp;Edit My Information</a>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/account/change-pwd">
                            <i class="fas fa-key"></i>&nbsp;Change My Password</a>
                        <security:authorize access="hasAnyRole('ADMIN')">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/account/register">
                                <i class="fas fa-user-plus"></i>&nbsp;Register Another User
                            </a>
                            <%--<a class="dropdown-item" href="#">--%>
                                <%--<i class="fas fa-user-lock"></i>&nbsp;Reset User's Password</a>--%>
                        </security:authorize>
                        <div class="dropdown-divider"><hr></div>
                        <a class="dropdown-item" href="#"
                           onclick="document.getElementById('logout-form').submit();">
                            <i class="fas fa-power-off"></i>&nbsp;Logout
                        </a>
                    </div>
                </li>
                <form:form method="POST" id="logout-form"
                           action="${pageContext.request.contextPath}/logout">
                </form:form>
            </security:authorize>

            <c:choose>
                <c:when test="${pageContext.request.userPrincipal.authenticated}">
                    <li class="nav-item active">
                        <a href="#" class="nav-link" onclick="document.getElementById('logout-form').submit();">
                            <i class="fas fa-power-off"></i>
                            &nbsp;Logout
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-unlock-alt"></i>
                            &nbsp;Login
                        </a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link" href="${pageContext.request.contextPath}/register">
                            <i class="fas fa-user"></i>
                            &nbsp;Register
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>

            <%--<security:authorize access="hasAnyRole('ADMIN', 'NORMAL')">--%>
                <%--<li class="nav-item active">--%>
                    <%--<a class="nav-link" onclick="document.getElementById('logout-form').submit();">--%>
                        <%--<span class="fa fa-user"></span>--%>
                        <%--Logout--%>
                    <%--</a>--%>
                <%--</li>--%>
            <%--</security:authorize>--%>

            <form:form method="POST" id="logout-form"
                       action="${pageContext.request.contextPath}/logout">
            </form:form>

            <%--<li class="nav-item active">--%>
                <%--<a class="nav-link" href="#">&nbsp;&nbsp;&nbsp;</a>--%>
            <%--</li>--%>
            <%--<li class="nav-item active">--%>
                <%--<a class="nav-link" href="${pageContext.request.contextPath}/contact">--%>
                    <%--Support--%>
                <%--</a>--%>
            <%--</li>--%>
        </ul>
    </div>
</nav>
