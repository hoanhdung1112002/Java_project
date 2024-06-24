package com.springmvc.demo.controllers.website;

import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.Post;
import com.springmvc.demo.models.Report;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.PostRepository;
import com.springmvc.demo.repositories.ReportRepository;

@Controller
@RequestMapping(path = "report")
public class ReportController extends BaseController{
    @Autowired
    private ReportRepository reportRepository;
    @Autowired
    private PostRepository postRepository;

    @RequestMapping(value = "/store", method = RequestMethod.POST)
    public ResponseEntity<String> storeComment(
        @RequestParam("content") String content,
        @RequestParam("postID") Long postID,
        HttpSession session
    ) {
        try {
            Optional<Post> postOptional = postRepository.findById(postID);

            if (postOptional.isPresent()) {

                User authLogin = userLogin(session);
                if (authLogin == null) {
                    return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
                }

                Report report = new Report();
                report.setContent(content);
                report.setUserID(authLogin);
                report.setPostID(postOptional.get());
                reportRepository.save(report);
                return ResponseEntity.ok().body("OK");
            } else {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
