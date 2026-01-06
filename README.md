# dc-sf-spring (daechul-spring-legacy)

**대철이제철 프로젝트 Spring Legacy 마이그레이션** - JSP/Servlet 기반 게시판 시스템을 Spring MVC 프레임워크 구조로 전환한 프로젝트입니다.

## 📖 프로젝트 가이드 및 상세 문서

프로젝트의 이해를 돕기 위해 상세 가이드를 제공합니다. 아래 링크를 통해 각 항목별 상세 내용을 확인할 수 있습니다.

- [**프로젝트 개요 (OVERVIEW)**](docs/OVERVIEW.md): 프로젝트의 목적, 주요 기능 및 기대 효과
- [**기술 스택 (TECH_STACK)**](docs/TECH_STACK.md): 사용된 프레임워크, 데이터베이스, 라이브러리 및 빌드 환경
- [**아키텍처 및 데이터 흐름 (ARCHITECTURE)**](docs/ARCHITECTURE.md): Spring MVC 계층 구조 및 처리 프로세스 (시퀀스 다이어그램 포함)
- [**마이그레이션 가이드 (MIGRATION_GUIDE)**](docs/MIGRATION_GUIDE.md): 기존 서블릿 프로젝트 대비 변경 사항 및 코드 변환 예시
- [**마이그레이션 팁 및 유용한 도구 (MIGRATION_TIPS)**](docs/MIGRATION_TIPS.md): 효율적인 작업을 위한 도구, 코드 패턴 및 추천 리소스
- [**파일 구조 맵 (FILE_STRUCTURE)**](docs/FILE_STRUCTURE.md): 프로젝트 내 주요 파일 및 디렉토리 역할 설명

---

## 🚀 마이그레이션 핵심 목표
- JSP 기반 게시판 시스템을 Spring MVC 패턴으로 재구성
- MyBatis를 활용한 데이터베이스 연동 및 SQL 분리
- Spring Framework의 DI(의존성 주입) 및 IoC(제어의 역전) 적용
- 계층형 아키텍처(Controller-Service-Mapper) 도입을 통한 유지보수성 향상

## 🛠 실행 방법 (Quick Start)
1. **Database**: `src/main/resources/db/schema.sql`을 실행하여 테이블을 생성합니다.
2. **Configuration**: `src/main/webapp/WEB-INF/spring/root-context.xml`에서 데이터베이스 연결 정보를 확인합니다.
3. **Run**: Maven 빌드 후 Tomcat 서버(8.5/9.0 권장)에 배포하여 실행합니다.

