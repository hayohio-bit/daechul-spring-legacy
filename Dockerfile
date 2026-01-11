# --- 1단계: 빌드 스테이지 (Maven + Java 21) ---
FROM maven:3.9.6-eclipse-temurin-21 AS build

# 작업 디렉토리 설정
WORKDIR /app

# 현재 폴더의 모든 파일을 컨테이너 내부로 복사
COPY . .

# Maven을 사용하여 WAR 파일 빌드 (테스트 제외)
RUN mvn clean package -DskipTests

# --- 2단계: 실행 스테이지 (Tomcat 10.1 + Java 21) ---
FROM tomcat:10.1-jdk21-openjdk-slim

# 톰캣 기본 앱 삭제
RUN rm -rf /usr/local/tomcat/webapps/*

# 1단계(build)에서 생성된 WAR 파일을 톰캣의 ROOT.war로 복사
COPY --from=build /app/target/dc-sf-spring.war /usr/local/tomcat/webapps/ROOT.war

# 포트 설정 및 실행
EXPOSE 8080
CMD ["catalina.sh", "run"]