# 아래의 쿼리문은 root 계정에서 실행해야한다. 

# 데이터베이스 생성하기 
CREATE DATABASE sample_db;
# 사용자계정 생성하기 
CREATE USER 'sample_user'@'%' IDENTIFIED BY '1234';
# 권한부여하기: sample_user에게 sample_db의 모든 테이블을 
#관리할 수 있는 권한을 부여한다. 
GRANT ALL PRIVILEGES ON sample_db.* TO 'sample_user'@'%';
# 즉시적용하기 
FLUSH PRIVILEGES;
/*
사용자 계정을 만들때 localhost로 작성하면 서버내부에서만 접속을 
허용한다. 만약 외부에서도 접속할 수 있게 하려면 %로 작성해야한다.
*/


CREATE TABLE board (
    board_no    INT UNSIGNED  NOT NULL AUTO_INCREMENT   COMMENT '일련번호',
    title       VARCHAR(200)  NOT NULL                  COMMENT '제목',
    content     TEXT          NOT NULL                  COMMENT '내용',
    writer      VARCHAR(50)   NOT NULL                  COMMENT '작성자',
    reg_date    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '작성일',
    view_count  INT UNSIGNED  NOT NULL DEFAULT 0        COMMENT '조회수',
    writer_id   VARCHAR(50)   NOT NULL                  COMMENT '작성자아이디',
    PRIMARY KEY (board_no),
    KEY idx_board_writer_id (writer_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='게시판';


INSERT INTO board (title, content, writer, reg_date, view_count, writer_id) VALUES
('부천 신축 아파트 분양 일정 문의', '부천 지역에 올해 하반기 분양 예정인 아파트가 있는지 궁금합니다.', '홍길동', '2026-10-01 09:15:00', 12, 'hong01'),
('인천 송도 오피스텔 청약 후기', '지난주 송도 오피스텔 청약에 참여했습니다. 경쟁률이 생각보다 높았어요.', '김영희', '2026-10-05 14:30:00', 35, 'kimyh'),
('상가 분양 시 주의할 점', '신축 상가 분양받을 때 확인해야 할 사항을 정리해 봤습니다.', '이철수', '2026-10-10 11:00:00', 48, 'leecs'),
('청약 가점 계산 방법 질문', '무주택 기간과 부양가족 수에 따른 가점 계산이 헷갈립니다.', '박민수', '2026-10-15 20:45:00', 7, 'parkms'),
('인천 검단 분양정보 공유', '검단신도시 신규 분양 단지 정보를 공유합니다. 모델하우스 일정도 참고하세요.', '최지은', '2026-10-20 16:10:00', 21, 'choije');

-- 입력 확인
SELECT * FROM board ORDER BY board_no;




