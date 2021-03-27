<!-- Modal for Edit ToDoItem -->
<div class="modal fade" id="editToDoItemModal${each.id}" tabindex="-1" role="dialog"
     aria-labelledby="editToDoItemModalTitle${each.id}" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="editToDoItemModalTitle${each.id}">
                    Edit a Current Item</h3>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container col-lg-8 col-md-8 col-sm-8 col-xsm-12">
                    <div class="tab-pane" id="about" role="tabpanel" aria-labelledby="about-tab">
                        <%--<h5>Edit a current item</h5>--%>
                        <%--@elvariable id="${ModelAttributes.TO_DO_ITEM_DTO}" type="java"--%>
                        <form:form class="form-horizontal" method="POST"
                                   action="${contextPath}/${UrlMappings.TO_DO_LIST}/edit/${each.id}"
                                   modelAttribute="${ModelAttributes.TO_DO_ITEM_DTO}">

                            <!-- Title -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2" for="title">
                                    <b>Title:</b></label>
                                <div class="col-sm-8">
                                    <form:input class="form-control" type="text" path="title"
                                                id="title" value="${each.title}"/>
                                    <form:errors path="title" cssClass="error" />
                                </div>

                            </div>

                            <!-- Type -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2" for="type">
                                    <b>Type:</b></label>
                                <div class="col-sm-8">
                                    <form:select class="form-control" path="type" id="type">
                                        <form:option value="${each.type}" label="${each.type}"/>
                                        <form:options items="${draft_item.typeOptions}" />
                                    </form:select>
                                    <form:errors path="type" cssClass="error" />
                                </div>
                            </div>

                            <!-- Priority -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2" for="priority">
                                    <b>Priority:</b></label>
                                <div class="col-sm-8">
                                    <form:select class="form-control" path="priority" id="priority">
                                        <form:option value="${each.priority}" label="${each.priority}"/>
                                        <form:options items="${draft_item.priorityOptions}" />
                                    </form:select>
                                    <form:errors path="priority" cssClass="error" />
                                </div>
                            </div>

                            <!-- Detail -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2" for="detail">
                                    <b>Detail:</b></label>
                                <div class="col-sm-8">
                                    <form:input class="form-control" type="text" path="detail"
                                                id="detail" value="${each.detail}"/>
                                </div>
                            </div>

                            <!-- Due Day -->
                            <div class="form-group row">
                                <label class="control-label col-sm-2" for="dueDay">
                                    <b>Due:</b></label>
                                <div class="col-sm-8">
                                    <form:input class="form-control" path="dueDay" type="date"
                                                id="dueDay" value="${each.dueDay}"/>
                                        <%--<form:errors path="dueDay" cssClass="error" />--%>
                                </div>
                            </div>

                            <br>
                            <!-- Cancel or Confirm -->
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <button id="cancelButton" type="button"
                                            class="btn btn-secondary btn-lg btn-danger"
                                            data-dismiss="modal">Cancel Edit</button>
                                </div>
                                <div class="col-sm-2">
                                </div>
                                <div class="col-sm-6">
                                    <input type="submit" name="confirmEditButton"
                                           class="btn btn-success btn-lg"
                                           id="confirmEditButton" value="Confirm Edit"/>
                                </div>
                            </div>

                            <%--@elvariable id="_csrf" type="java"--%>
                            <input type="hidden"
                                   name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        </form:form>
                        <%--Previous values:--%>
                        <%--<p>--%>
                        <%--Title = ${each.title}<br>--%>
                        <%--Type = ${each.type}<br>--%>
                        <%--Priority = ${each.priority}<br>--%>
                        <%--Details = ${each.detail}<br>--%>
                        <%--Due Day = ${each.dueDay}<br>--%>
                        <%--</p>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Modal end -->
