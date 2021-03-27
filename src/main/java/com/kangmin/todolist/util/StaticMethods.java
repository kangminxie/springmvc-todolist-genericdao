package com.kangmin.todolist.util;

import com.kangmin.todolist.model.dto.ToDoItemDto;
import com.kangmin.todolist.model.dto.UserRegisterDto;
import com.kangmin.todolist.model.entity.ToDoItem;
import com.kangmin.todolist.model.entity.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.LinkedHashMap;

public final class StaticMethods {

    private static final BCryptPasswordEncoder PASSWORD_ENCODER = new BCryptPasswordEncoder();
    private static final String UNKNOWN_FILED = "Unknown";

    protected StaticMethods() {
        super();
    }

    // for Asian Character
    public static void addUtf8CharEncodingSupport(
            final HttpServletRequest request,
            final HttpServletResponse response
    ) throws UnsupportedEncodingException {
        addCharEncodingSupport(request, response, "UTF-8");
    }

    // for
    private static void addCharEncodingSupport(
            final HttpServletRequest request,
            final HttpServletResponse response,
            final String type
    ) throws UnsupportedEncodingException {
        request.setCharacterEncoding(type);
        response.setCharacterEncoding(type);
    }

    public static ToDoItem mapDto2ToDoItem(final ToDoItemDto dto) {
        final ToDoItem item = new ToDoItem();
        item.setTitle(dto.getTitle());
        item.setType(dto.getType());
        item.setPriority(dto.getPriority());
        if (dto.getDetail() != null) {
            System.out.println("Dto Detail" + dto.getDetail());
            item.setDetail(dto.getDetail());
        }
        if (dto.getDueDay() != null) {
            item.setDueDay(dto.getDueDay());
        }
        item.setCreatedDay(new java.sql.Date(System.currentTimeMillis()));
        return item;
    }


    public static User mapUserRegisterDtoToUser(final UserRegisterDto t) {
        final User u = new User();
        u.setFirstName(t.getFirstName());
        u.setLastName(t.getLastName());
        u.setUsername(t.getUsername());
        u.setEmail(t.getEmail());
        u.setPassword(PASSWORD_ENCODER.encode(t.getPassword()));
        u.setCreatedDay(new Date(System.currentTimeMillis()));
        //u.setLastActiveDay(u.getCreatedDay());
        u.setAddressLine1(UNKNOWN_FILED);
        u.setAddressLine2(UNKNOWN_FILED);
        u.setCity(UNKNOWN_FILED);
        u.setCountry(UNKNOWN_FILED);
        u.setPhoneNumber(UNKNOWN_FILED);
        if (t.getRole() != null && !t.getRole().trim().equals("")) {
            // == for ADMIN to add ADMIN/NORMAL ==
            u.setRole(t.getRole());
        }
        return u;
    }

    public static LinkedHashMap<String, String> initToDoItemTypeOption() {
        final LinkedHashMap<String, String> typeOptions = new LinkedHashMap<>();
        typeOptions.put("Unknown", "-Type-");
        typeOptions.put("Family", "Family");
        typeOptions.put("Payment", "Payment");
        typeOptions.put("Personal", "Personal");
        typeOptions.put("Task", "Task");
        typeOptions.put("Work", "Work");
        return typeOptions;
    }

    public static LinkedHashMap<String, String> initToDoItemPriorityOption() {
        final LinkedHashMap<String, String> priorityOptions = new LinkedHashMap<>();
        priorityOptions.put("Normal", "Normal");
        priorityOptions.put("Minor", "Minor");
        priorityOptions.put("Important", "Important");
        priorityOptions.put("Urgent", "Urgent");
        priorityOptions.put("Super", "Super");
        return priorityOptions;
    }
}
