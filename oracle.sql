-- SELECT

SELECT [ 특정컬럼 | * (전체컬럼) | 표현식(SELECT -> SUBQUERY) | DISTINCT | AS 컬럼별칭 ]
FROM [ 테이블명 | JOIN | SELECT -> SUBQUERY) ]
WHERE 조건식(행의 제한) | SELECT -> SUBQUERY
GROUP BY 표현식 | SELECT -> SUBQUERY
HAVING 조건식
ORDER BY 기준컬럼 ;

-- 전체컬럼 EMPLOYEE
SELECT *
FROM EMPLOYEE ;

-- 특정컬럼
SELECT EMP_NAME,
       EMP_NO
FROM EMPLOYEE ;

-- 별칭
-- 주의사항 : 반드시 문자로 시작(숫자 시작 불가능), (특수기호, 공백)이 있다면 "" 붙어야함
-- AS 생략가능
SELECT EMP_NAME AS 이름,
       EMP_NO AS 주민번호,
       SALARY AS "급여(원)",
       DEPT_ID 부서번호
FROM EMPLOYEE ;

-- DISTINCT : 값의 중복 제거 시 사용
SELECT DISTINCT JOB_ID
FROM EMPLOYEE ;

-- 표현식 : 컬럼 값에 대한 연산을 식으로 작성
-- 기존에 NULL값이 있을 경우 계산결과는 NULL로 나옴
SELECT EMP_NAME AS 사원명,
       SALARY AS 급여,
       (SALARY + (SALARY*BONUS_PCT)) * 12 AS 연봉
FROM EMPLOYEE ;

-- 더미컬럼
-- '' : 문자열로 취급
-- "" : 키워드로 취급
SELECT EMP_ID,
       EMP_NAME,
       '재직' AS 근무여부
FROM EMPLOYEE ;

-- 부서번호 = 90인 사원만 검색
-- WHERE : 행의 제한, 조건절에서 연산자 사용가능, = (동등비교)
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = 90 ;

-- 부서코드가 90이고 급여를 2000000보다 많이 받는 사원의 이름, 부서코드, 급여 조회
-- AND, OR
SELECT EMP_NAME, 
       DEPT_ID, 
       SALARY
FROM EMPLOYEE
WHERE DEPT_ID = 90 AND SALARY > 2000000 ;

-- 부서코드가 90이거나 20번인 사원의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, 
       DEPT_ID, 
       SALARY
FROM EMPLOYEE
WHERE DEPT_ID = 90 OR DEPT_ID = 20 ;

-- 'XXX님의 월급은 XXXXX 원 입니다'
-- || -> 연결연산자
- [컬럼||컬럼] [컬럼||문자열']
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE ;

SELECT EMP_ID ||'의 월급은'|| SALARY||'원 입니다'
FROM EMPLOYEE ;

-- Operator =, >, >=, <, <=, !=
--BETWEEN AND, LIKE, IS NULL, IN

-- BETWEEN AND : 상한 값과 하한 값의 경계 포함
SELECT EMP_NAME,
       SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 5500000 ;

-- LIKE 
SELECT EMP_NAME,
       SALARY
FROM EMPLOYEE
WHERE EMP_NAME lIKE '김%' ; 

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9_______' ;

-- EMAIL_ID 중 '_' 앞 자리가 3자리이 직원 조회
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\' ;

-- '김'씨 성이 아닌 직원의 이름과 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '김%' ;

-- 부서가 없는데도 불구하고 보너스를 지급받는 직원의 이름, 부서, 보너스 조회
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE 
WHERE DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;

-- IN = OR
SELECT EMP_NAME, 
       DEPT_ID, 
       SALARY
FROM EMPLOYEE
WHERE DEPT_ID IN (90,20) ;

-- 부서번호가 20 또는 90인 사원 중 급여가 3000000 보다 많은 직원의 이름, 급여, 부서코드 조회
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IN ('20','90') AND SALARY > 3000000 ; 

-- 함수는 SELECT, WHERE 절에 적용가능
-- LENGTH() : NUMBER -> 문자의 개수 반환 함수
-- 문자열 -> CHAR(공백을 포함하는 고정길이), VARCHAR2(가변길이)
-- CHAR에 한글이 있다면 개수세는 방법이 다름!
SELECT CHARTYPE, LENGTH(CHARTYPE), VARCHARTYPE, LENGTH(VARCHARTYPE)
FROM COLUMN_LENGTH ;

-- LPAD / RPAD : 문자열에 길이를 덧붙이는 함수
-- 정렬효과를 가져오기위해 사용
-- 왼쪽에 비어있는 공간을 .로 채워줌 -> 오른쪽 정렬효과
-- LPAD / RPAD(문자열, 길이, 대체문자)
SELECT EMAIL, RPAD(EMAIL, 30, '.'),
              LPAD(EMAIL, 30, ' '), 
              LENGTH(RPAD(EMAIL, 30, '.'))
FROM EMPLOYEE ;

-- TRIM / LTRIM / RTRIM : 문자를 제거할 때 사용하는 함수
-- DUAL : 더미 테이블
-- 왼쪽은 공백이 제거되었지만 오른쪽 공백은 제거되지않음
SELECT LTRIM('     TEST   '),
       LENGTH(LTRIM('     TEST   '))
FROM DUAL ;

SELECT RTRIM('     TEST   '),
       LENGTH(RTRIM('     TEST   '))
FROM DUAL ;

-- LTRIM('XYZYYYTEST', 'XYZ') : X OR Y OR Z 가 있다면 제거
-- 왼쪽 또는 오른쪽에 제거할 문자가 없다면 그대로 출력
--  TRIM(LEADING) == LTRIM
-- TRIM(TRAILING) == RTRIM
SELECT TRIM('     TEST   '),
       LENGTH(TRIM('     TEST   ')),
       LTRIM('XYZYYYTEST', 'XYZ'),
       TRIM(LEADING '1' FROM 'TEST1'),
       TRIM(TRAILING '1' FROM '123TEST111')
FROM DUAL ;

-- 얘도 되지롱
SELECT TRIM(LEADING '1' FROM EMP_ID)
FROM EMPLOYEE ; 

-- SUBSTR
SELECT SUBSTR('THIS IS A TEST', 6, 2)
FROM DUAL ;

SELECT SUBSTR('TechOnTheNet', -3, 3)
FROM DUAL ;

SELECT SUBSTR('TechOnTheNet', -8, 2)
FROM DUAL ;

-- ROUND : 지정한 자릿수에서 반올림 하는 함수
SELECT ROUND(125.345)
FROM DUAL ;

SELECT ROUND(125.315, -1)
FROM DUAL ; 

SELECT ROUND(125.315, 1)
FROM DUAL ; 

-- TRUNC : 지정한 자릿수에서 버리는 함수
SELECT TRUNC(125.345)
FROM DUAL;

SELECT TRUNC (125.315, -1)
FROM DUAL ; 

SELECT TRUNC (-125.315, -3)
FROM DUAL ; 

-- 날짜함수 SYSDATE, ADD_MONTHS -> DATE
-- 오라클 DATE TYPE  : 연산가능
SELECT *
FROM EMPLOYEE ;

SELECT SYSDATE
FROM DUAL ;

# 20년 후
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 240) 
FROM EMPLOYEE ;

-- MONTHS_BETWEEN(date1, date2) -> NUMBER
-- date1 > date2 : 양수
-- 입사 10년차 이상인 직원들의 근무년수 조회
SELECT EMP_NAME, 
       HIRE_DATE,
       MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12 AS 근무년수
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 120 ;

-- 문자열 INSTR(string, char, [position, occurrence]) : 해당 문자의 인덱스 리턴
-- email 컬럼 값 중 '@vcc. com' 문자열 중 .앞의 문자 'c' 위치 조회
SELECT EMAIL,
       INSTR(EMAIL, 'c', -1,2) AS 위치,
       INSTR(EMAIL, 'c', INSTR(EMAIL, '.')-1)
FROM EMPLOYEE ;

SELECT TO_CHAR(1234,'99999') 
FROM DUAL ;

SELECT TO_CHAR(1234,'09999') 
FROM DUAL ;

SELECT TO_CHAR(1234,'L99999') 
FROM DUAL ;

SELECT TO_CHAR(1234,'$99999') 
FROM DUAL ;

SELECT TO_CHAR(1234,'99,999') 
FROM DUAL ;

SELECT TO_CHAR(1234,'999') 
FROM DUAL ;

-- TO_CHAR(날짜|숫자, 표현형식) -> CHAR
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'AM YYYY-MM-DAY Q HH:MI:SS')
FROM DUAL ; 

-- SUBSTR(문자)(날짜)
SELECT EMP_NAME, 
       HIRE_DATE,
       TO_CHAR(HIRE_DATE, 'YYYY"년"MM"월"DD"일"') AS 연도,
       SUBSTR(HIRE_DATE, 1,2) || '년' ||
       SUBSTR(HIRE_DATE, 4,2) || '월' ||
       SUBSTR(HIRE_DATE, 7,2) || '일' AS 입사일
FROM EMPLOYEE ;

-- TO_DATE()
SELECT TO_DATE('20210119','YYYYMMDD')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('20210119', 'YYYYMMDD'), 'YYYY, MM')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('20210119 132100', 'YYYYMMDD HH24MISS'), 'YY-MM-DD HH:MI:SS PM') 
FROM DUAL ;

-- 연월일에 시, 분, 초가 들어있는 경우 포맷형식 지켜주기
SELECT HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE =  TO_DATE('900401 133030', 'YYMMDD HH24MISS') ;

-- 연월일에 시, 분, 초가 들어있는 경우의 또 다른 방법 / 이 방법은 지양!
SELECT HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYMMDD') =  '900401' ;

-- YYYY / RRRR
SELECT EMP_NAME,
       HIRE_DATE,
       TO_CHAR(TO_DATE(HIRE_DATE, 'RR/MM/DD'), 'YYYY')
FROM EMPLOYEE
WHERE EMP_NAME = '한선기';

-- TO_NUMBER(CHAR) -> NUMBER
-- 좌측정렬 : 문자, 우측정렬 : 숫자
SELECT  EMP_NO,
        SUBSTR(EMP_NO,1,6),
        SUBSTR(EMP_NO,8),
        TO_NUMBER(SUBSTR(EMP_NO,1,6)) + TO_NUMBER(SUBSTR(EMP_NO,8))
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY, NVL(BONUS_PCT,0)
FROM EMPLOYEE
WHERE SALARY > 3500000;

-- NULL RETURN
SELECT EMP_NAME,
       (SALARY*12)+((SALARY*12)*BONUS_PCT)
FROM EMPLOYEE
WHERE SALARY > 3500000;

SELECT EMP_NAME,
       (SALARY*12)+((SALARY*12)*NVL(BONUS_PCT,0))
FROM EMPLOYEE
WHERE SALARY > 3500000;

-- DECODE(IF-ELSE)
SELECT EMP_NO, 
       DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '3','남','여') AS GENDER
FROM EMPLOYEE;

SELECT EMP_ID,
       EMP_NAME, 
       DECODE(MGR_ID, NULL, 'ADMIN', MGR_ID) AS MANAGER,
       NVL(MGR_ID,'ADMIN') AS "OTHER CASE"
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

-- 직원의 직급별 인상급여 확인
-- 'J7' -> 20% 인상
-- 'J6' -> 15%
-- 'J5' -> 10%
-- 나머지 직급은 그대로
SELECT EMP_NAME, 
        JOB_ID,
        SALARY,
        DECODE(JOB_ID, 
        'J7', SALARY * 1.2, 
        'J6', SALARY * 1.15, 
        'J5', SALARY * 1.1, 
        SALARY) AS "인상급여"
FROM EMPLOYEE ; 

-- CASE에는 ,가 없음
SELECT EMP_NAME, 
        JOB_ID,
        SALARY,
        CASE JOB_ID
            WHEN 'J7' THEN SALARY * 1.2
            WHEN 'J6' THEN SALARY * 1.15
            WHEN 'J5' THEN SALARY * 1.1
            ELSE SALARY
        END AS "인상 급여"
FROM EMPLOYEE ; 

-- 또 다른 방법

-- Group Function(집계함수, 그룹함수)
-- GROUP BY
-- 그룹함수 SELECT 절에서 사용되면 다른 컬럼은 정의 불가능
-- 그룹함수는 NULL 값 제거 후 연산진행 -> 주의!
-- SUM, AVG <- NUMBER
SELECT AVG(BONUS_PCT),
       ROUND(AVG(NVL(BONUS_PCT,0)),2)
FROM EMPLOYEE ;

-- MIN, MAX, COUNT <- ANY
SELECT MIN(SALARY), MIN(SALARY),
       MIN(HIRE_DATE), MAX(HIRE_DATE),
       MIN(JOB_ID), MAX(JOB_ID)
FROM EMPLOYEE ; 

SELECT COUNT(*), COUNT(JOB_ID), COUNT(DISTINCT JOB_ID)
FROM EMPLOYEE;

-- 부서번호가 50 이거나 부서번호가 존재하지 않는 사원의 이름, 급여 조회
-- 높은 급여순 정렬 -> ORDER BY [기준컬럼][ASC|DESC]
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL 
ORDER BY SALARY DESC ;

-- 입사일이 03년 1월1일 이후 입사자들의 이름, 입사일, 부서번호 조회
-- 단) 부서번호가 높은 순으로 정렬하고 같으면 입사일이 빠른 순서로 정렬하고 같으면 이름이 빠른 순서로 정렬
SELECT EMP_NAME, 
       HIRE_DATE, 
       DEPT_ID
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('03/01/01', 'RR/MM/DD')
ORDER BY DEPT_ID DESC NULLS LAST,HIRE_DATE, EMP_NAME;

-- SELECT 순서에 따라 ORDER BY 숫자로 작성 가능
SELECT EMP_NAME, 
       HIRE_DATE, 
       DEPT_ID
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('03/01/01', 'RR/MM/DD')
ORDER BY 3 DESC NULLS LAST,2, 1;

-- 별칭 순서도 가능
SELECT EMP_NAME 이름,
       HIRE_DATE 입사일, 
       DEPT_ID 부서
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('03/01/01', 'RR/MM/DD')
ORDER BY 부서 DESC NULLS LAST,입사일, 이름;

-- GROUP BY [기준컬럼]
-- 부서별 평균급여
-- GROUP BY 절에 정의된 컬럼은 SELECT 절에 정의가능
-- SELECT 절에 정의된 컬럼은 GROUP BY 절에 정의되어야함!
-- ROLLUP : 기준에 대한 소계값, 총 누적총계 출력
SELECT DEPT_ID, 
        JOB_ID,
       TRUNC(AVG(SALARY),0) AS 급여평균
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID, JOB_ID) 
ORDER BY DEPT_ID ;

-- 성별에 따른 급여 평균을 구한다면?
-- GROUP BY 는 인덱스나 별칭 적용이 안됨!
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','여'),
       AVG(SALARY)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','남','3','남','여')
ORDER BY 2 DESC ;

SELECT CASE SUBSTR(EMP_NO,8,1)
          WHEN '1' THEN '남' 
          WHEN '3' THEN '남' 
          ELSE '여'
       END ,
       AVG(SALARY)
FROM EMPLOYEE
GROUP BY CASE SUBSTR(EMP_NO,8,1)
          WHEN '1' THEN '남' 
          WHEN '3' THEN '남' 
          ELSE '여'
       END 
ORDER BY 2 DESC ;

-- 20210120 --
SELECT EMP_NAME, 
       SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '50'
OR    DEPT_ID IS NULL
ORDER BY SALARY DESC ;

SELECT EMP_NAME, 
        HIRE_DATE,
        DEPT_ID
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('2030101','YYYYMMDD')
ORDER BY DEPT_ID DESC, HIRE_DATE, EMP_NAME ;

-- ORDER BY 절에 컬럼의 별칭이나 인덱스 부여가능
SELECT EMP_NAME 이름,
        HIRE_DATE 입사일,
        DEPT_ID 부서코드
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101','YYYYMMDD')
ORDER BY 부서코드 DESC, 입사일, 이름 ;

SELECT EMP_NAME 이름,
        HIRE_DATE 입사일,
        DEPT_ID 부서코드
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101','YYYYMMDD')
ORDER BY 3 DESC, 2, 1 ;

-- GROUP BY : SELECT에 그룹함수와 같이 컬럼명 지정하려면 GROUP BY 절에 동일한 컬럼명 지정해주어야함
-- 그룹(집계)함수 : SUM, AGV, MIN, MAX, COUNT
-- GROUP BY는 별칭이나 인덱스 사용불가
-- 오류!
SELECT EMP_NAME,
        DEPT_ID,
        COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_ID ; 

-- 정상!
SELECT EMP_NAME,
        DEPT_ID,
        COUNT(*)
FROM EMPLOYEE
GROUP BY EMP_NAME, DEPT_ID ; 

-- WHERE 절은 행에 대한 제한이기 때문에 그룹 함수 사용 불가
-- 오류!
SELECT DEPT_ID,
        SUM(SALARY)
FROM EMPLOYEE
WHERE SUM(SALARY) > 9000000 
GROUP BY DEPT_ID ;

-- HAVING : 그룹에 대한 조건
-- 정상!
SELECT DEPT_ID,
        SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING SUM(SALARY)  > 9000000 ;

-- JOIN
-- 오라클 전용 조인
-- 테이블의 별칭은 AS 쓰지않음
-- E.DEPT_ID 중 NULL 값 있음 -> 2건의 데이터 누락
SELECT EMP_NAME,
        DEPT_NAME,
        E.DEPT_ID
FROM EMPLOYEE E,
    DEPARTMENT D
WHERE E.DEPT_ID = D.DEPT_ID ;

SELECT *
FROM EMPLOYEE;

SELECT * 
FROM DEPARTMENT ;

-- JOIN -> ANSI 표준(USING, ON)
-- JOIN 테이블 명 ON : 조건 기술 가능
-- JOIN 테이블 명 USING : 부모의 기본키와 자식의 외래키의 컬럼명이 동일할 때 사용
SELECT EMP_NAME,
        DEPT_NAME
FROM EMPLOYEE
JOIN DEPARTMENT USING(DEPT_ID) ;

SELECT EMP_NAME,
        DEPT_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_ID = D.DEPT_ID) 
WHERE JOB_ID = 'J6' ;

SELECT EMP_NAME,
        DEPT_NAME,
        LOC_DESCRIBE
FROM EMPLOYEE E
JOIN DEPARTMENT D USING(DEPT_ID)
JOIN LOCATION L ON(L.LOCATION_ID = D.LOC_ID) ;

-- OUTER JOIN : 조건을 만족하지 않은 행도 출력
-- LEFT JOIN : JOIN을 기준으로 왼쪽에 있는 테이블의 모든 행 출력
-- RIGTH JOIN : JOIN을 기준으로 오른쪽에 있는 테이블의 모든 행 출력
-- FULL JOIN  : 모든 테이블 출력
SELECT EMP_NAME,
        DEPT_NAME
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT USING(DEPT_ID) ;

SELECT *
FROM SAL_GRADE ;

-- 동일한 컬럼이 존재하지 않는 테이블에 대해서도 조인가능
-- 동일한 컬럼이 존재하지 않기 때문에 테이블 별칭 필요없음
SELECT EMP_NAME,
        SALARY,
        SLEVEL
FROM EMPLOYEE 
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST) ; 

-- 재귀조인
-- 헷갈림!
SELECT E.EMP_NAME, M.EMP_NAME, S.EMP_NAME
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID)
LEFT JOIN EMPLOYEE S ON (M.MGR_ID = S.EMP_ID)
ORDER BY 1 ;

SELECT *
FROM EMPLOYEE ;

-- 직급이 대리이고 지역이 아시아로 시작
SELECT EMP_NAME, SALARY, 
       SLEVEL,
       JOB_TITLE,
       DEPT_NAME,
       LOC_DESCRIBE,
       COUNTRY_NAME
FROM EMPLOYEE 
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST)
JOIN JOB USING (JOB_ID) 
JOIN DEPARTMENT D USING (DEPT_ID) 
JOIN LOCATION L ON (L.LOCATION_ID = D.LOC_ID) 
JOIN COUNTRY USING(COUNTRY_ID) 
WHERE JOB_TITLE = '대리' AND LOC_DESCRIBE LIKE '아시아%'
ORDER BY 1 ;

SELECT EMP_NAME,
        DEPT_NAME,
        LOC_DESCRIBE
FROM EMPLOYEE E
JOIN DEPARTMENT D USING(DEPT_ID)
JOIN LOCATION L ON(L.LOCATION_ID = D.LOC_ID) ;

-- 20210121 --
-- SET OPERATOR
-- UNION / UNION ALL / INTERSECT /MINUS
SELECT EMP_ID,
        ROLE_NAME
FROM EMPLOYEE_ROLE
UNION
SELECT EMP_ID,
        ROLE_NAME
FROM ROLE_HISTORY;

SELECT EMP_ID,
        ROLE_NAME
FROM EMPLOYEE_ROLE
UNION ALL
SELECT EMP_ID,
        ROLE_NAME
FROM ROLE_HISTORY;

SELECT EMP_ID,
        ROLE_NAME
FROM EMPLOYEE_ROLE
INTERSECT
SELECT EMP_ID,
        ROLE_NAME
FROM ROLE_HISTORY;

SELECT EMP_ID,
        ROLE_NAME
FROM EMPLOYEE_ROLE
MINUS
SELECT EMP_ID,
        ROLE_NAME
FROM ROLE_HISTORY;

-- 쿼리1과 2의 구조를 맞추기 위해 DUMMY COLUMN 사용
SELECT EMP_NAME,
        JOB_ID,
        HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_ID = '20 '
UNION
SELECT DEPT_NAME,
        DEPT_ID,
        NULL
FROM DEPARTMENT
WHERE DEPT_ID = '20' ;

-- UNION 50번 부서원을 관리자/직원으로 구분해서 표시
SELECT  EMP_ID,
        EMP_NAME,
        '직원' AS 구분
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL AND DEPT_ID = '50' 
UNION
SELECT EMP_ID,
        EMP_NAME,
        '관리자' AS 구분
FROM EMPLOYEE
WHERE MGR_ID IS NULL AND DEPT_ID = '50' 
ORDER BY 3 ;

-- 직급(JOB_TITLE)이 대리 또는 사원인 직원정보 조회(이름, 직급)
SELECT EMP_NAME,
        JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
WHERE JOB_TITLE = '대리'
UNION
SELECT EMP_NAME,
        JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
WHERE JOB_TITLE = '사원' 
ORDER BY 2 

-- 서브쿼리
-- 단일 행/다중 행 구분하여 연산자 사용
-- 단일 행 연산자 : >, >=, <, <=, <>
-- 다중 행 연산자 : IN, ANY, ALL
-- 나승원 이름을 이용하여 직급이 동일하고, 나승원보다 급여가 많은
-- 직원의 이름, 직급, 급여 조회
SELECT EMP_NAME,
        JOB_ID,
        SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID
                FROM EMPLOYEE
                WHERE EMP_NAME = '나승원')
AND   SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '나승원') ;         

-- 최소급여를 받는 사원의 이름, 직급, 급여 조회
-- 1. 최소급여 확인 -> 단일 행
-- 2. 검색
SELECT EMP_NAME, 
        JOB_ID,
        SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE ) ;

-- 부서별 급여총합이 가장 많은 부서이름, 급여총합 조회
SELECT DEPT_NAME,
        SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID) ;
-- IN, NOT IN , ANY, ALL 연산자 다중 행 서브쿼리에서 사용가능
-- 다중행 서브쿼리에 NULL값 존재 -> NULL 값 제거
SELECT EMP_ID,
        EMP_NAME,
        '관리자' AS 구분
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE)
UNION                    
SELECT EMP_ID,
        EMP_NAME,
        '직원' AS 구분
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT MGR_ID FROM EMPLOYEE
                        WHERE MGR_ID IS NOT NULL) ;
                        
-- 위의 결과 다른 방식으로 구현
SELECT EMP_ID,
       EMP_NAME,
       CASE WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) 
       THEN '관리자' ELSE '직원' END
FROM EMPLOYEE

SELECT EMP_ID,
       EMP_NAME,
       CASE
            WHEN MGR_ID IS NOT NULL THEN '직원'
        ELSE 
            '관리자'
        END AS 구분
FROM EMPLOYEE ;

-- 다중 행 서브쿼리 ANY 연산자
-- 박스 안
-- < ANY : 비교 대상 중 최대값 보다 작음
-- > ANY : 비교 대상 중 최소값 보다 큼
-- 박스 밖
-- < ALL : 비교 대상 중 최소값 보다 작음
-- > ALL : 비교 대상 중 최대값 보다 큼
SELECT EMP_NAME,
        SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '대리'
AND SALARY > ALL
                (SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING (JOB_ID)
                WHERE JOB_TITLE = '과장') ;
                
-- 자기 직급(JOB_ID)의 평균급여를 받는 직원 조회
-- 다중 행, 다중 열 서브쿼리
SELECT EMP_NAME,
        JOB_TITLE,
        SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE (JOB_ID,SALARY) IN (SELECT JOB_ID,TRUNC(AVG(SALARY),-5)
                          FROM EMPLOYEE
                          GROUP BY JOB_ID) ;
                
SELECT JOB_TITLE, TRUNC(AVG(SALARY),-5)
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
GROUP BY JOB_TITLE ;

-- FROM 절에서 서브쿼리 작성가능
SELECT EMP_NAME, 
        JOB_TITLE,
        SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY),-5) AS JOBAVG
    FROM EMPLOYEE
    GROUP BY JOB_ID) V
JOIN EMPLOYEE E ON (V.JOB_ID = E.JOB_ID AND V.JOBAVG=E.SALARY)
JOIN JOB J ON (E.JOB_ID = J.JOB_ID) ;

-- 상관관계 서브쿼리 : 메인의 값을 받아 서브 실행 -> 다시 메인 실행
SELECT EMP_NAME,
        JOB_TITLE, SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_ID = J.JOB_ID)
WHERE SALARY = (SELECT TRUNC(AVG(SALARY),-5)
                FROM EMPLOYEE
                WHERE JOB_ID = E.JOB_ID) ;
                
-- EXISTS, NOT EXISTS
SELECT EMP_ID,
        EMP_NAME,
        '관리자' AS 구분
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
              FROM EMPLOYEE
              WHERE E.EMP_ID = MGR_ID)
UNION                    
SELECT EMP_ID,
        EMP_NAME,
        '직원' AS 구분
FROM EMPLOYEE E2
WHERE NOT EXISTS (SELECT NULL
              FROM EMPLOYEE
              WHERE E2.EMP_ID = MGR_ID);

                
















