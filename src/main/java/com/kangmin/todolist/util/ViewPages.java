package com.kangmin.todolist.util;

public final class ViewPages {

    public static final String INDEX = "index";
    public static final String HOME = "home";
    public static final String LOGIN = "login";
    public static final String LOGOUT = "logout";
    public static final String REGISTER = "register";
    public static final String ABOUT = "about";
    public static final String CONTACT = "contact";
    public static final String UNAUTHORIZED = "access-denied";

    // == for Admin ==
    private static final String ADMIN_BASE = "admin";
    public static final String ADMIN_HOME = ADMIN_BASE + "/admin-home";
    public static final String USER_DETAIL = ADMIN_BASE + "/user-detail";

    // == for ToDoList ==
    public static final String TO_DO_LIST_BASE = "to-do-list";
    public static final String TO_DO_LIST_HOME = TO_DO_LIST_BASE + "/to-do-list";
    public static final String TO_DO_LIST_ADD = TO_DO_LIST_BASE + "/add-item";
    public static final String TO_DO_LIST_EDIT = TO_DO_LIST_BASE + "/edit-item";

    // == for FormTest ==
    private static final String FORM_BASE = "form-test/";
    public static final String FORM_HOME = FORM_BASE + "form-home";
    public static final String FORM_01_SHOW = FORM_BASE + "form-01";
    public static final String FORM_02_SHOW = FORM_BASE + "form-02";
    public static final String FORM_03_SHOW = FORM_BASE + "form-03";
    public static final String FORM_04_SHOW = FORM_BASE + "form-04";
    public static final String FORM_05_SHOW = FORM_BASE + "form-05";
    public static final String FORM_06_SHOW = FORM_BASE + "form-06";

    public static final String FORM_01_RESULT = FORM_BASE + "form-01-result";
    public static final String FORM_02_RESULT = FORM_BASE + "form-02-result";
    public static final String FORM_03_RESULT = FORM_BASE + "form-03-result";
    public static final String FORM_04_RESULT = FORM_BASE + "form-04-result";
    public static final String FORM_05_RESULT = FORM_BASE + "form-05-result";
    public static final String FORM_06_RESULT = FORM_BASE + "form-06-result";

    private ViewPages() {
        super();
    }
}
