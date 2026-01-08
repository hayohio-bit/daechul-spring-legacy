<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
	<%@ include file="../includes/header.jsp" %>
	
            <div class="container mt-5 mb-5">
                <div class="row justify-content-center">
                    <div class="col-md-10">
                        <h2 class="mb-4 text-center">게시물 등록</h2>
                        <form action="/board/write" method="post" class="needs-validation" novalidate>
                            <div class="mb-4">
                                <label for="title" class="form-label fw-bold">제목 <span
                                        class="text-danger">*</span></label>
                                <input type="text" class="form-control form-control-lg" id="title" name="title"
                                    maxlength="100" required placeholder="제목을 입력하세요.">
                                <div class="invalid-feedback">제목은 필수입니다 (최대 100자).</div>
                            </div>

                            <div class="mb-4">
                                <label for="writer" class="form-label fw-bold">작성자 <span
                                        class="text-danger">*</span></label>
                                <input type="text" class="form-control form-control-lg" id="writer" name="writer"
                                    maxlength="20" required placeholder="작성자 이름을 입력하세요.">
                                <div class="invalid-feedback">작성자는 필수입니다 (최대 20자).</div>
                            </div>

                            <div class="mb-4">
                                <label for="content" class="form-label fw-bold">내용 <span
                                        class="text-danger">*</span></label>
                                <textarea class="form-control" id="content" name="content" rows="15"
                                    style="resize: vertical; min-height: 300px;" required
                                    placeholder="내용을 입력하세요."></textarea>
                                <div class="invalid-feedback">내용은 필수입니다.</div>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-success btn-lg me-3 px-5">
                                    <i class="bi bi-check-circle"></i> 등록
                                </button>
                                <a href="/board/list" class="btn btn-outline-secondary btn-lg px-5">
                                    <i class="bi bi-list-ul"></i> 목록
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <script>
                // Bootstrap 5 클라이언트 유효성 검사
                (function () {
                    'use strict';
                    var forms = document.querySelectorAll('.needs-validation');
                    Array.prototype.slice.call(forms).forEach(function (form) {
                        form.addEventListener('submit', function (event) {
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                })();
            </script>