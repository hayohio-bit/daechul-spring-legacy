<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>

        <!-- Swiper CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

        <style>
            :root {
                --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
                --glass-bg: rgba(255, 255, 255, 0.08);
                --glass-border: rgba(255, 255, 255, 0.15);
                --swiper-theme-color: #fff;
            }

            .premium-hero {
                margin-top: 1.5rem;
                border-radius: 2rem;
                overflow: hidden;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
                position: relative;
                background: #0f172a;
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
                overflow: hidden;
            }

            .slide-bg {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-size: cover;
                background-position: center;
                opacity: 0.5;
                transition: transform 8s ease-out;
                z-index: 1;
            }

            .swiper-slide-active .slide-bg {
                transform: scale(1.1);
            }

            .slide-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: radial-gradient(circle at center, transparent 0%, rgba(15, 23, 42, 0.8) 100%);
                z-index: 2;
            }

            .slide-content {
                position: relative;
                z-index: 3;
                max-width: 900px;
                padding: 3rem;
                text-align: center;
            }

            /* Parallax Elements */
            .p-title {
                font-size: 4.5rem;
                font-weight: 800;
                line-height: 1;
                margin-bottom: 2rem;
                background: linear-gradient(to bottom, #ffffff, #94a3b8);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                text-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
            }

            .p-subtitle {
                font-size: 1.5rem;
                font-weight: 400;
                color: #cbd5e1;
                margin-bottom: 3rem;
                letter-spacing: 0.05em;
            }

            .premium-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
                gap: 2rem;
                margin-top: 2rem;
            }

            .premium-item {
                background: var(--glass-bg);
                backdrop-filter: blur(20px);
                padding: 2rem;
                border-radius: 1.5rem;
                border: 1px solid var(--glass-border);
                transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            }

            .premium-item:hover {
                transform: translateY(-10px) scale(1.05);
                background: rgba(255, 255, 255, 0.12);
                border-color: rgba(255, 255, 255, 0.3);
            }

            .premium-item .icon {
                font-size: 2rem;
                margin-bottom: 1rem;
                display: block;
            }

            .premium-item h4 {
                color: #f8fafc;
                font-weight: 700;
                margin-bottom: 0.5rem;
            }

            .premium-item span {
                font-size: 0.9rem;
                color: #94a3b8;
            }

            /* Custom Navigation */
            .swiper-button-next,
            .swiper-button-prev {
                width: 60px;
                height: 60px;
                background: var(--glass-bg);
                backdrop-filter: blur(10px);
                border: 1px solid var(--glass-border);
                border-radius: 50%;
                color: white;
                transition: all 0.3s;
            }

            .swiper-button-next:after,
            .swiper-button-prev:after {
                font-size: 1.5rem;
                font-weight: 900;
            }

            .swiper-button-next:hover,
            .swiper-button-prev:hover {
                background: #6366f1;
                border-color: #6366f1;
                box-shadow: 0 0 20px rgba(99, 102, 241, 0.5);
            }

            .swiper-pagination-bullet {
                width: 12px;
                height: 12px;
                background: rgba(255, 255, 255, 0.3);
                opacity: 1;
                transition: all 0.3s;
            }

            .swiper-pagination-bullet-active {
                width: 30px;
                background: #6366f1;
                border-radius: 6px;
            }

            /* Floating CTA */
            .cta-wrapper {
                margin-top: 4rem;
                text-align: center;
                perspective: 1000px;
            }

            .premium-cta {
                display: inline-flex;
                align-items: center;
                gap: 1rem;
                background: var(--primary-gradient);
                color: white;
                padding: 1.25rem 3.5rem;
                border-radius: 1rem;
                font-size: 1.25rem;
                font-weight: 700;
                text-decoration: none;
                box-shadow: 0 20px 40px rgba(99, 102, 241, 0.3);
                transition: all 0.5s;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .premium-cta:hover {
                transform: translateY(-5px) rotateX(10deg);
                box-shadow: 0 30px 60px rgba(99, 102, 241, 0.4);
                letter-spacing: 0.05em;
            }

            .premium-cta .arrow {
                transition: transform 0.3s;
            }

            .premium-cta:hover .arrow {
                transform: translateX(10px);
            }

            /* Slide Content Animations */
            [data-swiper-parallax] {
                transition-timing-function: cubic-bezier(0.2, 1, 0.3, 1);
            }

            .tech-pill-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 0.75rem;
                margin-top: 2rem;
            }

            .tech-pill {
                background: rgba(99, 102, 241, 0.15);
                color: #a5b4fc;
                padding: 0.5rem 1.25rem;
                border-radius: 5rem;
                border: 1px solid rgba(165, 180, 252, 0.2);
                font-size: 0.95rem;
                font-weight: 500;
                transition: all 0.3s;
            }

            .tech-pill:hover {
                background: #6366f1;
                color: white;
                transform: scale(1.1);
            }
        </style>

        <div class="premium-hero fade-in">
            <div class="swiper">
                <div class="slide-overlay"></div>
                <div class="swiper-wrapper">

                    <!-- Slide 1: Welcome -->
                    <div class="swiper-slide">
                        <div class="slide-bg" style="background-image: url('/images/door-802.jpg');"></div>
                        <div class="slide-content">
                            <h2 class="p-title" data-swiper-parallax="-500">DC-SF SPRING</h2>
                            <p class="p-subtitle" data-swiper-parallax="-300">Modern Architecture / Unrivaled
                                Performance</p>
                            <div class="premium-grid" data-swiper-parallax="-200">
                                <div class="premium-item">
                                    <span class="icon">🏛️</span>
                                    <h4>Legacy to Spring</h4>
                                    <span>Safe Migration</span>
                                </div>
                                <div class="premium-item">
                                    <span class="icon">⚡</span>
                                    <h4>Fast & Clean</h4>
                                    <span>Optimized Core</span>
                                </div>
                                <div class="premium-item">
                                    <span class="icon">🎨</span>
                                    <h4>Premium UI</h4>
                                    <span>Glassmorphism</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Slide 2: Technology -->
                    <div class="swiper-slide">
                        <div class="slide-bg" style="background-image: url('/images/door-802.jpg');"></div>
                        <div class="slide-content">
                            <h2 class="p-title" data-swiper-parallax="-500">Tech Stack</h2>
                            <p class="p-subtitle" data-swiper-parallax="-300">The Ultimate Engineering Choice</p>
                            <div class="tech-pill-container" data-swiper-parallax="-200">
                                <span class="tech-pill">Java 21</span>
                                <span class="tech-pill">Spring 6.2</span>
                                <span class="tech-pill">Security 6.2</span>
                                <span class="tech-pill">MyBatis 3.5</span>
                                <span class="tech-pill">MySQL 9.4</span>
                                <span class="tech-pill">HikariCP 7.0</span>
                            </div>
                        </div>
                    </div>

                    <!-- Slide 3: Security -->
                    <div class="swiper-slide">
                        <div class="slide-bg" style="background-image: url('/images/door-802.jpg');"></div>
                        <div class="slide-content">
                            <h2 class="p-title" data-swiper-parallax="-500">Security</h2>
                            <p class="p-subtitle" data-swiper-parallax="-300">Robust Defense Systems</p>
                            <div class="premium-grid" data-swiper-parallax="-200">
                                <div class="premium-item">
                                    <span class="icon">🔐</span>
                                    <h4>BCrypt</h4>
                                    <span>Data Encryption</span>
                                </div>
                                <div class="premium-item">
                                    <span class="icon">👥</span>
                                    <h4>Role-Based</h4>
                                    <span>Access Control</span>
                                </div>
                                <div class="premium-item">
                                    <span class="icon">🛡️</span>
                                    <h4>CSRF</h4>
                                    <span>Cross-Site Protection</span>
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

        <div class="cta-wrapper fade-in">
            <a href="/board/list" class="premium-cta">
                EXPLORE THE BOARD
                <span class="arrow">→</span>
            </a>
        </div>

        <!-- Swiper JS -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

        <script>
            const swiper = new Swiper('.swiper', {
                loop: true,
                parallax: true,
                speed: 1000,
                autoplay: {
                    delay: 6000,
                    disableOnInteraction: false,
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                    dynamicBullets: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                effect: 'fade',
                fadeEffect: {
                    crossFade: true
                }
            });
        </script>

        <%@ include file="/WEB-INF/views/includes/footer.jsp" %>