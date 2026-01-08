# 📝 Part 6: XML 설정 파일 상세 가이드

이 문서에서는 Spring 프로젝트에서 사용되는 주요 XML 설정 파일들을 상세하게 설명합니다.

---

## 0. pom.xml (Maven 프로젝트 설정)

> **파일 위치**: 프로젝트 루트 `pom.xml`  
> **역할**: Maven 빌드 도구를 위한 프로젝트 설정 및 의존성 관리

### 0.1 전체 구조도

```
┌─────────────────────────────────────────────────────────────────┐
│                      pom.xml 구성요소                            │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1️⃣ 프로젝트 기본 정보                                          │
│     ├── groupId, artifactId, version (좌표)                    │
│     ├── packaging (빌드 결과물 타입)                            │
│     └── name, description                                       │
│                                                                 │
│  2️⃣ Properties (속성 정의)                                     │
│     ├── Java 버전                                               │
│     ├── 인코딩 설정                                             │
│     └── 라이브러리 버전 관리                                    │
│                                                                 │
│  3️⃣ Dependencies (의존성)                                      │
│     ├── Spring Framework                                        │
│     ├── Spring Security                                         │
│     ├── MyBatis                                                 │
│     ├── 데이터베이스 (MySQL, HikariCP)                          │
│     ├── 로깅 (Log4j2)                                           │
│     └── 기타 유틸리티                                           │
│                                                                 │
│  4️⃣ Build Plugins (빌드 플러그인)                              │
│     ├── Compiler Plugin                                         │
│     ├── WAR Plugin                                              │
│     ├── Resources Plugin                                        │
│     └── Surefire Plugin (테스트)                                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 0.2 코드별 상세 설명

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- ═══════════════════════════════════════════════════════════════════
     pom.xml 파일 선언부
     • Maven POM (Project Object Model) 4.0.0 스키마 사용
     • 프로젝트의 모든 설정과 의존성을 정의하는 파일
     ═══════════════════════════════════════════════════════════════════ -->
<project xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    
    <!-- ═══════════════════════════════════════════════════════════
         1️⃣ 프로젝트 기본 정보
         
         📌 modelVersion: POM 모델 버전 (변경 불가)
         📌 groupId: 프로젝트 그룹 ID (보통 회사 도메인 역순)
         📌 artifactId: 프로젝트 이름 (빌드 결과물 파일명에 사용)
         📌 version: 프로젝트 버전 (SNAPSHOT = 개발 중)
         📌 packaging: 빌드 결과물 타입 (war = 웹 애플리케이션)
         ═══════════════════════════════════════════════════════════ -->
    <modelVersion>4.0.0</modelVersion>
    <groupId>org.zerock</groupId>
    <artifactId>daechul-SF</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>war</packaging>
    <name>daechul-SF</name>
    <description>대출 프로젝트 - Spring Framework 마이그레이션</description>

    <!-- ═══════════════════════════════════════════════════════════
         2️⃣ Properties (속성 정의)
         
         🎯 목적: 반복되는 값들을 변수로 관리
         
         📌 장점:
         • 버전 변경 시 한 곳만 수정하면 됨
         • 일관성 유지
         • ${변수명} 형태로 참조 가능
         ═══════════════════════════════════════════════════════════ -->
    <properties>
        <!-- 소스 파일 인코딩 (한글 깨짐 방지) -->
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <!-- 리포트 출력 인코딩 -->
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
        
        <!-- Java 버전 설정 -->
        <java.version>21</java.version>
        <maven.compiler.source>21</maven.compiler.source>  <!-- 소스 코드 Java 버전 -->
        <maven.compiler.target>21</maven.compiler.target>  <!-- 컴파일 대상 Java 버전 -->
        
        <!-- 라이브러리 버전 관리 (중앙 집중식) -->
        <spring.version>6.2.1</spring.version>
        <spring-security.version>6.4.2</spring-security.version>
    </properties>

    <!-- ═══════════════════════════════════════════════════════════
         3️⃣ Dependencies (의존성 라이브러리)
         
         🎯 목적: 프로젝트에서 사용할 외부 라이브러리 정의
         
         📌 scope 종류:
         • compile (기본값): 컴파일과 런타임 모두 필요
         • provided: 컴파일 시 필요, 런타임에는 제공됨 (Tomcat 등)
         • test: 테스트 코드에서만 사용
         ═══════════════════════════════════════════════════════════ -->
    <dependencies>

        <!-- ═══════════════════════════════════════════════════════
             📦 Lombok (코드 생성 라이브러리)
             
             🎯 목적: 보일러플레이트 코드 자동 생성
             • @Getter, @Setter, @ToString 등 어노테이션으로 코드 생성
             • 컴파일 타임에만 필요하므로 provided scope
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.36</version>
            <scope>provided</scope>  <!-- 컴파일 타임에만 필요 -->
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 Spring Framework Core
             
             🎯 핵심 기능:
             • spring-core: Spring의 기본 기능
             • spring-beans: Bean 관리 (IoC 컨테이너)
             • spring-context: 애플리케이션 컨텍스트
             • spring-tx: 트랜잭션 관리
             • spring-aop: 관점 지향 프로그래밍
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-core</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-beans</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-context</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-tx</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-aop</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 AspectJ (AOP 구현체)
             
             🎯 목적: AOP 기능 구현
             • aspectjweaver: 런타임 위빙 (프록시 생성)
             • aspectjrt: AspectJ 런타임
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjweaver</artifactId>
            <version>1.9.22</version>
        </dependency>

        <dependency>
            <groupId>org.aspectj</groupId>
            <artifactId>aspectjrt</artifactId>
            <version>1.9.22</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 Spring Web & MVC
             
             🎯 핵심 기능:
             • spring-web: 웹 통합 기능
             • spring-webmvc: MVC 프레임워크 (Controller, View Resolver 등)
             • spring-test: 테스트 지원
             • spring-jdbc: JDBC 추상화
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-web</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-test</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-jdbc</artifactId>
            <version>${spring.version}</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 Spring Security (보안 프레임워크)
             
             🎯 핵심 기능:
             • spring-security-web: 웹 보안 필터
             • spring-security-config: 보안 설정
             • spring-security-taglibs: JSP 태그 라이브러리
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>org.springframework.security</groupId>
            <artifactId>spring-security-web</artifactId>
            <version>${spring-security.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.security</groupId>
            <artifactId>spring-security-config</artifactId>
            <version>${spring-security.version}</version>
        </dependency>

        <dependency>
            <groupId>org.springframework.security</groupId>
            <artifactId>spring-security-taglibs</artifactId>
            <version>${spring-security.version}</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 JUnit 5 (테스트 프레임워크)
             
             🎯 목적: 단위 테스트 작성
             • junit-jupiter-api: 테스트 API
             • junit-jupiter-engine: 테스트 실행 엔진
             • scope=test: 테스트 코드에서만 사용
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-api</artifactId>
            <version>5.10.1</version>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.junit.jupiter</groupId>
            <artifactId>junit-jupiter-engine</artifactId>
            <version>5.10.1</version>
            <scope>test</scope>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 Jakarta Servlet API
             
             🎯 목적: 서블릿 API 사용
             • Jakarta EE 9+ 표준 (구 javax.servlet 대체)
             • scope=provided: Tomcat에서 제공하므로 포함하지 않음
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>jakarta.servlet</groupId>
            <artifactId>jakarta.servlet-api</artifactId>
            <version>6.0.0</version>
            <scope>provided</scope>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 Jakarta Annotations API
             
             🎯 목적: 어노테이션 지원 (@PostConstruct 등)
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>jakarta.annotation</groupId>
            <artifactId>jakarta.annotation-api</artifactId>
            <version>3.0.0</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 JSP API
             
             🎯 목적: JSP 페이지 작성
             • scope=provided: Tomcat에서 제공
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>jakarta.servlet.jsp</groupId>
            <artifactId>jakarta.servlet.jsp-api</artifactId>
            <version>3.1.1</version>
            <scope>provided</scope>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 Log4j2 (로깅 프레임워크)
             
             🎯 핵심 기능:
             • log4j-slf4j-impl: SLF4J 인터페이스 구현
             • log4j-core: 로깅 코어 기능
             • log4j-api: 로깅 API
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>org.apache.logging.log4j</groupId>
            <artifactId>log4j-slf4j-impl</artifactId>
            <version>2.24.3</version>
        </dependency>

        <dependency>
            <groupId>org.apache.logging.log4j</groupId>
            <artifactId>log4j-core</artifactId>
            <version>2.24.3</version>
        </dependency>

        <dependency>
            <groupId>org.apache.logging.log4j</groupId>
            <artifactId>log4j-api</artifactId>
            <version>2.24.3</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 HikariCP (커넥션 풀)
             
             🎯 목적: 데이터베이스 연결 풀 관리
             • 매우 빠르고 가벼운 JDBC 커넥션 풀
             • 성능 최적화에 유리
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>com.zaxxer</groupId>
            <artifactId>HikariCP</artifactId>
            <version>6.2.1</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 MySQL Connector
             
             🎯 목적: MySQL 데이터베이스 연결
             • JDBC 드라이버
             • MySQL 8.0+ 호환
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>com.mysql</groupId>
            <artifactId>mysql-connector-j</artifactId>
            <version>9.1.0</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 MyBatis (SQL 매퍼 프레임워크)
             
             🎯 핵심 기능:
             • mybatis: MyBatis 코어
             • mybatis-spring: Spring 통합
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.5.17</version>
        </dependency>

        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis-spring</artifactId>
            <version>3.0.4</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 JSTL (JSP Standard Tag Library)
             
             🎯 목적: JSP에서 사용할 표준 태그 라이브러리
             • jakarta.servlet.jsp.jstl-api: JSTL API
             • jakarta.servlet.jsp.jstl: JSTL 구현체
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>jakarta.servlet.jsp.jstl</groupId>
            <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
            <version>3.0.0</version>
        </dependency>

        <dependency>
            <groupId>org.glassfish.web</groupId>
            <artifactId>jakarta.servlet.jsp.jstl</artifactId>
            <version>3.0.1</version>
        </dependency>

        <!-- ═══════════════════════════════════════════════════════
             📦 Jackson (JSON 처리 라이브러리)
             
             🎯 핵심 기능:
             • jackson-databind: JSON ↔ Java 객체 변환
             • jackson-datatype-jsr310: Java 8+ 날짜/시간 지원
             ═══════════════════════════════════════════════════════ -->
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.18.2</version>
        </dependency>

        <dependency>
            <groupId>com.fasterxml.jackson.datatype</groupId>
            <artifactId>jackson-datatype-jsr310</artifactId>
            <version>2.18.2</version>
        </dependency>

    </dependencies>

    <!-- ═══════════════════════════════════════════════════════════
         4️⃣ Build Plugins (빌드 플러그인)
         
         🎯 목적: 빌드 과정을 제어하는 도구들
         • 컴파일, 패키징, 테스트 실행 등을 담당
         ═══════════════════════════════════════════════════════════ -->
    <build>
        <plugins>
            <!-- ═══════════════════════════════════════════════════
                 🔧 Maven Compiler Plugin
                 
                 🎯 목적: Java 소스 코드 컴파일
                 • source: 소스 코드 Java 버전
                 • target: 컴파일된 바이트코드 Java 버전
                 • encoding: 소스 파일 인코딩
                 ═══════════════════════════════════════════════════ -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.13.0</version>
                <configuration>
                    <source>21</source>      <!-- Java 21 문법 사용 -->
                    <target>21</target>     <!-- Java 21 바이트코드 생성 -->
                    <encoding>UTF-8</encoding>  <!-- 소스 파일 인코딩 -->
                </configuration>
            </plugin>
            
            <!-- ═══════════════════════════════════════════════════
                 🔧 Maven WAR Plugin
                 
                 🎯 목적: 웹 애플리케이션 WAR 파일 생성
                 • warSourceDirectory: 웹 리소스 위치
                 • failOnMissingWebXml: web.xml 없어도 빌드 허용
                 ═══════════════════════════════════════════════════ -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-war-plugin</artifactId>
                <version>3.4.0</version>
                <configuration>
                    <warSourceDirectory>src/main/webapp</warSourceDirectory>
                    <failOnMissingWebXml>false</failOnMissingWebXml>
                </configuration>
            </plugin>

            <!-- ═══════════════════════════════════════════════════
                 🔧 Maven Resources Plugin
                 
                 🎯 목적: 리소스 파일 처리
                 • src/main/resources 폴더의 파일들을 클래스패스에 복사
                 • 인코딩 설정으로 한글 깨짐 방지
                 ═══════════════════════════════════════════════════ -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-resources-plugin</artifactId>
                <version>3.3.1</version>
                <configuration>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>

            <!-- ═══════════════════════════════════════════════════
                 🔧 Maven Surefire Plugin
                 
                 🎯 목적: 단위 테스트 실행
                 • JUnit 5 테스트 자동 실행
                 • 테스트 실패 시 빌드 중단
                 ═══════════════════════════════════════════════════ -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.2.5</version>
            </plugin>
        </plugins>
    </build>
</project>
```

---

## 1. web.xml (웹 애플리케이션 설정)

> **파일 위치**: `src/main/webapp/WEB-INF/web.xml`  
> **역할**: 웹 애플리케이션의 **진입점**으로, 필터, 서블릿, 리스너 등을 설정합니다.

### 1.1 전체 구조도

```
┌─────────────────────────────────────────────────────────────────┐
│                        web.xml 구성요소                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1️⃣ 기본 정보 (display-name)                                   │
│     └── 애플리케이션 이름 표시                                   │
│                                                                 │
│  2️⃣ 필터(Filter) 설정                                          │
│     ├── 인코딩 필터 (CharacterEncodingFilter)                   │
│     └── 보안 필터 (Spring Security FilterChain)                 │
│                                                                 │
│  3️⃣ 리스너(Listener) 설정                                       │
│     └── Spring 컨텍스트 로더 (root-context.xml 로드)             │
│                                                                 │
│  4️⃣ 서블릿(Servlet) 설정                                        │
│     └── DispatcherServlet (모든 요청의 중앙 처리자)              │
│                                                                 │
│  5️⃣ Welcome File (시작 페이지)                                  │
│     └── index.jsp                                               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 1.2 코드별 상세 설명

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- ═══════════════════════════════════════════════════════════════════
     web.xml 파일 선언부
     • Jakarta EE 6.0 웹 애플리케이션 스키마 사용
     • Servlet 6.0 스펙 (Tomcat 10.x 이상 필요)
     ═══════════════════════════════════════════════════════════════════ -->
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="https://jakarta.ee/xml/ns/jakartaee"
    xsi:schemaLocation="https://jakarta.ee/xml/ns/jakartaee 
                        https://jakarta.ee/xml/ns/jakartaee/web-app_6_0.xsd"
    id="WebApp_ID" version="6.0">

    <!-- ═══════════════════════════════════════════════════════════
         1️⃣ 애플리케이션 표시 이름
         • Tomcat 관리 화면 등에서 표시되는 이름
         ═══════════════════════════════════════════════════════════ -->
    <display-name>daechul-SF</display-name>

    <!-- ═══════════════════════════════════════════════════════════
         2️⃣ 문자 인코딩 필터 (Character Encoding Filter)
         
         🎯 목적: 한글 깨짐 방지!
         
         • 모든 요청/응답을 UTF-8로 처리
         • forceEncoding=true : 강제로 모든 인코딩을 UTF-8로 변환
         • 가장 먼저 실행되어야 하므로 맨 위에 선언
         ═══════════════════════════════════════════════════════════ -->
    <filter>
        <filter-name>encodingFilter</filter-name>
        <filter-class>
            org.springframework.web.filter.CharacterEncodingFilter
        </filter-class>
        <!-- encoding : 사용할 문자 인코딩 -->
        <init-param>
            <param-name>encoding</param-name>
            <param-value>UTF-8</param-value>
        </init-param>
        <!-- forceEncoding : 이미 인코딩이 설정되어 있어도 강제로 적용 -->
        <init-param>
            <param-name>forceEncoding</param-name>
            <param-value>true</param-value>
        </init-param>
    </filter>

    <!-- 인코딩 필터를 모든 URL에 적용 -->
    <filter-mapping>
        <filter-name>encodingFilter</filter-name>
        <url-pattern>/*</url-pattern>  <!-- /* : 모든 요청에 적용 -->
    </filter-mapping>

    <!-- ═══════════════════════════════════════════════════════════
         3️⃣ Spring Security 필터 (보안 필터)
         
         🎯 목적: 로그인/로그아웃, 권한 체크, 보안 처리
         
         • DelegatingFilterProxy : Spring Bean으로 등록된 필터를 호출
         • "springSecurityFilterChain" : Spring Security가 자동 생성한 필터 체인
         • 모든 요청에 대해 보안 검사 수행
         ═══════════════════════════════════════════════════════════ -->
    <filter>
        <filter-name>springSecurityFilterChain</filter-name>
        <filter-class>
            org.springframework.web.filter.DelegatingFilterProxy
        </filter-class>
    </filter>

    <filter-mapping>
        <filter-name>springSecurityFilterChain</filter-name>
        <url-pattern>/*</url-pattern>  <!-- 모든 URL에 보안 필터 적용 -->
    </filter-mapping>

    <!-- ═══════════════════════════════════════════════════════════
         4️⃣ Root Application Context 설정 (리스너)
         
         🎯 목적: 애플리케이션 전체에서 공유할 Bean 설정 로드
         
         • ContextLoaderListener : 서버 시작 시 root-context.xml 로드
         • root-context.xml : DB, Service, Security 등 설정 포함
         • 여기서 생성된 Bean은 모든 서블릿에서 공유됨
         ═══════════════════════════════════════════════════════════ -->
    <listener>
        <listener-class>
            org.springframework.web.context.ContextLoaderListener
        </listener-class>
    </listener>

    <!-- root-context.xml 파일 위치 지정 -->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>/WEB-INF/spring/root-context.xml</param-value>
    </context-param>

    <!-- ═══════════════════════════════════════════════════════════
         5️⃣ DispatcherServlet 설정 (핵심!)
         
         🎯 목적: 모든 HTTP 요청을 받아서 적절한 Controller에 전달
         
         📌 Spring MVC의 핵심!
         • 프론트 컨트롤러 패턴 (Front Controller Pattern)
         • 요청 URL을 분석하여 알맞은 Controller 메서드 호출
         • servlet-context.xml에서 웹 관련 설정 로드
         ═══════════════════════════════════════════════════════════ -->
    <servlet>
        <servlet-name>appServlet</servlet-name>
        <servlet-class>
            org.springframework.web.servlet.DispatcherServlet
        </servlet-class>

        <!-- DispatcherServlet이 사용할 설정 파일 -->
        <init-param>
            <param-name>contextConfigLocation</param-name>
            <param-value>/WEB-INF/spring/servlet-context.xml</param-value>
        </init-param>

        <!-- load-on-startup : 서버 시작 시 바로 로드 (1 = 최우선) -->
        <load-on-startup>1</load-on-startup>

        <!-- ═══════════════════════════════════════════════════════
             📎 파일 업로드 설정 (Multipart Config)
             
             • max-file-size : 단일 파일 최대 크기 (20MB)
             • max-request-size : 전체 요청 최대 크기 (40MB)
             • file-size-threshold : 메모리 임계값 (이 크기 초과 시 디스크 사용)
             ═══════════════════════════════════════════════════════ -->
        <multipart-config>
            <max-file-size>20971520</max-file-size>         <!-- 20MB -->
            <max-request-size>41943040</max-request-size>   <!-- 40MB -->
            <file-size-threshold>20971520</file-size-threshold>
        </multipart-config>
    </servlet>

    <!-- DispatcherServlet이 처리할 URL 패턴 -->
    <servlet-mapping>
        <servlet-name>appServlet</servlet-name>
        <url-pattern>/</url-pattern>  <!-- / : 모든 요청을 처리 -->
    </servlet-mapping>

    <!-- ═══════════════════════════════════════════════════════════
         6️⃣ Welcome File (시작 페이지)
         
         🎯 목적: http://localhost:8080/ 접속 시 보여줄 페이지
         
         • 순서대로 찾아서 첫 번째로 존재하는 파일 표시
         ═══════════════════════════════════════════════════════════ -->
    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

</web-app>
```

### 1.3 요청 처리 순서도

```
사용자 요청 (http://localhost:8080/board/list)
        │
        ▼
┌─────────────────────────────────────┐
│  1. encodingFilter                  │  ← 문자 인코딩 설정
└─────────────────────────────────────┘
        │
        ▼
┌─────────────────────────────────────┐
│  2. springSecurityFilterChain       │  ← 로그인/권한 체크
└─────────────────────────────────────┘
        │
        ▼
┌─────────────────────────────────────┐
│  3. DispatcherServlet               │  ← Controller로 전달
└─────────────────────────────────────┘
        │
        ▼
    Controller 실행
```

---

## 2. root-context.xml (루트 컨텍스트 설정)

> **파일 위치**: `src/main/webapp/WEB-INF/spring/root-context.xml`  
> **역할**: **애플리케이션 전체**에서 공유하는 **비즈니스 로직** 관련 Bean 설정

### 2.1 전체 구조도

```
┌─────────────────────────────────────────────────────────────────┐
│                    root-context.xml 구성요소                     │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1️⃣ 네임스페이스 선언                                           │
│     └── beans, context, tx, aop, mybatis-spring                 │
│                                                                 │
│  2️⃣ 컴포넌트 스캔 (Component Scan)                              │
│     ├── org.zerock.service (서비스 계층)                        │
│     └── org.zerock.security (보안 설정)                         │
│                                                                 │
│  3️⃣ DataSource 설정 (HikariCP)                                 │
│     └── MySQL 연결 정보                                         │
│                                                                 │
│  4️⃣ MyBatis 설정                                               │
│     ├── SqlSessionFactory                                       │
│     └── Mapper 스캔                                             │
│                                                                 │
│  5️⃣ 트랜잭션 설정                                               │
│     └── @Transactional 사용 가능하게                            │
│                                                                 │
│  6️⃣ AOP 설정                                                   │
│     └── 다양한 공통 처리 가능                                    │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 2.2 코드별 상세 설명

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- ═══════════════════════════════════════════════════════════════════
     root-context.xml
     
     🎯 역할: 백엔드 핵심 Bean 설정
     • 데이터베이스 연결
     • Service, Mapper 빈 등록
     • 트랜잭션 관리
     • 보안(Security) 설정
     ═══════════════════════════════════════════════════════════════════ -->
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xmlns:tx="http://www.springframework.org/schema/tx"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xmlns:mybatis-spring="http://mybatis.org/schema/mybatis-spring"
    xsi:schemaLocation="
        http://www.springframework.org/schema/beans 
            https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context 
            https://www.springframework.org/schema/context/spring-context.xsd
        http://www.springframework.org/schema/tx 
            https://www.springframework.org/schema/tx/spring-tx.xsd
        http://www.springframework.org/schema/aop 
            https://www.springframework.org/schema/aop/spring-aop.xsd
        http://mybatis.org/schema/mybatis-spring 
            http://mybatis.org/schema/mybatis-spring.xsd">

    <!-- ═══════════════════════════════════════════════════════════
         1️⃣ 컴포넌트 스캔 (Component Scan)
         
         🎯 목적: @Service, @Component, @Configuration 등의 
                  어노테이션이 붙은 클래스를 자동으로 Bean으로 등록
         
         📦 스캔 대상:
         • org.zerock.service : 비즈니스 로직 (BoardService, MemberService 등)
         • org.zerock.security : 보안 설정 (SecurityConfig 등)
         ═══════════════════════════════════════════════════════════ -->
    <context:component-scan base-package="org.zerock.service" />
    <context:component-scan base-package="org.zerock.security" />

    <!-- ═══════════════════════════════════════════════════════════
         2️⃣ HikariCP DataSource 설정
         
         🎯 목적: 데이터베이스 연결 풀(Connection Pool) 관리
         
         📌 HikariCP란?
         • 매우 빠르고 가벼운 JDBC 커넥션 풀 라이브러리
         • 미리 여러 개의 DB 연결을 만들어두고 재사용 (성능 향상!)
         
         ⚙️ 주요 설정값:
         • minimumIdle : 최소 유지할 연결 수 (2개)
         • maximumPoolSize : 최대 연결 수 (10개)
         • connectionTimeout : 연결 대기 시간 (30초)
         ═══════════════════════════════════════════════════════════ -->
    <bean name="hikariConfig" class="com.zaxxer.hikari.HikariConfig">
        <!-- MySQL 드라이버 클래스 -->
        <property name="driverClassName" 
                  value="com.mysql.cj.jdbc.Driver" />
        
        <!-- JDBC URL (데이터베이스 주소) -->
        <property name="jdbcUrl"
            value="jdbc:mysql://localhost:3306/daechuldb
                   ?serverTimezone=Asia/Seoul
                   &amp;characterEncoding=UTF-8" />
        
        <!-- 데이터베이스 사용자 정보 -->
        <property name="username" value="daechuluser" />
        <property name="password" value="1234" />
        
        <!-- 연결 풀 설정 -->
        <property name="connectionTimeout" value="30000" />  <!-- 30초 -->
        <property name="minimumIdle" value="2" />            <!-- 최소 2개 연결 유지 -->
        <property name="maximumPoolSize" value="10" />       <!-- 최대 10개 연결 -->
    </bean>

    <!-- 실제 DataSource 객체 생성 -->
    <bean name="dataSource" 
          class="com.zaxxer.hikari.HikariDataSource" 
          destroy-method="close">
        <constructor-arg ref="hikariConfig" />
    </bean>

    <!-- ═══════════════════════════════════════════════════════════
         3️⃣ MyBatis SqlSessionFactory 설정
         
         🎯 목적: MyBatis가 SQL을 실행할 수 있도록 설정
         
         📌 SqlSessionFactory란?
         • MyBatis의 핵심 객체
         • Mapper XML 파일과 Java 인터페이스를 연결
         • SQL 실행 및 결과 매핑 담당
         ═══════════════════════════════════════════════════════════ -->
    <bean class="org.mybatis.spring.SqlSessionFactoryBean">
        <!-- DB 연결을 위해 위에서 만든 dataSource 사용 -->
        <property name="dataSource" ref="dataSource" />
        
        <!-- SQL이 작성된 Mapper XML 파일 위치 -->
        <property name="mapperLocations" 
                  value="classpath:/mapper/*.xml" />
        
        <!-- MyBatis 추가 설정 파일 -->
        <property name="configLocation" 
                  value="classpath:mybatis-config.xml" />
    </bean>

    <!-- ═══════════════════════════════════════════════════════════
         4️⃣ 트랜잭션 관리자 설정
         
         🎯 목적: 여러 DB 작업을 하나의 단위로 묶어서 처리
         
         📌 트랜잭션이란?
         • "전부 성공" 또는 "전부 실패" 단위
         • 예: 게시글 작성 중 에러 발생 시 모든 변경 취소
         ═══════════════════════════════════════════════════════════ -->
    <bean id="transactionManager"
          class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="dataSource" />
    </bean>

    <!-- @Transactional 어노테이션 활성화 -->
    <tx:annotation-driven transaction-manager="transactionManager" />

    <!-- ═══════════════════════════════════════════════════════════
         5️⃣ MyBatis Mapper 스캔
         
         🎯 목적: @Mapper 어노테이션이 붙은 인터페이스를 자동으로 Bean 등록
         
         📦 스캔 대상: org.zerock.mapper 패키지의 모든 Mapper 인터페이스
         ═══════════════════════════════════════════════════════════ -->
    <mybatis-spring:scan base-package="org.zerock.mapper" />

    <!-- ═══════════════════════════════════════════════════════════
         6️⃣ AOP 자동 프록시 설정
         
         🎯 목적: @Transactional, 로깅 등 공통 기능을 메서드에 자동 적용
         
         📌 AOP란?
         • Aspect Oriented Programming (관점 지향 프로그래밍)
         • 공통 기능(로깅, 트랜잭션 등)을 분리하여 관리
         ═══════════════════════════════════════════════════════════ -->
    <aop:aspectj-autoproxy />

</beans>
```

---

## 3. servlet-context.xml (서블릿 컨텍스트 설정)

> **파일 위치**: `src/main/webapp/WEB-INF/spring/servlet-context.xml`  
> **역할**: **웹 관련** 설정 (Controller, View, 정적 리소스 등)

### 3.1 전체 구조도

```
┌─────────────────────────────────────────────────────────────────┐
│                  servlet-context.xml 구성요소                    │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1️⃣ MVC 어노테이션 활성화                                       │
│     └── @Controller, @RequestMapping 등 사용 가능               │
│                                                                 │
│  2️⃣ View Resolver 설정                                         │
│     └── Controller 반환값 → JSP 파일 연결                       │
│                                                                 │
│  3️⃣ Multipart Resolver                                         │
│     └── 파일 업로드 처리                                        │
│                                                                 │
│  4️⃣ 정적 리소스 매핑                                            │
│     └── CSS, JS, 이미지 파일 접근 경로 설정                     │
│                                                                 │
│  5️⃣ Controller 컴포넌트 스캔                                    │
│     └── org.zerock.controller 패키지 스캔                       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 3.2 코드별 상세 설명

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- ═══════════════════════════════════════════════════════════════════
     servlet-context.xml
     
     🎯 역할: 웹 계층(Presentation Layer) 설정
     • Controller Bean 등록
     • View 리졸버 설정
     • 정적 리소스 매핑
     ═══════════════════════════════════════════════════════════════════ -->
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:mvc="http://www.springframework.org/schema/mvc"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="
        http://www.springframework.org/schema/beans 
            https://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/mvc 
            https://www.springframework.org/schema/mvc/spring-mvc.xsd
        http://www.springframework.org/schema/context 
            https://www.springframework.org/schema/context/spring-context.xsd">

    <!-- ═══════════════════════════════════════════════════════════
         1️⃣ Spring MVC 핵심 기능 자동 활성화
         
         🎯 목적: @Controller, @RequestMapping, @ResponseBody 등
                  MVC 관련 어노테이션 사용 가능하게 설정
         
         📌 자동 등록되는 기능들:
         • HandlerMapping : URL과 Controller 메서드 연결
         • HandlerAdapter : Controller 메서드 실행
         • MessageConverter : JSON 변환 등
         ═══════════════════════════════════════════════════════════ -->
    <mvc:annotation-driven />

    <!-- ═══════════════════════════════════════════════════════════
         2️⃣ View Resolver 설정
         
         🎯 목적: Controller가 반환한 문자열을 실제 JSP 파일로 변환
         
         📌 동작 원리:
         Controller: return "board/list";
              ↓
         View Resolver: prefix + "board/list" + suffix
              ↓
         실제 경로: /WEB-INF/views/board/list.jsp
         ═══════════════════════════════════════════════════════════ -->
    <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <!-- JSP 파일들이 있는 폴더 경로 -->
        <property name="prefix" value="/WEB-INF/views/" />
        <!-- 파일 확장자 -->
        <property name="suffix" value=".jsp" />
    </bean>

    <!-- ═══════════════════════════════════════════════════════════
         3️⃣ Multipart Resolver (파일 업로드 처리)
         
         🎯 목적: 파일 업로드 요청을 처리할 수 있게 설정
         
         📌 주의: web.xml의 multipart-config와 함께 사용
         ═══════════════════════════════════════════════════════════ -->
    <bean id="multipartResolver"
          class="org.springframework.web.multipart.support.StandardServletMultipartResolver" />

    <!-- ═══════════════════════════════════════════════════════════
         4️⃣ 정적 리소스 매핑
         
         🎯 목적: CSS, JS, 이미지 파일에 직접 접근 가능하게 설정
         
         📌 동작:
         요청: /resources/css/style.css
              ↓
         실제 파일: /webapp/resources/css/style.css
         ═══════════════════════════════════════════════════════════ -->
    <mvc:resources location="/resources/" mapping="/resources/**" />

    <!-- ═══════════════════════════════════════════════════════════
         5️⃣ Controller 컴포넌트 스캔
         
         🎯 목적: @Controller 어노테이션이 붙은 클래스를 Bean으로 등록
         
         📦 스캔 대상: org.zerock.controller 패키지
         • BoardController
         • MemberController
         • AdminController
         • HomeController
         ═══════════════════════════════════════════════════════════ -->
    <context:component-scan base-package="org.zerock.controller" />

</beans>
```

### 3.3 View Resolver 동작 흐름

```
┌─────────────────────────────────────────────────────────────────┐
│                    View Resolver 동작 원리                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  Controller 메서드                                               │
│  ┌────────────────────────────────────────────┐                │
│  │ @GetMapping("/list")                        │                │
│  │ public String list() {                      │                │
│  │     return "board/list";  ← 이 문자열이!    │                │
│  │ }                                           │                │
│  └────────────────────────────────────────────┘                │
│                        │                                        │
│                        ▼                                        │
│  View Resolver 처리                                              │
│  ┌────────────────────────────────────────────┐                │
│  │ prefix + 반환값 + suffix                    │                │
│  │ "/WEB-INF/views/" + "board/list" + ".jsp"   │                │
│  └────────────────────────────────────────────┘                │
│                        │                                        │
│                        ▼                                        │
│  실제 JSP 파일 실행                                              │
│  ┌────────────────────────────────────────────┐                │
│  │ /WEB-INF/views/board/list.jsp              │                │
│  └────────────────────────────────────────────┘                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 4. mybatis-config.xml (MyBatis 설정)

> **파일 위치**: `src/main/resources/mybatis-config.xml`  
> **역할**: MyBatis 동작 방식 세부 설정

### 4.1 코드별 상세 설명

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE configuration 
    PUBLIC "-//mybatis.org//DTD Config 3.0//EN" 
    "http://mybatis.org/dtd/mybatis-3-config.dtd">
<!-- ═══════════════════════════════════════════════════════════════════
     mybatis-config.xml
     
     🎯 역할: MyBatis 전역 설정
     • 컬럼명-프로퍼티 자동 매핑 규칙
     • NULL 값 처리
     • 로깅 설정
     • 타입 별칭 (Alias) 설정
     ═══════════════════════════════════════════════════════════════════ -->
<configuration>

    <!-- ═══════════════════════════════════════════════════════════
         1️⃣ MyBatis 동작 설정
         ═══════════════════════════════════════════════════════════ -->
    <settings>
        <!-- 
            mapUnderscoreToCamelCase : 스네이크 케이스 → 카멜 케이스 자동 변환
            
            📌 예시:
            DB 컬럼명: user_name    →  Java 필드명: userName
            DB 컬럼명: reg_date     →  Java 필드명: regDate
            DB 컬럼명: update_date  →  Java 필드명: updateDate
            
            🎯 이 설정이 없으면?
            → DB 컬럼명과 Java 필드명을 일일이 매핑해야 함
        -->
        <setting name="mapUnderscoreToCamelCase" value="true" />

        <!-- 
            jdbcTypeForNull : NULL 값을 DB에 저장할 때의 JDBC 타입
            
            📌 왜 필요한가?
            → Oracle 등 일부 DB에서 NULL 타입을 명시하지 않으면 오류 발생
            → MySQL은 없어도 되지만, 호환성을 위해 설정
        -->
        <setting name="jdbcTypeForNull" value="NULL" />

        <!-- 
            logImpl : SQL 실행 로그를 어떤 프레임워크로 출력할지
            
            📌 LOG4J2 사용
            → 실행된 SQL과 파라미터를 콘솔에 출력
            → 디버깅에 매우 유용!
        -->
        <setting name="logImpl" value="LOG4J2" />
    </settings>

    <!-- ═══════════════════════════════════════════════════════════
         2️⃣ 타입 별칭 (Type Aliases) 설정
         
         🎯 목적: Mapper XML에서 전체 클래스 경로 대신 짧은 이름 사용
         
         📌 예시:
         설정 전: resultType="org.zerock.dto.BoardDTO"
         설정 후: resultType="BoardDTO"
         ═══════════════════════════════════════════════════════════ -->
    <typeAliases>
        <!-- org.zerock.dto 패키지의 모든 클래스에 자동으로 별칭 부여 -->
        <package name="org.zerock.dto" />
    </typeAliases>

</configuration>
```

---

## 4.5. log4j2.xml (로깅 설정)

> **파일 위치**: `src/main/resources/log4j2.xml`  
> **역할**: 애플리케이션 로그 출력 설정

### 4.5.1 코드별 상세 설명

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!-- ═══════════════════════════════════════════════════════════════════
     log4j2.xml
     
     🎯 역할: 애플리케이션 로그 출력 설정
     • 로그 레벨 설정 (DEBUG, INFO, WARN, ERROR)
     • 로그 출력 형식 설정
     • 패키지별 로그 레벨 설정
     ═══════════════════════════════════════════════════════════════════ -->
<Configuration status="INFO">
    <!-- ═══════════════════════════════════════════════════════════
         1️⃣ Appender 설정 (로그 출력 대상)
         
         📌 Console Appender: 콘솔에 로그 출력
         • target="SYSTEM_OUT" : 표준 출력 스트림 사용
         • PatternLayout : 로그 출력 형식 지정
         ═══════════════════════════════════════════════════════════ -->
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <!-- 로그 출력 형식: 시간 [스레드] 레벨 로거명 - 메시지 -->
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n" />
        </Console>
    </Appenders>
    
    <!-- ═══════════════════════════════════════════════════════════
         2️⃣ Logger 설정 (패키지별 로그 레벨)
         
         📌 로그 레벨 우선순위:
         TRACE < DEBUG < INFO < WARN < ERROR < FATAL
         
         📌 additivity="false"
         • 상위 Logger로 전파하지 않음
         • 중복 출력 방지
         ═══════════════════════════════════════════════════════════ -->
    <Loggers>
        <!-- 프로젝트 패키지: DEBUG 레벨 (상세 로그) -->
        <Logger name="org.zerock" level="DEBUG" additivity="false">
            <AppenderRef ref="Console" />
        </Logger>
        
        <!-- Spring 프레임워크: INFO 레벨 (일반 정보만) -->
        <Logger name="org.springframework" level="INFO" additivity="false">
            <AppenderRef ref="Console" />
        </Logger>
        
        <!-- MyBatis: DEBUG 레벨 (SQL 쿼리 로그 확인) -->
        <Logger name="org.mybatis" level="DEBUG" additivity="false">
            <AppenderRef ref="Console" />
        </Logger>
        
        <!-- 루트 Logger: INFO 레벨 (기본 설정) -->
        <Root level="INFO">
            <AppenderRef ref="Console" />
        </Root>
    </Loggers>
</Configuration>
```

---

## 5. Mapper XML (SQL 쿼리 파일)

> **파일 위치**: `src/main/resources/mapper/*.xml`  
> **역할**: 실제 SQL 쿼리 작성

### 5.1 BoardMapper.xml 상세 설명

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper 
    PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- ═══════════════════════════════════════════════════════════════════
     BoardMapper.xml
     
     🎯 역할: 게시판 관련 SQL 쿼리 모음
     
     📌 namespace 규칙:
     • Java Mapper 인터페이스의 전체 경로와 일치해야 함
     • 예: org.zerock.mapper.BoardMapper (인터페이스)
          ↔ namespace="org.zerock.mapper.BoardMapper" (XML)
     ═══════════════════════════════════════════════════════════════════ -->
<mapper namespace="org.zerock.mapper.BoardMapper">

    <!-- ═══════════════════════════════════════════════════════════
         🔍 SELECT : 모든 게시글 조회
         
         📌 id="selectAllBoards"
         → Java 인터페이스: List<BoardDTO> selectAllBoards();
         
         📌 resultType="BoardDTO"
         → 조회 결과를 BoardDTO 객체에 자동 매핑
         → mybatis-config.xml의 typeAliases 덕분에 짧게 사용 가능
         
         📌 WHERE delflag = false
         → 논리적 삭제된 글은 제외 (delflag = true인 건 삭제된 글)
         
         📌 ORDER BY seq DESC
         → 최신 글이 위로 오도록 정렬
         ═══════════════════════════════════════════════════════════ -->
    <select id="selectAllBoards" resultType="BoardDTO">
        SELECT seq, writer, title, content, hit, regdate, updatedate, delflag
        FROM board
        WHERE delflag = false
        ORDER BY seq DESC
    </select>

    <!-- ═══════════════════════════════════════════════════════════
         🔍 SELECT : 게시글 단건 조회
         
         📌 parameterType="int"
         → 메서드 파라미터 타입 (게시글 번호)
         
         📌 #{seq}
         → 파라미터 바인딩 (SQL Injection 방지)
         → PreparedStatement의 ? 역할
         ═══════════════════════════════════════════════════════════ -->
    <select id="selectOneBySeq" parameterType="int" resultType="BoardDTO">
        SELECT seq, writer, title, content, hit, regdate, updatedate, delflag
        FROM board
        WHERE seq = #{seq}
    </select>

    <!-- ═══════════════════════════════════════════════════════════
         ➕ INSERT : 게시글 등록
         
         📌 parameterType="BoardDTO"
         → BoardDTO 객체의 필드값들을 SQL에 바인딩
         
         📌 #{writer}, #{title}, #{content}
         → BoardDTO의 getWriter(), getTitle(), getContent() 호출
         
         📌 seq, regdate, hit 등은?
         → seq : AUTO_INCREMENT로 자동 생성
         → regdate : DEFAULT CURRENT_TIMESTAMP로 자동 입력
         → hit : DEFAULT 0
         ═══════════════════════════════════════════════════════════ -->
    <insert id="insertBoard" parameterType="BoardDTO">
        INSERT INTO board (writer, title, content)
        VALUES (#{writer}, #{title}, #{content})
    </insert>

    <!-- ═══════════════════════════════════════════════════════════
         ✏️ UPDATE : 게시글 수정
         
         📌 SET 절에 포함된 컬럼만 수정됨
         → title, content만 수정 (작성자, 날짜는 변경 안 함)
         
         📌 updatedate는?
         → 테이블에 ON UPDATE CURRENT_TIMESTAMP 설정 시 자동 갱신
         ═══════════════════════════════════════════════════════════ -->
    <update id="updateBoard" parameterType="BoardDTO">
        UPDATE board
        SET title = #{title}, content = #{content}
        WHERE seq = #{seq}
    </update>

    <!-- ═══════════════════════════════════════════════════════════
         🗑️ DELETE : 게시글 삭제 (논리적 삭제)
         
         📌 실제로 DELETE 하지 않는 이유
         • 데이터 복구 가능
         • 통계/분석용 데이터 보존
         • 실수로 삭제해도 복원 가능
         
         📌 delflag = true
         → 삭제 플래그만 변경
         → 조회 시 WHERE delflag = false로 필터링
         ═══════════════════════════════════════════════════════════ -->
    <update id="deleteBoard" parameterType="int">
        UPDATE board
        SET delflag = true
        WHERE seq = #{seq}
    </update>

    <!-- ═══════════════════════════════════════════════════════════
         👁️ UPDATE : 조회수 증가
         
         📌 hit = hit + 1
         → 현재 조회수에 1을 더함
         → 동시성 문제를 방지하기 위해 이렇게 작성
           (변수에 담지 않고 직접 증가)
         ═══════════════════════════════════════════════════════════ -->
    <update id="updateHit" parameterType="int">
        UPDATE board
        SET hit = hit + 1
        WHERE seq = #{seq}
    </update>

    <!-- ═══════════════════════════════════════════════════════════
         📄 SELECT : 게시글 목록 조회 (페이징)
         
         📌 LIMIT #{size} OFFSET #{skip}
         → size: 한 페이지에 보여줄 게시글 수
         → skip: 건너뛸 게시글 수 (페이지 번호 * size)
         
         📌 페이징 예시:
         • 1페이지 (skip=0, size=10): LIMIT 10 OFFSET 0
         • 2페이지 (skip=10, size=10): LIMIT 10 OFFSET 10
         • 3페이지 (skip=20, size=10): LIMIT 10 OFFSET 20
         ═══════════════════════════════════════════════════════════ -->
    <select id="selectBoardsWithPaging" resultType="BoardDTO">
        SELECT seq, writer, title, content, hit, regdate, updatedate, delflag
        FROM board
        WHERE delflag = false
        ORDER BY seq DESC
        LIMIT #{size} OFFSET #{skip}
    </select>
    
    <!-- ═══════════════════════════════════════════════════════════
         🔢 SELECT : 전체 게시글 수 조회
         
         📌 페이징을 위한 총 게시글 수 계산
         → 전체 페이지 수 = 총 게시글 수 / 페이지당 게시글 수
         ═══════════════════════════════════════════════════════════ -->
    <select id="countBoards" resultType="int">
        SELECT COUNT(seq)
        FROM board
        WHERE delflag = false
    </select>

</mapper>
```

### 5.2 MemberMapper.xml 상세 설명

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper 
    PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
    "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- ═══════════════════════════════════════════════════════════════════
     MemberMapper.xml
     
     🎯 역할: 회원 관련 SQL 쿼리 모음
     • 회원 CRUD 작업
     • 권한 관리
     • 아이디 중복 확인
     ═══════════════════════════════════════════════════════════════════ -->
<mapper namespace="org.zerock.mapper.MemberMapper">

    <!-- ═══════════════════════════════════════════════════════════
         🔍 SELECT : 모든 회원 조회 (최신 가입순)
         
         📌 enabled : 계정 활성화 여부 (true=활성, false=비활성)
         📌 ORDER BY regdate DESC : 최신 가입자부터 표시
         ═══════════════════════════════════════════════════════════ -->
    <select id="selectAllMembers" resultType="MemberDTO">
        SELECT id, password, name, email, role, phone, regdate, enabled
        FROM members
        ORDER BY regdate DESC
    </select>

    <!-- ═══════════════════════════════════════════════════════════
         🔍 SELECT : 아이디로 회원 조회
         
         📌 Spring Security에서 사용
         → 로그인 시 사용자 정보 조회
         ═══════════════════════════════════════════════════════════ -->
    <select id="getMember" parameterType="String" resultType="MemberDTO">
        SELECT id, password, name, email, role, phone, regdate, enabled
        FROM members
        WHERE id = #{id}
    </select>

    <!-- ═══════════════════════════════════════════════════════════
         🔍 SELECT : 아이디 중복 확인
         
         📌 resultType="int"
         → COUNT(*) 결과 반환 (0 또는 1)
         → 0이면 사용 가능, 1이면 중복
         ═══════════════════════════════════════════════════════════ -->
    <select id="confirmID" parameterType="String" resultType="int">
        SELECT COUNT(*)
        FROM members
        WHERE id = #{id}
    </select>

    <!-- ═══════════════════════════════════════════════════════════
         ➕ INSERT : 회원 등록
         
         📌 enabled = true
         → 신규 가입자는 기본적으로 활성화 상태
         
         📌 password는 암호화된 상태로 저장됨
         → SecurityConfig의 PasswordEncoder 사용
         ═══════════════════════════════════════════════════════════ -->
    <insert id="insertMember" parameterType="MemberDTO">
        INSERT INTO members (id, password, name, email, role, phone, enabled)
        VALUES (#{id}, #{password}, #{name}, #{email}, #{role}, #{phone}, true)
    </insert>

    <!-- ═══════════════════════════════════════════════════════════
         ➕ INSERT : 회원 권한 등록
         
         📌 member_roles 테이블에 권한 정보 저장
         → Spring Security에서 권한 체크 시 사용
         → 일반 사용자: ROLE_USER
         → 관리자: ROLE_ADMIN
         ═══════════════════════════════════════════════════════════ -->
    <insert id="insertMemberRole">
        INSERT INTO member_roles (id, role)
        VALUES (#{id}, #{role})
    </insert>

    <!-- ═══════════════════════════════════════════════════════════
         ✏️ UPDATE : 회원 정보 수정
         
         📌 수정 가능한 필드: email, phone만
         → id, password는 별도 메서드로 처리
         ═══════════════════════════════════════════════════════════ -->
    <update id="updateMember" parameterType="MemberDTO">
        UPDATE members
        SET email = #{email}, phone = #{phone}
        WHERE id = #{id}
    </update>

    <!-- ═══════════════════════════════════════════════════════════
         ✏️ UPDATE : 비밀번호 업데이트
         
         📌 비밀번호 변경 전용 메서드
         → 암호화된 비밀번호로 저장됨
         ═══════════════════════════════════════════════════════════ -->
    <update id="updatePassword">
        UPDATE members
        SET password = #{password}
        WHERE id = #{id}
    </update>

    <!-- ═══════════════════════════════════════════════════════════
         🗑️ DELETE : 회원 삭제
         
         📌 물리적 삭제 (실제 DB에서 제거)
         → 주의: 관련 데이터(댓글, 게시글 등)도 함께 처리 필요
         ═══════════════════════════════════════════════════════════ -->
    <delete id="deleteMember" parameterType="String">
        DELETE FROM members
        WHERE id = #{id}
    </delete>

</mapper>
```

### 5.3 ReplyMapper.xml 상세 설명

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
  "https://mybatis.org/dtd/mybatis-3-mapper.dtd">
<!-- ═══════════════════════════════════════════════════════════════════
     ReplyMapper.xml
     
     🎯 역할: 댓글 관련 SQL 쿼리 모음
     • 댓글 CRUD 작업
     • 게시글별 댓글 목록 조회 (페이징)
     • 논리적 삭제 처리
     ═══════════════════════════════════════════════════════════════════ -->
<mapper namespace="org.zerock.mapper.ReplyMapper">
  
  <!-- ═══════════════════════════════════════════════════════════
       📋 resultMap : 컬럼명과 Java 필드명 매핑
       
       📌 왜 필요한가?
       → DB 컬럼명: replydate (소문자)
       → Java 필드명: replyDate (카멜케이스)
       → 직접 매핑 필요
       ═══════════════════════════════════════════════════════════ -->
  <resultMap id="replyResultMap" type="org.zerock.dto.ReplyDTO">
    <id property="rno" column="rno"/>
    <result property="replyText" column="replyText"/>
    <result property="replyer" column="replyer"/>
    <result property="replyDate" column="replydate"/>
    <result property="updateDate" column="updatedate"/>
    <result property="deflag" column="deflag"/>
    <result property="bno" column="bno"/>
  </resultMap>
  
  <!-- ═══════════════════════════════════════════════════════════
       ➕ INSERT : 댓글 등록
       
       📌 selectKey : INSERT 후 자동 생성된 키값 가져오기
       • order="AFTER" : INSERT 실행 후 SELECT 실행
       • keyProperty="rno" : 결과를 ReplyDTO의 rno 필드에 저장
       • LAST_INSERT_ID() : MySQL의 마지막 AUTO_INCREMENT 값
       ═══════════════════════════════════════════════════════════ -->
  <insert id="insert">
  	<selectKey order="AFTER" keyProperty="rno"
  		resultType="int">
  		SELECT LAST_INSERT_ID()
  	</selectKey>
  
  	INSERT INTO reply(bno, replyText, replyer)
  	VALUES(#{bno}, #{replyText}, #{replyer})
  </insert>
  
  <!-- ═══════════════════════════════════════════════════════════
       🔍 SELECT : 댓글 조회
       
       📌 resultMap 사용
       → 위에서 정의한 replyResultMap으로 매핑
       ═══════════════════════════════════════════════════════════ -->
  <select id="read" resultMap="replyResultMap">
  	SELECT rno, replyText, replyer, replydate, updatedate, deflag, bno 
  	FROM reply 
  	WHERE rno = #{rno}
  </select>
  
  <!-- ═══════════════════════════════════════════════════════════
       🗑️ UPDATE : 댓글 삭제 (논리적 삭제)
       
       📌 실제 DELETE가 아닌 UPDATE
       → deflag = true로 변경하여 삭제 표시
       → 데이터 복구 가능
       ═══════════════════════════════════════════════════════════ -->
  <update id="delete">
    UPDATE reply
    SET deflag = true 
    WHERE rno = #{rno}
  </update>
  
  <!-- ═══════════════════════════════════════════════════════════
       ✏️ UPDATE : 댓글 수정
       
       📌 updatedate = NOW()
       → 수정 시간을 현재 시간으로 갱신
       ═══════════════════════════════════════════════════════════ -->
  <update id="update">
  	UPDATE reply
  	SET replyText = #{replyText}, updatedate = NOW()
  	WHERE rno = #{rno}
  </update>
  
  <!-- ═══════════════════════════════════════════════════════════
       📄 SELECT : 게시글의 댓글 목록 조회 (페이징)
       
       📌 WHERE bno = #{bno}
       → 특정 게시글의 댓글만 조회
       
       📌 rno > 0 AND deflag = false
       → 유효한 댓글만 조회 (삭제되지 않은 것)
       
       📌 ORDER BY rno ASC
       → 댓글 번호 순서대로 (등록 순서)
       
       📌 AS 별칭 사용
       → replydate AS replyDate : 컬럼명을 Java 필드명에 맞게 변환
       ═══════════════════════════════════════════════════════════ -->
  <select id="listOfBoard" resultType="org.zerock.dto.ReplyDTO">  
  	SELECT 
  		rno, 
  		replyText, 
  		replyer, 
  		replydate AS replyDate, 
  		updatedate AS updateDate, 
  		deflag, 
  		bno 
  	FROM reply
  	WHERE bno = #{bno} AND rno > 0 AND deflag = false
  	ORDER BY rno ASC
  	LIMIT #{size} OFFSET #{skip}
  </select>
  
  <!-- ═══════════════════════════════════════════════════════════
       🔢 SELECT : 게시글의 댓글 수 조회
       
       📌 페이징을 위한 총 댓글 수 계산
       → 특정 게시글(bno)의 댓글 개수만 카운트
       ═══════════════════════════════════════════════════════════ -->
  <select id="countOfBoard" resultType="int">
  	SELECT COUNT(rno) 
  	FROM reply
  	WHERE bno = #{bno} AND rno > 0 AND deflag = false
  </select>
  
</mapper>
```

### 5.4 Java Mapper 인터페이스와의 연결

```
┌─────────────────────────────────────────────────────────────────┐
│               Mapper 인터페이스 ↔ XML 연결                       │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  📄 BoardMapper.java (인터페이스)                                │
│  ┌──────────────────────────────────────────────┐              │
│  │ @Mapper                                      │              │
│  │ public interface BoardMapper {               │              │
│  │     List<BoardDTO> selectAllBoards();   ←───┼──┐           │
│  │     BoardDTO selectOneBySeq(int seq);   ←───┼──┼──┐        │
│  │     void insertBoard(BoardDTO dto);     ←───┼──┼──┼──┐     │
│  │     void updateBoard(BoardDTO dto);     ←───┼──┼──┼──┼──┐  │
│  │ }                                            │  │  │  │  │  │
│  └──────────────────────────────────────────────┘  │  │  │  │  │
│                                                     │  │  │  │  │
│  📄 BoardMapper.xml (SQL)                           │  │  │  │  │
│  ┌──────────────────────────────────────────────┐  │  │  │  │  │
│  │ <mapper namespace="...BoardMapper">          │  │  │  │  │  │
│  │   <select id="selectAllBoards">         ←───┘  │  │  │  │  │
│  │   <select id="selectOneBySeq">          ←──────┘  │  │  │  │
│  │   <insert id="insertBoard">             ←─────────┘  │  │  │
│  │   <update id="updateBoard">             ←────────────┘  │  │
│  │ </mapper>                                                │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
│  📌 연결 규칙:                                                   │
│  • namespace = 인터페이스 전체 경로                              │
│  • id = 메서드 이름                                              │
│  • parameterType = 메서드 파라미터 타입                         │
│  • resultType = 메서드 반환 타입                                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 6. XML 설정 파일 요약 테이블

| 파일 | 위치 | 주요 역할 | 로드 시점 |
|------|------|----------|----------|
| pom.xml | 프로젝트 루트 | Maven 의존성 및 빌드 설정 | 빌드 시 |
| web.xml | WEB-INF/ | 웹앱 진입점, 필터/서블릿 설정 | 서버 시작 시 |
| root-context.xml | WEB-INF/spring/ | DB, Service, Mapper, 트랜잭션 | 서버 시작 시 |
| servlet-context.xml | WEB-INF/spring/ | Controller, View Resolver | 요청 수신 시 |
| mybatis-config.xml | resources/ | MyBatis 전역 설정 | SqlSessionFactory 생성 시 |
| log4j2.xml | resources/ | 로깅 설정 | 애플리케이션 시작 시 |
| BoardMapper.xml | resources/mapper/ | 게시판 SQL 쿼리 | Runtime 시 |
| MemberMapper.xml | resources/mapper/ | 회원 SQL 쿼리 | Runtime 시 |
| ReplyMapper.xml | resources/mapper/ | 댓글 SQL 쿼리 | Runtime 시 |

---

## 7. 설정 파일 로딩 순서

```
┌─────────────────────────────────────────────────────────────────┐
│                    서버 시작 시 로딩 순서                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  1️⃣ Tomcat 시작                                                 │
│      │                                                          │
│      ▼                                                          │
│  2️⃣ web.xml 읽기                                                │
│      │                                                          │
│      ├──▶ Filter 등록 (인코딩, 시큐리티)                         │
│      │                                                          │
│      ├──▶ Listener 실행 (ContextLoaderListener)                │
│      │         │                                                │
│      │         ▼                                                │
│      │    3️⃣ root-context.xml 로드                              │
│      │         │                                                │
│      │         ├──▶ DataSource (DB 연결)                        │
│      │         ├──▶ SqlSessionFactory (MyBatis)                │
│      │         │         └──▶ mybatis-config.xml               │
│      │         │         └──▶ *Mapper.xml                      │
│      │         ├──▶ Service Bean 등록                          │
│      │         └──▶ Security Bean 등록                         │
│      │                                                          │
│      └──▶ Servlet 등록 (DispatcherServlet)                     │
│                │                                                │
│                ▼                                                │
│           4️⃣ servlet-context.xml 로드                           │
│                │                                                │
│                ├──▶ Controller Bean 등록                       │
│                └──▶ View Resolver 설정                         │
│                                                                 │
│  5️⃣ 서버 준비 완료! 요청 대기 중...                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

👉 **다음: Part 7: 코드 주석 가이드** - 각 Java 파일에 필요한 핵심 주석 설명
