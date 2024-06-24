package com.springmvc.demo.controllers.admin;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Notification;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.NotifyRepository;
import com.springmvc.demo.services.NotifyService;

@Controller
@RequestMapping(path = "admin/notify")
public class AdminNotifyController extends BaseController{

    @Autowired
    NotifyService notifyService;

    @Autowired
    NotifyRepository notifyRepository;

    /**
     * Get all notify of admin
     * @return 
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index(ModelMap modelMap) {
        List<Notification> notifications = notifyRepository.getNotifyOfAdmin(PageRequest.of(0, 1000));
        modelMap.addAttribute("notifications", notifications);
        return "admin/notify/index";
    }

    /**
     * Show view notifications
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap modelMap) {
        modelMap.addAttribute("notifications", new Notification());
        return "admin/notify/create";
    }

    /**
     * Xử lý thêm thông báo
     * @param modelMap
     * @param notify
     * @param bindingResult
     * @return
     */
    @RequestMapping(value = "/store", method = RequestMethod.POST)
    public String store(
        ModelMap modelMap, 
        @Valid @ModelAttribute("notifications") Notification notify, 
        BindingResult bindingResult,
        HttpSession session) 
    {
        if (!bindingResult.hasErrors()) {
            try {
                User userLogin = userLogin(session);

                notify.setStatus(1);
                notify.setType(4); // ADMIN SEND
                notify.setUserSend(userLogin);
                notifyRepository.save(notify);

                modelMap.addAttribute("success", "Thông báo đã được tạo thành công");
                return "redirect:/admin/notify";
            } catch (Exception e) {
                modelMap.addAttribute("error", "Đã có lỗi xảy ra");
            }
        }
        return "admin/notify/create";
    }

    /**
     * Show view edit notifications
     * @param modelMap
     * @param ID
     * @return
     */
    @RequestMapping(value = "/edit/{ID}", method = RequestMethod.GET)
    public String edit(ModelMap modelMap,  @PathVariable("ID") Long ID) {
        modelMap.addAttribute("notify", notifyRepository.findById(ID).get());
        return "admin/notify/edit";
    }

    /**
     * Xử lý sửa thông báo
     * @param modelMap
     * @param post
     * @param bindingResult
     * @param ID
     * @return
     */
    @RequestMapping(value = "/update/{ID}", method = RequestMethod.POST)
    public String update(
        ModelMap modelMap, 
        @Valid @ModelAttribute("notify") Notification notify, 
        BindingResult bindingResult,
        @PathVariable Long ID)
    {
        if (!bindingResult.hasErrors()) {
            try {
                if (notifyRepository.findById(ID).isPresent()) {
                    Notification findNotify = notifyRepository.findById(ID).get();

                    if (!notify.getTitle().trim().isEmpty()) findNotify.setTitle(notify.getTitle());
                    if (!notify.getContent().trim().isEmpty()) findNotify.setContent(notify.getContent());

                    findNotify.setUpdatedAt(new Date());

                    notifyRepository.save(findNotify);
                    modelMap.addAttribute("success", "Cập nhật thông tin thành công");
                }
            } catch (Exception e) {
                modelMap.addAttribute("error", e.toString());
            }
        }
        return "admin/notify/edit";
    }
    /**
     * Delete a notify
     * @param ID
     * @return
     */
    @RequestMapping(value = "/delete/{ID}", method = RequestMethod.POST)
    public ResponseEntity<String> destroy(@PathVariable Long ID) {
        try {
            notifyRepository.deleteById(ID);
            return new ResponseEntity<>("Notify deleted successfully", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Failed to delete notify", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}