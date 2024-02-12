package kr.co.evcharger.map.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MapController {

    @GetMapping("/charging")
    public String charging() {

        return "map/charging";
    }

    @GetMapping ("/home_charging")
    public String charging_test(@RequestParam(name="searchAddress", required=false) String searchAddress, Model model) {
        model.addAttribute("searchAddress", searchAddress);
        return "map/charging";
    }

    @GetMapping("/charging_test")
    public String charging_test() {

        return "map/charging_test";
    }


}
