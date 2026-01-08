<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../includes/header.jsp" %>

        <div class="card">
            <h2 style="margin-top: 0; margin-bottom: 2rem;">게시글 수정</h2>

            <form role="form" action="/board/modify" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <input type="hidden" name="seq" value='<c:out value="${board.seq}"/>'>
                <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>

                <div class="form-group">
                    <label>번호</label>
                    <input value='<c:out value="${board.seq}"/>' readonly>
                </div>

                <div class="form-group">
                    <label>제목</label>
                    <input name="title" value='<c:out value="${board.title}"/>' required>
                </div>

                <div class="form-group">
                    <label>내용</label>
                    <textarea name="content" required><c:out value="${board.content}"/></textarea>
                </div>

                <div class="form-group">
                    <label>작성자</label>
                    <input name="writer" value='<c:out value="${board.writer}"/>' readonly>
                </div>

                <div
                    style="display: flex; gap: 0.5rem; border-top: 1px solid var(--border-color); padding-top: 1.5rem; margin-top: 2rem;">
                    <sec:authentication property="principal" var="pinfo" />
                    <sec:authorize access="isAuthenticated()">
                        <c:if test="${pinfo.username eq board.writer}">
                            <button type="submit" data-oper='modify' class="btn btn-primary">수정완료</button>
                            <button type="submit" data-oper='remove' class="btn btn-outline"
                                style="color: var(--danger); border-color: var(--danger);">삭제하기</button>
                        </c:if>
                    </sec:authorize>
                    <button type="submit" data-oper='list' class="btn btn-outline">목록</button>
                </div>
            </form>
        </div>

        <script>
            $(document).ready(function () {
                var formObj = $("form");

                $('button').on("click", function (e) {
                    e.preventDefault();
                    var operation = $(this).data("oper");

                    if (operation === 'remove') {
                        formObj.attr("action", "/board/remove");
                    } else if (operation === 'list') {
                        formObj.attr("action", "/board/list").attr("method", "get");
                        var pageNumTag = $("input[name='pageNum']").clone();
                        var amountTag = $("input[name='amount']").clone();
                        formObj.empty();
                        formObj.append(pageNumTag);
                        formObj.append(amountTag);
                    }
                    formObj.submit();
                });
            });
        </script>

        <%@ include file="../includes/footer.jsp" %>