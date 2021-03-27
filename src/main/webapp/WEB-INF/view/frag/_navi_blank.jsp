<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/about">
                    <i class="fas fa-leaf"></i>&nbsp;About
                </a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/contact">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/register">
                            <span class="fa fa-user"></span>
                            &nbsp;Register
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
