package com.kangmin.todolist.controller;

import com.kangmin.todolist.service.ToDoItemService;
import com.kangmin.todolist.service.UserService;
import com.kangmin.todolist.util.ModelAttributes;
import com.kangmin.todolist.util.UrlMappings;
import com.kangmin.todolist.util.ViewPages;

import lombok.extern.slf4j.Slf4j;
import org.genericdao.RollbackException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.security.Principal;

// == user authenticated required in WebSecurityConfig.java ==
// == The purpose of home-page is to give information of all app ==

@Slf4j
@Controller
@RequestMapping("/home")
public final class HomeController {

    private final UserService userService;
    private final ToDoItemService toDoItemService;

    @Autowired
    public HomeController(final UserService userService,
                          final ToDoItemService toDoItemService
    ) {
        this.userService = userService;
        this.toDoItemService = toDoItemService;
    }

    @GetMapping(value = {"", UrlMappings.SLASH}, produces = "application/html; charset=UTF-8")
    public String showHomePage(
            final HttpServletRequest request,
            final HttpServletResponse response,
            final Model model,
            final Authentication auth
    ) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // == get logged-in user from auth ==
        // same as Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        final String username = auth.getName();
        // final long uid = userService.getUserId(username);
        model.addAttribute("user", userService.getUser(username));
        return ViewPages.HOME;
    }

    @PostMapping(value = {"", UrlMappings.SLASH}, produces = "application/html; charset=UTF-8")
    public String processAddItemInHomePage(
            final HttpServletRequest request,
            final HttpServletResponse response,
            final Model model,
            final Principal principal
    ) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // == get logged-in user with Principal ==
        final String username = principal.getName();
        model.addAttribute("user", userService.getUser(username));
        return ViewPages.HOME;
    }

    @ModelAttribute(ModelAttributes.NUM_OF_TO_DO_ITEMS)
    public int obtainNumOfActiveToDoItems() throws RollbackException {
        return toDoItemService.getNumOfActiveToDoItems(getLoggedInUserUid());
    }

    @ModelAttribute(ModelAttributes.NUM_OF_INACTIVE_ITEMS)
    public int obtainNumOfInActiveToDoItems() throws RollbackException {
        return toDoItemService.getNumOfInActiveToDoItems(getLoggedInUserUid());
    }

    private long getLoggedInUserUid() throws RollbackException {
        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        final String username = auth.getName();
        return userService.getUserId(username);
    }
}
