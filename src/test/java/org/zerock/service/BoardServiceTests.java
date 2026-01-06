package org.zerock.service;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.BoardListPaginDTO;

import lombok.extern.log4j.Log4j2;
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class BoardServiceTests {

	@Autowired
	private BoardService boardService;
	
	@Test
	void testGetBoardList() {
		List<BoardDTO> list = boardService.getBoardList();
		assertNotNull(list);
		log.info("BoardService getBoardList() 반환 개수: {}", list.size());
		if (!list.isEmpty()) {
			log.info("첫번째 게시글: {}", list.get(0));
		}
	}
	
	@Test
	void testGetBoardsWithPaging() {
		BoardListPaginDTO dto = boardService.getBoardsWithPaging(1, 10);
		assertNotNull(dto);
		assertNotNull(dto.getDto());
		log.info("page={}, totla={}, totalPages={}, start={}, end={}, pageNums={}",
				dto.getPage(), dto.getTotal(), dto.getTotal(), dto.getStart(), dto.getEnd(), dto.getPageNums());
	}

}
