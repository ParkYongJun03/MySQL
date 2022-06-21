-- SQL (Structured Query Language)
/*주석인건가?*/

-- 1. select 쿼리 (조회)
SELECT *	-- ALL
	FROM contact;

-- 기본 쿼리
SELECT Id, name, phonenumber, email, address
	From contact;
-- 데이터가 몇 개 조회 쿼리
SELECT COUNT(*)
	FROM contact;
    
-- 데이터를 원하는 컬럼만 조회
SELECT name, phonenumber, email
	From contact;

-- 원하는 결과만 조회
SELECT *
	FROM contact
	WHERE id = 2;	-- PK 조회가 일반적

-- 이름으로 조회하는 쿼리
SELECT *
	FROM contact
    WHere	name = '박용준'; -- DB에서는 같다고 비교하는 로직을 '='로 함
    
-- 2.insert 쿼리
insert into contact
(name, phonenumber, email, address) Values
('김용명', '456-78887-6656', 'kym@email.com', '태안군');

-- NULL 값 제외
Insert into contact
(name, phonenumber) Values ('손흥민', '010-0000');
-- 칼럼 값이 NOT NULL이어야 하도록 설정 해 둠.alter

-- 컬럼이 4개인데 데이터를 4개를 다 넣겠다고 한다면
Insert into contact values
(12, '이동욱', '010-4567-9876', 'ldw@mail.com', '설');

-- 3. update 쿼리 (데이터 수정)
-- 홍길동 id = 1, phonenumber = 010-0000-9999 --> 010-7777-6648
Update contact SET
	phonenumber = '010-7777-6648'
	where id=1;
    
-- 칼럼이 1개이상 변경
UPdate contact set
	phonenumber = '010-2222-3333',	-- 쉼표 필수!
    email = 'gdhong@email.com'
    where id = 1;

-- 4. DELETE 삭제 쿼리
DELETE FROM contact
	Where id = 4; -- where 절 없으면 안 됨