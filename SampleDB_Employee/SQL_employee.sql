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