package com.springmvc.demo.controllers.website;

import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Notification;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.NotifyRepository;

@Controller
@RequestMapping(path = "notify")
public class NotifyController extends BaseController{
    /**
     * Initializes
     */
    @Autowired
    private NotifyRepository notifyRepository;

    /**
     * Show list notify of user 
     * @param content
     * @param postID
     * @param session
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String showNotify(HttpSession session, @RequestParam(value = "page", defaultValue = "1") int page, ModelMap modelMap) {
        try {
            User userLogin = userLogin(session);
            if (userLogin != null) {
                Iterable<Notification> notifications = notifyRepository.getNotifyByUserID(userLogin, PageRequest.of(page-1, 10));
                modelMap.addAttribute("notifications", notifications);
            }
        } catch (Exception e) {}
        return "website/notify/index";
    }

    /**
     * Show details notify by ID Notification
     * @param ID
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/details/{ID}", method = RequestMethod.GET)
    public String details(@PathVariable("ID") Long ID, ModelMap modelMap) {
        Optional<Notification> notification = notifyRepository.findById(ID);
        modelMap.addAttribute("notification", notification.get());
        return "website/notify/details";
    }
}
