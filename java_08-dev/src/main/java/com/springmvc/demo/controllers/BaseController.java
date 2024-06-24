package com.springmvc.demo.controllers;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.springmvc.demo.models.Category;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.Room;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.CategoryRepository;
import com.springmvc.demo.repositories.PostRepository;
import com.springmvc.demo.repositories.RoomRepository;
import com.springmvc.demo.repositories.UserRepository;

@ControllerAdvice
public class BaseController {

    /**
     * Constructor
     */
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private RoomRepository roomRepository;

    /**
     * Auth login provider
     * @param session
     * @return
     */
    @ModelAttribute("authLogin")
    public User userLogin(HttpSession session) {
        Long userID = (Long)session.getAttribute("userID");
        if (userID == null) {
            userID = -1L;
        }
        return userRepository.findById(userID).orElse(null);
    }

    /**
     * Categories
     * @return
     */
    @ModelAttribute("categories")
    public Iterable<Category> categories() {
        return categoryRepository.findAllCategory();
    }

    /**
     * Get total count unread conversations
     * @return
     */
    @ModelAttribute("countUnread")
    public Integer countUnread(HttpSession session) {
        User userLogin = userLogin(session);
        if (userLogin == null) return 0;

        List<Room> listRoomUnread = roomRepository.countUnreadConversations(userLogin);

        if (listRoomUnread != null && !listRoomUnread.isEmpty()) {
            return listRoomUnread.size();
        } else {
            return 0;
        }
    }

    /**
     * Categories
     * @return
     */
    @ModelAttribute("recentPosts")
    public List<Post> getRecentPosts() {
        return postRepository.findRecentPosts(PageRequest.of(0, 5));
    }

    /**
     * Upload file into uploads/
     * @param file
     * @return fileName
     */
    public String uploadFile(MultipartFile file) {
        Path path = Paths.get("uploads/");
        if (!file.isEmpty()) {
            try {
                InputStream inputStream = file.getInputStream();
                Files.copy(
                    inputStream, path.resolve(file.getOriginalFilename()), 
                    StandardCopyOption.REPLACE_EXISTING
                );
                return file.getOriginalFilename();
            } catch (Exception e) {
                return "";
            }
        }
        return "";
    }
}
