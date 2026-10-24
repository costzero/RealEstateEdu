#아래의 쿼리문은 root 계정에서 실행해야한다. 

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