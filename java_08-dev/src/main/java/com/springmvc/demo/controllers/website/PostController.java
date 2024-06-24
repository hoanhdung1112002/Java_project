package com.springmvc.demo.controllers.website;

import com.springmvc.demo.Utilities.Functions;
import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Category;
import com.springmvc.demo.models.Comment;
import com.springmvc.demo.models.LikesHistory;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.Report;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.CategoryRepository;
import com.springmvc.demo.repositories.CommentRepository;
import com.springmvc.demo.repositories.LikesHistoryRepository;
import com.springmvc.demo.repositories.PostRepository;
import com.springmvc.demo.repositories.ReportRepository;
import com.springmvc.demo.repositories.UserRepository;
import com.springmvc.demo.services.LikesHistoryService;
import com.springmvc.demo.services.NotifyService;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping(path = "posts")
public class PostController extends BaseController{
    @Autowired
    private PostRepository postRepository;
    
    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private LikesHistoryService likesHistoryService;

    @Autowired
    private LikesHistoryRepository likesHistoryRepository;
    
    @Autowired
    private NotifyService notifyService;
    
    @Autowired
    private ReportRepository reportRepository;
    
    /**
     * Show all posts
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String getAllPosts(ModelMap modelMap) {
        Iterable<Post> posts = postRepository.findAll();
        modelMap.addAttribute("posts", posts);
        return "website/post/index";
    }

    /**
     * Get posts by category
     * @param modelMap
     * @param categoryID
     * @return
     */
    @RequestMapping(value = "/category/{categoryID}", method = RequestMethod.GET)
    public String getAllByCategory(@PathVariable("categoryID") Long categoryID, @RequestParam(value = "page", defaultValue = "1") int page, ModelMap modelMap) {
        Page<Post> posts = postRepository.findAllByCategoryID(categoryID, PageRequest.of(page-1, 10));
        modelMap.addAttribute("posts", posts);
        return "website/post/index";
    }
    
    /**
     * Get post of user following 
     * @param page
     * @param modelMap
     * @param session
     * @return
     */
    @RequestMapping(value = "/followings", method = RequestMethod.GET)
    public String getPostFollowing(@RequestParam(value = "page", defaultValue = "1") int page, HttpSession session, ModelMap modelMap) {
 
        User userLogin = userLogin(session);
        if (userLogin != null) {
            Page<Post> posts = postRepository.getPostFollowing(userLogin, PageRequest.of(page-1, 10));
            modelMap.addAttribute("posts", posts);
        }
        
        return "website/post/index";
    }

    /**
     * Show post details by ID
     * @param modelMap
     * @param ID
     * @return
     */
    @RequestMapping(value = "/{ID}/{slug}", method = RequestMethod.GET)
    public String findPostByID(@PathVariable("ID") Long ID, HttpSession session, ModelMap modelMap) {
        Optional<Post> postOptional = postRepository.findById(ID);
        if (postOptional.isPresent()) {
            Post post = postOptional.get();
            User userLogin = userLogin(session);
            Boolean isLiked = false;

            if (userLogin != null) isLiked = likesHistoryService.isLiked(post, userLogin);

            //Update view
            post.setTotalView(post.getTotalView() + 1);
            postRepository.save(post);

            Iterable<Comment> comments = commentRepository.getCommentsByPostID(post);
            modelMap.addAttribute("comments", comments);
            modelMap.addAttribute("post", postOptional);
            modelMap.addAttribute("isLiked", isLiked);
        }
        return "website/post/details";
    }

    /**
     * Like and unlike post
     * @param postID
     * @param check
     * @param session
     * @return
     */
    @RequestMapping(value = "/like", method = RequestMethod.POST)
    public ResponseEntity<String> changeLikePost(@RequestParam("postID") Long postID, @RequestParam("check") Integer check, HttpSession session) {
        try {
            Optional<Post> postOptional = postRepository.findById(postID);
            if (postOptional.isPresent()) {
                Post post = postOptional.get();
                User userLogin = userLogin(session);

                if (userLogin != null) {
                    LikesHistory findLike  =  likesHistoryRepository.isLiked(post, userLogin);
                    if (check == 1) {
                        likesHistoryRepository.deleteById(findLike.getID());
                        post.setTotalLike(post.getTotalLike() - 1);
                        postRepository.save(post);

                        // Delete notify
                        notifyService.destroy(userLogin, post, 1); // 1: LIKE
                    } else {
                        LikesHistory like = new LikesHistory();
                        like.setUserID(userLogin);
                        like.setPostID(post);
                        likesHistoryRepository.save(like);

                        post.setTotalLike(post.getTotalLike() + 1);
                        postRepository.save(post);

                        if (userLogin.getID() != post.getUserID().getID()) {
                            // Send notify
                            notifyService.store(userLogin, post.getUserID(), post, " đã thích bài viết của bạn", 1); // 1: LIKE
                        }
                    }
                    return new ResponseEntity<>("successfully", HttpStatus.OK);
                }
            }
        } catch (Exception e) {}
        return new ResponseEntity<>("Failed", HttpStatus.INTERNAL_SERVER_ERROR);
    }

    /**
     * Search post
     * @param search
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String searchPost(@RequestParam("search") String search, @RequestParam(value = "page", defaultValue = "1") int page, ModelMap modelMap) {
        Page<Post> posts = postRepository.searchPost(search, PageRequest.of(page-1, 10));
        modelMap.addAttribute("posts", posts);
        modelMap.addAttribute("search", search);
        return "website/post/search";
    }

    /**
     * Show view create post
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap modelMap) {
        Iterable<Category> categories = categoryRepository.findAllCategory();
        modelMap.addAttribute("categories", categories);
        return "website/post/create";
    }

    /**
     * Handle store post
     * @param modelMap
     * @param post
     * @param bindingResult
     * @param session
     * @param avatarFile
     * @return
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
                if (authLogin == null) {
                    modelMap.addAttribute("error", "Đăng nhập mới có thể đăng bài");
                    modelMap.addAttribute("categories", categoryRepository.findAllCategory());
                    return "website/post/create";
                }

                String slug = Functions.makeSlug(post.getTitle());

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
        return "website/post/create";
    }
    /**
     * Show view edit post
     * @param modelMap
     * @param ID
     * @return
     */
    @RequestMapping(value = "/edit/{ID}", method = RequestMethod.GET)
    public String edit(ModelMap modelMap,  @PathVariable("ID") Long ID) {
        modelMap.addAttribute("categories", categoryRepository.findAll());
        modelMap.addAttribute("post", postRepository.findById(ID).get());
        return "website/post/edit";
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
        @RequestParam("_avatar") MultipartFile avatarFile,
        @PathVariable("ID") Long ID)
    {
        if (!bindingResult.hasErrors()) {
            try {
                if (postRepository.findById(ID).isPresent()) {
                    Post findPost = postRepository.findById(ID).get();

                    if (!post.getTitle().trim().isEmpty()) findPost.setTitle(post.getTitle());
                    if (!post.getContent().trim().isEmpty()) findPost.setContent(post.getContent());
                    // if (!post.getAvatar().trim().isEmpty()) findPost.setAvatar(post.getAvatar());
                    if (post.getCategoryID() != null) findPost.setCategoryID(post.getCategoryID());

                    findPost.setUpdateAt(new Date());
                    String fileName = uploadFile(avatarFile);
                    if (!fileName.isEmpty()) {
                        findPost.setAvatar(fileName);   
                    }

                    postRepository.save(findPost);
                    modelMap.addAttribute("success", "Cập nhật bài đăng thành công");
                }
            } catch (Exception e) {
                modelMap.addAttribute("error", e.toString());
            }
        }
        modelMap.addAttribute("categories", categoryRepository.findAll());
        return "website/post/edit";
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
