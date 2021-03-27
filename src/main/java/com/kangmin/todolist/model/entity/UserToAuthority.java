package com.kangmin.todolist.model.entity;

import org.genericdao.PrimaryKey;

@PrimaryKey("uid,aid")
public class UserToAuthority {

    private long uid;
    private long aid;

    public final long getUid() {
        return uid;
    }

    public final void setUid(final long uid) {
        this.uid = uid;
    }

    public final long getAid() {
        return aid;
    }

    public final void setAid(final long aid) {
        this.aid = aid;
    }
}
