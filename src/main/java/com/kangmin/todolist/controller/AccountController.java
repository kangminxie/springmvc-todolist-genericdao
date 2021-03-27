package com.kangmin.todolist.controller;

import com.kangmin.todolist.model.dto.UserEditInfoDto;
import com.kangmin.todolist.model.dto.UserEditPwdDto;
import com.kangmin.todolist.model.entity.User;
import com.kangmin.todolist.service.UserService;
import com.kangmin.todolist.util.UrlMappings;
import com.kangmin.todolist.util.ViewPages;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.UnsupportedEncodingException;

import static com.kangmin.todolist.util.ModelAttributes.HOME_ERROR;
import static com.kangmin.todolist.util.ModelAttributes.HOME_MESSAGE;

@Slf4j
@Controller
@RequestMapping({"/account", UrlMappings.ACCOUNT_BASE})
public final class AccountController {

    private final UserService userService;
    private final BCryptPasswordEncoder passwordEncoder;

    @Autowired
    public AccountController(
            final UserService userService,
            final BCryptPasswordEncoder passwordEncoder
    ) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    // == Account Login GET - redirect ==
    @GetMapping(value = UrlMappings.LOGIN)
    public String showAccountLoginPage() {
        return "redirect:/" + ViewPages.LOGIN;
    }

    // == Account Logout - redirect ==
    @RequestMapping(value = UrlMappings.LOGOUT)
    public String accountLogoutPage() {
        return "redirect:/" + ViewPages.LOGOUT;
    }

    // == Account Register GET - redirect ==
    @GetMapping(value = UrlMappings.REGISTER)
    public String showAccountRegisterPage() {
        return "redirect:/" + ViewPages.REGISTER;
    }

    // == Edit Profile GET ==
    @GetMapping(value = {UrlMappings.EDIT_INFORMATION})
    public String showEditInfoPage(
            final HttpServletRequest request,
            final HttpServletResponse response,
            final Model model,
            final Authentication auth
    ) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        final User u = userService.getUser(auth.getName());
        if (u == null) {
            model.addAttribute(HOME_ERROR, "User not Found!");
            return "redirect:/" + ViewPages.HOME;
        }
        final UserEditInfoDto dto = new UserEditInfoDto(u);
        model.addAttribute("user", dto);
        return "edit-info";
    }

    // == Edit Profile POST ==
    @PostMapping(value = {UrlMappings.EDIT_INFORMATION})
    public String processEditInfoPage(
            final HttpServletRequest request,
            final HttpServletResponse response,
            final @Valid @ModelAttribute("user") UserEditInfoDto dto,
            final BindingResult theBindingResult,
            final Model model,
            final Authentication auth,
            final RedirectAttributes redirectAttributes
    ) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        if (theBindingResult.hasErrors()) {
            log.info(theBindingResult.toString());
            model.addAttribute("edit_error", "Edit Information Error!");
            return "edit-info";
        }

        final User u = userService.getUser(auth.getName());
        if (u == null) {
            model.addAttribute(HOME_ERROR, "User not Found!");
            return "redirect:/" + ViewPages.HOME;
        }
        u.updateInfoFromEditDto(dto);
        userService.update(u);
        final String flashMessage = "You have successfully updated your information";
        redirectAttributes.addFlashAttribute(HOME_MESSAGE, flashMessage);
        return "redirect:/" + ViewPages.HOME;
    }

    // == Change Password GET ==
    @GetMapping(value = {UrlMappings.CHANGE_PASSWORD})
    public String showEditPwdPage(final Model model) {
        final UserEditPwdDto dto = new UserEditPwdDto();
        model.addAttribute("user_dto_pwd", dto);
        return "edit-pwd";
    }

    // == Change Password POST ==
    @PostMapping(value = {UrlMappings.CHANGE_PASSWORD})
    public String processEditPwdPage(
            final @Valid @ModelAttribute("user_dto_pwd") UserEditPwdDto dto,
            final BindingResult theBindingResult,
            final Model model,
            final Authentication auth,
            final RedirectAttributes redirectAttributes
    ) {
        if (theBindingResult.hasErrors()) {
            log.info(theBindingResult.toString());
            model.addAttribute("edit_error", "Edit Password Error - Check your forms");
            return "edit-pwd";
        }

        final User u = userService.getUser(auth.getName());
        if (u == null) {
            model.addAttribute("edit_error", "User not Found!");
            return "redirect:/" + ViewPages.HOME;
        }
        // == if current password is correct ==
        if (!passwordEncoder.matches(dto.getPassword(), u.getPassword())) {
            model.addAttribute("edit_error", "Previous Password Is Not Right");
            return "edit-pwd";
        }
        // == if new password and confirm are consistent ==
        if (!dto.getNewPassword().equals(dto.getNewPassword2())) {
            model.addAttribute("edit_error", "New Password does Not match");
            return "edit-pwd";
        }

        u.setPassword(passwordEncoder.encode(dto.getNewPassword()));
        userService.update(u);
        final String flashMessage = "You have successfully updated your password";
        redirectAttributes.addFlashAttribute(HOME_MESSAGE, flashMessage);
        return "redirect:/" + ViewPages.HOME;
    }
}
