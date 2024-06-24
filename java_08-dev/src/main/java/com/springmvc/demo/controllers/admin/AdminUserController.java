package com.springmvc.demo.controllers.admin;

import com.springmvc.demo.Utilities.Functions;
import com.springmvc.demo.controllers.BaseController;
import com.springmvc.demo.models.User;
import com.springmvc.demo.repositories.UserRepository;
import com.springmvc.demo.services.UserService;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping(path = "admin/users")
public class AdminUserController extends BaseController {
    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    /**
     * Show list users
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String getAllUsers(ModelMap modelMap) {
        Iterable<User> users = userService.getAllUsers();
        modelMap.addAttribute("users", users);
        return "admin/user/index";
    }

    /**
     * Show view create user
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(ModelMap modelMap) {
        modelMap.addAttribute("user", new User());
        return "admin/user/create";
    }

    /**
     * Handle create user
     * @param modelMap
     * @param user
     * @param bindingResult
     * @return View admin/user/create
     */
    @RequestMapping(value = "/store", method = RequestMethod.POST)
    public String store(
        ModelMap modelMap,
        @Valid @ModelAttribute("user") User user,
        BindingResult bindingResult)
    {
        if(bindingResult.hasErrors()) {
            return "admin/user/create";
        } else {
            try {
                user.setPassword(Functions.hashMD5("123456"));
                userRepository.save(user);

                modelMap.addAttribute("success", "Thêm người dùng thành công");
                return "admin/user/create";
            } catch (Exception e) {
                modelMap.addAttribute("error", e.toString());
                return "admin/user/create";
            }
        }
    }

    /**
     * Show view edit user
     * @param modelMap
     * @param ID
     * @return
     */
    @RequestMapping(value = "/edit/{ID}", method = RequestMethod.GET)
    public String edit(ModelMap modelMap,  @PathVariable Long ID) {
        modelMap.addAttribute("user", userRepository.findById(ID).get());
        return "admin/user/edit";
    }

    /**
     * Handle update user by ID
     * @param modelMap
     * @param user
     * @param bindingResult
     * @param ID
     * @return
     */
    @RequestMapping(value = "/update/{ID}", method = RequestMethod.POST)
    public String update(
        ModelMap modelMap,
        @Valid @ModelAttribute("user") User user,
        BindingResult bindingResult,
        @PathVariable Long ID)
    {
        if(bindingResult.hasErrors()) {
            return "admin/user/edit";
        } else {
            try {
                if(userRepository.findById(ID).isPresent()) {
                    User findUser = userRepository.findById(ID).get();

                    if (!user.getUsername().trim().isEmpty()) findUser.setUsername(user.getUsername());
                    if (!user.getFullName().trim().isEmpty()) findUser.setFullName(user.getFullName());
                    if (!user.getPhone().trim().isEmpty()) findUser.setPhone(user.getPhone());
                    if (!user.getEmail().trim().isEmpty()) findUser.setEmail(user.getEmail());
                    if (!user.getIntroduce().trim().isEmpty()) findUser.setIntroduce(user.getIntroduce());

                    userRepository.save(findUser);

                    modelMap.addAttribute("success", "Cập nhật thông tin thành công");
                    return "admin/user/edit";
                }
                return "admin/user/edit";
            } catch (Exception e) {
                modelMap.addAttribute("error", e.toString());
                return "admin/user/edit";
            }
        }
    }

    /**
     * Handle delete user by ID
     * @param modelMap
     * @param ID
     * @return
     */
    @RequestMapping(value = "/delete/{ID}", method = RequestMethod.POST)
    public ResponseEntity<String> destroy(@PathVariable Long ID) {
        try {
            userRepository.deleteById(ID);
            return new ResponseEntity<>("User deleted successfully", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("Failed to delete user", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}