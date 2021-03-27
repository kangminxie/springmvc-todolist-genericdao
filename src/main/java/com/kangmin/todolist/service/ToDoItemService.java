package com.kangmin.todolist.service;

import com.kangmin.todolist.model.ToDoItemDAO;
import com.kangmin.todolist.model.dto.ToDoItemDto;
import com.kangmin.todolist.model.entity.ToDoItem;
import lombok.extern.slf4j.Slf4j;
import org.genericdao.MatchArg;
import org.genericdao.RollbackException;
import org.genericdao.Transaction;
import org.springframework.stereotype.Component;

import java.util.Optional;


@Slf4j
@Component
public class ToDoItemService {

    private final ToDoItemDAO toDoItemDAO;

    public ToDoItemService(final ToDoItemDAO toDoItemDAO) {
        this.toDoItemDAO = toDoItemDAO;
    }

    // method to get one user's all toDoItems from his/her user id
//    public final ToDoItem[] getToDoItems(final long uid) throws RollbackException {
//        return toDoItemDAO.getToDoItems(uid);
//    }

    // method to get one user's active toDoItems from his/her user id
    public final ToDoItem[] getActiveToDoItems(final long uid) throws RollbackException {
        return toDoItemDAO.getActiveToDoItems(uid);
    }

    // method to get one user's active toDoItems # from his/her user id
    public final int getNumOfActiveToDoItems(final long uid) throws RollbackException {
        return toDoItemDAO.getActiveToDoItems(uid).length;
    }

    // method to get one user's in-active toDoItems from his/her user id
    public final ToDoItem[] getInActiveToDoItems(final long uid) throws RollbackException {
        return toDoItemDAO.getInActiveToDoItems(uid);
    }

    // method to get one user's active toDoItems # from his/her user id
    public final int getNumOfInActiveToDoItems(final long uid) throws RollbackException {
        return toDoItemDAO.getInActiveToDoItems(uid).length;
    }

    // method trying to get an particular toDoItem from user id and item id
    public final Optional<ToDoItem> getToDoItem(final long uid, final long tid) {
        try {
            Transaction.begin();
            final ToDoItem[] items = this.toDoItemDAO.match(MatchArg.and(
                    MatchArg.equals("uid", uid),
                    MatchArg.equals("id", tid)));
            Transaction.commit();
            if (items == null || items.length == 0) {
                return Optional.empty();
            } else {
                return Optional.of(items[0]);
            }
        } catch (final RollbackException e) {
            log.info(e.toString());
            return Optional.empty();
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }

    }

    // method to create a new ToDoItem
    public final boolean createToDoItem(final ToDoItem item, final long uid) {
        try {
            Transaction.begin();
            item.setUid(uid);
            item.setCreatedDay(new java.sql.Date(System.currentTimeMillis()));
            this.toDoItemDAO.create(item);
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

    // method to update a existing ToDoItem
    public final boolean updateToDoItem(final ToDoItemDto dto, final long uid) {
        try {
            Transaction.begin();
            final ToDoItem target = toDoItemDAO.read(uid);
            final boolean preUpdateSuccess = editToDoItemFromDto(target, dto);
            if (!preUpdateSuccess) {
                return false;
            }
            this.toDoItemDAO.update(target);
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

    // method to delete a ToDoItem
    public final boolean deleteToDoItemById(final long tid) {
        try {
            Transaction.begin();
            this.toDoItemDAO.delete(tid);
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

    // method to put Item to Backlog
    public final String backlogOrRecoverItemById(final long tid) {
        try {
            Transaction.begin();
            final ToDoItem target = toDoItemDAO.read(tid);
            final boolean previousBacklog = target.isBacklog();
            target.setBacklog(!previousBacklog);
            this.toDoItemDAO.update(target);
            Transaction.commit();
            if (previousBacklog) {
                return "Re-Activated";
            }
            return "Backlogged";
        } catch (RollbackException e) {
            log.warn("", e);
            return "FAILED";
        } finally {
            if (Transaction.isActive()) {
                Transaction.rollback();
            }
        }
    }

    // helper method to update a current item using editing dto
    private boolean editToDoItemFromDto(final ToDoItem item, final ToDoItemDto dto) {
        try {
            item.setTitle(dto.getTitle());
            item.setType(dto.getType());
            item.setPriority(dto.getPriority());
            item.setDetail(dto.getDetail());
            item.setDueDay(dto.getDueDay());
            return true;
        } catch (Exception e) {
            log.info("", e);
            return false;
        }
    }
}
