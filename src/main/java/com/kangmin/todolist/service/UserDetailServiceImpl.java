package com.kangmin.todolist.service;

import com.kangmin.todolist.model.AuthorityDAO;
import com.kangmin.todolist.model.UserDAO;
import com.kangmin.todolist.model.UserToAuthorityDAO;
import com.kangmin.todolist.model.entity.User;
import lombok.extern.slf4j.Slf4j;
import org.genericdao.RollbackException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.Date;

@Slf4j
@Component
public class UserDetailServiceImpl implements UserDetailsService {

    private final UserDAO userDAO;
    private final AuthorityDAO authorityDAO;
    private final UserToAuthorityDAO userToAuthorityDAO;

    public UserDetailServiceImpl(final UserDAO userDAO,
                                 final AuthorityDAO authorityDAO,
                                 final UserToAuthorityDAO userToAuthorityDAO) {
        this.userDAO = userDAO;
        this.authorityDAO = authorityDAO;
        this.userToAuthorityDAO = userToAuthorityDAO;
    }

    @Override
    public final UserDetails loadUserByUsername(final String username)
            throws UsernameNotFoundException {
        User user = null;
        try {
            user = userDAO.getUserByUserName(username);
            if (user == null) {
                throw new UsernameNotFoundException("User not found.");
            }
            user.setLastActiveDay(new Date(System.currentTimeMillis()));
            userDAO.update(user);
        } catch (RollbackException e) {
            log.warn("", e);
        }

        log.info("loadUserByUsername() : {}", username);
        return new MyUserDetails(user, authorityDAO, userToAuthorityDAO);
    }
}
