# Spring Framework Migration Guide

이 문서는 기존의 **JSP/Servlet Model 2** 기반 프로젝트를 **Spring Framework(또는 Spring Boot)** 아키텍처로 마이그레이션하기 위한 실전 가이드입니다.

---

## 1. 아키텍처 패러다임의 변화

| 구분 | JSP/Servlet (현재) | Spring Framework (이후) |
| :--- | :--- | :--- |
| **제어 흐름** | 개발자가 직접 Front Servlet 작성 및 인스턴스 관리 | **IoC (제어의 역전)**: Spring 컨테이너가 객체 생명주기 관리 |
| **의존성 관리** | 직접 Singleton 패턴 구현 (ex: `getInstance()`) | **DI (의존성 주입)**: `@Autowired` 등으로 필요한 객체 주입 |
| **요청 매핑** | `ActionFactory`의 `if-else`문으로 분기 처리 | `@RequestMapping`, `@GetMapping` 등의 어노테이션 사용 |
| **데이터 접근** | JDBC 직접 사용 및 `DBManager` 관리 | **Spring JDBC / MyBatis / JPA**: 설정만으로 관리 |

---

## 2. 구성 요소 1:1 매핑 (Component Mapping)

기존 프로젝트의 핵심 파일들이 Spring 환경에서 어떻게 변하는지 매핑 테이블로 확인하세요.

| 기존 컴포넌트 (Servlet) | Spring 대응 컴포넌트 | 비고 |
| :--- | :--- | :--- |
| `MemberServlet`, `BoardServlet` | `DispatcherServlet` (내장) | 개발자가 직접 작성할 필요 없음 |
| `ActionFactory.java` | **Spring Web MVC 컨테이너** | 설정 또는 스캔을 통해 자동 매핑 |
| `***Action.java` (클래스당 기능하나) | `@Controller` 클래스 내의 **메서드** | 하나의 컨트롤러에 여러 기능 통합 가능 |
| `BoardDAO.java` | `@Repository` 클래스 | 인터페이스 기반 개발 권장 (MyBatis 등 연결) |
| `BoardVO.java` | `DTO` (Data Transfer Object) | 데이터 전달용 객체로 동일하게 사용 |
| `web.xml` | `Application.properties` 또는 Java Config | XML 설정에서 어노테이션/자바 설정으로 변경 |

---

## 3. 디렉토리 구조 비교 (Before vs After)

```text
[기존: Servlet/JSP]                      [변경: Spring Boot/MVC]
board-project/                         board-project/
├── src/main/java/                     ├── src/main/java/com/saeyan/
│   ├── com.saeyan.controller/         │   ├── controller/ (Action 통합)
│   │   ├── ActionFactory.java         │   ├── service/ (신규: 비즈니스 로직 계층)
│   │   └── ***Servlet.java            │   ├── repository/ (DAO의 발전형)
│   ├── com.saeyan.dao/                │   ├── dto/ (VO에서 역할 분리)
│   └── com.saeyan.dto/                │   └── entity/ (DB 매핑용)
└── src/main/webapp/                   ├── src/main/resources/
    ├── board/ (JSP)                   │   ├── templates/ (Thymeleaf/JSP)
    ├── css/                           │   ├── static/ (CSS/JS/Images)
    └── WEB-INF/web.xml                │   └── application.yml (설정 통합)
                                       └── pom.xml (의존성 관리)
```

---

## 4. 코드 변환 예시 (Code Transformation)

### 4.1. Controller: 게시글 목록 보기

**Before: `BoardListAction.java`**
```java
public class BoardListAction implements Action {
    @Override
    public void execute(HttpServletRequest request, HttpServletResponse response) {
        BoardDAO dao = BoardDAO.getInstance(); // 직접 인스턴스 획득
        List<BoardVO> list = dao.selectAllBoards();
        request.setAttribute("boardList", list); // 속성 직접 저장
        request.getRequestDispatcher("/board/list.jsp").forward(request, response);
    }
}
```

**After: `BoardController.java`**
```java
@Controller
@RequestMapping("/board")
public class BoardController {
    
    @Autowired
    private BoardService boardService; // 의존성 주입 (DI)

    @GetMapping("/list")
    public String list(Model model) {
        List<BoardDTO> list = boardService.findAll();
        model.addAttribute("boardList", list); // Model 객체 사용
        return "board/list"; // View name 반환 (자동 포워딩)
    }
}
```

### 4.2. DAO/Repository: 데이터 접근

**Before: `BoardDAO.java` (JDBC)**
```java
public List<BoardVO> selectAllBoards() {
    Connection con = DBManager.getConnection();
    // SQL 작성, Statement 생성, RS 순회, 자원 해제 등 모든 로직 직접 작성...
}
```

**After: `BoardMapper.java` (MyBatis)**
```java
@Mapper
public interface BoardMapper {
    @Select("SELECT * FROM board ORDER BY seq DESC")
    List<BoardDTO> selectAll(); // 구현체 없이 인터페이스와 SQL만으로 동작
}
```

---

## 5. 마이그레이션의 장단점

### 장점 (Pros)
1.  **생산성 향상**: 반복적인 JDBC 코드, 서블릿 설정 코드가 사라집니다.
2.  **테스트 용이성**: DI를 통해 Mock 객체를 주입하여 단위 테스트가 매우 쉬워집니다.
3.  **유연성**: 비즈니스 로직(Service 계층)이 명확히 분리되어 프로그램이 견고해집니다.
4.  **보안/검증 통합**: Spring Security나 Validation을 통해 강력한 부가 기능을 쉽게 추가합니다.

### 단점 (Cons)
1.  **학습 곡선**: 설정 방식과 어노테이션의 동작 원리를 이해하는 데 시간이 필요합니다.
2.  **환경 설정**: 초기 라이브러리 의존성 구성이 까다로울 수 있습니다 (Spring Boot로 완화 가능).

---

## 6. 마이그레이션 추천 로드맵

1.  **의존성 라이브러리 추가**: `pom.xml`에 Spring 관련 모듈 설정.
2.  **데이터 소스 설정**: `DBManager` 대신 Spring의 `DataSource` 설정.
3.  **Service 계층 도입**: `Action`에서 직접 `DAO`를 호출하던 것을 `Service` 인터페이스 거치도록 구조 개편.
4.  **Controller 전환**: 개별 `Action` 클래스들을 도메인별(Member, Board) `Controller` 클래스로 통합.
5.  **View 전환**: JSP의 JSTL/EL은 유지하며, Controller에서 데이터를 넘겨주는 방식(Model)만 변경.
