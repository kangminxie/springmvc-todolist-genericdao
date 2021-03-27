package com.kangmin.todolist.controller;

import com.kangmin.todolist.util.UrlMappings;
import com.kangmin.todolist.util.ViewPages;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
public final class LoginController {

    // == login with GET/POST ==
    @RequestMapping(value = UrlMappings.LOGIN)
    public String processLoginForm() {
        log.info("LoginController /login GET/POST visited at {}: ", UrlMappings.LOGIN);

        // == check if user already logged-in ==
        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth.getName() == null || auth.getName().equals("anonymousUser")) {
            // == not logged-in ==
            return ViewPages.LOGIN;
        }
        // same idea, to be safe
        if (auth instanceof AnonymousAuthenticationToken) {
            // == not logged-in ==
            return ViewPages.LOGIN;
        }

        // == already logged-in ==
        return "redirect:" + UrlMappings.HOME;
    }

    // == logout with GET only  ==
    // == internally user click POST-logout, Spring deal with it and redirected to login?logout ==
//    @GetMapping(value = UrlMappings.LOGOUT)
//    public String logoutUser(
//            HttpServletRequest request,
//            HttpServletResponse response,
//            Model model) {
//        log.info("COME ON FROM LOGOUT GET CONTROLLER 05-04");
//        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        if (auth != null){
//            //request.getSession().invalidate();
//            new SecurityContextLogoutHandler().logout(request, response, auth);
//
//        }
//        request.getSession().invalidate();
//        final String GOODBYE_INFO = "You have been logged out. Have a great one!";
//        //model.addAttribute(LOGIN_MESSAGE, GOODBYE_INFO);
//        return ViewPages.LOGIN;
//    }
}
