package com.kangmin.todolist.model.entity;

import lombok.Data;
import org.genericdao.MaxSize;
import org.genericdao.PrimaryKey;

import java.sql.Date;

@Data
@PrimaryKey("id")
public class ToDoItem {

    private long id;
    private long uid;
    private String title;
    private String detail;
    private String type;
    private String priority;
    private boolean done;
    private boolean backlog;
    private Date createdDay;
    private Date dueDay;

    @MaxSize(1023)
    public final void setDetail(final String s) {
        this.detail = s;
    }
}
