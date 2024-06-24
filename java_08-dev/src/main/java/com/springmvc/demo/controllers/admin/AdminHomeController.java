package com.springmvc.demo.controllers.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Notification;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.repositories.CategoryRepository;
import com.springmvc.demo.repositories.CommentRepository;
import com.springmvc.demo.repositories.NotifyRepository;
import com.springmvc.demo.repositories.PostRepository;
import com.springmvc.demo.repositories.UserRepository;

@Controller
@RequestMapping(path = "admin")
public class AdminHomeController extends BaseController{

    @Autowired
    private NotifyRepository notifyRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private UserRepository userRepository;

    /**
     * Admin home page
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String index() {
        return "admin/index";
    }

    @RequestMapping(path = "/statistical", method=RequestMethod.GET)
    public String statistical(ModelMap modelMap) {

        List<Notification> notifications = notifyRepository.getNotifyOfAdmin(PageRequest.of(0, 9));
        List<Object[]> categories = categoryRepository.getCategoryAndTotalPost(PageRequest.of(0, 5));
        List<Post> topPost = postRepository.getTopLike(PageRequest.of(0, 5));
        Long totalPost = postRepository.count();
        Long totalComment = commentRepository.count();
        Long totalUser = userRepository.count();

        modelMap.addAttribute("notifications", notifications)
            .addAttribute("categories", categories)
            .addAttribute("totalPost", totalPost)
            .addAttribute("totalComment", totalComment)
            .addAttribute("totalUser", totalUser)
            .addAttribute("topPost", topPost);

        return "admin/statistical/index";
    }
}
