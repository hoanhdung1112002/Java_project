package com.springmvc.demo.controllers.admin;

import com.springmvc.demo.Utilities.Functions;
import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.Report;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.CategoryRepository;
import com.springmvc.demo.repositories.PostRepository;
import com.springmvc.demo.repositories.ReportRepository;
import com.springmvc.demo.repositories.UserRepository;

import java.util.Date;
import java.util.Optional;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping(path = "admin/posts")
public class AdminPostController extends BaseController {
    @Autowired
    private PostRepository postRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ReportRepository reportRepository;

    /**
     * Show list post
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String getAllPosts(ModelMap modelMap) {
        Page<Post> posts = postRepository.getAllPosts(PageRequest.of(0, 100));
        modelMap.addAttribute("posts", posts);
        return "admin/post/index";
    }

    /**
     * Show view create post
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap modelMap) {
        modelMap.addAttribute("categories", categoryRepository.findAllCategory());
        modelMap.addAttribute("post", new Post());
        return "admin/post/create";
    }

    /**
     * Handle create post
     * @param modelMap
     * @param post
     * @param bindingResult
     * @return View admin/post/create
     */
    @RequestMapping(value = "/store", method = RequestMethod.POST)
    public String store(
        ModelMap modelMap,
        @Valid @ModelAttribute("post") Post post,
        BindingResult bindingResult,
        HttpSession session,
        @RequestParam("_avatar") MultipartFile avatarFile)
    {
        if (!bindingResult.hasErrors()) {
            try {
                if (!uploadFile(avatarFile).isEmpty()) {
                    post.setAvatar(uploadFile(avatarFile));
                }

                User authLogin = userLogin(session);
                String slug = Functions.makeSlug(post.getTitle());  //su-dung-colab-train-yolov5-voi-custom-dataset-phat-hien-cac-oi-tuong-ac-thu.html
                post.setUserID(userRepository.findById(authLogin.getID()).orElse(null));
                post.setSlug(slug);
                post.setStatus(1);
                postRepository.save(post);

                modelMap.addAttribute("success", "Bài viết đã được đăng tải");
            } catch (Exception e) {
                modelMap.addAttribute("error", "Đã có lỗi xảy ra");
            }
        }
        modelMap.addAttribute("categories", categoryRepository.findAllCategory());
        return "admin/post/create";
    }

    /**
     * Show view edit post
     * @param modelMap
     * @param ID
     * @return
     */
    @RequestMapping(value = "/edit/{ID}", method = RequestMethod.GET)
    public String edit(ModelMap modelMap,  @PathVariable Long ID) {
        modelMap.addAttribute("categories", categoryRepository.findAllCategory());
        modelMap.addAttribute("post", postRepository.findById(ID).get());
        return "admin/post/edit";
    }

    /**
     * Handle update post by ID
     * @param modelMap
     * @param post
     * @param bindingResult
     * @param ID
     * @return
     */
    @RequestMapping(value = "/update/{ID}", method = RequestMethod.POST)
    public String update(
        ModelMap modelMap,
        @Valid @ModelAttribute("post") Post post,
        BindingResult bindingResult,
        @PathVariable Long ID)
    {
        if (!bindingResult.hasErrors()) {
            try {
                if (postRepository.findById(ID).isPresent()) {
                    Post findPost = postRepository.findById(ID).get();

                    if (!post.getTitle().trim().isEmpty()) findPost.setTitle(post.getTitle());
                    if (!post.getContent().trim().isEmpty()) findPost.setContent(post.getContent());
                    if (post.getCategoryID() != null) findPost.setCategoryID(post.getCategoryID());
                    findPost.setUpdateAt(new Date());

                    postRepository.save(findPost);
                    modelMap.addAttribute("success", "Cập nhật thông tin thành công");
                }
            } catch (Exception e) {
                modelMap.addAttribute("error", e.toString());
            }
        }
        modelMap.addAttribute("categories", categoryRepository.findAllCategory());
        return "admin/post/edit";
    }

    /**
     * Handle delete post by ID
     * @param modelMap
     * @param ID
     * @return
     */
    @RequestMapping(value = "/delete/{ID}", method = RequestMethod.POST)
    public ResponseEntity<String> destroy(@PathVariable Long ID) {
        try {
            Optional<Post> findPost = postRepository.findById(ID);
            if (findPost.isPresent()) {
                Post post = findPost.get();
                Optional<Report> reportOptional = reportRepository.findReportByPostID(post);

                // Delete report of post if it exists
                if (reportOptional.isPresent()) {
                    Report report = reportOptional.get();
                    report.setStatus(0);
                    reportRepository.save(report);
                }

                post.setStatus(0); // Status: HIDE
                postRepository.save(post);
                return new ResponseEntity<>("Successfully", HttpStatus.OK);
            }
        } catch (Exception e) {}
        return new ResponseEntity<>("INTERNAL_SERVER_ERROR", HttpStatus.INTERNAL_SERVER_ERROR);
    }
}