package com.kangmin.todolist.controller;

import com.kangmin.todolist.model.entity.User;
import com.kangmin.todolist.service.UserService;
import com.kangmin.todolist.util.ModelAttributes;
import com.kangmin.todolist.util.UrlMappings;
import com.kangmin.todolist.util.ViewPages;
import lombok.extern.slf4j.Slf4j;
import org.genericdao.RollbackException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import static com.kangmin.todolist.util.ModelAttributes.ADMIN_HOME_ERROR;
import static com.kangmin.todolist.util.ModelAttributes.ADMIN_HOME_MESSAGE;

// == user authenticated as ADMIN is required ==

@Slf4j
@Controller
@PropertySource("classpath:/config/meta-common.properties")
@RequestMapping(UrlMappings.ADMIN_BASE)
public final class AdminController {

    @Value("${current.app.version}")
    private String currentVersion;

    private final UserService userService;

    @Autowired
    public AdminController(final UserService userService) {
        this.userService = userService;
    }

    @GetMapping({"", "/", UrlMappings.INDEX})
    public String showAdminHomePage() {
        log.info("Admin Controller - Index/Home Visited at " + currentVersion);
        return ViewPages.ADMIN_HOME;
    }

    // == Current version page, only ADMIN can see ==
    @ResponseBody
    @RequestMapping(UrlMappings.VERSION)
    public String showCurrentVersion() {
        return "Current Webapp Version is: " + currentVersion;
    }

    @GetMapping(UrlMappings.USER_DETAIL + "/{id}")
    public String showUserDetail(
            final @PathVariable("id") int id,
            final Model model
    ) throws RollbackException {
        log.info(">>> ADMIN controller, user detail visited with id:" + id);

        final User u = userService.getUser(id);
        if (u == null) {
            model.addAttribute(ADMIN_HOME_ERROR, "Please make sure user id is valid");
            return ViewPages.ADMIN_HOME;
        }
        model.addAttribute("user", u);
        return ViewPages.USER_DETAIL;
    }

    @PostMapping("/disable/{id}")
    public String processDisableUser(
            final @PathVariable("id") int id,
            final RedirectAttributes redirectAttributes
    ) {
        log.info("disable visited with id:" + id);

        final String status = this.userService.disableOrEnableUser(id);
        final String message = " You have successfully " + status + " one user";
        redirectAttributes.addFlashAttribute(ADMIN_HOME_MESSAGE, message);
        return "redirect:/" + UrlMappings.ADMIN_BASE;
    }

    @PostMapping("/terminate/{id}")
    public String processRemoveUser(
            final @PathVariable("id") int id,
            final RedirectAttributes redirectAttributes
    ) {
        log.info("terminate user with id:" + id);

        if (this.userService.terminateUser(id)) {
            redirectAttributes.addFlashAttribute(ADMIN_HOME_MESSAGE, "successfully terminate user with id:" + id);
        } else {
            redirectAttributes.addFlashAttribute(ADMIN_HOME_ERROR, "Exception when terminating user with id:" + id);
        }
        return "redirect:/" + UrlMappings.ADMIN_BASE;
    }


    @ModelAttribute(ModelAttributes.ALL_USERS)
    public User[] obtainAllUsers() {
        return this.userService.getAllUsers();
    }

    @ModelAttribute(ModelAttributes.ACTIVE_USERS)
    public User[] obtainActiveUsers() {
        return this.userService.getActiveUsers();
    }

    @ModelAttribute(ModelAttributes.DISABLED_USERS)
    public User[] obtainDisabledUsers() {
        return this.userService.getDisabledUsers();
    }
}
