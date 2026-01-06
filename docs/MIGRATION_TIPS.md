# Migration Tips & Useful Resources

이 문서는 `dc-sf-spring` 프로젝트를 진행하면서 마이그레이션 품질을 높이고 개발 생산성을 향상시킬 수 있는 팁과 추천 도구들을 정리한 가이드입니다.

## 1. 개발 생산성 향상 도구 (Tools)

### IDE 플러그인
- **Lombok**: 이미 프로젝트에 적용되어 있습니다. `@Getter`, `@Setter`, `@ToString`, `@RequiredArgsConstructor` 등을 활용해 가독성을 높이세요.
- **MyBatis Log Plugin**: 실행되는 SQL 쿼리를 가독성 있게 로그로 출력해줍니다. 디버깅 시 매우 유용합니다.
- **Sonarlint**: 코드 품질을 실시간으로 확인하고 잠재적인 버그나 개선 사항을 제안해줍니다.

### 외부 도구
- **Postman / Hoppscotch**: Controller의 API 엔드포인트를 테스트할 때 필수적입니다.
- **DBeaver / Sequel Ace**: 데이터베이스 관리 도구로, GUI 환경에서 쿼리를 연습하고 테이블 구조를 파악하기 좋습니다.

## 2. 마이그레이션 추천 코드 패턴

### 2.1. 전역 예외 처리 (`@ControllerAdvice`)
기존에는 각 Action에서 `try-catch`로 예외를 처리했지만, Spring에서는 전역적으로 공통 처리가 가능합니다.

```java
@ControllerAdvice
@Log4j2
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handleException(Exception ex, Model model) {
        log.error("Exception occurred: " + ex.getMessage());
        model.addAttribute("errorMessage", ex.getMessage());
        return "error/commonError";
    }
}
```

### 2.2. 선언적 트랜잭션 관리 (`@Transactional`)
서비스 계층에서 `@Transactional` 어노테이션 하나로 DB 트랜잭션을 관리할 수 있습니다.

```java
@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
    private final BoardMapper mapper;

    @Transactional
    @Override
    public void register(BoardDTO dto) {
        mapper.insert(dto); // 글 작성
        // 추가 로직... (에러 발생 시 자동 롤백)
    }
}
```

### 2.3. 로그 활용 (Logging)
`System.out.println()` 대신 `@Log4j2`와 `log.info()`, `log.debug()`, `log.error()`를 적극 활용하세요.
- `log.info("Request mapping success for /board/list")`
- `log.error("DB Error: ", e)`

## 3. 추천 학습 및 참고 사이트

- **[Baeldung](https://www.baeldung.com/)**: Spring의 거의 모든 기능을 코드 예제와 함께 설명하는 가장 유명한 사이트입니다.
- **[Spring 공식 가이드](https://spring.io/guides)**: Spring 팀에서 제공하는 공식 가이드로, 특정 기능을 구현하는 'How-to' 문서가 많습니다.
- **[MyBatis 공식 문서](https://mybatis.org/mybatis-3/ko/index.html)**: 매퍼 설정이나 동적 SQL 작성이 헷갈릴 때 가장 정확한 정보를 제공합니다.
- **[Inlearn (인프런)](https://www.inflearn.com/)**: '김영한의 스프링 핵심 원리'와 같은 유료 강의도 마이그레이션 기본기를 다지는 데 매우 좋습니다.

## 4. 현대적 Java (Java 21) 활용
현재 프로젝트는 **Java 21**을 사용하고 있습니다. 마이그레이션 중에 다음과 같은 현대적 문법을 활용해보세요.

- **Record 클래스**: DTO를 더 간결하게 정의할 수 있습니다. (불변 객체인 경우)
  ```java
  public record BoardDTO(int seq, String title, String content) {}
  ```
- **Text Blocks**: SQL 쿼리나 긴 문자열을 작성할 때 가독성이 좋습니다.
  ```java
  String query = """
      SELECT * FROM board
      WHERE title LIKE ?
      ORDER BY seq DESC
      """;
  ```
- **Pattern Matching for switch**: 타입을 체크하고 캐스팅하는 과정을 획기적으로 줄여줍니다.
