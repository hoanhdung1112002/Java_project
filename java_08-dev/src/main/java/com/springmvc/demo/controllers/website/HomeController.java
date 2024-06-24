package com.springmvc.demo.controllers.website;

import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.repositories.CategoryRepository;
import com.springmvc.demo.repositories.PostRepository;
import com.springmvc.demo.repositories.UserRepository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(path = "")
public class HomeController extends BaseController {
    @Autowired
    private PostRepository postRepository;
    
    @Autowired
    private UserRepository userRepository;
    
    /**
     * Home page
     * @param page
     * @param modelMap
     * @return
     */
    @RequestMapping(value = {"/home", ""}, method = RequestMethod.GET)
    public String Index(@RequestParam(value = "page", defaultValue = "1") int page, ModelMap modelMap) {
        Iterable<Post> posts = postRepository.getAllPosts(PageRequest.of(page-1, 10));
        List<Post> topLike = postRepository.getTopLike(PageRequest.of(0, 6));
        List<Post> topView = postRepository.getTopView(PageRequest.of(0, 6));
        List<Object[]> topUser = userRepository.getTopUser(PageRequest.of(0, 5));
        modelMap.addAttribute("posts", posts);
        modelMap.addAttribute("topLike", topLike);
        modelMap.addAttribute("topView", topView);
        modelMap.addAttribute("topUser", topUser);
        return "website/home";
    }
}