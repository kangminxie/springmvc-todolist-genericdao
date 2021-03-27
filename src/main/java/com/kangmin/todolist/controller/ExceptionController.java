package com.kangmin.todolist.controller;

import com.kangmin.todolist.util.ModelAttributes;
import com.kangmin.todolist.util.UrlMappings;
import com.kangmin.todolist.util.ViewPages;
import lombok.extern.slf4j.Slf4j;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Slf4j
@Controller
public final class ExceptionController {

    @RequestMapping(value = UrlMappings.UNAUTHORIZED)
    public String showUnauthorizedPage(
            final Model model,
            final @Nullable @RequestParam("redirectInfo") String redirectInfo
    ) {
        model.addAttribute(ModelAttributes.UNAUTHORIZED_MESSAGE, redirectInfo);
        return ViewPages.UNAUTHORIZED;
    }
}

