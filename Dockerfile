# ---------------------------------------------------
# 1. 서버 환경 설정 (Tomcat 9 + Java 11)
# ---------------------------------------------------
FROM tomcat:9.0-jdk11-openjdk-slim
# 2. 톰캣의 기본 앱들을 삭제하여 충돌 방지
RUN rm -rf /usr/local/tomcat/webapps/*
# 3. 내 PC의 target 폴더에 있는 war 파일을 톰캣으로 복사
# (주의: target 폴더 안에 .war 파일이 1개만 있어야 함)
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war
# 4. 서버가 사용할 포트 번호 안내
EXPOSE 8080
# 5. 서버 실행 명령
CMD ["catalina.sh", "run"]
# ---------------------------------------------------