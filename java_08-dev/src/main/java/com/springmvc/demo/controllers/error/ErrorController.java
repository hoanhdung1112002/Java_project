package com.springmvc.demo.controllers.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(path = "error")
public class ErrorController {

    @RequestMapping(value = {"/401.html", ""}, method = RequestMethod.GET)
    public String login() {
        return "error/401";
    }
}
