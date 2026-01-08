package org.zerock.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.Criteria;

public interface BoardMapper {

  public List<BoardDTO> getList();

  public List<BoardDTO> getListWithPaging(Criteria cri);

  public void insert(BoardDTO board);

  public void insertSelectKey(BoardDTO board);

  public BoardDTO read(int bno);

  public int delete(int bno);

  public int update(BoardDTO board);

  public int getTotalCount(Criteria cri);

  public void updateReplyCnt(@Param("bno") int bno, @Param("amount") int amount);

  public void updateHit(int bno);
}
