<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../includes/header.jsp" %>

        <div class="card">
            <h2 style="margin-top: 0; margin-bottom: 2rem;">새 게시글 작성</h2>

            <form role="form" action="/board/register" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                <div class="form-group">
                    <label>제목</label>
                    <input name="title" placeholder="제목을 입력하세요" required>
                </div>

                <div class="form-group">
                    <label>내용</label>
                    <textarea name="content" placeholder="내용을 입력하세요" required></textarea>
                </div>

                <div class="form-group">
                    <label>작성자</label>
                    <input name="writer" value='<sec:authentication property="principal.username"/>' readonly>
                </div>

                <div
                    style="display: flex; gap: 0.5rem; border-top: 1px solid var(--border-color); padding-top: 1.5rem; margin-top: 2rem;">
                    <button type="submit" class="btn btn-primary">등록하기</button>
                    <button type="reset" class="btn btn-outline">다시쓰기</button>
                    <a href="/board/list" class="btn btn-outline">취소</a>
                </div>
            </form>
        </div>

        <%@ include file="../includes/footer.jsp" %>