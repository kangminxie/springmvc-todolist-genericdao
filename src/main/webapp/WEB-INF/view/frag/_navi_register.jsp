<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<nav class="navbar navbar-light navbar-expand-lg fixed-top shadow-sm bg-light">
    <a class="navbar-brand" href="${contextPath}/index">
        <i class="fas fa-seedling"></i>&nbsp;MyToDoList</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav mr-auto">
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
        </ul>

        <!-- Right aligned -->
        <ul class="navbar-nav">
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
                            <span class="fa fa-user"></span>
                            &nbsp;Login
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
            <form:form method="POST" id="logout-form"
                       action="${pageContext.request.contextPath}/logout">
            </form:form>
        </ul>
    </div>
</nav>
