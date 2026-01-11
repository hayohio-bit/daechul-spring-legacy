-- 1. members 테이블 생성
CREATE TABLE members (
    id VARCHAR(50) PRIMARY KEY,
    password VARCHAR(200) NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(200) NOT NULL,
    role VARCHAR(20) DEFAULT 'MEMBER',
    phone VARCHAR(20),
    regdate TIMESTAMP DEFAULT NOW(),
    enabled BOOLEAN DEFAULT TRUE
);
-- 2. member_roles 테이블 생성
CREATE TABLE member_roles (
    id VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    PRIMARY KEY (id, role),
    FOREIGN KEY (id) REFERENCES members(id) ON DELETE CASCADE
);
-- 3. board 테이블 생성
CREATE TABLE board (
    seq INT AUTO_INCREMENT PRIMARY KEY,
    writer VARCHAR(50) NOT NULL,
    title VARCHAR(500) NOT NULL,
    content TEXT NOT NULL,
    hit INT DEFAULT 0,
    regdate TIMESTAMP DEFAULT NOW(),
    updatedate TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP,
    replyCnt INT DEFAULT 0,
    delflag BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (writer) REFERENCES members(id) ON DELETE CASCADE
);
-- 4. reply 테이블 생성
CREATE TABLE reply (
    rno INT AUTO_INCREMENT PRIMARY KEY,
    bno INT NOT NULL,
    replyText VARCHAR(500) NOT NULL,
    replyer VARCHAR(50) NOT NULL,
    replydate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    delflag BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (bno) REFERENCES board(seq) ON DELETE CASCADE
);
-- 5. persistent_logins 테이블 생성 (Spring Security)
CREATE TABLE persistent_logins (
    username VARCHAR(64) NOT NULL,
    series VARCHAR(64) PRIMARY KEY,
    token VARCHAR(64) NOT NULL,
    last_used TIMESTAMP NOT NULL
);