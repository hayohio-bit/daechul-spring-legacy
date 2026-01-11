# 1. 서버 환경 설정 (Tomcat 10.1 + Java 21)
# Spring 6 프로젝트는 Jakarta EE 10 지원을 위해 Tomcat 10.1 이상
FROM tomcat:10.1-jdk21-openjdk-slim
# 2. 톰캣의 기본 앱들을 삭제하여 ROOT 충돌 방지
RUN rm -rf /usr/local/tomcat/webapps/*
# 3. 내 PC의 target 폴더에 있는 dc-sf-spring.war 파일을 톰캣으로 복사
# ROOT.war로 이름을 바꾸어 복사하면 접속 시 경로에 프로젝트명을 안 써도 됨
COPY target/dc-sf-spring.war /usr/local/tomcat/webapps/ROOT.war
# 4. 서버가 사용할 포트 번호
EXPOSE 8080
# 5. 서버 실행 명령
CMD ["catalina.sh", "run"]