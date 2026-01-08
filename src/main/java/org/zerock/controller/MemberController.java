package org.zerock.controller;

import java.security.Principal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.MemberDTO;
import org.zerock.service.MemberService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/member/*")
@Log4j2
@RequiredArgsConstructor
public class MemberController {

    private final MemberService service;

    @GetMapping("/join")
    public void join() {
    }

    @PostMapping("/join")
    public String join(MemberDTO member, RedirectAttributes rttr) {
        log.info("join: " + member);
        if (service.join(member)) {
            rttr.addFlashAttribute("result", "success");
            return "redirect:/customLogin";
        } else {
            rttr.addFlashAttribute("error", "이미 사용 중인 아이디입니다.");
            return "redirect:/member/join";
        }
    }

    @GetMapping("/update")
    public void update(Principal principal, Model model) {
        log.info("update get......" + principal.getName());
        MemberDTO member = service.get(principal.getName());
        model.addAttribute("member", member);
    }

    @PostMapping("/update")
    public String update(MemberDTO member, RedirectAttributes rttr) {
        log.info("update post......" + member);
        if (service.modify(member)) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/";
    }
}
