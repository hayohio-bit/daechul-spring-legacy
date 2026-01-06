# File Structure Map

`dc-sf-spring` 프로젝트의 주요 디렉토리 및 파일 구성에 대한 설명입니다.

## 1. Java Source (`src/main/java`)

```text
org.zerock/
├── controller/
│   └── BoardController.java      # 게시판 및 회원 관련 통합 컨트롤러
├── dto/
│   ├── BoardDTO.java             # 게시글 정보 전달 객체
│   ├── MemberDTO.java            # 회원 정보 전달 객체
│   └── ReplyDTO.java             # 댓글 정보 전달 객체
├── mapper/
│   └── BoardMapper.java          # MyBatis 매퍼 인터페이스
└── service/
    ├── BoardService.java         # 비즈니스 로직 인터페이스
    └── BoardServiceImpl.java     # 비즈니스 로직 구현체
```

## 2. Resource & Config (`src/main/resources`)

```text
resources/
├── db/
│   └── schema.sql                # 데이터베이스 테이블 생성 스크립트
├── mapper/
│   └── BoardMapper.xml           # MyBatis SQL 매핑 XML
├── log4j2.xml                    # 로그 출력 설정
└── mybatis-config.xml            # MyBatis 환경 설정
```

## 3. Web Assets (`src/main/webapp`)

```text
webapp/
├── WEB-INF/
│   ├── spring/
│   │   ├── root-context.xml      # 서비스, 데이터베이스 등 비웹 관련 설정
│   │   └── servlet-context.xml   # 컨트롤러, 뷰리졸버 등 웹 관련 설정
│   ├── views/                    # JSP 뷰 파일 저장소
│   │   ├── admin/                # 관리자 전용 페이지
│   │   ├── board/                # 게시판 관련 페이지
│   │   └── member/               # 회원 관련 페이지
│   └── web.xml                   # 서블릿 등록 및 웹 애플리케이션 설정
├── images/                       # 공통 이미지 자원
└── index.jsp                     # 메인 인덱스 페이지
```

## 4. Test Code (`src/test/java`)

```text
org.zerock/
├── db/
│   └── DBTests.java              # 커넥션 풀 및 DB 연동 테스트
├── mapper/
│   └── BoardMapperTests.java     # SQL 쿼리 실행 테스트
└── service/
    └── BoardServiceTests.java    # 비즈니스 로직 테스트
```
