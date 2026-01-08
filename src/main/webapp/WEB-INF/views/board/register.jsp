<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../includes/header.jsp" %>

        <style>
            .register-container {
                max-width: 800px;
                margin: 3rem auto;
                padding: 0 1.5rem;
            }

            .premium-card {
                background: #ffffff;
                border-radius: 1.5rem;
                border: 1px solid #e2e8f0;
                box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.05);
                overflow: hidden;
                animation: slideUp 0.6s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .card-header-premium {
                background: linear-gradient(135deg, #4f46e5 0%, #9333ea 100%);
                padding: 2.5rem 2rem;
                color: white;
                text-align: center;
            }

            .card-header-premium h2 {
                margin: 0;
                font-size: 2rem;
                font-weight: 800;
                letter-spacing: -0.025em;
            }

            .card-header-premium p {
                margin: 0.5rem 0 0;
                opacity: 0.8;
                font-size: 1rem;
            }

            .card-body-premium {
                padding: 2.5rem;
            }

            .form-group-premium {
                margin-bottom: 2rem;
            }

            .form-group-premium label {
                display: block;
                font-size: 0.875rem;
                font-weight: 700;
                color: #1e293b;
                margin-bottom: 0.625rem;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }

            .input-premium {
                width: 100%;
                padding: 0.875rem 1rem;
                border-radius: 0.75rem;
                border: 2px solid #e2e8f0;
                font-size: 1rem;
                color: #1e293b;
                background: #f8fafc;
                transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                box-sizing: border-box;
            }

            .input-premium:focus {
                outline: none;
                border-color: #4f46e5;
                background: #ffffff;
                box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.1);
                transform: translateY(-1px);
            }

            .input-premium[readonly] {
                background: #f1f5f9;
                cursor: not-allowed;
                color: #64748b;
            }

            textarea.input-premium {
                min-height: 200px;
                resize: vertical;
                line-height: 1.6;
            }

            .form-actions-premium {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                gap: 1rem;
                margin-top: 3rem;
                padding-top: 2rem;
                border-top: 1px solid #e2e8f0;
            }

            .btn-premium {
                padding: 0.875rem 2rem;
                border-radius: 0.75rem;
                font-weight: 700;
                font-size: 1rem;
                cursor: pointer;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                text-decoration: none;
                border: none;
            }

            .btn-submit {
                background: linear-gradient(135deg, #4f46e5 0%, #9333ea 100%);
                color: white;
                box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.4);
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 15px 30px -5px rgba(79, 70, 229, 0.5);
            }

            .btn-cancel {
                background: #ffffff;
                color: #64748b;
                border: 1px solid #e2e8f0;
            }

            .btn-cancel:hover {
                background: #f8fafc;
                color: #1e293b;
                border-color: #cbd5e1;
            }

            .btn-reset {
                background: transparent;
                color: #94a3b8;
                padding: 0.5rem 1rem;
                font-size: 0.875rem;
            }

            .btn-reset:hover {
                color: #64748b;
            }

            /* Small decorations */
            .required-dot {
                color: #ef4444;
                margin-left: 0.25rem;
            }
        </style>

        <div class="register-container">
            <div class="premium-card">
                <div class="card-header-premium">
                    <h2>새 게시글 작성</h2>
                    <p>당신의 소중한 생각을 공유해 주세요</p>
                </div>

                <div class="card-body-premium">
                    <form role="form" action="/board/register" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                        <div class="form-group-premium">
                            <label>제목 <span class="required-dot">*</span></label>
                            <input name="title" class="input-premium" placeholder="제목을 입력하세요 (최대 100자)" required
                                maxlength="100">
                        </div>

                        <div class="form-group-premium">
                            <label>작성자</label>
                            <input name="writer" class="input-premium"
                                value='<sec:authentication property="principal.username"/>' readonly>
                        </div>

                        <div class="form-group-premium">
                            <label>내용 <span class="required-dot">*</span></label>
                            <textarea name="content" class="input-premium" placeholder="내용을 자유롭게 작성해 주세요"
                                required></textarea>
                        </div>

                        <div class="form-actions-premium">
                            <button type="reset" class="btn-premium btn-reset">내용 초기화</button>
                            <a href="/board/list" class="btn-premium btn-cancel">취소</a>
                            <button type="submit" class="btn-premium btn-submit">
                                게시글 등록하기 →
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %>