package org.zerock.mapper;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
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
	public void testSelectBoardList() {
		List<BoardDTO> list = boardMapper.selectBoardList();
		assertNotNull(list);
		log.info("BoardMapper selectBoardList() 반환 개수: {}", list.size());
			if (!list.isEmpty()) {
				log.info("첫 번째 게시글(Mapper): {}", list.get(0));
		    }	
	}

}
