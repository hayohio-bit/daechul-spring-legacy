package org.zerock.mapper;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.jdbc.Sql;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.BoardDTO;

import lombok.extern.log4j.Log4j2;
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class BoardMapperTests {

	@Autowired
	private BoardMapper boardMapper;
	
	@Test
	@DisplayName("selectBoardList - 전체 게시글 조회")
	public void testSelectBoardList() {
		List<BoardDTO> list = boardMapper.selectBoardList();
		assertNotNull(list);
		log.info("BoardMapper selectBoardList() 반환 개수: {}", list.size());
			if (!list.isEmpty()) {
				log.info("첫 번째 게시글(Mapper): {}", list.get(0));
		    }	
	}
	
	@Test
	@DisplayName("boardWithPageing - 페이징 조회")
	public void testSelectBoardWithPaging() {
		List<BoardDTO> list = boardMapper.selectBoardsWithPaging(0, 10);
		assertNotNull(list);
		log.info("페이징 조회 결과 개수: {}", list.size());
	}
	
	@Test
	@DisplayName("countBoard - 총 게시글 수")
	public void testCountBoards() {
		int total = boardMapper.countBoards();
		log.info("총 게시글 수: {}", total);
		assertTrue(total >= 0);
	}

	@Test
	@DisplayName("selectOneBySeq - 게시글 상세조회")
	public void testSelectOneBySeq() {
		
		// when
		BoardDTO boardDTO = boardMapper.selectOneBySeq(1);
		log.info("seq=1 조회 결과: {}", boardDTO);
		
		// then: 기본 동작 검증
		assertNotNull(boardDTO); // Mapper 호출 성공
		// 데이터 없으면 null이 아닌 빈 DTO 예상 (MyBatis 동작 확인)
	    
	    if (boardDTO != null) {
	        log.info("title: {}, delFlag: {}", boardDTO.getTitle(), boardDTO.isDelflag());
	        // 실제 데이터 있으면 추가 assert
	        // assertEquals("Spring Migration 테스트1", boardDTO.getTitle());
	    }
	}
}
