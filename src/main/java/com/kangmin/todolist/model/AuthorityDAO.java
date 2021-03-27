package com.kangmin.todolist.model;

import com.kangmin.todolist.model.entity.Authority;
import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.genericdao.GenericDAO;

public class AuthorityDAO extends GenericDAO<Authority> {

    public AuthorityDAO(final ConnectionPool cp,
                        final String tableName) throws DAOException {
        super(Authority.class, tableName, cp);
    }
}
