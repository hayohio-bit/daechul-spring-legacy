<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DC-SF Spring 게시판</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .hero-section { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 60vh; }
        .feature-card { transition: transform 0.3s; }
        .feature-card:hover { transform: translateY(-10px); }
    </style>
</head>
<body>

    <!-- Hero Section -->
    <section class="hero-section text-white d-flex align-items-center">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">Spring Legacy Migration</h1>
                    <p class="lead mb-4">JSP/Servlet → Spring Framework 완벽 전환</p>
                    <div class="d-flex gap-3 flex-wrap">
                        <a href="/board/list" class="btn btn-light btn-lg px-5">
                            <i class="bi bi-journal-text me-2"></i>게시판 바로가기
                        </a>
                        <a href="/member/login" class="btn btn-outline-light btn-lg px-5">
                            <i class="bi bi-box-arrow-in-right me-2"></i>로그인
                        </a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="text-center">
                        <i class="bi bi-spring display-1 text-white-50"></i>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row text-center mb-5">
                <div class="col-lg-8 mx-auto">
                    <h2 class="display-5 fw-bold">주요 기능</h2>
                    <p class="lead text-muted">Spring Framework로 마이그레이션된 완성도 높은 시스템</p>
                </div>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="card h-100 feature-card border-0 shadow-sm">
                        <div class="card-body text-center p-5">
                            <i class="bi bi-list-ul display-4 text-primary mb-3"></i>
                            <h4 class="card-title">게시판 CRUD</h4>
                            <p class="card-text">전체 기능 완비 (목록/상세/작성/수정/삭제)</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="card h-100 feature-card border-0 shadow-sm">
                        <div class="card-body text-center p-5">
                            <i class="bi bi-shield-check display-4 text-success mb-3"></i>
                            <h4 class="card-title">Spring Security</h4>
                            <p class="card-text">인증/인가 완벽 구현</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="card h-100 feature-card border-0 shadow-sm">
                        <div class="card-body text-center p-5">
                            <i class="bi bi-database display-4 text-info mb-3"></i>
                            <h4 class="card-title">MyBatis</h4>
                            <p class="card-text">성능 최적화된 데이터 처리</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <%-- <%@ include file="/WEB-INF/views/common/footer.jsp" %> --%>

    <!-- Bootstrap 5 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
