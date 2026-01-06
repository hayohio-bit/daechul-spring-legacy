# Migration Guide: JSP/Servlet to Spring Legacy

이 가이드는 기존 `daechul-project` (Servlet/JSP)에서 `dc-sf-spring` (Spring Legacy)으로 전환하면서 변경된 주요 설계 포인트를 요약합니다.

## 1. 컴포넌트 매핑 (Before vs After)

| 구분 | JSP/Servlet (Before) | Spring Legacy (After) |
| :--- | :--- | :--- |
| **Front Controller** | `BoardServlet`, `MemberServlet` | `DispatcherServlet` (Web-infra) |
| **Command Logic** | `Action` 구현 클래스들 (`***Action.java`) | `@Controller` 클래스의 메서드들 |
| **Routing** | `ActionFactory.java` (Manual mapping) | `@RequestMapping`, `@GetMapping` |
| **Data Interaction** | `BoardDAO.java` (JDBC, Singleton) | `@Mapper` 인터페이스 (MyBatis) |
| **Dependency** | `getInstance()` 직접 호출 | `@Autowired` 의존성 주입 |
| **Attribute Transfer** | `request.setAttribute()` | `Model.addAttribute()` |
| **Forwarding** | `request.getRequestDispatcher().forward()` | `return "path/to/view";` (String 반환) |

## 2. 주요 코드 변화 예시

### 2.1. Controller (요청 처리)
- **Before**: `BoardListAction.java` 라는 별도의 클래스 파일을 생성하고 `execute` 메서드를 구현해야 했습니다.
- **After**: `BoardController.java` 내의 하나의 메서드(`list()`)로 처리되며, 매개변수로 `Model`을 받아 데이터를 전달합니다.

### 2.2. Mapper (데이터베이스)
- **Before**: `BoardDAO` 내부에 SQL 쿼리를 문자열로 작성하고 `Connection`, `PreparedStatement`를 직접 열고 닫았습니다.
- **After**: 인터페이스(`BoardMapper.java`)만 정의하거나 별도의 XML(`BoardMapper.xml`)에 쿼리를 작성하여 관리합니다. 매핑은 MyBatis가 자동으로 처리합니다.

### 2.3. Service 계층 도입
- 기존에는 `Action`에서 직접 `DAO`를 호출했지만, 마이그레이션 후에는 `@Service` 인터페이스와 구현체를 두어 비즈니스 로직과 데이터 접근을 엄격히 분리했습니다.

## 3. 설정 관리의 중앙화
- 기존에는 `web.xml`과 `DBManager` 등에 흩어져 있던 설정들이 `root-context.xml`과 `servlet-context.xml`로 통합되어 관리됩니다.
- 스프링 컨테이너가 빈(Bean)들을 관리하므로 메모리 관리 및 싱글톤 유지에 더 유리합니다.
