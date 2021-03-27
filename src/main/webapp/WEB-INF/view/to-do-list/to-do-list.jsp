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
    <title>ToDoList</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <%@ include file="../frag/_style-external-links.jsp" %>
    <link href='<spring:url value="/resources/css/my_common.css"/>' rel="stylesheet" />
</head>
<body>
<%@ include file="../frag/_navi_common.jsp" %>
<header id="main-header" class="mt-0">
    <div class="row">
        <div class="col mt-1 py-2 bg-dark text-center text-white">
            <h1>ToDoList App - To-Do-List Page</h1>
        </div>
    </div>
</header>
<div class="container col-lg-10 col-md-10 col-sm-12 col-xsm-12">
    <h2 style="text-align: center">My To-Do Items Table View
        <!-- DEV purpose comments out -->
        <%--<security:authentication property="principal.username"/>!--%>
    </h2>
    <!-- to do items -->
    <table id="showToDoListTable" class="table table-striped table-bordered">
        <thead class="thead-dark">
        <tr>
            <%--<th style="width: 5%">Id</th>--%>
            <th>Id</th>
            <th>Item Title</th>
            <th>Type</th>
            <th>Priority</th>
            <th>Details</th>
            <th>Due Day</th>
            <th>Edit</th>
            <th>Backlog</th>
            <th>Done</th>
        </tr>
        </thead>
        <tbody>
        <%--@elvariable id="to_do_items" type="com.kangmin.todolist.model.entity.ToDoItem[]"--%>
        <c:forEach var="each" items="${to_do_items}">
            <tr>
                <td>${each.id}</td>
                <td>${each.title}</td>
                <td>${each.type}</td>
                <td>${each.priority}</td>
                <td>${each.detail}</td>
                <td>
                    <i> <fmt:formatDate value="${each.dueDay}" type="both"
                                        pattern="MMM/dd/yyyy"/> </i>
                </td>

                <!-- Edit it -->
                <td>
                    <!-- Edit it in another web page -->
                        <%--<form:form method="POST" action="${contextPath}/toDoList/edit/${each.id}">--%>
                        <%--<input class="btn btn-warning btn-sm" type="submit"--%>
                        <%--value="Edit it"--%>
                        <%--onclick="if (!(confirm('Are you sure want to edit this entry')))--%>
                        <%--return false" />--%>
                        <%--</form:form>--%>
                    <!-- Edit it in modal in situ -->
                    <a href="#" class="btn btn-warning btn-sm"
                       data-toggle="modal" data-target="#editToDoItemModal${each.id}">
                        Edit
                    </a>
                    <%@ include file="../frag/_edit_todoitem_modal.jsp" %>
                </td>
                <!-- Backlog it -->
                <td>
                    <form:form method="POST" action="${contextPath}/todolist/backlog/${each.id}">
                        <i class="fas fa-arrow-circle-down"></i>
                        <input class="btn btn-secondary btn-sm" type="submit" value="Backlog" />
                    </form:form>
                </td>
                <!-- Delete it -->
                <td>
                    <form:form method="POST" action="${contextPath}/todolist/delete/${each.id}">
                        <i class='fas fa-trash-alt'></i>
                        <input class="btn btn-danger btn-sm" type="submit" value="Remove"
                               onclick="if (!(confirm('Are you sure want to delete this entry')))
                                           return false" />
                    </form:form>
                </td>
            </tr>
        </c:forEach>
        </tbody>

        <!-- check if any error message -->
        <%--@elvariable id="error" type="java"--%>
        <c:if test="${!(empty error)}">
            <div class="alert alert-danger alert-dismissible col-sm-12">
                <button class="close" type="button" data-dismiss="alert">
                    <span>&times;</span>
                </button>
                <i class="alert">${error}</i>
            </div>
        </c:if>

        <!-- check if any more message-->
        <%--@elvariable id="message" type="java.lang.String"--%>
        <c:if test="${!(empty message)}">
            <div class="alert alert-success alert-dismissible col-sm-12">
                <button class="close" type="button" data-dismiss="alert">
                    <span>&times;</span>
                </button>
                <i class="alert">${message}</i>
            </div>
        </c:if>

        <!-- add another entry in situ -->
        <tr>
            <%--@elvariable id="${ModelAttributes.TO_DO_ITEM_DTO}" type="java"--%>
            <%--@elvariable id="draft_item" type="java"--%>
            <form:form method="POST" class="form-horizontal"
                       accept-charset="UTF-8" onsubmit="document.charset='UTF-8'"
                       action="${contextPath}/${UrlMappings.TO_DO_LIST}"
                       modelAttribute="${ModelAttributes.TO_DO_ITEM_DTO}">
                <td>
                    new
                </td>
                <td>
                    <form:input type="text" path="title" value="${draft_item.title}"/>
                    <form:errors path="title" cssClass="error" />
                </td>
                <td>
                    <form:select path="type" id="type">
                        <%--<option selected>Choose..</option>--%>
                        <form:options items="${draft_item.typeOptions}" />
                    </form:select>
                    <form:errors path="type" cssClass="error" />
                </td>
                <td>
                    <form:select path="priority" id="priority">
                        <form:options items="${draft_item.priorityOptions}" />
                    </form:select>
                    <form:errors path="priority" cssClass="error" />
                </td>
                <td>
                    <form:input type="text" path="detail" value="${draft_item.detail}"/>
                </td>
                <td>
                    <form:input path="dueDay" type="date"/>
                </td>
                <td colspan="3">
                    <input type="submit" name="addButton" class="btn btn-success btn-md"
                           id="addSubmit" value="Add this New Item" required/>

                        <%--@elvariable id="_csrf" type="java"--%>
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                </td>
            </form:form>
        </tr>
    </table>

    <!-- Go to formal Add To-do Item Page-->
    <a href="${contextPath}/${UrlMappings.TO_DO_LIST}/add">
        <button type="submit" class="btn btn-success">Add a New Item Entry In Another Page</button>
    </a><br><br>

    <!-- BackLog -->
    <h4>Backlog Table</h4>

    <table id="showBacklogItemsTable" class="table table-striped table-bordered">
        <thead class="thead-light">
        <tr>
            <%--<th style="width: 5%">Id</th>--%>
            <th>Id</th>
            <th>Item Title</th>
            <th>Type</th>
            <th>Priority</th>
            <th>Details</th>
            <th>Due Day</th>
            <th>Promote</th>
            <th>Done</th>
        </tr>
        </thead>
        <tbody>
        <%--@elvariable id="to_do_items" type="com.kangmin.todolist.model.entity.ToDoItem[]"--%>
        <c:forEach var="each" items="${backlogItems}">
            <tr>
                <td>${each.id}</td>
                <td>${each.title}</td>
                <td>${each.type}</td>
                <td>${each.priority}</td>
                <td>${each.detail}</td>
                <td>
                    <i> <fmt:formatDate value="${each.dueDay}" type="both"
                                        pattern="MMM/dd/yyyy"/> </i>
                </td>
                <!-- Promote it -->
                <td>
                    <form:form method="POST" action="${contextPath}/todolist/backlog/${each.id}">
                        <input class="btn btn-outline-success btn-sm" type="submit" value="Activate" />
                    </form:form>
                </td>
                <!-- Delete it -->
                <td>
                    <form:form method="POST" action="${contextPath}/todolist/delete/${each.id}">
                        <i class='fas fa-trash-alt'></i>
                        <input class="btn btn-danger btn-sm" type="submit" value="Remove"
                               onclick="if (!(confirm('Are you sure want to delete this entry')))
                                       return false" />
                    </form:form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- All logged-in users can see -->
    <%--<security:authorize access="isAuthenticated()">--%>
    <%--<div>--%>
    <%--<form:form action="${contextPath}/logout" method="POST">--%>
    <%--<h6>You can click the button below to Logout:</h6>--%>
    <%--<button type="submit" class="btn btn-warning btn-md"--%>
    <%--onclick="location.href='${contextPath}/${UrlMappings.LOGOUT}/'" >--%>
    <%--&nbsp;&nbsp;Logout&nbsp;&nbsp;</button>--%>
    <%--</form:form>--%>
    <%--</div>--%>
    <%--</security:authorize>--%>

    <!-- All logged-out users can see -->
    <%--<security:authorize access="!isAuthenticated()"><br>--%>
    <%--<div class="bg-light">--%>
    <%--Start to enjoy a happy journey here !--%>
    <%--</div>--%>
    <%--</security:authorize><br>--%>
</div><br><br>

<!-- scripts and footer-->
<%@ include file="../frag/_scripts-external-links.jsp" %>
<script type="text/javascript">
    $(document).ready(function() {
        $('#showToDoListTable').DataTable({})
    });
</script>
<%@ include file="../frag/_footer_pre.jsp" %>
<%@ include file="../frag/_footer.jsp" %>
</body>
</html>
