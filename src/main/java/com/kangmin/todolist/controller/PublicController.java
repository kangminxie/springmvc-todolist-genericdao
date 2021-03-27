package com.kangmin.todolist.controller;

import com.kangmin.todolist.util.ModelAttributes;
import com.kangmin.todolist.util.UrlMappings;
import com.kangmin.todolist.util.ViewPages;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;


@Slf4j
@Controller
public final class PublicController {

    // == deal with all public pages beyond login and register ==

    // == Index page ==
    @GetMapping({"/", UrlMappings.INDEX})
    public String showIndexPage() {
        return ViewPages.INDEX;
    }

    // == About page ==
    @RequestMapping(UrlMappings.ABOUT)
    public String showAboutPage() {
        return ViewPages.ABOUT;
    }

    // == Contact page ==
    @RequestMapping(UrlMappings.CONTACT)
    public String showContactPage() {
        return ViewPages.CONTACT;
    }

    // == Apply to all model and users here ==
    @ModelAttribute(ModelAttributes.WELCOME_MESSAGE)
    public String welcomeMessage() {
        return "Welcome to this Web Application!";
    }
}
