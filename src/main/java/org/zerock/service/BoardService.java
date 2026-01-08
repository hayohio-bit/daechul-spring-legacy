package org.zerock.service;

import java.util.List;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.Criteria;

public interface BoardService {

  public void register(BoardDTO board);

  public BoardDTO get(int bno);

  public boolean modify(BoardDTO board);

  public boolean remove(int bno);

  public List<BoardDTO> getList(Criteria cri);

  public int getTotal(Criteria cri);
}
