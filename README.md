# MySQL
MySQL Basic

[mySQL 구글드라이브 다운링크](https://drive.google.com/file/d/12rYOSpwrfiaWZ-KKb97Y_QqhhlFO6zwo/view)

[mySQL Study자료 성명건 강사님 구글드라이브 링크](https://drive.google.com/drive/folders/1zDitkBAaNBxJSFGkhI8E-KrUGeNEzyJy)
[mySQL Study자료 성명건 강사님 구글드라이브 링크2](https://drive.google.com/drive/folders/1CgQFgv8HFxAdd5oy13gZpGgSx9uMF2Tl)

[WorkBench 설치 링크](https://dev.mysql.com/downloads/workbench/)
[Sample DB 설치 링크](https://github.com/datacharmer/test_db)

[인프런 추천 강의-생활코딩](https://www.inflearn.com/courses/it-programming/database-dev?skill=mysql)

[MySQL-C 연동 프로그램](https://downloads.mysql.com/archives/c-c/)
## MySQL 설치
> `C:\DEV\Server\mysql-5.7.32-winx64\` 폴더에 [mySQL 구글드라이브 다운링크](https://drive.google.com/file/d/12rYOSpwrfiaWZ-KKb97Y_QqhhlFO6zwo/view) 설치
> 
> 설치 후 `C:\DEV\Server\mysql-5.7.32-winx64\startup.bat`을 누르면 도스 창이 실행되고 어쩌구 port 3306 나오면 서버와 연결 완료된 것
> 
>> ### 최신 MySQL 설치 방법 (해보진 않음)
>> [최신 MySQL설치 링크](https://dev.mysql.com/downloads/windows/installer/8.0.html) 하지만 최근 Oracle이 인수하면서 유료로 전환됐다고 한다.
>> 
>> 링크를 타고 설치를 한다.
>> 
>> 로그인은 좌측 하단에 No Thanks!
>> `Developer Default -> Next -> Execute -> Next -> Finish`
## WorkBench 설치 및 실행(feat. SampleDB)
> [WorkBench 설치 링크](https://dev.mysql.com/downloads/workbench/) WorkBench 설치
>> 링크를 따라 설치, 로그인은 좌측 하단에 No Thanks!
>> 
>> 경로:`C:\DEV\IDE\MySQL\MySQL Workbench 8.0 CE\`
>> 
> [Sample DB 설치 링크](https://github.com/datacharmer/test_db) 깃 허브에서 .zip 형태로 다운
>> 
>> `C:\Temp\test_db` 쯤에 설치
>> 
>>  MySQL을 어디서나 실행할 수 있도록 시스템 환경 변수에 mysql.exe 파일 위치를 Path에 등록
>>  
>>  cmd 창을 열고 `mysql -u root -p -t < employees.sql` 입력 password:` `공란
>>  
>>  worbench 실행 후 왼쪽 Navigator에 Schema -> refresh
>>  employee 스키마가 생성된 걸 볼 수 있다.
>>  
>>  <img src="https://user-images.githubusercontent.com/83456300/174706588-037bface-8cc0-4a16-b8cf-cdb04a97f36e.png" width="200px"></img>
>>  
>>  `set as default schema`>
> ### Database로 EER model 만들기
>> <img src="https://user-images.githubusercontent.com/83456300/174707814-f7a6ab46-4d16-492e-97d7-0328804abb42.png" width="200"></img>
>>
>> home처럼 생긴 집을 누른 뒤, `create EER model from Database` 클릭
>> 
>> 또는 Database 탭의 Reverse Engineering 
>> 
>> <img src="https://user-images.githubusercontent.com/83456300/174708005-e3277366-b6ae-45fe-afd0-24ebeeac41fc.png" width="300"></img>
>> 
>> 원하는 데이터 베이스 선택
>> 
>> 쭉쭉 만들다 보면
>> 
>> <img src="https://user-images.githubusercontent.com/83456300/174708194-1231e7a8-0523-4136-9ab6-1f29facb2e03.png" width="500px"></img>
>>
>> 완성
>
> ### 쿼리 문 실습
> <img src="https://user-images.githubusercontent.com/83456300/174707112-6a75f992-961b-44aa-8e74-5bae96e1cc9c.png" width="200">
``` MySQL
-- Sample DB Employees 학습
-- Department 부서 테이블 조회
select dp.dept_no, dp.dept_name From departments as dp;

select dm.emp_no, dm.dept_no, dm.from_date, dm.to_date From dept_manager as dm;

-- 합치기
select dp.dept_no
		, dp.dept_name
        , dm.emp_no
        , dm.from_date
        , dm.to_date
-- From dept_manager as dm
-- Inner join departments as dp
From departments as dp	-- department가 부모테이블이라서 From에 두었음, 하지만 둘이 바뀌어도 됨
Inner join dept_manager as dm
 on dp.dept_no = dm.dept_no;

-- Employee
Select em.emp_no, em.birth_date, em.first_name, em.last_name, em.gender, em.hire_date
	From employees as em;


-- 또 합치기
select dp.dept_no
		, dp.dept_name
        , dm.emp_no
        , dm.from_date
        , dm.to_date
--        , em.emp_no
        , date_format(em.birth_date, '%Y년 %m월 %d일') as '생일'
        , concat(em.first_name, ' ', em.last_name)  as '이름' 
        , CASE WHEN em.gender = 'F' then '여성'
					when em.gender = 'M' then '남성'
                    else	'오류'	END as '성별'
From departments as dp
Inner join dept_manager as dm
	on dp.dept_no = dm.dept_no
Inner join employees as em
	on em.emp_no = dm.emp_no;

-- Employees & Salaries
select em.emp_no
		, em.birth_date
        , em.first_name
        , em.last_name
        , em.gender
        , em.hire_date
        , sl.salary
        , sl.from_date
        , sl.to_date
        FROM employees as em
        inner join salaries as sl
        on em.emp_no=sl.emp_no
        where em.emp_no = 10002;
        
        
	SELECT * FROM salaries; 
    SELECT count(*) FROM salaries; -- 2844047건
    SELECT SUM(salary) FROM salaries; -- 181480757419, 1814억
    
    SELECT sl.emp_no,  SUM(sl.salary) FROM salaries as sl
    group by sl.emp_no;
    -- 회사 직원중 10299번째 회사원의
    -- 평균연봉, 연봉총합, 근무연수를  출력
    select res.emp_no
			, res.연봉총합
			, res.평균연봉
			, res.근무년수
            , concat(emp.first_name, ' ', emp.last_name) as 'Full Name'
			, CASE WHEN emp.gender = 'F' then '여성'
					when emp.gender = 'M' then '남성'
                    else	'오류'	END as '성별'
    From (
    SELECT sl.emp_no
				, SUM(sl.salary) as '연봉총합'
                , AVG(sl.salary) as '평균연봉'
                , COUNT(sl.salary) as '근무년수'
	FROM salaries as sl
	WHERE sl.emp_no <= 10299 
    group by sl.emp_no with rollup
	having COUNT(sl.salary) >= 15
) as res
Inner join employees as emp
	on res.emp_no = emp.emp_no;
  ```
