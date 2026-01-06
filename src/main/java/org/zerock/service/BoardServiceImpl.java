package org.zerock.service;

import java.util.List;
import java.util.stream.IntStream;

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
	  
	  // 페이지 번호와 크기 유효성 검사
	  page = page <= 0 ? 1 : page;
	  size = (size <= 0 || size > 100) ? 10 : size;
	  
	  // 건너뛸 게시글 수
	  int skip = (page -1) * size;
	  
	  List<BoardDTO> list = boardMapper.selectBoardsWithPaging(skip, size);
	  int total = boardMapper.countBoards();
	  
	  int blockSize = 10;	// 한 블럭에 보여줄 페이지 수
	  int totalPages = (int) Math.ceil(total / (double) size);
	  
	  int currentBlock = (int) Math.ceil(page / (double) blockSize);
	  int start = (currentBlock - 1)*blockSize +1;
	  int end = Math.min(start + blockSize -1, totalPages);
	  
	  boolean prev = start != 1;
	  boolean next = total > (end*size);
	  
	  List<Integer> pageNums = IntStream.rangeClosed(start, end)
			  .boxed()
			  .toList();
	  
	  // 페이징 정보를 담은 DTO 반환
	  return BoardListPaginDTO.builder()
			  .dto(list)
			  .size(size)
			  .total(total)
			  .page(page)
			  .start(start)
			  .end(end)
			  .prev(prev)
			  .next(next)
			  .pageNums(pageNums)
			  .build();
  }



}
