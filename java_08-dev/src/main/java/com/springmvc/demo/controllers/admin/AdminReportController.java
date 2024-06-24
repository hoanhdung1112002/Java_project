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
import org.springframework.data.crossstore.ChangeSetPersister.NotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;


@Controller
@RequestMapping(path = "admin/report")
public class AdminReportController extends BaseController {
    @Autowired
    private PostRepository postRepository;
    
    @Autowired
    private ReportRepository reportRepository;

    @Autowired
    private UserRepository userRepository;
    
    /**
     * Show list post report
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/posts", method = RequestMethod.GET)
    public String getAllPosts(ModelMap modelMap) {
        Iterable<Report> reports = reportRepository.getReportPosts();
        modelMap.addAttribute("reports", reports);
        return "admin/report/index";
    }

    /**
     * Show report post details by ID report
     * @param ID
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/posts/{ID}", method = RequestMethod.GET)
    public String getReportPostByID(@PathVariable("ID") Long ID, ModelMap modelMap) {
        Optional<Report> reportOptional = reportRepository.findById(ID);
        modelMap.addAttribute("report", reportOptional.get());
        return "admin/report/details";
    }

    /**
     * Delete report
     * @param ID
     * @return
     */
    @RequestMapping(value = "/delete/{ID}", method = RequestMethod.POST)
    public ResponseEntity<String> destroy(@PathVariable Long ID) {
        try {
            Optional<Report> reportOptional = reportRepository.findById(ID);
            if (reportOptional.isPresent()) {
                Report report = reportOptional.get();
                report.setStatus(0);
                reportRepository.save(report);
            }
            return new ResponseEntity<>("Successfully", HttpStatus.OK);
        } catch (Exception e) {}
        return new ResponseEntity<>("INTERNAL_SERVER_ERROR", HttpStatus.INTERNAL_SERVER_ERROR);
    }
}