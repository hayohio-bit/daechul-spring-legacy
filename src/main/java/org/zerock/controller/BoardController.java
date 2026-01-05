package org.zerock.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.dto.BoardDTO;
import org.zerock.service.BoardService;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board")
@Log4j2
@RequiredArgsConstructor
public class BoardController {

  private final BoardService boardService;

  @GetMapping("/list")
  public String list(Model model) {
    List<BoardDTO> boardList = boardService.getBoardList();	//서비스에서 받아온 결과
    model.addAttribute("boardList", boardList);
    return "board/list"; // /WEB-INF/views/board/list.jsp
  }

  
  
}
