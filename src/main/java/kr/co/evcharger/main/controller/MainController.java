package kr.co.evcharger.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
    @GetMapping("/home")
    public String home() {
        return "main/home";
    }

    @GetMapping ("/hlogin")
    public String login() {

        return "main/hlogin";
    }

    @GetMapping ("/faq")
    public String faq() {

        return "main/faq";
    }
    @GetMapping ("/about")
    public String about() {

        return "main/about";
    }

}

