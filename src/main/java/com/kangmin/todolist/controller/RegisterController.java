package com.kangmin.todolist.controller;

import com.kangmin.todolist.model.dto.UserRegisterDto;
import com.kangmin.todolist.model.entity.AuthorityType;
import com.kangmin.todolist.model.entity.User;
import com.kangmin.todolist.service.JavaEmailService;
import com.kangmin.todolist.service.UserService;
import com.kangmin.todolist.util.ModelAttributes;
import com.kangmin.todolist.util.StaticMethods;
import com.kangmin.todolist.util.UrlMappings;
import com.kangmin.todolist.util.ViewPages;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.time.LocalTime;
import java.util.Collection;

import static com.kangmin.todolist.util.ModelAttributes.HOME_MESSAGE;
import static com.kangmin.todolist.util.ModelAttributes.LOGIN_MESSAGE;
import static com.kangmin.todolist.util.ModelAttributes.REGISTER_ERROR;
import static com.kangmin.todolist.util.ModelAttributes.UNAUTHORIZED_MESSAGE;

@Slf4j
@Controller
public final class RegisterController {

    private final UserService userService;
    private final JavaEmailService javaEmailService;

    @Autowired
    public RegisterController(final UserService userService,
                              final JavaEmailService javaEmailService) {
        this.userService = userService;
        this.javaEmailService = javaEmailService;
    }

    @GetMapping(UrlMappings.REGISTER)
    public String showRegistrationPage(final Model model) {
        log.info("RegisterController: GET/register visited at {}:", UrlMappings.REGISTER);
        UserRegisterDto blankUserRegisterDto = new UserRegisterDto();
        blankUserRegisterDto.setRole("NORMAL");
        model.addAttribute(ModelAttributes.USER_DTO, blankUserRegisterDto);
        return ViewPages.REGISTER;
    }

    @PostMapping(UrlMappings.REGISTER)
    public String processRegistration(
            final HttpServletRequest request,
            final @Valid @ModelAttribute(ModelAttributes.USER_DTO) UserRegisterDto userRegisterDto,
            final BindingResult theBindingResult,
            final Model model,
            final Authentication auth,
            final RedirectAttributes redirectAttributes
    ) {
        log.info("POST/register request from dto-user: " + userRegisterDto + ", with URI: "
                + request.getRequestURI() + ", at local time: " + LocalTime.now());

        // final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!isAuthorizedToRegister(auth)) {
            model.addAttribute(UNAUTHORIZED_MESSAGE, "Your privilege can NOT register other users");
            return ViewPages.UNAUTHORIZED;
        }

        if (theBindingResult.hasErrors()) {
            log.info(theBindingResult.toString());
            model.addAttribute(REGISTER_ERROR, "Please check the error in related attribute!");
            return ViewPages.REGISTER;
        }

        final User u = StaticMethods.mapUserRegisterDtoToUser(userRegisterDto);
        final boolean createdSuccessful = userService.createUser(u);
        if (!createdSuccessful) {
            model.addAttribute(REGISTER_ERROR, "Register not successful, please contact admin");
            return ViewPages.REGISTER;
        }

        try {
            javaEmailService.sendPlainEmail(userRegisterDto.getEmail(),
                "MountKingX Spring MVC Application",
                "Hello There!\nThanks for your registration!\nYou can login and enjoy now");
        } catch (final Exception e) {
            e.printStackTrace();
        }

        if (isRequestFromAdmin(auth)) {
            redirectAttributes.addAttribute(HOME_MESSAGE, "Cool, you just created a new user!");
            return "redirect:/" + ViewPages.HOME;
        }

        model.addAttribute(LOGIN_MESSAGE, "Thanks for Registering! Please login and enjoy!");
        return ViewPages.LOGIN;
    }

    private boolean isAuthorizedToRegister(final Authentication auth) {
        // == new user can register for them self
        if (auth == null || auth.getName().equals("anonymousUser")) {
            return true;
        }
        // == logged-in ADMIN user can register a new ADMIN/NORMAL user
        // == logged-in NORMAL user can NOT register for other user
        return isRequestFromAdmin(auth);
    }

    private boolean isRequestFromAdmin(final Authentication auth) {
        if (auth == null) {
            return false;
        }
        final SimpleGrantedAuthority adminRole = new SimpleGrantedAuthority(AuthorityType.ROLE_ADMIN);
        final Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();
        return authorities.contains(adminRole);
    }
}
