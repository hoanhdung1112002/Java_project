package com.springmvc.demo.controllers.auth;

import java.util.Iterator;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.UserRepository;
import com.springmvc.demo.Utilities.Functions;

@Controller
@RequestMapping(path = "auth")
public class LoginController {
    @Autowired
    private UserRepository userRepository;

    @RequestMapping(value = {"/login", ""}, method = RequestMethod.GET)
    public String login() {
        return "auth/login";
    }

    @RequestMapping(value = {"/login", ""}, method = RequestMethod.POST)
    public String handleLogin(
        @RequestParam("email") String email,
        @RequestParam("password") String password, HttpSession session, Model model
    ) {
        String passwordHash = Functions.hashMD5(password);
        Iterable<User> userLogin = userRepository.authentication (email, passwordHash);

        Iterator<User> iterator = userLogin.iterator();
        if (iterator.hasNext()) {
            User user = iterator.next();
            session.setAttribute("userID", user.getID());
            session.setAttribute("role", user.getRole());

            if (user.getRole() == 0) { //ADMIN
                return "redirect:/admin/statistical";
            }
            return "redirect:/";
        } else {
            model.addAttribute("error", "Thông tin đăng nhập không chính xác!");
            return "auth/login";
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("userID");
        return "redirect:/auth/login";
    }
}
