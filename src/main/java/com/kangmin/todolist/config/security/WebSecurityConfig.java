package com.kangmin.todolist.config.security;

import com.kangmin.todolist.config.dao.DaoConfig;
import com.kangmin.todolist.model.AuthorityDAO;
import com.kangmin.todolist.model.UserDAO;
import com.kangmin.todolist.model.UserToAuthorityDAO;
import com.kangmin.todolist.service.UserDetailServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;

@Import({
        DaoConfig.class,
        PasswordEncoderConfig.class,
})
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

    private final UserDAO userDAO;
    private final AuthorityDAO authorityDAO;
    private final UserToAuthorityDAO userToAuthorityDAO;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    WebSecurityConfig(final UserDAO userDAO,
                      final AuthorityDAO authorityDAO,
                      final UserToAuthorityDAO userToAuthorityDAO,
                      final PasswordEncoder passwordEncoder) {
        this.userDAO = userDAO;
        this.authorityDAO = authorityDAO;
        this.userToAuthorityDAO = userToAuthorityDAO;
        this.passwordEncoder = passwordEncoder;
    }

    @Bean
    public UserDetailsService userDetailsService() {
        return new UserDetailServiceImpl(userDAO, authorityDAO, userToAuthorityDAO);
    }


    @Override
    protected final void configure(final AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService())
            .passwordEncoder(passwordEncoder);

        // == same as using Provider, see below
        //auth.authenticationProvider(authenticationProvider());
    }

    @Override
    protected final void configure(final HttpSecurity http) throws Exception {
        http.authorizeRequests()
                .antMatchers("/", "/register", "/about", "/contact",
                        "/resources/**", "/images/**")
                    .permitAll()
                .antMatchers("/list", "/list/", "/edit", "/edit/*", "/home", "/home/",
                        "/account/*", "/form-test/**")
                    .hasAnyRole("NORMAL", "ADMIN")
                .antMatchers("/private/**")
                    .hasRole("ADMIN")
                .and()
                    .formLogin()
                    .loginPage("/login")
                    .loginProcessingUrl("/authenticateTheUser")
                    .defaultSuccessUrl("/home")
                .and()
                    .logout().permitAll()
                    .logoutSuccessUrl("/login?logout=true")
                    .deleteCookies("JSESSIONID")
                    .invalidateHttpSession(true)
                .and()
                    .exceptionHandling().accessDeniedPage("/access-denied");
    }

    // == another way to configure userDetailsService() and passwordEncoder via Provider
//    @Bean
//    public DaoAuthenticationProvider authenticationProvider() {
//        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
//        authProvider.setUserDetailsService(userDetailsService());
//        authProvider.setPasswordEncoder(passwordEncoder());
//        return authProvider;
//    }
}

