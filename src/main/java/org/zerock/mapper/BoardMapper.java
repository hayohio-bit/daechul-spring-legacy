package org.zerock.mapper;

import java.util.List;
import org.zerock.dto.BoardDTO;

public interface BoardMapper {

  List<BoardDTO> selectBoardList();
  
  BoardDTO selectBoard(int seq);

  List<BoardDTO> selectBoardsWithPaging(int skip, int size);

  int countBoards();

  BoardDTO selectOneBySeq(int seq);

  void updateHitCount(int seq);

  void boardWrite(BoardDTO boardDTO);

}
