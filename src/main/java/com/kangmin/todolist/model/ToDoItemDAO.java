package com.kangmin.todolist.model;

import com.kangmin.todolist.model.entity.ToDoItem;
import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.genericdao.GenericDAO;
import org.genericdao.MatchArg;
import org.genericdao.RollbackException;


public class ToDoItemDAO extends GenericDAO<ToDoItem> {
    public ToDoItemDAO(final ConnectionPool cp,
                       final String tableName) throws DAOException {
        super(ToDoItem.class, tableName, cp);
    }

    public final ToDoItem[] getAllToDoItems() throws RollbackException {
        return match();
    }

    public final ToDoItem[] getToDoItems(final long uid) throws RollbackException {
        return match(MatchArg.and(MatchArg.equals("uid", uid),
                MatchArg.equals("done", false)));
    }

    public final ToDoItem[] getActiveToDoItems(final long uid) throws RollbackException {
        return match(MatchArg.and(MatchArg.equals("uid", uid),
                MatchArg.equals("backlog", false),
                MatchArg.equals("done", false)));
    }

    public final ToDoItem[] getInActiveToDoItems(final long uid) throws RollbackException {
        return match(MatchArg.and(MatchArg.equals("uid", uid),
                MatchArg.equals("backlog", true),
                MatchArg.equals("done", false)));
    }
}
