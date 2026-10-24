-- 도커 데스크탑에 mariaDB 컨테이너를 추가하려 한다. 10.5.29버전이다. 최대한 유사한 버전으로 생성할 수 있는 명령어 작성해줘.

-- =====================================================================
-- Docker Desktop에 MariaDB 10.5.29 컨테이너 생성 (운영 서버와 동일 버전)
-- =====================================================================
/*
1. 이미지 받기
docker pull mariadb:10.5.29

2. 컨테이너 생성
docker run -d 
  --name mariadb105
  -p 3399:3306
  -e MARIADB_ROOT_PASSWORD=123456
  -e TZ=Asia/Seoul
  -v .\mariadb:/var/lib/mysql
  --restart unless-stopped
  mariadb:10.5.29
  --character-set-server=utf8mb4
  --collation-server=utf8mb4_unicode_ci
 

옵션 설명
  -p 3399:3306 : PC에서 3306을 이미 쓰고 있으므로 3399:3306처럼 앞쪽 포트를 바꾼다.
  -v .\mariadb : 데이터를 저장할 디렉토리를 .\mariadb로 설정하여 바인드 마운트 한다. 
  --character-set-server / --collation-server : 한글 처리를 위해 utf8mb4로 지정


3. 버전 확인 (결과가 10.5.29-MariaDB-... 이면 정상)
docker exec -it mariadb105 mysql -uroot -p -e "SELECT VERSION();"
*/


-- =====================================================================
-- 게시판 테이블 생성
-- 컬럼: 일련번호, 제목, 내용, 작성자, 작성일, 조회수, 작성자아이디
-- =====================================================================
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


-- =====================================================================
-- board 테이블 더미데이터 5건
-- board_no(자동 증가), reg_date(현재 시각), view_count(0)는 기본값이 있어 생략 가능
-- 여기서는 작성일/조회수를 다르게 보이도록 직접 지정
-- =====================================================================
INSERT INTO board (title, content, writer, reg_date, view_count, writer_id) VALUES
('부천 신축 아파트 분양 일정 문의', '부천 지역에 올해 하반기 분양 예정인 아파트가 있는지 궁금합니다.', '홍길동', '2026-10-01 09:15:00', 12, 'hong01'),
('인천 송도 오피스텔 청약 후기', '지난주 송도 오피스텔 청약에 참여했습니다. 경쟁률이 생각보다 높았어요.', '김영희', '2026-10-05 14:30:00', 35, 'kimyh'),
('상가 분양 시 주의할 점', '신축 상가 분양받을 때 확인해야 할 사항을 정리해 봤습니다.', '이철수', '2026-10-10 11:00:00', 48, 'leecs'),
('청약 가점 계산 방법 질문', '무주택 기간과 부양가족 수에 따른 가점 계산이 헷갈립니다.', '박민수', '2026-10-15 20:45:00', 7, 'parkms'),
('인천 검단 분양정보 공유', '검단신도시 신규 분양 단지 정보를 공유합니다. 모델하우스 일정도 참고하세요.', '최지은', '2026-10-20 16:10:00', 21, 'choije');

-- 입력 확인
SELECT * FROM board ORDER BY board_no;
