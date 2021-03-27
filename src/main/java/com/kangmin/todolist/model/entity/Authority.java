package com.kangmin.todolist.model.entity;

import org.genericdao.PrimaryKey;

@PrimaryKey("id")
public class Authority {

    private long id;
    private String name;

    public Authority() {

    }

    public Authority(final String name) {
        switch (name) {
            case AuthorityType.ROLE_ADMIN:
            case AuthorityType.ROLE_NORMAL:
                this.name = name;
                break;
            default:
                this.name = AuthorityType.ROLE_UNKNOWN;
        }
    }

    public final long getId() {
        return id;
    }

    public final void setId(final long id) {
        this.id = id;
    }

    public final String getName() {
        return name;
    }

    public final void setName(final String name) {
        switch (name) {
            case AuthorityType.ROLE_ADMIN:
            case AuthorityType.ROLE_NORMAL:
                this.name = name;
                break;
            default:
                this.name = AuthorityType.ROLE_UNKNOWN;
        }
    }
}
