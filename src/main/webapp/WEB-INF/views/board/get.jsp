<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../includes/header.jsp" %>
        <script src="/resources/js/reply.js"></script>

        <div class="card">
            <div style="border-bottom: 1px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 1.5rem;">
                <h2 style="margin: 0;">
                    <c:out value="${board.title}" />
                </h2>
                <div style="color: var(--text-muted); font-size: 0.875rem; margin-top: 0.5rem;">
                    작성자: <b>
                        <c:out value="${board.writer}" />
                    </b> | 작성일:
                    <c:out value="${board.getCreatedDate()}" /> | 조회수: ${board.hit}
                </div>
            </div>

            <div style="min-height: 200px; white-space: pre-wrap; margin-bottom: 2rem;">
                <c:out value="${board.content}" />
            </div>

            <hr style="border: none; border-top: 1px solid var(--border-color); margin-bottom: 1.5rem;">

            <div style="display: flex; gap: 0.5rem;">
                <sec:authentication property="principal" var="pinfo" />
                <sec:authorize access="isAuthenticated()">
                    <c:if test="${pinfo.username eq board.writer}">
                        <a href='/board/modify?seq=<c:out value="${board.seq}"/>&pageNum=${cri.pageNum}&amount=${cri.amount}'
                            class="btn btn-primary">수정하기</a>
                    </c:if>
                </sec:authorize>
                <a href='/board/list?pageNum=${cri.pageNum}&amount=${cri.amount}' class="btn btn-outline">목록으로</a>
            </div>
        </div>

        <!-- Reply Section -->
        <div class="card" style="margin-top: 2rem;">
            <h3>댓글</h3>

            <sec:authorize access="isAuthenticated()">
                <div style="margin-bottom: 1.5rem;">
                    <textarea id="replyText" placeholder="댓글을 입력하세요..." style="min-height: 80px;"></textarea>
                    <div style="display: flex; justify-content: flex-end; margin-top: 0.5rem;">
                        <button id="addReplyBtn" class="btn btn-primary">댓글 등록</button>
                    </div>
                </div>
            </sec:authorize>
            <sec:authorize access="isAnonymous()">
                <p style="color: var(--text-muted); text-align: center; padding: 1rem;">댓글을 작성하려면 <a
                        href="/customLogin">로그인</a>이 필요합니다.</p>
            </sec:authorize>

            <div id="replyList">
                <!-- Replies loaded here via AJAX -->
            </div>
        </div>

        <script>
            $(document).ready(function () {
                var bnoValue = '<c:out value="${board.seq}"/>';
                var replyList = $("#replyList");
                var replyer = "";

                <sec:authorize access="isAuthenticated()">
                    replyer = '<sec:authentication property="principal.username" />';
                </sec:authorize>

                var csrfHeaderName = "${_csrf.headerName}";
                var csrfTokenValue = "${_csrf.token}";

                // Setup CSRF for AJAX
                $(document).ajaxSend(function (e, xhr, options) {
                    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
                });

                function showList(page) {
                    console.log("Fetching replies for bno: " + bnoValue + ", page: " + page);
                    replyService.getList({ bno: bnoValue, page: page || 1 }, function (list) {
                        console.log("Reply list received:", list);
                        var str = "";
                        if (list == null || list.length == 0) {
                            replyList.html("<p style='color:var(--text-muted)'>등록된 댓글이 없습니다.</p>");
                            return;
                        }
                        for (var i = 0, len = list.length || 0; i < len; i++) {
                            str += "<div style='padding: 1rem 0; border-top:1px solid var(--border-color)'>";
                            str += "  <div style='display:flex; justify-content:space-between; margin-bottom:0.25rem'>";
                            str += "    <strong style='font-size:0.875rem'>" + list[i].replyer + "</strong>";
                            str += "    <small style='color:var(--text-muted)'>" + replyService.displayTime(list[i].replydate) + "</small>";
                            str += "  </div>";
                            str += "  <p style='margin:0.25rem 0'>" + list[i].replyText + "</p>";
                            if (replyer == list[i].replyer) {
                                str += "  <div style='display:flex; gap:0.5rem; margin-top:0.5rem; font-size:0.75rem'>";
                                str += "    <a href='#' class='removeReply' data-rno='" + list[i].rno + "' style='color:var(--danger)'>삭제</a>";
                                str += "  </div>";
                            }
                            str += "</div>";
                        }
                        replyList.html(str);
                    }, function (err) {
                        console.error("Failed to load replies:", err);
                        replyList.html("<p style='color:var(--danger)'>댓글 로딩 실패!</p>");
                    });
                }

                showList(1);

                // Add Reply
                $("#addReplyBtn").on("click", function (e) {
                    var reply = {
                        replyText: $("#replyText").val(),
                        replyer: replyer,
                        bno: bnoValue
                    };
                    replyService.add(reply, function (result) {
                        alert("댓글이 등록되었습니다.");
                        $("#replyText").val("");
                        showList(1);
                    });
                });

                // Remove Reply
                $(document).on("click", ".removeReply", function (e) {
                    e.preventDefault();
                    var rno = $(this).data("rno");
                    if (confirm("정말 삭제하시겠습니까?")) {
                        replyService.remove(rno, replyer, function (result) {
                            alert("삭제되었습니다.");
                            showList(1);
                        });
                    }
                });

            });
        </script>

        <%@ include file="../includes/footer.jsp" %>