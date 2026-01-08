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
import org.zerock.dto.BoardDTO;
import org.zerock.dto.Criteria;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class BoardMapperTests {

	@Autowired
	private BoardMapper boardMapper;

	@Test
	@DisplayName("getList - 전체 게시글 조회")
	public void testGetList() {
		List<BoardDTO> list = boardMapper.getList();
		assertNotNull(list);
		log.info("BoardMapper getList() 반환 개수: {}", list.size());
	}

	@Test
	@DisplayName("getListWithPaging - 페이징 조회")
	public void testGetListWithPaging() {
		Criteria cri = new Criteria();
		cri.setPageNum(1);
		cri.setAmount(10);
		List<BoardDTO> list = boardMapper.getListWithPaging(cri);
		assertNotNull(list);
		log.info("페이징 조회 결과 개수: {}", list.size());
	}

	@Test
	@DisplayName("getTotalCount - 총 게시글 수")
	public void testGetTotalCount() {
		Criteria cri = new Criteria();
		int total = boardMapper.getTotalCount(cri);
		log.info("총 게시글 수: {}", total);
		assertTrue(total >= 0);
	}

	@Test
	@DisplayName("read - 게시글 상세조회")
	public void testRead() {
		// 해당 seq가 DB에 존재하는지 확인 필요 (예제에서는 1번 사용)
		BoardDTO boardDTO = boardMapper.read(1);
		log.info("seq=1 조회 결과: {}", boardDTO);

		if (boardDTO != null) {
			log.info("title: {}, delFlag: {}", boardDTO.getTitle(), boardDTO.isDelflag());
		}
	}
}
