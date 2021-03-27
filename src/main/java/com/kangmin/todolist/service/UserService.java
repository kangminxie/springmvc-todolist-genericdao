package com.kangmin.todolist.service;

import com.kangmin.todolist.model.UserDAO;
import com.kangmin.todolist.model.UserToAuthorityDAO;
import com.kangmin.todolist.model.entity.User;
import com.kangmin.todolist.model.entity.UserToAuthority;

import lombok.extern.slf4j.Slf4j;
import org.genericdao.RollbackException;
import org.genericdao.Transaction;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class UserService {

    private final UserDAO userDAO;
    private final UserToAuthorityDAO userToAuthorityDAO;

    private static final long ROLE_NORMAL_AID = 1L;
    private static final long ROLE_ADMIN_AID = 2L;

    public UserService(
            final UserDAO userDAO,
            final UserToAuthorityDAO userToAuthorityDAO
    ) {
        this.userDAO = userDAO;
        this.userToAuthorityDAO = userToAuthorityDAO;
    }

    public final User[] getAllUsers() {
        try {
            Transaction.begin();
            final User[] users = userDAO.getAllUsers();
            Transaction.commit();
            return users;
        } catch (final RollbackException e) {
            log.warn("", e);
            return new User[0];
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }
    }

    public final User[] getActiveUsers() {
        try {
            Transaction.begin();
            final User[] users = userDAO.getActiveUsers();
            Transaction.commit();
            return users;
        } catch (RollbackException e) {
            log.warn("", e);
            return new User[0];
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }
    }

    public final User[] getDisabledUsers() {
        try {
            Transaction.begin();
            final User[] users = userDAO.getDisabledUsers();
            Transaction.commit();
            return users;
        } catch (RollbackException e) {
            log.warn("", e);
            return new User[0];
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }
    }

    // manually use Transaction
    public final boolean createUser(final User u) {
        try {
            Transaction.begin();
            log.info(">>> transaction just get started for user:" + u.getUsername());
            if (u.getRole() == null) {
                // new user, as logged-in plain user has been filtered out in Controller
                u.setRole("NORMAL");
            }
            this.userDAO.create(u);
            final long uid = this.getUserId(u.getUsername());
            log.info(">>>uid is: " + uid);
            final long aid;
            switch (u.getRole()) {
                case "NORMAL":
                    aid = ROLE_NORMAL_AID;
                    break;
                case "ADMIN":
                    aid = ROLE_ADMIN_AID;
                    break;
                default:
                    return false;
            }

            // must use default constructor for GenericDAO
            final UserToAuthority u2a = new UserToAuthority();
            u2a.setUid(uid);
            u2a.setAid(aid);
            this.userToAuthorityDAO.create(u2a);
            log.info("new User successfully created " + u.getUsername());
            Transaction.commit();
            return true;
        } catch (RollbackException e) {
            log.info("RollbackException>>>" + e);
            log.warn("", e);
            return false;
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }
    }

    public final User getUser(final long id) throws RollbackException {
        return userDAO.read(id);
    }

    public final User getUser(final String username) {
        try {
            Transaction.begin();
            final User u = userDAO.getUserByUserName(username);
            Transaction.commit();
            return u;
        } catch (RollbackException e) {
            log.info("RollbackException>>>getUser" + e);
            log.warn("", e);
            return null;
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }
    }

    public final long getUserId(final String username) throws RollbackException {
        final User u = userDAO.getUserByUserName(username);
        if (u == null) {
            log.info("Did not get user, return -1 for username=" + username);
            return -1L;
        }
        log.info("getUserId - Find user with id: " + u.getId());
        return u.getId();
    }

    public final void update(final User u) {
        try {
            Transaction.begin();
            this.userDAO.update(u);
            Transaction.commit();
        } catch (RollbackException e) {
            log.warn("", e);
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }
    }

    public final String disableOrEnableUser(final long uid) {
        try {
            Transaction.begin();
            final User u = this.userDAO.read(uid);
            final boolean previousDisabled = u.isDisabled();
            u.setDisabled(!previousDisabled);
            this.userDAO.update(u);
            Transaction.commit();
            if (previousDisabled) {
                return "Activated";
            }
            return "Disabled";
        } catch (RollbackException e) {
            log.warn("", e);
            return "FAILED";
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }
    }

    public final boolean terminateUser(final long uid) {
        try {
            Transaction.begin();
            this.userDAO.delete(uid);
            Transaction.commit();
            return true;
        } catch (RollbackException e) {
            log.warn("", e);
            return false;
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }
    }
}
