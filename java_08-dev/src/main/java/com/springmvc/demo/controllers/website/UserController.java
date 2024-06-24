package com.springmvc.demo.controllers.website;

import java.util.Date;
import java.util.List;
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

import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Comment;
import com.springmvc.demo.models.Follow;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.CommentRepository;
import com.springmvc.demo.repositories.FollowRepository;
import com.springmvc.demo.repositories.PostRepository;
import com.springmvc.demo.repositories.UserRepository;
import com.springmvc.demo.services.FollowService;
import com.springmvc.demo.services.NotifyService;

@Controller
@RequestMapping(path = "users")
public class UserController extends BaseController{

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private FollowRepository followRepository;
    
    @Autowired
    private FollowService followService;

    @Autowired
    private NotifyService notifyService;

    /**
     * Show wall user
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "wall/{ID}/{username}", method = RequestMethod.GET)
    public String getWallUser(@PathVariable("username") String username, @PathVariable("ID") Long ID, HttpSession session,ModelMap modelMap) {
        try {
            User user = userRepository.findById(ID).get();
            Iterable<Post> posts = postRepository.getAllPostByUserID(user);
            Iterable<Comment> comments = commentRepository.getAllCommentByUserID(user);
            List<Post> postsTopView = postRepository.getTopViewByUserID(user, PageRequest.of(0, 5));
            List<Post> postsTopLike = postRepository.getTopLikeByUserID(user, PageRequest.of(0, 5));
            Page<Follow> listFollowing = followRepository.getFollowing(user, PageRequest.of(0, 16));
            Page<Follow> listFollower = followRepository.getFollower(user, PageRequest.of(0, 16));

            Boolean isFollow = false;
            User userLogin = userLogin(session);
            if (user != null) {
                isFollow = followService.isLiked(userLogin, user);
            }
            
            modelMap.addAttribute("isFollow", isFollow);
            modelMap.addAttribute("user", user);
            modelMap.addAttribute("posts", posts);
            modelMap.addAttribute("comments", comments);
            modelMap.addAttribute("postsTopView", postsTopView);
            modelMap.addAttribute("postsTopLike", postsTopLike);
            modelMap.addAttribute("listFollowing", listFollowing);
            modelMap.addAttribute("listFollower", listFollower);
            return "website/user/wall";
        } catch (Exception e) {
            return "website/user/wall";
        }
    }
    
    /**
     * Show view manage profile
     * @param username
     * @param ID
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "profile", method = RequestMethod.GET)
    public String getManageUser(HttpSession session, ModelMap modelMap) {
        try {
            User user = userLogin(session);
            if (user != null) {
                Iterable<Post> posts = postRepository.getAllPostByUserID(user);
                Iterable<Comment> comments = commentRepository.getAllCommentByUserID(user);
                Page<Follow> listFollowing = followRepository.getFollowing(user, PageRequest.of(0, 16));
                Page<Follow> listFollower = followRepository.getFollower(user, PageRequest.of(0, 16));

                modelMap.addAttribute("user", user);
                modelMap.addAttribute("posts", posts);
                modelMap.addAttribute("comments", comments);
                modelMap.addAttribute("listFollowing", listFollowing);
                modelMap.addAttribute("listFollower", listFollower);
                return "website/user/manage";
            } else {
                return "error/404.jsp";
            }

        } catch (Exception e) {
            return "website/user/manage";
        }
    }

    /**
     * Edit profile user
     * @param session
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "profile/edit", method = RequestMethod.GET)
    public String editProfile(HttpSession session, ModelMap modelMap) {
        try {
            User user = userLogin(session);
            if (user != null) {
                modelMap.addAttribute("user", user);
                return "website/user/edit-profile";
            } else {
                return "error/404.jsp";
            }

        } catch (Exception e) {
            return "website/user/edit-profile";
        }
    }

    /**
     * Update profile user
     * @param session
     * @param modelMap
     * @param user
     * @param bindingResult
     * @param avatarFile
     * @return
     */
    @RequestMapping(value = "profile/update", method = RequestMethod.POST)
    public String updateProfile(
        HttpSession session, 
        ModelMap modelMap,
        @Valid @ModelAttribute("user") User user,
        BindingResult bindingResult,
        @RequestParam("_avatar") MultipartFile avatarFile
    ) {
        if (!bindingResult.hasErrors()) {
            try {
                if (userRepository.findById(user.getID()).isPresent()) {
                    User findUser = userRepository.findById(user.getID()).get();

                    if (!user.getFullName().trim().isEmpty()) findUser.setFullName(user.getFullName());
                    if (!user.getPhone().trim().isEmpty()) findUser.setPhone(user.getPhone());
                    if (user.getGender() != null) findUser.setGender(user.getGender());
                    if (!user.getIntroduce().trim().isEmpty()) findUser.setIntroduce(user.getIntroduce());

                    String fileName = uploadFile(avatarFile);
                    if (!fileName.isEmpty()) {
                        findUser.setAvatar(fileName);   
                    }
                    findUser.setUpdateAt(new Date());

                    userRepository.save(findUser);
                    modelMap.addAttribute("success", "Cập nhật thông tin thành công");
                }
            } catch (Exception e) {
                modelMap.addAttribute("error", "Lỗi hệ thống");
            }
        }
        return "website/user/edit-profile";
    }

    /**
     * Follow and unfollow a user
     * @param ID
     * @param session
     * @return
     */
    @RequestMapping(value = "/follow/{ID}", method = RequestMethod.POST)
    public ResponseEntity<String> changeLikePost(@PathVariable("ID") Long ID, HttpSession session) {
        try {
            Optional<User> following = userRepository.findById(ID);
            if (following.isPresent()) {
                User followingID = following.get();
                User userLogin = userLogin(session);

                if (userLogin != null) {
                    Follow findFollow = followRepository.isFollow(userLogin, followingID);
                    if (findFollow != null) {
                        followRepository.deleteById(findFollow.getID());

                        followingID.setTotalFollow(followingID.getTotalFollow() - 1);
                        userRepository.save(followingID);

                        notifyService.destroyTypeFollow(userLogin, followingID, 3);// 3: FOLLOW
                    } else { 
                        Follow newFollow = new Follow();
                        newFollow.setFollower(userLogin);
                        newFollow.setFollowing(followingID);
                        followRepository.save(newFollow);

                        followingID.setTotalFollow(followingID.getTotalFollow() + 1);
                        userRepository.save(followingID);

                        // Send notify
                        notifyService.store(userLogin, followingID, null, " đã bắt đầu theo dõi bạn", 3); // 3: FOLLOW
                    }
                    return new ResponseEntity<>("successfully", HttpStatus.OK);
                }
            }
        } catch (Exception e) {}
        return new ResponseEntity<>("Failed", HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
