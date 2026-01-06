package org.zerock.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.BoardListPaginDTO;
import org.zerock.mapper.BoardMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

  private final BoardMapper boardMapper;

  @Override
  public List<BoardDTO> getBoardList() {
	return boardMapper.selectBoardList();
  }
  
  @Override
  public BoardListPaginDTO getBoardsWithPaging(int page, int size) {
	  
	  
	  
  }



}
