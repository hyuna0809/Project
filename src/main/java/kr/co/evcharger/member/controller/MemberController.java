package kr.co.evcharger.member.controller;

import kr.co.evcharger.member.dto.MemberDTO;
import kr.co.evcharger.member.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

    @GetMapping("/login")
    public String loginPage() {
        return "member/login";
    }

    @Autowired
    private MemberService.SessionService sessionService;

    @PostMapping("/login")
    public String login(MemberDTO memberDTO, Model model) {
        if (sessionService.login(memberDTO.getMemberEmail(), memberDTO.getMemberPassword())) {
            // 로그인 성공 시
            return "redirect:/home";  // 이전 페이지가 없을 경우 기본 페이지로 리다이렉트
        } else {
            // 로그인 실패 시
            model.addAttribute("loginError", true);
            return "member/login";
        }
    }

    @GetMapping("/member/save")
    public String saveForm() {
        return "member/save";
    }

    @PostMapping("/member/save")
    public String save(@ModelAttribute MemberDTO memberDTO) {
        System.out.println("MemberController.save");
        System.out.println("memberDTO = " + memberDTO);
        memberService.save(memberDTO);

        return "member/login";
    }

    @GetMapping("/member/login")
    public String loginForm(){
        return "member/login";
    }


    @GetMapping("/member/")
    public String findAll(Model model) {
        List<MemberDTO> memberDTOList = memberService.findAll();
        model.addAttribute("memberList", memberDTOList);
        return "member/list";
    }

    @GetMapping("/member/{id}")
    public String findById(@PathVariable Long id, Model model) {
        MemberDTO memberDTO = memberService.findById(id);
        model.addAttribute("member", memberDTO);
        return "member/detail";
    }

    @GetMapping("/member/update")
    public String updateForm(HttpSession session, Model model) {
        String myEmail = (String) session.getAttribute("loginEmail");
        MemberDTO memberDTO = memberService.updateForm(myEmail);
        model.addAttribute("updateMember", memberDTO);
        return "member/update";
    }

    @PostMapping("/member/update")
    public String update(@ModelAttribute MemberDTO memberDTO) {
        memberService.update(memberDTO);
        return "redirect:/member/" + memberDTO.getId();
    }

    @GetMapping("/member/delete/{id}")
    public String deleteById(@PathVariable Long id) {
        memberService.deleteById(id);
        return "redirect:/member/";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "member/logout";
    }

    @PostMapping("/logout")
    public String loginout(MemberDTO memberDTO, Model model, HttpSession session) {
        String referer = (String) session.getAttribute("referer");
        session.removeAttribute("referer");
        return "redirect:" + referer;
    }

    @PostMapping("/member/email-check")
    public @ResponseBody String emailCheck(@RequestParam("memberEmail") String memberEmail) {
        System.out.println("memberEmail = " + memberEmail);
        String checkResult = memberService.emailCheck(memberEmail);
        return checkResult;
//        if (checkResult != null) {
//            return "ok";
//        } else {
//            return "no";
//        }
    }

    @GetMapping("/mypage")
    public String mypage() {
        return "member/mypage";
    }

    @PostMapping("/mypage")
    public String mypage(@ModelAttribute MemberDTO memberDTO) {
        System.out.println("MemberController.save");
        System.out.println("memberDTO = " + memberDTO);
        memberService.save(memberDTO);
        return "member/mypage";
    }


}