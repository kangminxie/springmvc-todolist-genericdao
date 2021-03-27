package com.kangmin.todolist.controller;

import com.kangmin.todolist.model.dto.ToDoItemDto;
import com.kangmin.todolist.model.entity.ToDoItem;
import com.kangmin.todolist.service.ToDoItemService;
import com.kangmin.todolist.service.UserService;
import com.kangmin.todolist.util.ModelAttributes;
import com.kangmin.todolist.util.StaticMethods;
import com.kangmin.todolist.util.UrlMappings;
import com.kangmin.todolist.util.ViewPages;

import lombok.extern.slf4j.Slf4j;
import org.genericdao.RollbackException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.UnsupportedEncodingException;
import java.time.LocalTime;
import java.util.Optional;

@Slf4j
@Controller
@RequestMapping(UrlMappings.TO_DO_LIST)
public final class ToDoListController {

    private final UserService userService;
    private final ToDoItemService toDoItemService;

    @Autowired
    public ToDoListController(final UserService userService,
                              final ToDoItemService toDoItemService) {
        this.userService = userService;
        this.toDoItemService = toDoItemService;
    }

    @GetMapping(value = {"", UrlMappings.SLASH}, produces = "application/html; charset=UTF-8")
    public String showHomePage(final HttpServletRequest request,
                               final HttpServletResponse response,
                               final Model model
    ) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // == populate new Item model ==
        final ToDoItemDto draftItem = new ToDoItemDto();
        model.addAttribute(ModelAttributes.TO_DO_ITEM_DTO, draftItem);
        return ViewPages.TO_DO_LIST_HOME;
    }

    @PostMapping(value = {"", UrlMappings.SLASH}, produces = "application/html; charset=UTF-8")
    public String processAddItemInHomePage(
            final HttpServletRequest request,
            final HttpServletResponse response,
            final @Valid @ModelAttribute(ModelAttributes.TO_DO_ITEM_DTO) ToDoItemDto draftItem,
            final BindingResult theBindingResult,
            final Model model,
            final RedirectAttributes redirectAttributes
    ) throws RollbackException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        log.info("POST/add item request from item: " + draftItem + ", with URI: "
                + request.getRequestURI() + ", at local time: " + LocalTime.now());

        // == get user id from auth ==
        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        final String username = auth.getName();
        final long uid = userService.getUserId(username);

        // form has error, do not save and leave previous draft there
        if (theBindingResult.hasErrors()) {
            model.addAttribute(ModelAttributes.ERROR, "Error in adding new items, make sure a due day is chosen");
            // == due to form error, re-populate previous items models ==
            return ViewPages.TO_DO_LIST_HOME;
        }

        // instantiate new item from dto and create new item bounding to user's id
        final ToDoItem newItem = StaticMethods.mapDto2ToDoItem(draftItem);
        final boolean createdSuccessful = toDoItemService.createToDoItem(newItem, uid);
        if (!createdSuccessful) {
            model.addAttribute(ModelAttributes.ERROR, "Server failed to create new item");
            // == due to backend error, re-populate previous items models ==
            return ViewPages.TO_DO_LIST_HOME;
        }

        redirectAttributes.addFlashAttribute(ModelAttributes.MESSAGE, "Successfully created one item");
        return "redirect:/" + UrlMappings.TO_DO_LIST;
    }


    // == Add/Create GET from home page or URL link ==
    @GetMapping({"add", "/add"})
    public String showNewToDoItemForm(
            final HttpServletRequest request,
            final HttpServletResponse response,
            final Model model) throws UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        model.addAttribute(ModelAttributes.TO_DO_ITEM_DTO, new ToDoItemDto());
        return ViewPages.TO_DO_LIST_ADD;
    }

    // == Add/Create POST ==
    @PostMapping({"add", "/add"})
    public String processToDoItemForm(
            final HttpServletRequest request,
            final HttpServletResponse response,
            final @Valid @ModelAttribute(ModelAttributes.TO_DO_ITEM_DTO) ToDoItemDto itemDto,
            final BindingResult theBindingResult,
            final Model model,
            final RedirectAttributes redirectAttributes
    ) throws RollbackException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        log.info("POST/add item request from item: " + itemDto + ", with URI: "
                + request.getRequestURI() + ", at local time: " + LocalTime.now());

        // == come back to original form if there is error
        if (theBindingResult.hasErrors()) {
            model.addAttribute("error", "Error in adding new items");
            return ViewPages.TO_DO_LIST_ADD;
        }

        // == obtain information for new item ==
        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        final long uid = userService.getUserId(auth.getName());
        final ToDoItem newItem = StaticMethods.mapDto2ToDoItem(itemDto);
        newItem.setUid(uid);

        // == trying to create ==
        final boolean createdSuccessful = toDoItemService.createToDoItem(newItem, uid);
        final String flashMessage;
        if (createdSuccessful) {
            flashMessage = "You have successfully added a new to-do-item";
            redirectAttributes.addFlashAttribute(ModelAttributes.MESSAGE, flashMessage);
        } else {
            flashMessage = "Failed to create new item";
            redirectAttributes.addFlashAttribute(ModelAttributes.ERROR, flashMessage);
        }
        return "redirect:/" + UrlMappings.TO_DO_LIST;
    }


    // == Edit GET from home page or URL link ==
    @GetMapping("/edit/{id}")
    public String showEditForm(
            final HttpServletRequest request,
            final HttpServletResponse response,
            final @PathVariable("id") int id,
            final Model model
    ) throws RollbackException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // need to check if this item id belongs to the host uid
        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        final Optional<ToDoItem> targetOpt = getToDoItemFromAuthAndItemId(auth, id);
        if (!targetOpt.isPresent()) {
            model.addAttribute(ModelAttributes.UNAUTHORIZED_MESSAGE, "The item can not be edited by you!");
            return ViewPages.UNAUTHORIZED;
        }
        final ToDoItemDto draftItem = mapToDoItemToDto(targetOpt.get());
        model.addAttribute(ModelAttributes.TO_DO_ITEM_DTO, draftItem);
        return ViewPages.TO_DO_LIST_EDIT;
    }


    // == Edit POST ==
    @PostMapping("/edit/{id}")
    public String processEditingItem(
                final HttpServletRequest request,
                final HttpServletResponse response,
                final @PathVariable("id") int id,
                final @Valid @ModelAttribute(ModelAttributes.TO_DO_ITEM_DTO) ToDoItemDto editingDto,
                final BindingResult theBindingResult,
                final RedirectAttributes redirectAttributes,
                final Model model
    ) throws RollbackException, UnsupportedEncodingException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // == need to check if this item id belongs to the host uid ==
        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (isNotAuthorizedToManageThisItem(auth, id)) {
            model.addAttribute(ModelAttributes.UNAUTHORIZED_MESSAGE, "The item can not be edited by you!");
            return ViewPages.UNAUTHORIZED;
        }

        log.info("try editing item using Dto:" + editingDto);

        // == come back to original form if there is error
        if (theBindingResult.hasErrors()) {
            model.addAttribute(ModelAttributes.ERROR, "Error in editing existing items");
            return ViewPages.TO_DO_LIST_EDIT;
        }

        // finally we could save the update
        final boolean editSuccessful = this.toDoItemService.updateToDoItem(editingDto, id);
        final String flashMessage;
        if (editSuccessful) {
            flashMessage = "You have successfully updated one to-do-item";
            redirectAttributes.addFlashAttribute(ModelAttributes.MESSAGE, flashMessage);
        } else {
            flashMessage = "Error when editing, pass paras from Dto to item, or Transaction Error";
            redirectAttributes.addFlashAttribute(ModelAttributes.ERROR, flashMessage);
        }
        return "redirect:/" + UrlMappings.TO_DO_LIST;
    }


    // == PutBacklog POST, will do RedirectView ==
    @PostMapping("/backlog/{id}")
    public String backlogItem(final @PathVariable("id") int id,
                              final Model model,
                              final RedirectAttributes redirectAttributes)
            throws RollbackException {
        // need to check if this item id belongs to the host uid
        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (isNotAuthorizedToManageThisItem(auth, id)) {
            model.addAttribute(ModelAttributes.UNAUTHORIZED_MESSAGE, "The item can not be edited by you!");
            return ViewPages.UNAUTHORIZED;
        }

        final String type;
        final String infor;
        final String status = toDoItemService.backlogOrRecoverItemById(id);
        if (status.equals("FAILED")) {
            type = "error";
            infor = "Backlog attempt is Not successful";
        } else {
            type = "message";
            infor = "You just " + status + " one to-do-item successfully";
        }
        // == redirect to home, to avoid submitting form twice
        // return "redirect:/" + ViewPages.HOME; will not bring any redirected Information
        redirectAttributes.addFlashAttribute(type, infor);
        // == back to home ==
        return "redirect:/" + UrlMappings.TO_DO_LIST;
    }


    // == Delete/remove POST, will do RedirectView ==
    @RequestMapping("/delete/{id}")
    public String deleteItem(final @PathVariable("id") int id,
                             final Model model,
                             final RedirectAttributes redirectAttributes) throws RollbackException {

        log.info("ToDoListController delete/id Visited, with id=" + id);

        // need to check if this item id belongs to the host uid
        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (isNotAuthorizedToManageThisItem(auth, id)) {
            model.addAttribute(ModelAttributes.UNAUTHORIZED_MESSAGE, "The item can not be edited by you!");
            return ViewPages.UNAUTHORIZED;
        }

        final String type;
        final String infor;
        final boolean deleteSuccessful = toDoItemService.deleteToDoItemById(id);
        if (!deleteSuccessful) {
            type = "error";
            infor = "Delete attempt is Not successful";
        } else {
            type = "message";
            infor = "You just deleted one to-do-item successfully";
        }
        redirectAttributes.addFlashAttribute(type, infor);
        return "redirect:/" + UrlMappings.TO_DO_LIST;
    }

    @ModelAttribute(ModelAttributes.TO_DO_ITEMS)
    public ToDoItem[] obtainActiveToDoItems() throws RollbackException {
        return toDoItemService.getActiveToDoItems(getLoggedInUserId());
    }

    @ModelAttribute(ModelAttributes.INACTIVE_TO_DO_ITEMS)
    public ToDoItem[] obtainNotActiveToDoItems() throws RollbackException {
        return toDoItemService.getInActiveToDoItems(getLoggedInUserId());
    }

    // helper method to fetch the UserId of current loggedIn user
    private long getLoggedInUserId() throws RollbackException {
        final Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        final String username = auth.getName();
        return userService.getUserId(username);
    }

    // helper method to see if we can get an Item or not from uid-tid pair
    private Optional<ToDoItem> getToDoItemFromAuthAndItemId(final Authentication auth,
                                                            final long id) throws RollbackException {
        log.info("Try to see if the item is belong to current user with id {}", id);
        final long uid = userService.getUserId(auth.getName());
        return toDoItemService.getToDoItem(uid, id);
    }

    // helper method to determine if the item is belong to current user
    private boolean isNotAuthorizedToManageThisItem(final Authentication auth, final long id)
            throws RollbackException {
        return !getToDoItemFromAuthAndItemId(auth, id).isPresent();
    }

    private ToDoItemDto mapToDoItemToDto(final ToDoItem item) {
        final ToDoItemDto dto = new ToDoItemDto();
        dto.setId(item.getId());
        dto.setTitle(item.getTitle());
        dto.setType(item.getType());
        dto.setPriority(item.getPriority());
        dto.setDetail(item.getDetail());
        dto.setDueDay(item.getDueDay());
        return dto;
    }
}
