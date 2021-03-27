package com.kangmin.todolist.model.dto;

import com.kangmin.todolist.util.StaticMethods;
import lombok.Data;
import org.springframework.stereotype.Component;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.sql.Date;
import java.util.LinkedHashMap;

@Data
@Component
public class ToDoItemDto {

    // can be none
    private long id;

    @NotNull
    @Size (min = 1, message = "is required")
    private String title;

    // not required
    private String detail;

    @NotNull (message = "type is required")
    private String type;

    @NotNull (message = "priority is required")
    private String priority;

    @NotNull (message = "due day is required")
    private Date dueDay;

    private LinkedHashMap<String, String> typeOptions;
    private LinkedHashMap<String, String> priorityOptions;

    public ToDoItemDto() {
        initTypeOption();
        initPriorityOption();
        this.title = "Title is required";
        this.detail = "详细内容";
    }

    private void initTypeOption() {
        this.typeOptions = StaticMethods.initToDoItemTypeOption();
    }

    private void initPriorityOption() {
        this.priorityOptions = StaticMethods.initToDoItemPriorityOption();
    }
}
