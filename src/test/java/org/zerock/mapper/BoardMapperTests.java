package org.zerock.mapper;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.BoardDTO;
import org.zerock.mapper.BoardMapper;

import lombok.extern.log4j.Log4j2;
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class BoardMapperTests {

	@Autowired
	private BoardMapper boardMapper;
	
	@Test
	public void testSelectBoardMapper() {
		List<BoardDTO> list = boardMapper.selectBoardList();
		assertNotNull(list);
		log.info(list.get(0));
	}

}
