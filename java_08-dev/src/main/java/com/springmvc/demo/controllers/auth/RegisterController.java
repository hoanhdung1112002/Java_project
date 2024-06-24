package com.springmvc.demo.controllers.auth;

import java.util.Iterator;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.UserRepository;
import com.springmvc.demo.Utilities.Functions;

@Controller
@RequestMapping(path = "auth")
public class RegisterController {
    @Autowired
    private UserRepository userRepository;

    /**
     * Show View Register
     * @param modelMap
     * @return
     */
    @RequestMapping(value = {"/register", ""}, method = RequestMethod.GET)
     public String register(ModelMap modelMap) {
        modelMap.addAttribute("user", new User());
        return "auth/register";
    }
    
    /**
     * Handle Register
     * @param user
     * @param model
     * @return
     */
    @PostMapping("/register")
    public String handleRegister(
        @RequestParam("username") String username, 
        @RequestParam("password") String password,
        @RequestParam("password_confirm") String password_confirm,
        @RequestParam("email") String email,
        Model model
    ) {
        Optional<User> checkEmail = userRepository.checkEmailExists(email);
        if (checkEmail.isPresent()) {
            model.addAttribute("error", "Email đã tồn tại!");
            return "auth/register";
        }
        Optional<User> checkUser = userRepository.checkUsernameExists(username);
        if (checkUser.isPresent()) {
            model.addAttribute("error", "Tên tài khoản đã tồn tại!");
            return "auth/register";
        }

        if (!password.trim().equals(password_confirm.trim())){
            model.addAttribute("error", "Mật khẩu không trùng khớp!");
            return "auth/register";
        }

        if (password.trim().length() < 6){
            model.addAttribute("error", "Mật khẩu tối thiểu 6 ký tự!");
            return "auth/register";
        }

        User user = new User();

        user.setRole(1);
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(Functions.hashMD5(password));
        userRepository.save(user);
        return "redirect:/auth/login";
    }




    
}
