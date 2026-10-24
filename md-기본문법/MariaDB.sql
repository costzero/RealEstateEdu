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
