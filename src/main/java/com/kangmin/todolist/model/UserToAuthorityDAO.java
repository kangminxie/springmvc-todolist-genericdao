package com.kangmin.todolist.model;

import com.kangmin.todolist.model.entity.UserToAuthority;
import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.genericdao.GenericDAO;

public class UserToAuthorityDAO extends GenericDAO<UserToAuthority> {

    public UserToAuthorityDAO(final ConnectionPool cp,
                              final String tableName) throws DAOException {
        super(UserToAuthority.class, tableName, cp);
    }
}
