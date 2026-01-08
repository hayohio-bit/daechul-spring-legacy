# 📊 Part 7: Mermaid 흐름도 모음

> 이 문서는 대철이제철 게시판 프로젝트의 모든 주요 흐름을 **Mermaid 다이어그램**으로 시각화합니다.

---

## 1. 전체 요청 처리 흐름

```mermaid
flowchart TB
    subgraph 사용자
        A[👤 브라우저]
    end
    
    subgraph Tomcat["🌐 Tomcat 서버"]
        B[📥 요청 수신]
        C[🔒 Security Filter]
        D[🎮 DispatcherServlet]
        E[🏛️ Controller]
        F[⚙️ Service]
        G[🗄️ Mapper]
        H[📄 View - JSP]
    end
    
    I[(🐬 MySQL DB)]
    
    A -->|① URL 요청| B
    B --> C
    C -->|② 통과/차단| D
    D -->|③ Controller 찾기| E
    E -->|④ Service 호출| F
    F -->|⑤ Mapper 호출| G
    G <-->|⑥ SQL 실행| I
    G -->|⑦ DTO 반환| F
    F -->|⑧ 결과 반환| E
    E -->|⑨ Model 전달| H
    H -->|⑩ HTML 응답| A
```

---

## 2. MVC 레이어 구조

```mermaid
flowchart LR
    subgraph Presentation["📺 Presentation Layer"]
        V[JSP View]
        C[Controller]
    end
    
    subgraph Business["⚙️ Business Layer"]
        S[Service Interface]
        SI[ServiceImpl]
    end
    
    subgraph Persistence["🗄️ Persistence Layer"]
        M[Mapper Interface]
        MX[Mapper XML]
    end
    
    subgraph Data["💾 Data Layer"]
        DB[(MySQL Database)]
    end
    
    V <-->|"Model 데이터"| C
    C <-->|"DTO"| S
    S --> SI
    SI <-->|"DTO"| M
    M --> MX
    MX <-->|"SQL"| DB
```

---

## 3. 회원가입 흐름

```mermaid
sequenceDiagram
    autonumber
    participant U as 👤 사용자
    participant C as 🏛️ MemberController
    participant S as ⚙️ MemberService
    participant M as 🗄️ MemberMapper
    participant DB as 🐬 MySQL
    
    U->>C: GET /member/join
    C-->>U: join.jsp 화면 표시
    
    Note over U,DB: 아이디 중복 체크 (AJAX)
    U->>C: GET /member/idCheck?id=user01
    C->>S: isDuplicateId("user01")
    S->>M: confirmID("user01")
    M->>DB: SELECT COUNT(*) FROM members WHERE id=?
    DB-->>M: 0 또는 1
    M-->>S: 결과
    S-->>C: true/false
    C-->>U: "available" 또는 "duplicate"
    
    Note over U,DB: 회원가입 제출
    U->>C: POST /member/join (id, password, name, email)
    C->>S: join(MemberDTO)
    S->>S: 비밀번호 BCrypt 암호화
    S->>M: insertMember(MemberDTO)
    M->>DB: INSERT INTO members...
    S->>M: insertMemberRole(id, role)
    M->>DB: INSERT INTO member_roles...
    S-->>C: 성공
    C-->>U: redirect:/member/login
```

---

## 4. 로그인 흐름 (Spring Security)

```mermaid
sequenceDiagram
    autonumber
    participant U as 👤 사용자
    participant F as 🔒 SecurityFilter
    participant S as 🔐 SecurityConfig
    participant UDS as 👔 CustomUserDetailsService
    participant M as 🗄️ MemberMapper
    participant DB as 🐬 MySQL
    participant H as ✅ SuccessHandler
    
    U->>F: POST /login (id, password)
    F->>S: formLogin 설정 확인
    S->>UDS: loadUserByUsername(id)
    UDS->>M: getMember(id)
    M->>DB: SELECT * FROM members WHERE id=?
    DB-->>M: MemberDTO
    M->>DB: SELECT role FROM member_roles WHERE id=?
    DB-->>M: [ROLE_MEMBER]
    M-->>UDS: MemberDTO + roles
    UDS-->>S: UserDetails 객체
    
    alt 비밀번호 일치
        S->>H: 로그인 성공 처리
        H-->>U: redirect:/ (홈으로)
    else 비밀번호 불일치
        S-->>U: redirect:/member/login?error
    end
```

---

## 5. 게시글 CRUD 흐름

### 5.1 게시글 목록 조회 (페이징)

```mermaid
flowchart LR
    A["👤 사용자<br/>GET /board/list?page=1&size=10"] --> B["🏛️ BoardController<br/>list(page, size)"]
    B --> C["⚙️ BoardService<br/>getBoardsWithPaging(page, size)"]
    C --> D1["계산: skip = (page-1)*size"]
    D1 --> D2["🗄️ BoardMapper<br/>selectBoardsWithPaging(skip, size)"]
    D2 --> E1["🐬 MySQL<br/>SELECT ... LIMIT size OFFSET skip"]
    C --> D3["🗄️ BoardMapper<br/>countBoards()"]
    D3 --> E2["🐬 MySQL<br/>SELECT COUNT(seq)"]
    E1 --> D2
    E2 --> D3
    D2 --> C
    D3 --> C
    C --> F["📦 BoardListPaginDTO 생성<br/>(페이징 정보 포함)"]
    F --> B
    B --> G["📄 board/list.jsp<br/>페이징된 게시글 목록 표시"]
    G --> A
```

### 5.2 게시글 상세 조회 (조회수 증가 포함)

```mermaid
flowchart TB
    A["👤 사용자<br/>GET /board/view?seq=5"] --> B["🏛️ BoardController<br/>view(5)"]
    B --> C["⚙️ BoardService<br/>getBoard(5)"]
    
    C --> D["🗄️ BoardMapper<br/>updateHit(5)"]
    D --> E["🐬 MySQL<br/>UPDATE board<br/>SET hit = hit + 1<br/>WHERE seq = 5"]
    
    C --> F["🗄️ BoardMapper<br/>selectOneBySeq(5)"]
    F --> G["🐬 MySQL<br/>SELECT * FROM board<br/>WHERE seq = 5"]
    
    G --> H["📦 BoardDTO"]
    H --> I["📄 board/view.jsp"]
    I --> A
```

### 5.3 게시글 작성

```mermaid
sequenceDiagram
    autonumber
    participant U as 👤 사용자
    participant SF as 🔒 Spring Security
    participant C as 🏛️ BoardController
    participant S as ⚙️ BoardService
    participant M as 🗄️ BoardMapper
    participant DB as 🐬 MySQL
    
    U->>SF: GET /board/write
    SF->>SF: 로그인 체크 ✅
    SF->>C: writeForm()
    C-->>U: board/write.jsp 표시
    
    U->>C: POST /board/write (title, content)
    C->>C: 로그인 사용자 ID로 writer 설정
    C->>S: addBoard(BoardDTO)
    S->>M: insertBoard(BoardDTO)
    M->>DB: INSERT INTO board (writer, title, content) VALUES (...)
    DB-->>M: 성공
    M-->>S: 성공
    S-->>C: 성공
    C-->>U: redirect:/board/list
```

### 5.4 게시글 수정

```mermaid
sequenceDiagram
    autonumber
    participant U as 👤 사용자
    participant C as 🏛️ BoardController
    participant S as ⚙️ BoardService
    participant M as 🗄️ BoardMapper
    participant DB as 🐬 MySQL
    
    U->>C: GET /board/update?seq=5
    C->>S: getBoard(5)
    S->>M: selectOneBySeq(5)
    M->>DB: SELECT * FROM board WHERE seq=5
    DB-->>M: BoardDTO
    M-->>S: BoardDTO
    S-->>C: BoardDTO
    C-->>U: board/update.jsp (기존 내용 표시)
    
    U->>C: POST /board/update (seq, title, content)
    C->>S: updateBoard(BoardDTO)
    S->>M: updateBoard(BoardDTO)
    M->>DB: UPDATE board SET title=?, content=? WHERE seq=?
    DB-->>M: 성공
    M-->>S: 성공
    S-->>C: 성공
    C-->>U: redirect:/board/view?seq=5
```

### 5.5 게시글 삭제 (논리적 삭제)

```mermaid
flowchart LR
    A["👤 사용자<br/>POST /board/delete?seq=5"] --> B["🏛️ BoardController<br/>delete(5)"]
    B --> C["⚙️ BoardService<br/>deleteBoard(5)"]
    C --> D["🗄️ BoardMapper<br/>deleteBoard(5)"]
    D --> E["🐬 MySQL<br/>UPDATE board<br/>SET delflag = true<br/>WHERE seq = 5"]
    E --> F["✅ 논리적 삭제 완료"]
    F --> G["redirect:/board/list"]
```

---

## 6. 접근 권한 제어 흐름

```mermaid
flowchart TB
    A[📥 HTTP 요청] --> B{🔒 Spring Security<br/>URL 체크}
    
    B -->|"/, /member/login,<br/>/member/join"| C[✅ 누구나 접근 가능]
    B -->|"/board/list,<br/>/board/view"| D[✅ 누구나 접근 가능]
    B -->|"/board/write,<br/>/board/update,<br/>/board/delete"| E{로그인 여부?}
    B -->|"/admin/**"| F{ADMIN 권한?}
    
    E -->|로그인 O| G[✅ 접근 허용]
    E -->|로그인 X| H["🔄 /member/login<br/>으로 리다이렉트"]
    
    F -->|ADMIN O| I[✅ 관리자 페이지 접근]
    F -->|ADMIN X| J["🚫 403 Forbidden<br/>access-denied.jsp"]
```

---

## 7. 데이터베이스 ERD

```mermaid
erDiagram
    MEMBERS ||--o{ MEMBER_ROLES : "has"
    MEMBERS ||--o{ BOARD : "writes"
    MEMBERS ||--o{ PERSISTENT_LOGINS : "remembers"
    BOARD ||--o{ REPLY : "has"
    
    MEMBERS {
        varchar id PK "회원 아이디"
        varchar password "암호화된 비밀번호"
        varchar name "이름"
        varchar email "이메일"
        varchar role "권한 (MEMBER/ADMIN)"
        varchar phone "전화번호"
        timestamp regdate "가입일시"
        boolean enabled "활성화 여부"
    }
    
    MEMBER_ROLES {
        varchar id PK,FK "회원 아이디"
        varchar role PK "권한 (ROLE_MEMBER/ROLE_ADMIN)"
    }
    
    BOARD {
        int seq PK "글 번호 (자동증가)"
        varchar writer FK "작성자 아이디"
        varchar title "제목"
        text content "내용"
        int hit "조회수"
        timestamp regdate "작성일시"
        timestamp updatedate "수정일시"
        boolean delflag "삭제여부"
    }
    
    REPLY {
        int rno PK "댓글 번호 (자동증가)"
        int bno FK "게시글 번호"
        varchar replyText "댓글 내용"
        varchar replyer "댓글 작성자"
        timestamp replydate "댓글 작성일시"
        timestamp updatedate "댓글 수정일시"
        boolean deflag "삭제여부"
    }
    
    PERSISTENT_LOGINS {
        varchar series PK "시리즈 토큰"
        varchar username "사용자 아이디"
        varchar token "인증 토큰"
        timestamp last_used "마지막 사용시간"
    }
```

---

## 8. 데이터 흐름 (요청 → 응답)

```mermaid
flowchart TB
    subgraph Request["📤 요청 데이터 흐름"]
        direction LR
        R1["🌐 Form 데이터"] --> R2["🏛️ Controller"]
        R2 --> R3["📦 DTO"]
        R3 --> R4["⚙️ Service"]
        R4 --> R5["🗄️ Mapper"]
        R5 --> R6["🐬 DB"]
    end
    
    subgraph Response["📥 응답 데이터 흐름"]
        direction RL
        S1["🐬 DB"] --> S2["🗄️ Mapper"]
        S2 --> S3["📦 DTO"]
        S3 --> S4["⚙️ Service"]
        S4 --> S5["🏛️ Controller"]
        S5 --> S6["📋 Model"]
        S6 --> S7["📄 JSP"]
    end
```

---

## 9. Spring Security 인증 상태 다이어그램

```mermaid
stateDiagram-v2
    [*] --> 비회원: 첫 접속
    
    비회원 --> 로그인중: POST /login
    로그인중 --> 회원: 인증 성공
    로그인중 --> 비회원: 인증 실패
    
    회원 --> 비회원: 로그아웃
    회원 --> 회원: Remember-Me 쿠키로 자동 로그인
    
    회원 --> 관리자권한: hasRole(ADMIN)
    관리자권한 --> 회원: /admin 외 접근
    
    state 비회원 {
        [*] --> 글열람가능
        글열람가능 --> 글쓰기시도
        글쓰기시도 --> 로그인페이지이동: 권한 없음
    }
    
    state 회원 {
        [*] --> 모든기능사용가능
        모든기능사용가능 --> 글작성
        모든기능사용가능 --> 글수정
        모든기능사용가능 --> 글삭제
    }
    
    state 관리자권한 {
        [*] --> 관리자페이지접근
        관리자페이지접근 --> 회원관리
        관리자페이지접근 --> 게시글관리
    }
```

---

## 10. 프로젝트 폴더 구조

```mermaid
flowchart TB
    subgraph Root["dc-SF/"]
        A["📄 pom.xml<br/>(라이브러리 관리)"]
        B["📄 setup_database.sql<br/>(DB 초기화)"]
    end
    
    subgraph Src["src/main/"]
        subgraph Java["java/org/zerock/"]
            C["📂 controller/<br/>요청 처리"]
            D["📂 service/<br/>비즈니스 로직"]
            E["📂 mapper/<br/>DB 접근"]
            F["📂 dto/<br/>데이터 객체"]
            G["📂 security/<br/>보안 설정"]
        end
        
        subgraph Resources["resources/"]
            H["📂 mapper/*.xml<br/>SQL 쿼리"]
            I["📄 mybatis-config.xml"]
            J["📄 log4j2.xml"]
        end
        
        subgraph Webapp["webapp/"]
            K["📂 resources/<br/>CSS, JS, Images"]
            subgraph WEB-INF["WEB-INF/"]
                L["📄 web.xml"]
                M["📂 spring/<br/>Spring 설정 XML"]
                subgraph Views["views/"]
                    N["📂 member/"]
                    O["📂 board/"]
                    P["📂 admin/"]
                    Q["📂 common/"]
                end
            end
        end
    end
    
    Root --> Src
```

---

## 11. 관리자 기능 흐름

```mermaid
flowchart TB
    A["👑 관리자 접속"] --> B{"/admin/** 접근"}
    B -->|"ROLE_ADMIN 확인"| C["✅ 관리자 메인 페이지"]
    
    C --> D["📋 회원 목록 조회<br/>/admin/member/list"]
    C --> E["📄 회원 상세 보기<br/>/admin/member/detail?id="]
    C --> F["🗑️ 회원 강제 탈퇴<br/>/admin/member/delete?id="]
    C --> G["📊 게시글 관리<br/>/admin/board/list"]
    
    D --> H["🐬 MemberMapper<br/>getAllMembers()"]
    E --> I["🐬 MemberMapper<br/>getMember(id)"]
    F --> J["🐬 MemberMapper<br/>deleteMember(id)"]
    G --> K["🐬 BoardMapper<br/>getAllBoards()"]
```

---

## 12. 댓글 CRUD 흐름

### 12.1 댓글 등록

```mermaid
sequenceDiagram
    autonumber
    participant U as 👤 사용자
    participant C as 🏛️ ReplyController
    participant S as ⚙️ ReplyService
    participant M as 🗄️ ReplyMapper
    participant DB as 🐬 MySQL
    
    U->>C: POST /replies (JSON)
    Note over U,C: {bno: 5, replyText: "좋은 글입니다", replyer: "user01"}
    C->>S: add(ReplyDTO)
    S->>M: insert(ReplyDTO)
    M->>DB: INSERT INTO reply(bno, replyText, replyer) VALUES(...)
    DB-->>M: rno 생성
    M-->>S: 성공
    S-->>C: 성공
    C-->>U: ResponseEntity.ok({result: rno})
```

### 12.2 댓글 목록 조회 (페이징)

```mermaid
sequenceDiagram
    autonumber
    participant U as 👤 사용자
    participant C as 🏛️ ReplyController
    participant S as ⚙️ ReplyService
    participant M as 🗄️ ReplyMapper
    participant DB as 🐬 MySQL
    
    U->>C: GET /replies/{bno}/list?page=1&size=10
    C->>S: listOfBoard(bno, page, size)
    S->>S: skip = (page - 1) * size
    S->>M: listOfBoard(bno, skip, size)
    M->>DB: SELECT ... WHERE bno=? LIMIT ? OFFSET ?
    DB-->>M: 댓글 목록
    S->>M: countOfBoard(bno)
    M->>DB: SELECT COUNT(rno) WHERE bno=?
    DB-->>M: 전체 댓글 수
    M-->>S: ReplyListPaginDTO 생성
    S-->>C: ReplyListPaginDTO
    C-->>U: ResponseEntity.ok(ReplyListPaginDTO)
```

### 12.3 댓글 수정/삭제

```mermaid
flowchart TB
    subgraph 수정["댓글 수정"]
        A1["👤 사용자<br/>PUT /replies/{rno}"] --> B1["🏛️ ReplyController<br/>modify()"]
        B1 --> C1["⚙️ ReplyService<br/>modify()"]
        C1 --> D1["🗄️ ReplyMapper<br/>update()"]
        D1 --> E1["🐬 MySQL<br/>UPDATE reply<br/>SET replyText=?, updatedate=NOW()"]
    end
    
    subgraph 삭제["댓글 삭제"]
        A2["👤 사용자<br/>DELETE /replies/{rno}"] --> B2["🏛️ ReplyController<br/>delete()"]
        B2 --> C2["⚙️ ReplyService<br/>remove()"]
        C2 --> D2["🗄️ ReplyMapper<br/>delete()"]
        D2 --> E2["🐬 MySQL<br/>UPDATE reply<br/>SET deflag=true"]
    end
```

---

## 13. 페이징 처리 흐름

```mermaid
flowchart TB
    A["👤 사용자 요청<br/>page=5, size=10"] --> B["계산: skip = (5-1)*10 = 40"]
    B --> C["DB 조회<br/>LIMIT 10 OFFSET 40"]
    C --> D["전체 개수 조회<br/>SELECT COUNT(*)"]
    D --> E["페이징 정보 계산"]
    
    E --> F["페이지 블록 계산"]
    F --> G["tempEnd = ceil(5/10)*10 = 10"]
    G --> H["start = 1, end = 10"]
    H --> I["prev = false, next = true"]
    I --> J["pageNums = [1,2,3,4,5,6,7,8,9,10]"]
    
    J --> K["📦 BoardListPaginDTO 생성"]
    K --> L["📄 JSP에 페이징 정보 전달"]
```

---

## 14. 의존성 주입 (DI) 흐름

```mermaid
flowchart TB
    subgraph Container["🌱 Spring IoC Container"]
        A["@Controller<br/>BoardController"]
        A2["@RestController<br/>ReplyController"]
        B["@Service<br/>BoardServiceImpl"]
        B2["@Service<br/>ReplyServiceImpl"]
        C["@Mapper<br/>BoardMapper"]
        C2["@Mapper<br/>ReplyMapper"]
        D["@Configuration<br/>SecurityConfig"]
        E["DataSource<br/>HikariCP"]
        F["SqlSessionFactory<br/>MyBatis"]
    end
    
    A -->|"@RequiredArgsConstructor<br/>생성자 주입"| B
    A2 -->|"@RequiredArgsConstructor<br/>생성자 주입"| B2
    B -->|"@RequiredArgsConstructor<br/>생성자 주입"| C
    B2 -->|"@RequiredArgsConstructor<br/>생성자 주입"| C2
    C -->|"사용"| F
    C2 -->|"사용"| F
    F -->|"사용"| E
    E -->|"연결"| G[(🐬 MySQL)]
    D -->|"설정"| H["🔒 Security Filter"]
```

---

## 🎉 문서 완료

이 Mermaid 다이어그램들을 통해 **대철이제철 게시판** 프로젝트의 전체적인 구조와 흐름을 시각적으로 이해할 수 있습니다.

### 포함된 다이어그램

1. 전체 요청 처리 흐름
2. MVC 레이어 구조
3. 회원가입 흐름
4. 로그인 흐름 (Spring Security)
5. 게시글 CRUD (목록/조회/작성/수정/삭제) - 페이징 포함
6. 접근 권한 제어 흐름
7. 데이터베이스 ERD (댓글 테이블 포함)
8. 데이터 흐름
9. Spring Security 인증 상태
10. 프로젝트 폴더 구조
11. 관리자 기능 흐름
12. 댓글 CRUD 흐름 (등록/목록/수정/삭제, 페이징 포함)
13. 페이징 처리 흐름
14. 의존성 주입 (DI) 흐름
