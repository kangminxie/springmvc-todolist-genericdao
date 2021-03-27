package com.kangmin.todolist.config.dao;

import com.kangmin.todolist.config.database.JdbcConnectionPoolConfig;
import com.kangmin.todolist.model.AuthorityDAO;

import com.kangmin.todolist.model.ToDoItemDAO;
import com.kangmin.todolist.model.UserDAO;
import com.kangmin.todolist.model.UserToAuthorityDAO;
import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Import({
        JdbcConnectionPoolConfig.class,
})
@Configuration
public class DaoConfig {

    private final ConnectionPool connectionPool;

    @Autowired
    public DaoConfig(final ConnectionPool connectionPool) {
        this.connectionPool = connectionPool;
    }

    @Bean
    public UserDAO userDAO() throws DAOException {
        return new UserDAO(connectionPool, DatabaseTableName.USER);
    }

    @Bean
    public AuthorityDAO authorityDAO() throws DAOException {
        return new AuthorityDAO(connectionPool, DatabaseTableName.AUTHORITY);
    }

    @Bean
    public UserToAuthorityDAO userToAuthorityDAO() throws DAOException {
        return new UserToAuthorityDAO(connectionPool, DatabaseTableName.USER_TO_AUTHORITY);
    }

    @Bean
    public ToDoItemDAO toDoItemDAO() throws DAOException {
        return new ToDoItemDAO(connectionPool, DatabaseTableName.TO_DO_ITEM);
    }
}
