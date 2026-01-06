# Project Overview: dc-sf-spring

## 1. 개요
`dc-sf-spring` 프로젝트는 기존의 **JSP/Servlet Model 2** 기반 게시판 시스템인 `daechul-project`를 **Spring Legacy Framework** 환경으로 마이그레이션한 프로젝트입니다.

이 프로젝트의 주된 목적은 레거시 시스템의 기능을 유지하면서도, 현대적인 프레임워크의 이점(유지보수성, 확장성, 테스트 용이성)을 확보하는 데 있습니다.

## 2. 주요 목표
- **FrameWork 전환**: 커스텀 Front Controller(ActionFactory) 기반 구조에서 Spring Web MVC로 전환
- **의존성 주입(DI)**: 객체 간의 결합도를 낮추기 위해 Spring IoC 컨테이너 활용
- **Persistence 계층 개선**: JDBC 직접 호출 방식에서 MyBatis를 활용한 SQL 매핑 방식으로 개선
- **코드 정규화**: Action 클래스들을 Controller의 메서드로 통합하여 복잡도 감소

## 3. 핵심 기능 (Original vs Migrated)
기존 프로젝트에서 제공하던 핵심 기능들을 동일하게 유지하며 내부 로직만 Spring 구조로 최적화되었습니다.

| 기능 | 설명 |
| :--- | :--- |
| **회원 관리** | 회원가입, 로그인, 로그아웃, 회원 정보 수정, 아이디 중복 확인 |
| **게시판 (Board)** | 게시글 목록, 상세 보기, 글쓰기, 수정, 삭제, 페이징(예정) |
| **답글 (Reply)** | 게시글에 대한 댓글 작성 및 관리 (DTO 포함) |
| **관리자 모드** | 회원 리스트 조회, 회원 상세 관리, 게시글 통합 관리 |

## 4. 기대 효과
1. **유지보수성 향상**: 계층형 아키텍처(Controller-Service-Mapper)를 통해 코드 역할이 명확히 분리됨.
2. **개발 생산성**: 반복적인 JDBC 코드가 사라지고 MyBatis와 어노테이션을 통해 코드량이 감소함.
3. **안정성**: Spring의 트랜잭션 관리 및 예외 처리 구조를 활용하여 보다 견고한 시스템 구축 가능.
