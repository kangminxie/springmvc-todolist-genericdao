package com.kangmin.todolist.model;

import com.kangmin.todolist.model.entity.User;

import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.genericdao.GenericDAO;
import org.genericdao.MatchArg;
import org.genericdao.RollbackException;

import java.util.Arrays;
import java.util.Comparator;

public class UserDAO extends GenericDAO<User> {

    public UserDAO(final ConnectionPool cp,
                   final String tableName) throws DAOException {
        super(User.class, tableName, cp);
    }

    public final User[] getAllUsers() throws RollbackException {
        final User[] users = match();
        Arrays.sort(users, Comparator.comparing(User::getFirstName));
        Arrays.sort(users, Comparator.comparing(User::getLastName));
        return users;
    }

    public final User[] getActiveUsers() throws RollbackException {
//        final User[] activeUsers = match(MatchArg.equals("disabled", false));
//        Arrays.sort(activeUsers, Comparator.comparing(User::getFirstName));
//        Arrays.sort(activeUsers, Comparator.comparing(User::getLastName));
//        return activeUsers;
        return match(MatchArg.equals("disabled", false));
    }

    public final User[] getDisabledUsers() throws RollbackException {
//        final User[] disabled = match(MatchArg.equals("disabled", true));
//        Arrays.sort(disabled, Comparator.comparing(User::getFirstName));
//        Arrays.sort(disabled, Comparator.comparing(User::getLastName));
//        return disabled;
        return match(MatchArg.equals("disabled", true));
    }

    public final User getUserByUserName(final String username) throws RollbackException {
        final User[] users = match(MatchArg.and(MatchArg.equals("username", username),
                                MatchArg.equals("disabled", false)));
        if (users == null || users.length == 0) {
            return null;
        }
        return users[0];
    }

    // different from read(id)
    public final User getActiveUserById(final long id) throws RollbackException {
        final User[] users = match(MatchArg.and(MatchArg.equals("id", id),
                MatchArg.equals("disabled", false)));
        if (users == null || users.length == 0) {
            return null;
        }
        return users[0];
    }
}
