-- 더미 회원 정보 생성 (100명 분량)

-- delete member where id like 'ezen%';
-- delete member_role where id like 'ezen%';

CREATE OR REPLACE PROCEDURE dummy_member_gen_proc
IS
BEGIN
 
    FOR i IN 1..100 LOOP
    
        INSERT INTO member VALUES
        ('ezen_' || (1000+i),
         '@Abcd1234',
         '김' || (100+i),
         'ezen_' || i || '@abcd.com',
         '010-3434-' || (1000+i),
         '12345',  
         '서울 강서구 화곡동',
         '이젠아카데미 화곡점',
         'y',
         SYSDATE);
         
        INSERT INTO member_role VALUES 
        (role_seq.nextval,
        'ezen_' || (1000+i),
        'user');

     END LOOP;
 
    COMMIT;    
END;
/

exec dummy_member_gen_proc;


-- 회원 정보 이름 현실화
CREATE OR REPLACE PROCEDURE name_update_gen_proc  
IS  
      TYPE first_name_array      IS VARRAY(20) OF CLOB;  
      TYPE middle_name_array      IS VARRAY(10) OF CLOB;  
      TYPE last_name_array      IS VARRAY(10) OF CLOB;  
      first_names   first_name_array;  
      middle_names   middle_name_array;  
      last_names   last_name_array;        
      v_firstName CLOB;  
      v_middleName CLOB;  
      v_lastName CLOB;  
      totalName CLOB;  
      temp_num NUMBER(2);  
BEGIN  
      first_names := first_name_array('김', '안', '백', '박', '서', '원');  
      middle_names := middle_name_array('종','미','수','지','희','다','재');  
      last_names := last_name_array('훈','아','빈','경','혜','원','솔','현');  
       
      FOR i IN 1..100 LOOP  
         
        temp_num := round(DBMS_RANDOM.VALUE(1,20),0);  
        v_firstName :=  first_names(temp_num);  
        temp_num := round(DBMS_RANDOM.VALUE(1,10),0);  
        v_middleName :=  middle_names(temp_num);  
        temp_num := round(DBMS_RANDOM.VALUE(1,10),0);  
        v_lastName :=  last_names(temp_num);  
        totalName := v_firstName || v_middleName || v_lastName;  
                         
        UPDATE member SET name = totalName  
        WHERE id = 'ezen_' || (1000+i);
 
    END LOOP;  
        
  END;  
/  
 
EXECUTE name_update_gen_proc; 


--- 페이징을 활용한 전체 회원정보 조회 (인라인 뷰(inline-view) 활용)
--- 한번에 10명씩 출력
--- 아이디 중심으로 오름차순 정렬
--- 회원 롤 추가
 
SELECT *  
FROM (SELECT ROWNUM,  
             m.*,  
             FLOOR((ROWNUM - 1) / 10 + 1) page  
      FROM (
            SELECT m.id, m.pwd, m.name, m.email, m.phone, m.zip_num, m.address1, m.address2, m.useyn, m.indate, r.role 
			FROM member m, member_role r
			WHERE m.id = r.id
			ORDER BY id ASC
           ) m  
      )  
WHERE page = 1;

