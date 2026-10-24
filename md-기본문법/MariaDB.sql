-- 도커 데스크탑에 mariaDB 컨테이너를 추가하려 한다. 10.5.29버전이다.최대한 유사한 버전으로 생성할 수 있는 명령어 작성해줘.

-- =====================================================================
-- Docker Desktop에 MariaDB 10.5.29 컨테이너 생성 (운영 서버와 동일 버전)
-- 아래 명령은 PowerShell에서 실행한다. (SQL이 아니므로 주석으로 기록)
-- =====================================================================

-- 1. 이미지 받기
-- docker pull mariadb:10.5.29

-- 2. 컨테이너 생성 (PowerShell, 줄바꿈은 백틱 `)
-- docker run -d `
--   --name mariadb105 `
--   -p 3306:3306 `
--   -e MARIADB_ROOT_PASSWORD=원하는비밀번호 `
--   -e TZ=Asia/Seoul `
--   -v mariadb105-data:/var/lib/mysql `
--   --restart unless-stopped `
--   mariadb:10.5.29 `
--   --character-set-server=utf8mb4 `
--   --collation-server=utf8mb4_unicode_ci

-- 한 줄 버전
-- docker run -d --name mariadb105 -p 3306:3306 -e MARIADB_ROOT_PASSWORD=원하는비밀번호 -e TZ=Asia/Seoul -v mariadb105-data:/var/lib/mysql --restart unless-stopped mariadb:10.5.29 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

-- 옵션 설명
--   -p 3306:3306        : PC에서 3306을 이미 쓰고 있으면 3307:3306처럼 앞쪽 포트를 바꾼다
--   -v mariadb105-data  : 데이터를 볼륨에 저장하므로 컨테이너를 지워도 데이터가 남는다
--   --character-set-server / --collation-server : 한글 처리를 위해 utf8mb4로 지정

-- 3. 버전 확인 (결과가 10.5.29-MariaDB-... 이면 정상)
-- docker exec -it mariadb105 mysql -uroot -p -e "SELECT VERSION();"

-- =====================================================================
-- 참고: 운영 서버와 설정 맞추기
-- 운영 서버에서 아래 쿼리로 실제 값을 확인한 뒤 docker run 옵션을 맞춘다.
-- =====================================================================
SHOW VARIABLES WHERE Variable_name IN
 ('character_set_server','collation_server','sql_mode','lower_case_table_names','time_zone');
