package org.zerock.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.BoardListPaginDTO;
import org.zerock.mapper.BoardMapper;
import org.zerock.service.BoardService;
import org.zerock.service.BoardServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/board")
@Log4j2
@RequiredArgsConstructor
public class BoardController {

  private final BoardService boardService;

  @GetMapping("/list")
  public String list(
		  @RequestParam(defaultValue = "1") int page,
		  @RequestParam(defaultValue = "10") int size, 
		  Model model) {
	  
	BoardListPaginDTO paginDTO = boardService.getBoardsWithPaging(page, size);
    model.addAttribute("dto", paginDTO);
    return "board/list"; // /WEB-INF/views/board/list.jsp
  }

  @GetMapping("/view/{seq}")
  public String view(
		  @PathVariable("seq") int seq, Model model) {
	  
	  BoardDTO boardDTO = boardService.getWithHitCount(seq);
	  model.addAttribute("dto", boardDTO);
	  return "board/view";
  }
  
  @GetMapping("/write")
  public String WriteFrom() {
	  log.info("board write");
	  return "board/write";
  }

  @PostMapping("/write")
  public String write(BoardDTO boardDTO) {
	  log.info("BoardDTO: " + boardDTO);
	  boardService.write(boardDTO);
	  return "redirect:/board/list";
  }

}
