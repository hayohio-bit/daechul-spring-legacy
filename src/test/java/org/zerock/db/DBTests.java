package org.zerock.db;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import lombok.extern.log4j.Log4j2;
@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class DBTests {

	@Autowired
	private DataSource dataSource;	// root-context.xml의 id="dataSource"
	
	@Test
	void testConnection() {
		assertNotNull(dataSource);
		log.info("✅ HikariCP DataSource 연결 성공");
		log.info("Datasource 클래스: {}", dataSource.getClass().getName());
	}

}
