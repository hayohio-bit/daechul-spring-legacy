package org.zerock.service;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.BoardDTO;
import org.zerock.dto.Criteria;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class BoardServiceTests {

	@Autowired
	private BoardService boardService;

	@Test
	void testGetList() {
		Criteria cri = new Criteria();
		List<BoardDTO> list = boardService.getList(cri);
		assertNotNull(list);
		log.info("BoardService getList() 반환 개수: {}", list.size());
		if (!list.isEmpty()) {
			log.info("첫번째 게시글: {}", list.get(0));
		}
	}

	@Test
	void testGetTotal() {
		Criteria cri = new Criteria();
		int total = boardService.getTotal(cri);
		log.info("BoardService getTotal() 결과: {}", total);
	}

	@Test
	void testRegister() {
		BoardDTO board = new BoardDTO();
		board.setTitle("새로 작성하는 글 - Service");
		board.setContent("새로 작성하는 내용 - Service");
		board.setWriter("newbie");

		boardService.register(board);
		log.info("생성된 게시물의 번호: {}", board.getBno());
	}

	@Test
	void testGet() {
		log.info("1번 게시글 조회: {}", boardService.get(1));
	}

	@Test
	void testModify() {
		BoardDTO board = boardService.get(1);
		if (board == null) {
			return;
		}

		board.setTitle("제목 수정합니다 - Service");
		log.info("MODIFY RESULT: {}", boardService.modify(board));
	}

	@Test
	void testRemove() {
		log.info("REMOVE RESULT: {}", boardService.remove(2)); // 임의의 번호
	}
}
