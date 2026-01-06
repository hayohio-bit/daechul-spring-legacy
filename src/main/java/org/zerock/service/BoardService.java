package org.zerock.service;

import java.util.List;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.BoardListPaginDTO;

public interface BoardService {

  List<BoardDTO> getBoardList();
  
  BoardListPaginDTO getBoardsWithPaging(int page, int size);

  
}
