package com.kangmin.todolist.service;

import com.kangmin.todolist.model.AuthorityDAO;
import com.kangmin.todolist.model.UserToAuthorityDAO;
import com.kangmin.todolist.model.entity.Authority;
import com.kangmin.todolist.model.entity.User;
import com.kangmin.todolist.model.entity.UserToAuthority;
import lombok.extern.slf4j.Slf4j;
import org.genericdao.MatchArg;
import org.genericdao.RollbackException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
public class MyUserDetails implements UserDetails {

    private final User user;
    private final AuthorityDAO authorityDAO;
    private final UserToAuthorityDAO userToAuthorityDAO;

    MyUserDetails(final User user,
                  final AuthorityDAO authorityDAO,
                  final UserToAuthorityDAO userToAuthorityDAO) {
        this.user = user;
        this.authorityDAO = authorityDAO;
        this.userToAuthorityDAO = userToAuthorityDAO;
    }

    @Override
    public final Collection<? extends GrantedAuthority> getAuthorities() {
        try {
            final UserToAuthority[] entries
                    = userToAuthorityDAO.match(
                            MatchArg.equals("uid", user.getId()));
            final List<Authority> authorities = new ArrayList<>();
            for (UserToAuthority entry : entries) {
                authorities.add(authorityDAO.read(entry.getAid()));
            }
            log.info(">>> Roles" + authorities);
            authorities.forEach(each -> System.out.println(each.getName()));
            return authorities.stream()
                    .map(authority ->
                            new SimpleGrantedAuthority(authority.getName()))
                    .collect(Collectors.toList());
        } catch (RollbackException e) {
            log.info("", e);
            return null;
        }
    }

    public final long getId() {
        return user.getId();
    }

    @Override
    public final String getPassword() {
        return user.getPassword();
    }

    @Override
    public final String getUsername() {
        return user.getUsername();
    }

    @Override
    public final boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public final boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public final boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public final boolean isEnabled() {
        return !user.isDisabled();
    }

//    public final User getUserDetails() {
//        return user;
//    }
}
