<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

        <!-- Swiper CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #4f46e5 0%, #9333ea 100%);
                --glass-bg: rgba(255, 255, 255, 0.03);
                --glass-border: rgba(255, 255, 255, 0.08);
                --text-dim: #94a3b8;
                --accent: #818cf8;
            }

            .premium-hero {
                margin-top: 1rem;
                border-radius: 1.5rem;
                overflow: hidden;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
                background: #0f172a;
                position: relative;
            }

            .swiper {
                width: 100%;
                height: 650px;
            }

            .swiper-slide {
                display: flex;
                align-items: center;
                justify-content: center;
                background: #0f172a;
                color: white;
                padding: 3rem 5rem;
                /* Reduced horizontal padding from 10rem to 5rem */
                box-sizing: border-box;
            }

            .slide-content {
                width: 100%;
                max-width: 900px;
                z-index: 10;
                display: flex;
                flex-direction: column;
                height: 100%;
            }

            .slide-header {
                margin-bottom: 2rem;
                text-align: left;
            }

            .p-title {
                font-size: 2.5rem;
                font-weight: 800;
                margin-bottom: 0.5rem;
                background: linear-gradient(to right, #ffffff, var(--accent));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
            }

            .p-subtitle {
                font-size: 1.1rem;
                color: var(--text-dim);
                border-left: 4px solid var(--accent);
                padding-left: 1rem;
            }

            .slide-body {
                flex-grow: 1;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            /* Comparison Table Style */
            .comp-box {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 2rem;
            }

            .comp-card {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                padding: 1.5rem;
                border-radius: 1rem;
            }

            .comp-card h4 {
                color: var(--accent);
                margin-bottom: 1rem;
                font-size: 1.25rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .comp-list {
                list-style: none;
                padding: 0;
                margin: 0;
                text-align: left;
            }

            .comp-list li {
                margin-bottom: 0.75rem;
                padding-left: 1.5rem;
                position: relative;
                font-size: 0.95rem;
                color: #e2e8f0;
            }

            .comp-list li::before {
                content: "•";
                position: absolute;
                left: 0;
                color: var(--accent);
            }

            /* Grid Info Style */
            .info-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 1.5rem;
            }

            .info-item {
                background: var(--glass-bg);
                border: 1px solid var(--glass-border);
                padding: 1.25rem;
                border-radius: 1rem;
                text-align: left;
            }

            .info-item h5 {
                color: var(--accent);
                margin-bottom: 0.5rem;
                font-size: 1rem;
            }

            .info-item p {
                font-size: 0.85rem;
                color: var(--text-dim);
                margin: 0;
                line-height: 1.6;
            }

            /* Process Flow Style */
            .flow-container {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 0.75rem;
                /* Reduced gap */
                margin-top: 2rem;
                flex-wrap: nowrap;
                /* Force single line */
            }

            .flow-node {
                background: var(--glass-bg);
                border: 2px solid var(--accent);
                padding: 0.6rem 0.8rem;
                /* Reduced padding */
                border-radius: 0.6rem;
                font-weight: 700;
                min-width: fit-content;
                /* Allow fitting content */
                font-size: 0.85rem;
                /* Slightly smaller font to ensure fit */
                box-shadow: 0 4px 15px rgba(129, 140, 248, 0.15);
                transition: all 0.3s ease;
                white-space: nowrap;
                /* Prevent text wrapping inside node */
            }

            .flow-node:hover {
                background: rgba(129, 140, 248, 0.1);
                transform: translateY(-3px);
            }

            .flow-arrow {
                color: var(--accent);
                font-size: 1.2rem;
                font-weight: 900;
            }

            /* About Style */
            .about-box {
                display: flex;
                gap: 3rem;
                align-items: center;
                text-align: left;
            }

            .about-text h3 {
                font-size: 1.75rem;
                margin-bottom: 1rem;
            }

            .about-text p {
                color: var(--text-dim);
                line-height: 1.8;
                margin-bottom: 1.5rem;
            }

            .profile-info {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .profile-info span {
                font-size: 0.95rem;
            }

            .profile-info a {
                color: var(--accent);
                text-decoration: none;
            }

            /* Swiper UI */
            .swiper-button-next,
            .swiper-button-prev {
                color: rgba(255, 255, 255, 0.3);
            }

            .swiper-pagination-bullet {
                background: #fff;
            }

            .swiper-pagination-bullet-active {
                background: var(--accent);
            }
        </style>

        <div class="premium-hero fade-in">
            <div class="swiper">
                <div class="swiper-wrapper">

                    <!-- Slide 1: 프로젝트 개요 -->
                    <div class="swiper-slide">
                        <div class="slide-content">
                            <div class="slide-header">
                                <h2 class="p-title" data-swiper-parallax="-300">프로젝트 개요</h2>
                                <p class="p-subtitle" data-swiper-parallax="-200">DC Spring Legacy Migration Project
                                </p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <div class="about-box">
                                    <div class="about-text">
                                        <p>본 프로젝트는 JSP/Servlet Model 2 기반의 레거시(daechul-project)를 Spring Framework
                                            환경으로 마이그레이션한 프로젝트입니다. IoC/DI 컨테이너와 AOP를 도입하여 객체 간 결합도를 낮추고, Spring Security를
                                            통합하여 URL 레벨 제어 및 어노테이션 기반(@PreAuthorize)의 세밀한 권한 관리를 구현하였습니다.</p>
                                        <div class="info-grid">
                                            <div class="info-item">
                                                <h5>현대화 (Modernization)</h5>
                                                <p>Spring 6 요구사항 충족을 위한 Java 21 및 Jakarta EE 최신 스펙 적용</p>
                                            </div>
                                            <div class="info-item">
                                                <h5>보안 강화 (Security)</h5>
                                                <p>Spring Security 6 기반 인증/인가, CSRF 토큰, BCrypt 암호화</p>
                                            </div>
                                            <div class="info-item">
                                                <h5>퍼시스턴스 최적화 (Data)</h5>
                                                <p>MyBatis 선언적 매핑, HikariCP 커넥션 풀, 트랜잭션 관리</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Slide 2: 마이그레이션 전후 비교 -->
                    <div class="swiper-slide">
                        <div class="slide-content">
                            <div class="slide-header">
                                <h2 class="p-title" data-swiper-parallax="-300">마이그레이션 전후 비교</h2>
                                <p class="p-subtitle" data-swiper-parallax="-200">Legacy Servlet to Spring MVC</p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <div class="comp-box">
                                    <div class="comp-card">
                                        <h4>Legacy (Before)</h4>
                                        <ul class="comp-list">
                                            <li>수동 ActionFactory 기반의 Command 패턴</li>
                                            <li>JDBC 직접 호출 및 반복적인 자원 해제 코드</li>
                                            <li>Servlet 내 강한 결합도(Hard Coupling)</li>
                                            <li>보안 및 트랜잭션의 수동 관리</li>
                                        </ul>
                                    </div>
                                    <div class="comp-card" style="border-color: var(--accent);">
                                        <h4>Spring 6 (After)</h4>
                                        <ul class="comp-list">
                                            <li>DispatcherServlet 기반의 Front Controller 패턴(중앙화)</li>
                                            <li>MyBatis(@Mapper)를 통한 선언적 SQL 매핑</li>
                                            <li>DI(의존성 주입)를 통한 느슨한 결합도(Loose Coupling)</li>
                                            <li>AOP 기반의 선언적 트랜잭션(@Transactional) 처리</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Slide 3: 폴더 구조 및 클래스 역할 -->
                    <div class="swiper-slide">
                        <div class="slide-content">
                            <div class="slide-header">
                                <h2 class="p-title" data-swiper-parallax="-300">프로젝트 구조 및 역할</h2>
                                <p class="p-subtitle" data-swiper-parallax="-200">Layered Architecture & Components
                                </p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <div class="info-grid">
                                    <div class="info-item">
                                        <h5>Controller</h5>
                                        <p><strong>org.zerock.controller</strong><br>요청 URL 매핑, Model 객체 관리, View
                                            반환(JSP)</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Service</h5>
                                        <p><strong>org.zerock.service</strong><br>핵심 비즈니스 로직 처리, 트랜잭션 단위의 기능 수행</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Mapper</h5>
                                        <p><strong>org.zerock.mapper</strong><br>MyBatis SQL 인터페이스, DB CRUD 연동</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>DTO / Domain</h5>
                                        <p><strong>org.zerock.dto / domain</strong><br>계층 간 데이터 교환을 위한 객체 (Lombok @Data
                                            사용)</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Security</h5>
                                        <p><strong>org.zerock.security</strong><br>UserDetailsService 구현, 권한 관리 및 필터 보안
                                        </p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Resources</h5>
                                        <p><strong>src/main/resources</strong><br>log4j2.xml, MyBatis Config, Mapper XML
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Slide 4: 상호관계 지표화 -->
                    <div class="swiper-slide">
                        <div class="slide-content">
                            <div class="slide-header">
                                <h2 class="p-title" data-swiper-parallax="-300">상호관계 지표화</h2>
                                <p class="p-subtitle" data-swiper-parallax="-200">Request Processing Flow & Dependency
                                    Injection</p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <p style="text-align: left; color: var(--text-dim); margin-bottom: 2rem;">
                                    DispatcherServlet이 모든 HTTP 요청을 중앙에서 받아 적절한 Controller로 위임하며, Service와 Mapper를 거쳐 DB
                                    결과가 DTO로 변환되어 반환됩니다.</p>
                                <div class="flow-container">
                                    <div class="flow-node">Browser (JSP)</div>
                                    <div class="flow-arrow">→</div>
                                    <div class="flow-node">DispatcherServlet</div>
                                    <div class="flow-arrow">→</div>
                                    <div class="flow-node">Controller</div>
                                    <div class="flow-arrow">→</div>
                                    <div class="flow-node">Service</div>
                                    <div class="flow-arrow">→</div>
                                    <div class="flow-node">Mapper</div>
                                    <div class="flow-arrow">→</div>
                                    <div class="flow-node">MySQL DB</div>
                                </div>
                                <div class="info-grid-compact"
                                    style="margin-top: 3rem; display: grid; grid-template-columns: 1fr 1fr; gap: 2rem;">
                                    <div style="text-align: left;">
                                        <h5 style="color: var(--accent);">의존성 전파</h5>
                                        <p style="font-size: 0.9rem; color: var(--text-dim);">상위 레이어는 하위 레이어의 인터페이스에만
                                            의존하며, 구체적인 구현체는 스프링 컨테이너에 의해 주입됩니다.</p>
                                    </div>
                                    <div style="text-align: left;">
                                        <h5 style="color: var(--accent);">데이터 흐름</h5>
                                        <p style="font-size: 0.9rem; color: var(--text-dim);">클라이언트의 요청 데이터는 DTO에 담겨
                                            전달되며, DB에서 조회된 결과 또한 DTO를 통해 화면까지 전달됩니다.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Slide 5: 프로젝트 구현 기능 -->
                    <div class="swiper-slide">
                        <div class="slide-content">
                            <div class="slide-header">
                                <h2 class="p-title" data-swiper-parallax="-300">프로젝트 구현 기능</h2>
                                <p class="p-subtitle" data-swiper-parallax="-200">Core Features & Functionality</p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <div class="info-grid">
                                    <div class="info-item">
                                        <h5>게시판 (Board)</h5>
                                        <p>CRUD 기능, 페이징 처리, 조회수 증가</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>댓글 (Reply)</h5>
                                        <p>Ajax 기반 실시간 댓글 등록/삭제, 게시글 연동 처리</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>회원 (Member)</h5>
                                        <p>회원가입, 중복 체크, 회원 정보 수정</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>인증 (Auth)</h5>
                                        <p>Spring Security Form Login, Remember-me, 로그아웃</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>권한 (Permission)</h5>
                                        <p>게시글 작성자 본인 확인(AOP)</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Slide 6: 회고 및 자기소개 -->
                    <div class="swiper-slide">
                        <div class="slide-content">
                            <div class="slide-header">
                                <h2 class="p-title" data-swiper-parallax="-300">프로젝트 회고 및 소개</h2>
                                <p class="p-subtitle" data-swiper-parallax="-200">Retrospective & Contact</p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <div class="about-box">
                                    <div class="about-text">
                                        <h3>"스프링의 핵심 원리를 관통하다"</h3>
                                        <p>단순한 코드 변환을 넘어, Servlet/JSP의 한계점을 스프링 프레임워크가 어떻게 해결하는지 체득했습니다. 의존성 주입(DI)과 관점
                                            지향 프로그래밍(AOP)을 직접 구현하며 백엔드 아키텍처에 대한 깊이 있는 이해를 갖추게 되었습니다.
                                        </p>
                                        <div class="profile-info">
                                            <span><strong>성함:</strong> 선하영 </span>
                                            <span><strong>GitHub:</strong> <a href="https://github.com/hayohio-bit"
                                                    target="_blank">/daechul-spring-legacy.git</a></span>
                                            <span><strong>프로젝트 기간:</strong> 2025.12.31 - 2026.06.07</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="swiper-pagination"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
        </div>

        <div style="margin-top: 2rem; text-align: center;">
            <a href="/board/list" class="btn-premium"
                style="background: var(--primary-gradient); color: white; padding: 1rem 3rem; border-radius: 0.75rem; text-decoration: none; font-weight: 700; box-shadow: 0 10px 20px rgba(79, 70, 229, 0.3); display: inline-block;">
                게시판 서비스 둘러보기 →
            </a>
        </div>

        <!-- Swiper JS -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

        <script>
            const swiper = new Swiper('.swiper', {
                loop: true,
                parallax: true,
                speed: 800,
                autoplay: {
                    delay: 7000,
                    disableOnInteraction: false,
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                grabCursor: true
            });
        </script>

        <%@ include file="/WEB-INF/views/includes/footer.jsp" %>