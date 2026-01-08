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
                gap: 1rem;
                /* Use gap instead of space-between for better control */
                margin-top: 1rem;
                flex-wrap: wrap;
                /* Allow wrapping if absolutely necessary on smaller screens */
            }

            .flow-node {
                background: var(--glass-bg);
                border: 2px solid var(--accent);
                /* Slightly thicker border for clarity */
                padding: 0.75rem 1rem;
                border-radius: 0.75rem;
                font-weight: 700;
                min-width: 100px;
                /* Reduced min-width to prevent overflow */
                font-size: 0.9rem;
                /* Slightly smaller font */
                box-shadow: 0 4px 15px rgba(129, 140, 248, 0.2);
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
                                <p class="p-subtitle" data-swiper-parallax="-200">DC-SF Spring Legacy Migration Project
                                </p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <div class="about-box">
                                    <div class="about-text">
                                        <p>본 프로젝트는 기존의 JSP/Servlet 기반 레거시 시스템을 최신 Spring Framework 6 아키텍처로 마이그레이션한
                                            사례입니다. 코드의 결합도를 낮추고 유지보수성을 극대화하며, 최신 보안 표준을 적용하여 견고한 애플리케이션 프레임워크를 구축하는 것을
                                            핵심 목표로 합니다.</p>
                                        <div class="info-grid">
                                            <div class="info-item">
                                                <h5>현대화 (Modernization)</h5>
                                                <p>Java 21 및 Spring 6 기반의 최신 환경 구축</p>
                                            </div>
                                            <div class="info-item">
                                                <h5>보안 강화 (Security)</h5>
                                                <p>Spring Security 6를 통한 체계적인 인증/인가</p>
                                            </div>
                                            <div class="info-item">
                                                <h5>최적화 (Optimization)</h5>
                                                <p>MyBatis 및 HikariCP를 활용한 효율적 데이터 처리</p>
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
                                <p class="p-subtitle" data-swiper-parallax="-200">Architecture & Performance
                                    Transformation</p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <div class="comp-box">
                                    <div class="comp-card">
                                        <h4>Legacy (Before)</h4>
                                        <ul class="comp-list">
                                            <li>JSP / Servlet 중심의 강한 결합</li>
                                            <li>JDBC 사용으로 인한 반복적 코드</li>
                                            <li>수동적인 트랜잭션 관리 및 보안</li>
                                            <li>스파게티 코드로 인한 유지보수 어려움</li>
                                        </ul>
                                    </div>
                                    <div class="comp-card" style="border-color: var(--accent);">
                                        <h4>Spring 6 (After)</h4>
                                        <ul class="comp-list">
                                            <li>Layered Architecture (관심사 분리)</li>
                                            <li>MyBatis를 통한 선언적 SQL 매핑</li>
                                            <li>Annotation 기반의 자동 설정 및 보안</li>
                                            <li>높은 확장성과 재사용 가능한 컴포넌트</li>
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
                                <p class="p-subtitle" data-swiper-parallax="-200">Structured Package & Responsibility
                                </p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <div class="info-grid">
                                    <div class="info-item">
                                        <h5>Controller</h5>
                                        <p><strong>org.zerock.controller</strong><br>사용자 요청 매핑, Model 객체 관리, View
                                            반환(JSP)</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Service</h5>
                                        <p><strong>org.zerock.service</strong><br>핵심 비즈니스 로직 처리, 트랜잭션 단위의 기능 수행</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Mapper</h5>
                                        <p><strong>org.zerock.mapper</strong><br>MyBatis 기반 SQL 연동, 데이터베이스 CRUD 인터페이스
                                        </p>
                                    </div>
                                    <div class="info-item">
                                        <h5>DTO / Domain</h5>
                                        <p><strong>org.zerock.dto / domain</strong><br>계층 간 데이터 전송(Data Transfer Object)
                                            및 도메인 객체</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Security</h5>
                                        <p><strong>org.zerock.security</strong><br>UserDetailsService 구현, 권한 관리 및 필터 보안
                                        </p>
                                    </div>
                                    <div class="info-item">
                                        <h5>Resources</h5>
                                        <p><strong>src/main/resources</strong><br>log4j2.xml, MyBatis XML Mapper,
                                            Context 설정</p>
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
                                <p class="p-subtitle" data-swiper-parallax="-200">Component Interaction & Flow</p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <p style="text-align: left; color: var(--text-dim); margin-bottom: 2rem;">각 레이어는 인터페이스를
                                    통해 느슨하게 연결(Loosely Coupled)되어 있으며, Dependency Injection을 통해 의존성이 주입됩니다.</p>
                                <div class="flow-container">
                                    <div class="flow-node">Browser (JSP)</div>
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
                                        <p>CRUD 기능, 페이징 처리, 조회수 증가, 게시글 검색 기능</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>댓글 (Reply)</h5>
                                        <p>Ajax 기반 실시간 댓글 등록/삭제, 게시글 연동 처리</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>회원 (Member)</h5>
                                        <p>회원가입, 중복 체크, 회원 정보 수정, 회원 등급 관리</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>인증 (Auth)</h5>
                                        <p>Spring Security Form Login, Remember-me, 로그아웃</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>권한 (Permission)</h5>
                                        <p>게시글 작성자 본인 확인(AOP), 페이지별 접근 제한</p>
                                    </div>
                                    <div class="info-item">
                                        <h5>파일 (Upload)</h5>
                                        <p>멀티파트 파일 업로드 및 서버 저장 처리 (확장 예정)</p>
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
                                <p class="p-subtitle" data-swiper-parallax="-200">Retrospective & Contactor</p>
                            </div>
                            <div class="slide-body" data-swiper-parallax="-100">
                                <div class="about-box">
                                    <div class="about-text">
                                        <h3>"Legacy에서 Modern으로의 여정"</h3>
                                        <p>레거시 코드의 복잡성을 해결하고 현대적인 웹 아키텍처로의 전환 과정을 통해 객체지향 설계와 프레임워크의 핵심 원리를 깊이 있게 이해할 수
                                            있었습니다. 특히 스프링 시큐리티를 통한 보안 프로세스와 MyBatis의 유연한 SQL 관리 방식을 경험하며 탄탄한 백엔드 개발 역량을
                                            쌓았습니다.</p>
                                        <div class="profile-info">
                                            <span><strong>성함:</strong> 신대철</span>
                                            <span><strong>GitHub:</strong> <a href="https://github.com/hayohio-bit"
                                                    target="_blank">github.com/hayohio-bit/daechul-spring-legacy</a></span>
                                            <span><strong>프로젝트 기간:</strong> 2026.01 - 2026.02</span>
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