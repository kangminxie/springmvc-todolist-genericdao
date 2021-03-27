package com.kangmin.todolist.config.support;

//import com.mysql.jdbc.AbandonedConnectionCleanupThread;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

@Slf4j
@WebListener
public class ContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(final ServletContextEvent sce) {
        log.info(">>> Initialising Context...{}", "void contextInitialized");
    }

    @Override
    public final void contextDestroyed(final ServletContextEvent sce) {

        log.info(">>> Destroying Context...{}", "void contextDestroyed");

        final ClassLoader cl = Thread.currentThread().getContextClassLoader();
        final Enumeration<Driver> drivers = DriverManager.getDrivers();

        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            if (driver.getClass().getClassLoader() == cl) {
                try {
                    log.info(">>> Trying de-registering JDBC driver {}", driver);
                    DriverManager.deregisterDriver(driver);

                } catch (SQLException ex) {
                    log.error(">>> SQLException when de-registering JDBC driver {}", driver, ex);
                }
            } else {
                log.trace(">>> Not de-registering JDBC driver {} "
                        + "as it does not belong to this webapp's ClassLoader", driver);
            }
        }
//        try {
//            log.info("Calling MySQL AbandonedConnectionCleanupThread shutdown");
//            AbandonedConnectionCleanupThread.shutdown();
//
//        } catch (Exception e) {
//            log.error("Error calling MySQL AbandonedConnectionCleanupThread shutdown {}", e);
//        }
        //AbandonedConnectionCleanupThread.checkedShutdown();
    }
}
