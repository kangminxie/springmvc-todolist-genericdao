package com.kangmin.todolist.controller;

import com.kangmin.todolist.model.dto.StudentDto;
import com.kangmin.todolist.service.tutorial.StudentService;
import com.kangmin.todolist.util.ModelAttributes;
import com.kangmin.todolist.util.UrlMappings;
import com.kangmin.todolist.util.ViewPages;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

@Slf4j
@Controller
@RequestMapping(UrlMappings.FORM_TEST_BASE)
public final class TutorialController {

    private final StudentService studentService;

    @Autowired
    public TutorialController(final StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping("/")
    @ResponseBody
    public String showHomePage() {
        return ViewPages.FORM_HOME;
    }

    // == form-version-01 ==
    @GetMapping(UrlMappings.FORM_01)
    public String showForm01() {
        return ViewPages.FORM_01_SHOW;
    }

    @PostMapping(UrlMappings.FORM_01)
    public String processForm01() {
        return ViewPages.FORM_01_RESULT;
    }


    // == form-version-02 ==
    @GetMapping(UrlMappings.FORM_02)
    public String showForm02() {
        return ViewPages.FORM_02_SHOW;
    }

    @PostMapping(UrlMappings.FORM_02)
    public String processForm02(final HttpServletRequest request,
                                final Model model) {
        final String fullName = request.getParameter("firstName") + " "
                + request.getParameter("lastName");
        model.addAttribute("userFullName", fullName);
        return ViewPages.FORM_02_RESULT;
    }


    // == form-version-03 ==
    @GetMapping(UrlMappings.FORM_03)
    public String showForm03() {
        return ViewPages.FORM_03_SHOW;
    }

    @PostMapping(UrlMappings.FORM_03)
    public String processForm03(final @RequestParam("firstName") String fn,
                                final @RequestParam("lastName") String ln,
                                final Model model) {
        final String fullName = fn + " " + ln;
        model.addAttribute("userFullName", fullName);
        return ViewPages.FORM_03_RESULT;
    }


    // == form-version-04 ==
    @GetMapping(UrlMappings.FORM_04)
    public String showForm04(final Model model) {
        final StudentDto s = new StudentDto();
        model.addAttribute("student", s);
        return ViewPages.FORM_04_SHOW;
    }

    @PostMapping(UrlMappings.FORM_04)
    public String processForm04(final @ModelAttribute("student") StudentDto s) {
        log.info("Student is: " + s.toString());
        return ViewPages.FORM_04_RESULT;
    }


    // == form-version-05 ==
    @GetMapping(UrlMappings.FORM_05)
    public String showForm05(final Model model) {
        final StudentDto blankStudentDTO = new StudentDto();
        model.addAttribute(ModelAttributes.STUDENT, blankStudentDTO);
        return ViewPages.FORM_05_SHOW;
    }

    @PostMapping(UrlMappings.FORM_05)
    public String processForm05(
            final @Valid @ModelAttribute(ModelAttributes.STUDENT) StudentDto s,
            final BindingResult theBindingResult,
            final Model model) {
        log.info("Student is: " + s.toString());
        if (theBindingResult.hasErrors()) {
            log.info(theBindingResult.toString());
            return ViewPages.FORM_05_SHOW;
        }

        final String helloMessage = studentService.sayHello(s);
        model.addAttribute(ModelAttributes.STUDENT_HELLO_MESSAGE, helloMessage);
        return ViewPages.FORM_05_RESULT;
    }


    // == form-version-06 ==
    @GetMapping(UrlMappings.FORM_06)
    public String showForm06(final Model model) {
        final StudentDto blankStudentDto = new StudentDto();
        model.addAttribute(ModelAttributes.STUDENT, blankStudentDto);
        return ViewPages.FORM_06_SHOW;
    }

    @PostMapping(UrlMappings.FORM_06)
    public String processForm06(
            final @Valid @ModelAttribute(ModelAttributes.STUDENT) StudentDto s,
            final BindingResult theBindingResult,
            final Model model
    ) {
        log.info("Student is: " + s.toString());
        if (theBindingResult.hasErrors()) {
            log.info(theBindingResult.toString());
            return ViewPages.FORM_06_SHOW;
        }

        final String helloMessage = studentService.sayHello(s);
        model.addAttribute(ModelAttributes.STUDENT_HELLO_MESSAGE, helloMessage);
        return ViewPages.FORM_06_RESULT;
    }

    // == Need to understand more ==
    @InitBinder
    public void initBinder(final WebDataBinder dataBinder) {
        final StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
    }
}
