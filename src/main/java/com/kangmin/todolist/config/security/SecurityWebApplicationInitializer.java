package com.kangmin.todolist.config.security;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;
import org.springframework.web.filter.CharacterEncodingFilter;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;

public class SecurityWebApplicationInitializer
        extends AbstractSecurityWebApplicationInitializer {

    // == test UTF-8 works or not for Spring Security's _Csrf chain ==
    @Override
    protected void beforeSpringSecurityFilterChain(final ServletContext servletContext) {
        FilterRegistration.Dynamic characterEncodingFilter
                = servletContext.addFilter("encodingFilter", new CharacterEncodingFilter());
        characterEncodingFilter.setInitParameter("encoding", "UTF-8");
        characterEncodingFilter.setInitParameter("forceEncoding", "true");
        characterEncodingFilter.addMappingForUrlPatterns(null, true, "/*");
    }
}
