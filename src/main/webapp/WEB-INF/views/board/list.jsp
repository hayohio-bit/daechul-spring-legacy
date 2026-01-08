<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../includes/header.jsp" %>

        <div class="card">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 1rem;">
                <h2 style="margin: 0;">게시판 목록</h2>
                <sec:authorize access="isAuthenticated()">
                    <a href="/board/register" class="btn btn-primary">글쓰기</a>
                </sec:authorize>
            </div>

            <table>
                <thead>
                    <tr>
                        <th style="width: 80px;">번호</th>
                        <th>제목</th>
                        <th style="width: 150px;">작성자</th>
                        <th style="width: 150px;">작성일</th>
                        <th style="width: 80px;">조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="board">
                        <tr>
                            <td>${board.seq}</td>
                            <td>
                                <a href='/board/get?seq=<c:out value="${board.seq}"/>&pageNum=${pageMaker.cri.pageNum}&amount=${pageMaker.cri.amount}'
                                    style="text-decoration: none; color: inherit; font-weight: 500;">
                                    <c:out value="${board.title}" />
                                    <c:if test="${board.replyCnt > 0}">
                                        <span
                                            style="color: var(--primary-color); font-size: 0.8em; margin-left: 4px;">[${board.replyCnt}]</span>
                                    </c:if>
                                </a>
                            </td>
                            <td>
                                <c:out value="${board.writer}" />
                            </td>
                            <td>
                                <c:out value="${board.getCreatedDate()}" />
                            </td>
                            <td>${board.hit}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Pagination -->
            <div class="pagination">
                <c:if test="${pageMaker.prev}">
                    <a href="/board/list?pageNum=${pageMaker.startPage - 1}&amount=${pageMaker.cri.amount}"
                        class="pagination-item">이전</a>
                </c:if>

                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                    <a href="/board/list?pageNum=${num}&amount=${pageMaker.cri.amount}"
                        class="pagination-item ${pageMaker.cri.pageNum == num ? 'active' : ''}">${num}</a>
                </c:forEach>

                <c:if test="${pageMaker.next}">
                    <a href="/board/list?pageNum=${pageMaker.endPage + 1}&amount=${pageMaker.cri.amount}"
                        class="pagination-item">다음</a>
                </c:if>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                var result = '<c:out value="${result}"/>';
                if (result != '' && history.state == null) {
                    alert("처리가 완료되었습니다.");
                }
                history.replaceState({}, null, null);
            });
        </script>

        <%@ include file="../includes/footer.jsp" %>