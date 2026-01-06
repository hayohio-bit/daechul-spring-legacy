package org.zerock.mapper;

import java.util.List;
import org.zerock.dto.BoardDTO;

public interface BoardMapper {

  List<BoardDTO> selectBoardList();

  BoardDTO selectBoard(int bno);
}
