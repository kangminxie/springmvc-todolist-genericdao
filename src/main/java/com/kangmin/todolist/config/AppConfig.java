package com.kangmin.todolist.config;

import com.kangmin.todolist.config.dao.DaoConfig;
import com.kangmin.todolist.config.support.JavaMailSenderConfig;
import com.kangmin.todolist.config.support.MessageConverterConfig;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Import({
        DaoConfig.class,
        JavaMailSenderConfig.class,
        MessageConverterConfig.class,
})
@Configuration
@ComponentScan(basePackages = "com.kangmin.todolist")
public class AppConfig {

    // scanned package for all components including DAO config
    // import java mail support
}
