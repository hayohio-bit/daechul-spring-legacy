# Technical Stack

`dc-sf-spring` 프로젝트에 사용된 기술 스택과 라이브러리 구성입니다.

## 1. Core Framework
- **Spring Framework (Legacy)**: 5.x.x version
  - Spring Web MVC
  - Spring Context/Core (DI/IoC)
  - Spring JDBC / Transaction

## 2. Persistence (Database)
- **Database**: H2 Database / MySQL (compatible)
- **ORM / Mapper**: MyBatis
- **Connection Pool**: HikariCP / Spring-JDBC Managed

## 3. View (Presentation)
- **View Engine**: JSP (JavaServer Pages)
- **Tag Library**: JSTL (JavaServer Pages Standard Tag Library)
- **Frontend**: Vanilla JS, CSS3, HTML5

## 4. Build & Environment
- **Build Tool**: Maven (`pom.xml`)
- **Web Server (WAS)**: Apache Tomcat 8.5/9.0
- **Log**: Log4j2
- **Java Version**: JDK 1.8 (Java 8)

## 5. Major Dependencies (pom.xml)
- `spring-webmvc`
- `spring-jdbc`
- `mybatis`
- `mybatis-spring`
- `h2` (In-memory DB support)
- `lombok` (Getter/Setter auto-gen)
- `log4j-api / log4j-core`
- `junit` / `spring-test` (Testing framework)
