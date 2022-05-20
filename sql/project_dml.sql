-- 베스트 상품 조회
select * from best_pro_view;

-- 신상품 조회
select * from new_pro_view;

-- 카테고리=1 상품들 조회
select * from product where kind=1;

-- 상품 상세 조회
select * from product where pseq=21;
 
-- 회원 정보 삽입
insert into member values 
('qortndk123', 'qortndk123!', '백수아', 'qortndk@naver.com', '010-1234-5678', 
'07714', '서울특별시 강서구 화곡동 149(화곡동)', '심당빌딩 404호', 'y', sysdate);

-- 개별 회원 정보 조회 : 아이디 중복 점검
select count(*) from member where id='qortndk123';

-- 개별 회원 정보 조회 : 이메일 중복 점검
select count(*) from member where email='qortndk@naver.com';

-- 개별 회원 정보 조회 : 연락처 중복 점검
select count(*) from member where phone='010-1234-5678';

-- 로그인
select count(*) from member where id='qortndk123' and pwd='qortndk123!';

-- 개별 회원 정보 조회
select * from member where id='qortndk123';

-- 개별 회원 정보 수정
UPDATE member SET 
pwd='qortndk123!',
email='qortndk@naver.com',
phone='010-1212-3434',
zip_num='12345',
address1='서울시 종훈구 수아동',
address2='김치말이국수'
useyn='y'
WHERE id ='qortndk123';

-- 이메일 중복 점검 (회원 정보 수정) from( 자기를 제외한 메일중에) : 기존의 자신의 이메일과의 중복은 배제
select count(*) from (select email from member where id !='qortndk123') 
where email='qortndk@naver.com';

-- 연락처 중복 점검 (회원 정보 수정) from( 자기를 제외한 연락처중에) : 기존의 자신의 연락처와의 중복은 배제
select count(*) from (select phone from member where id !='qortndk123') 
where phone='010-1222-3444';

-- 회원 탈퇴 처리 => 삭제 X 회원 비활성화 (useyn)=N
update member set useyn='n' where id='ezen 1001';

-- 회원 탈퇴 처리 / 롤(Role) 게스트(guest) 하향화 
update member_role set role='guest' where id='ezen 1001';

-- 회원 활성화 여부 점검 (활동/탈퇴 회원 점검)
select useyn from member where id='dksalrud';

-- 탈퇴 회원 정보 존재 여부
select count(*) from member
where id='id'
  and pwd= 'pwd'
  and email= 'email'
  and phone= 'phone';
  
-- 개별 회원 롤 정보 조회
select role from member_role where id='rlawhdgns';
  
-- 전체 회원 수 조회
select count(*) from member;