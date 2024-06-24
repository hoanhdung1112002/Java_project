package com.springmvc.demo.controllers.website;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Comment;
import com.springmvc.demo.models.Notification;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.CommentRepository;
import com.springmvc.demo.repositories.NotifyRepository;
import com.springmvc.demo.repositories.PostRepository;
import com.springmvc.demo.services.NotifyService;

@Controller
@RequestMapping(path = "comments")
public class CommentController extends BaseController{
    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private PostRepository postRepository;
    @Autowired
    private NotifyService notifyService;
    @Autowired
    private NotifyRepository notifyRepository;

    /**
     * Store comment
     * @param content
     * @param postID
     * @param parentID
     * @param session
     * @return
     */
    @RequestMapping(value = "/store", method = RequestMethod.POST)
    public ResponseEntity<String> storeComment(
        @RequestParam("content") String content,
        @RequestParam("postID") Long postID,
        @RequestParam("parentID") Long parentID,
        HttpSession session
    ) {
        try {
            Optional<Post> postOptional = postRepository.findById(postID);
            Comment comment = new Comment();

            if (postOptional.isPresent()) {

                User authLogin = userLogin(session);
                if (authLogin == null) {
                    return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
                }

                Post post = postOptional.get();
                post.setTotalComment(post.getTotalComment() + 1);
                postRepository.save(post);

                comment.setContent(content);
                comment.setUserID(authLogin);
                comment.setPostID(post);
                comment.setParentID(parentID);
                commentRepository.save(comment);

                // Send notify
                Optional<Notification> notifyOptional = notifyRepository.findByUserSendAndPostID(authLogin, post, 0); // 0: COMMENT
                if (notifyOptional.isPresent()) {
                    Notification findNotify = notifyOptional.get();
                    findNotify.setUpdatedAt(new Date());
                    notifyRepository.save(findNotify);
                } else {
                    if (post.getUserID().getID() != authLogin.getID()) {
                        notifyService.store(authLogin, post.getUserID(), post, " đã trả lời bài viết của bạn", 0); // 0: COMMENT
                    }
                }

                return ResponseEntity.ok().body("OK");
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * Delete comment
     * @param ID
     * @return
     */
    @RequestMapping(value = "/destroy/{ID}", method = RequestMethod.GET)
    public ResponseEntity<String> destroy(@PathVariable("ID") Long ID, HttpSession session) {
        try {
            Optional<Comment> comment = commentRepository.findById(ID);

            if (comment.isPresent()) {

                // Check is login
                User userLogin = userLogin(session);
                if (userLogin == null) {
                    return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
                }

                // Delete sub comments
                List<Comment> subComments = commentRepository.getCommentByParentID(comment.get().getID());
                Integer totalSubComment = subComments.size();

                for (Comment subComment : subComments) {
                    commentRepository.deleteById(subComment.getID());
                }
                commentRepository.deleteById(ID);

                // Set total comment count
                Post post = comment.get().getPostID();
                post.setTotalComment(post.getTotalComment() - (totalSubComment + 1));
                postRepository.save(post);

                // Delete notify
                notifyService.destroy(userLogin, post, 0); // 0: COMMENT
                return ResponseEntity.ok().body("OK");
            } else {
                return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
            }

        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
