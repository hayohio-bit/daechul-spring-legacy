package org.zerock.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.Criteria;
import org.zerock.dto.PageDTO;
import org.zerock.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board/*")
@Log4j2
@RequiredArgsConstructor
public class BoardController {

  private final BoardService service;

  @GetMapping("/list")
  public void list(Criteria cri, Model model) {
    log.info("list: " + cri);
    model.addAttribute("list", service.getList(cri));

    int total = service.getTotal(cri);
    log.info("total: " + total);
    model.addAttribute("pageMaker", new PageDTO(cri, total));
  }

  @GetMapping("/register")
  @PreAuthorize("isAuthenticated()")
  public void register() {
  }

  @PostMapping("/register")
  @PreAuthorize("isAuthenticated()")
  public String register(BoardDTO board, RedirectAttributes rttr) {
    log.info("register: " + board);
    service.register(board);
    rttr.addFlashAttribute("result", board.getSeq());
    return "redirect:/board/list";
  }

  @GetMapping({ "/get", "/modify" })
  public void get(@RequestParam("seq") int seq, @ModelAttribute("cri") Criteria cri, Model model) {
    log.info("/get or modify");
    model.addAttribute("board", service.get(seq));
  }

  @PreAuthorize("principal.username == #board.writer")
  @PostMapping("/modify")
  public String modify(BoardDTO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
    log.info("modify: " + board);
    if (service.modify(board)) {
      rttr.addFlashAttribute("result", "success");
    }

    rttr.addAttribute("pageNum", cri.getPageNum());
    rttr.addAttribute("amount", cri.getAmount());

    return "redirect:/board/list";
  }

  @PreAuthorize("principal.username == #writer")
  @PostMapping("/remove")
  public String remove(@RequestParam("seq") int seq, Criteria cri, RedirectAttributes rttr, String writer) {
    log.info("remove..." + seq);
    if (service.remove(seq)) {
      rttr.addFlashAttribute("result", "success");
    }
    rttr.addAttribute("pageNum", cri.getPageNum());
    rttr.addAttribute("amount", cri.getAmount());

    return "redirect:/board/list";
  }
}
