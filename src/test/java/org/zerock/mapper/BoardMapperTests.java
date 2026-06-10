package org.zerock.mapper;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.*;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class BoardMapperTests {

	@Autowired
	private BoardMapper boardMapper;

	@Test
	@DisplayName("getList - 전체 게시글 조회")
	void testGetList() {
		List<BoardDTO> list = boardMapper.getList();
		assertNotNull(list);
		log.info("BoardMapper getList() 반환 개수: {}", list.size());
	}

	@Test
	@DisplayName("getListWithPaging - 페이징 조회")
	void testGetListWithPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		cri.setAmount(10);
		List<BoardDTO> list = boardMapper.getListWithPaging(cri);
		assertNotNull(list);
		log.info("페이징 조회 결과 개수: {}", list.size());
	}

	@Test
	@DisplayName("getTotalCount - 총 게시글 수")
	void testGetTotalCount() {
		Criteria cri = new Criteria();
		int total = boardMapper.getTotalCount(cri);
		log.info("총 게시글 수: {}", total);
		assertTrue(total >= 0);
	}

	@Test
	@DisplayName("read - 게시글 상세조회")
	void testRead() {
		// 해당 seq가 DB에 존재하는지 확인 필요 (예제에서는 1번 사용)
		BoardDTO boardDTO = boardMapper.read(1);
		log.info("seq=1 조회 결과: {}", boardDTO);

		if (boardDTO != null) {
			log.info("title: {}, delFlag: {}", boardDTO.getTitle(), boardDTO.isDelflag());
		}
	}
	@Test
	@DisplayName("insert - 게시글 등록")
	void testInsert() {
		BoardDTO board = new BoardDTO();
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("newbie");

		boardMapper.insert(board);
		log.info("insert 된 게시글: {}", board);
	}

	@Test
	@DisplayName("insertSelectKey - 게시글 등록 후 PK 확인")
	void testInsertSelectKey() {
		BoardDTO board = new BoardDTO();
		board.setTitle("새로 작성하는 글 select key");
		board.setContent("새로 작성하는 내용 select key");
		board.setWriter("newbie");

		boardMapper.insertSelectKey(board);
		log.info("insertSelectKey 등록 후 BNO: {}", board.getBno());
	}

	@Test
	@DisplayName("delete - 게시글 삭제")
	void testDelete() {
		log.info("DELETE COUNT: {}", boardMapper.delete(3)); // 임의의 번호
	}

	@Test
	@DisplayName("update - 게시글 수정")
	void testUpdate() {
		BoardDTO board = new BoardDTO();
		board.setBno(1); // 존재하는 번호여야 함
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("user00");

		int count = boardMapper.update(board);
		log.info("UPDATE COUNT: {}", count);
	}
	
	@Test
	@DisplayName("updateReplyCnt - 댓글 수 업데이트")
	void testUpdateReplyCnt() {
		boardMapper.updateReplyCnt(1, 1);
		log.info("1번 게시글 댓글 수 1 증가 완료");
	}

	@Test
	@DisplayName("updateHit - 조회수 업데이트")
	void testUpdateHit() {
		boardMapper.updateHit(1);
		log.info("1번 게시글 조회수 1 증가 완료");
	}
}
