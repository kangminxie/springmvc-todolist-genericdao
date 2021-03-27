package com.kangmin.todolist.config.database;

import org.genericdao.ConnectionPool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;

import java.util.Properties;

@Configuration
@PropertySource("classpath:/config/persistence-mysql.properties")
public class JdbcConnectionPoolConfig {

    private static final String JDBC_DRIVER_NAME = "jdbc.driver";
    private static final String JDBC_URL = "jdbc.url";
    private static final String JDBC_USER = "jdbc.user";
    private static final String JDBC_PASSWORD = "jdbc.password";

    private final Environment env;

    @Autowired
    JdbcConnectionPoolConfig(final Environment env) {
        this.env = env;
    }

    @Bean
    public ConnectionPool connectionPool(final Properties jdbcProperties) {
        final String jdbcDriverName = jdbcProperties.getProperty(JDBC_DRIVER_NAME);
        final String jdbcURL = jdbcProperties.getProperty(JDBC_URL);
        final String jdbcUser = jdbcProperties.getProperty(JDBC_USER);
        final String jdbcPassword = jdbcProperties.getProperty(JDBC_PASSWORD);
        return new ConnectionPool(jdbcDriverName, jdbcURL, jdbcUser, jdbcPassword);
    }

    // == take params from persistence-mysql.properties and load to Properties ==
    @Bean
    public Properties jdbcProperties() {
        final Properties prop = new Properties();
        prop.setProperty(JDBC_DRIVER_NAME, env.getProperty("jdbc.driver"));
        prop.setProperty(JDBC_URL, env.getProperty("jdbc.url"));
        prop.setProperty(JDBC_USER, env.getProperty("jdbc.user"));
        prop.setProperty(JDBC_PASSWORD, env.getProperty("jdbc.password"));
        return prop;
    }
}
