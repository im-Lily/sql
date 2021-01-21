-- SELECT

SELECT [ Ư���÷� | * (��ü�÷�) | ǥ����(SELECT -> SUBQUERY) | DISTINCT | AS �÷���Ī ]
FROM [ ���̺�� | JOIN | SELECT -> SUBQUERY) ]
WHERE ���ǽ�(���� ����) | SELECT -> SUBQUERY
GROUP BY ǥ���� | SELECT -> SUBQUERY
HAVING ���ǽ�
ORDER BY �����÷� ;

-- ��ü�÷� EMPLOYEE
SELECT *
FROM EMPLOYEE ;

-- Ư���÷�
SELECT EMP_NAME,
       EMP_NO
FROM EMPLOYEE ;

-- ��Ī
-- ���ǻ��� : �ݵ�� ���ڷ� ����(���� ���� �Ұ���), (Ư����ȣ, ����)�� �ִٸ� "" �پ����
-- AS ��������
SELECT EMP_NAME AS �̸�,
       EMP_NO AS �ֹι�ȣ,
       SALARY AS "�޿�(��)",
       DEPT_ID �μ���ȣ
FROM EMPLOYEE ;

-- DISTINCT : ���� �ߺ� ���� �� ���
SELECT DISTINCT JOB_ID
FROM EMPLOYEE ;

-- ǥ���� : �÷� ���� ���� ������ ������ �ۼ�
-- ������ NULL���� ���� ��� ������� NULL�� ����
SELECT EMP_NAME AS �����,
       SALARY AS �޿�,
       (SALARY + (SALARY*BONUS_PCT)) * 12 AS ����
FROM EMPLOYEE ;

-- �����÷�
-- '' : ���ڿ��� ���
-- "" : Ű����� ���
SELECT EMP_ID,
       EMP_NAME,
       '����' AS �ٹ�����
FROM EMPLOYEE ;

-- �μ���ȣ = 90�� ����� �˻�
-- WHERE : ���� ����, ���������� ������ ��밡��, = (�����)
SELECT *
FROM EMPLOYEE
WHERE DEPT_ID = 90 ;

-- �μ��ڵ尡 90�̰� �޿��� 2000000���� ���� �޴� ����� �̸�, �μ��ڵ�, �޿� ��ȸ
-- AND, OR
SELECT EMP_NAME, 
       DEPT_ID, 
       SALARY
FROM EMPLOYEE
WHERE DEPT_ID = 90 AND SALARY > 2000000 ;

-- �μ��ڵ尡 90�̰ų� 20���� ����� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, 
       DEPT_ID, 
       SALARY
FROM EMPLOYEE
WHERE DEPT_ID = 90 OR DEPT_ID = 20 ;

-- 'XXX���� ������ XXXXX �� �Դϴ�'
-- || -> ���Ῥ����
- [�÷�||�÷�] [�÷�||���ڿ�']
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE ;

SELECT EMP_ID ||'�� ������'|| SALARY||'�� �Դϴ�'
FROM EMPLOYEE ;

-- Operator =, >, >=, <, <=, !=
--BETWEEN AND, LIKE, IS NULL, IN

-- BETWEEN AND : ���� ���� ���� ���� ��� ����
SELECT EMP_NAME,
       SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 5500000 ;

-- LIKE 
SELECT EMP_NAME,
       SALARY
FROM EMPLOYEE
WHERE EMP_NAME lIKE '��%' ; 

SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9_______' ;

-- EMAIL_ID �� '_' �� �ڸ��� 3�ڸ��� ���� ��ȸ
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\' ;

-- '��'�� ���� �ƴ� ������ �̸��� �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME NOT LIKE '��%' ;

-- �μ��� ���µ��� �ұ��ϰ� ���ʽ��� ���޹޴� ������ �̸�, �μ�, ���ʽ� ��ȸ
SELECT EMP_NAME, DEPT_ID, BONUS_PCT
FROM EMPLOYEE 
WHERE DEPT_ID IS NULL AND BONUS_PCT IS NOT NULL;

-- IN = OR
SELECT EMP_NAME, 
       DEPT_ID, 
       SALARY
FROM EMPLOYEE
WHERE DEPT_ID IN (90,20) ;

-- �μ���ȣ�� 20 �Ǵ� 90�� ��� �� �޿��� 3000000 ���� ���� ������ �̸�, �޿�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_ID
FROM EMPLOYEE
WHERE DEPT_ID IN ('20','90') AND SALARY > 3000000 ; 

-- �Լ��� SELECT, WHERE ���� ���밡��
-- LENGTH() : NUMBER -> ������ ���� ��ȯ �Լ�
-- ���ڿ� -> CHAR(������ �����ϴ� ��������), VARCHAR2(��������)
-- CHAR�� �ѱ��� �ִٸ� �������� ����� �ٸ�!
SELECT CHARTYPE, LENGTH(CHARTYPE), VARCHARTYPE, LENGTH(VARCHARTYPE)
FROM COLUMN_LENGTH ;

-- LPAD / RPAD : ���ڿ��� ���̸� �����̴� �Լ�
-- ����ȿ���� ������������ ���
-- ���ʿ� ����ִ� ������ .�� ä���� -> ������ ����ȿ��
-- LPAD / RPAD(���ڿ�, ����, ��ü����)
SELECT EMAIL, RPAD(EMAIL, 30, '.'),
              LPAD(EMAIL, 30, ' '), 
              LENGTH(RPAD(EMAIL, 30, '.'))
FROM EMPLOYEE ;

-- TRIM / LTRIM / RTRIM : ���ڸ� ������ �� ����ϴ� �Լ�
-- DUAL : ���� ���̺�
-- ������ ������ ���ŵǾ����� ������ ������ ���ŵ�������
SELECT LTRIM('     TEST   '),
       LENGTH(LTRIM('     TEST   '))
FROM DUAL ;

SELECT RTRIM('     TEST   '),
       LENGTH(RTRIM('     TEST   '))
FROM DUAL ;

-- LTRIM('XYZYYYTEST', 'XYZ') : X OR Y OR Z �� �ִٸ� ����
-- ���� �Ǵ� �����ʿ� ������ ���ڰ� ���ٸ� �״�� ���
--  TRIM(LEADING) == LTRIM
-- TRIM(TRAILING) == RTRIM
SELECT TRIM('     TEST   '),
       LENGTH(TRIM('     TEST   ')),
       LTRIM('XYZYYYTEST', 'XYZ'),
       TRIM(LEADING '1' FROM 'TEST1'),
       TRIM(TRAILING '1' FROM '123TEST111')
FROM DUAL ;

-- �굵 ������
SELECT TRIM(LEADING '1' FROM EMP_ID)
FROM EMPLOYEE ; 

-- SUBSTR
SELECT SUBSTR('THIS IS A TEST', 6, 2)
FROM DUAL ;

SELECT SUBSTR('TechOnTheNet', -3, 3)
FROM DUAL ;

SELECT SUBSTR('TechOnTheNet', -8, 2)
FROM DUAL ;

-- ROUND : ������ �ڸ������� �ݿø� �ϴ� �Լ�
SELECT ROUND(125.345)
FROM DUAL ;

SELECT ROUND(125.315, -1)
FROM DUAL ; 

SELECT ROUND(125.315, 1)
FROM DUAL ; 

-- TRUNC : ������ �ڸ������� ������ �Լ�
SELECT TRUNC(125.345)
FROM DUAL;

SELECT TRUNC (125.315, -1)
FROM DUAL ; 

SELECT TRUNC (-125.315, -3)
FROM DUAL ; 

-- ��¥�Լ� SYSDATE, ADD_MONTHS -> DATE
-- ����Ŭ DATE TYPE  : ���갡��
SELECT *
FROM EMPLOYEE ;

SELECT SYSDATE
FROM DUAL ;

# 20�� ��
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 240) 
FROM EMPLOYEE ;

-- MONTHS_BETWEEN(date1, date2) -> NUMBER
-- date1 > date2 : ���
-- �Ի� 10���� �̻��� �������� �ٹ���� ��ȸ
SELECT EMP_NAME, 
       HIRE_DATE,
       MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12 AS �ٹ����
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) > 120 ;

-- ���ڿ� INSTR(string, char, [position, occurrence]) : �ش� ������ �ε��� ����
-- email �÷� �� �� '@vcc. com' ���ڿ� �� .���� ���� 'c' ��ġ ��ȸ
SELECT EMAIL,
       INSTR(EMAIL, 'c', -1,2) AS ��ġ,
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

-- TO_CHAR(��¥|����, ǥ������) -> CHAR
SELECT SYSDATE,
       TO_CHAR(SYSDATE, 'AM YYYY-MM-DAY Q HH:MI:SS')
FROM DUAL ; 

-- SUBSTR(����)(��¥)
SELECT EMP_NAME, 
       HIRE_DATE,
       TO_CHAR(HIRE_DATE, 'YYYY"��"MM"��"DD"��"') AS ����,
       SUBSTR(HIRE_DATE, 1,2) || '��' ||
       SUBSTR(HIRE_DATE, 4,2) || '��' ||
       SUBSTR(HIRE_DATE, 7,2) || '��' AS �Ի���
FROM EMPLOYEE ;

-- TO_DATE()
SELECT TO_DATE('20210119','YYYYMMDD')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('20210119', 'YYYYMMDD'), 'YYYY, MM')
FROM DUAL;

SELECT TO_CHAR(TO_DATE('20210119 132100', 'YYYYMMDD HH24MISS'), 'YY-MM-DD HH:MI:SS PM') 
FROM DUAL ;

-- �����Ͽ� ��, ��, �ʰ� ����ִ� ��� �������� �����ֱ�
SELECT HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE =  TO_DATE('900401 133030', 'YYMMDD HH24MISS') ;

-- �����Ͽ� ��, ��, �ʰ� ����ִ� ����� �� �ٸ� ��� / �� ����� ����!
SELECT HIRE_DATE
FROM EMPLOYEE
WHERE TO_CHAR(HIRE_DATE, 'YYMMDD') =  '900401' ;

-- YYYY / RRRR
SELECT EMP_NAME,
       HIRE_DATE,
       TO_CHAR(TO_DATE(HIRE_DATE, 'RR/MM/DD'), 'YYYY')
FROM EMPLOYEE
WHERE EMP_NAME = '�Ѽ���';

-- TO_NUMBER(CHAR) -> NUMBER
-- �������� : ����, �������� : ����
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
       DECODE(SUBSTR(EMP_NO,8,1), '1', '��', '3','��','��') AS GENDER
FROM EMPLOYEE;

SELECT EMP_ID,
       EMP_NAME, 
       DECODE(MGR_ID, NULL, 'ADMIN', MGR_ID) AS MANAGER,
       NVL(MGR_ID,'ADMIN') AS "OTHER CASE"
FROM EMPLOYEE
WHERE JOB_ID = 'J4';

-- ������ ���޺� �λ�޿� Ȯ��
-- 'J7' -> 20% �λ�
-- 'J6' -> 15%
-- 'J5' -> 10%
-- ������ ������ �״��
SELECT EMP_NAME, 
        JOB_ID,
        SALARY,
        DECODE(JOB_ID, 
        'J7', SALARY * 1.2, 
        'J6', SALARY * 1.15, 
        'J5', SALARY * 1.1, 
        SALARY) AS "�λ�޿�"
FROM EMPLOYEE ; 

-- CASE���� ,�� ����
SELECT EMP_NAME, 
        JOB_ID,
        SALARY,
        CASE JOB_ID
            WHEN 'J7' THEN SALARY * 1.2
            WHEN 'J6' THEN SALARY * 1.15
            WHEN 'J5' THEN SALARY * 1.1
            ELSE SALARY
        END AS "�λ� �޿�"
FROM EMPLOYEE ; 

-- �� �ٸ� ���

-- Group Function(�����Լ�, �׷��Լ�)
-- GROUP BY
-- �׷��Լ� SELECT ������ ���Ǹ� �ٸ� �÷��� ���� �Ұ���
-- �׷��Լ��� NULL �� ���� �� �������� -> ����!
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

-- �μ���ȣ�� 50 �̰ų� �μ���ȣ�� �������� �ʴ� ����� �̸�, �޿� ��ȸ
-- ���� �޿��� ���� -> ORDER BY [�����÷�][ASC|DESC]
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE DEPT_ID = '50' OR DEPT_ID IS NULL 
ORDER BY SALARY DESC ;

-- �Ի����� 03�� 1��1�� ���� �Ի��ڵ��� �̸�, �Ի���, �μ���ȣ ��ȸ
-- ��) �μ���ȣ�� ���� ������ �����ϰ� ������ �Ի����� ���� ������ �����ϰ� ������ �̸��� ���� ������ ����
SELECT EMP_NAME, 
       HIRE_DATE, 
       DEPT_ID
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('03/01/01', 'RR/MM/DD')
ORDER BY DEPT_ID DESC NULLS LAST,HIRE_DATE, EMP_NAME;

-- SELECT ������ ���� ORDER BY ���ڷ� �ۼ� ����
SELECT EMP_NAME, 
       HIRE_DATE, 
       DEPT_ID
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('03/01/01', 'RR/MM/DD')
ORDER BY 3 DESC NULLS LAST,2, 1;

-- ��Ī ������ ����
SELECT EMP_NAME �̸�,
       HIRE_DATE �Ի���, 
       DEPT_ID �μ�
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('03/01/01', 'RR/MM/DD')
ORDER BY �μ� DESC NULLS LAST,�Ի���, �̸�;

-- GROUP BY [�����÷�]
-- �μ��� ��ձ޿�
-- GROUP BY ���� ���ǵ� �÷��� SELECT ���� ���ǰ���
-- SELECT ���� ���ǵ� �÷��� GROUP BY ���� ���ǵǾ����!
-- ROLLUP : ���ؿ� ���� �Ұ谪, �� �����Ѱ� ���
SELECT DEPT_ID, 
        JOB_ID,
       TRUNC(AVG(SALARY),0) AS �޿����
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_ID, JOB_ID) 
ORDER BY DEPT_ID ;

-- ������ ���� �޿� ����� ���Ѵٸ�?
-- GROUP BY �� �ε����� ��Ī ������ �ȵ�!
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','��'),
       AVG(SALARY)
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO,8,1),'1','��','3','��','��')
ORDER BY 2 DESC ;

SELECT CASE SUBSTR(EMP_NO,8,1)
          WHEN '1' THEN '��' 
          WHEN '3' THEN '��' 
          ELSE '��'
       END ,
       AVG(SALARY)
FROM EMPLOYEE
GROUP BY CASE SUBSTR(EMP_NO,8,1)
          WHEN '1' THEN '��' 
          WHEN '3' THEN '��' 
          ELSE '��'
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

-- ORDER BY ���� �÷��� ��Ī�̳� �ε��� �ο�����
SELECT EMP_NAME �̸�,
        HIRE_DATE �Ի���,
        DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101','YYYYMMDD')
ORDER BY �μ��ڵ� DESC, �Ի���, �̸� ;

SELECT EMP_NAME �̸�,
        HIRE_DATE �Ի���,
        DEPT_ID �μ��ڵ�
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('20030101','YYYYMMDD')
ORDER BY 3 DESC, 2, 1 ;

-- GROUP BY : SELECT�� �׷��Լ��� ���� �÷��� �����Ϸ��� GROUP BY ���� ������ �÷��� �������־����
-- �׷�(����)�Լ� : SUM, AGV, MIN, MAX, COUNT
-- GROUP BY�� ��Ī�̳� �ε��� ���Ұ�
-- ����!
SELECT EMP_NAME,
        DEPT_ID,
        COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_ID ; 

-- ����!
SELECT EMP_NAME,
        DEPT_ID,
        COUNT(*)
FROM EMPLOYEE
GROUP BY EMP_NAME, DEPT_ID ; 

-- WHERE ���� �࿡ ���� �����̱� ������ �׷� �Լ� ��� �Ұ�
-- ����!
SELECT DEPT_ID,
        SUM(SALARY)
FROM EMPLOYEE
WHERE SUM(SALARY) > 9000000 
GROUP BY DEPT_ID ;

-- HAVING : �׷쿡 ���� ����
-- ����!
SELECT DEPT_ID,
        SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_ID
HAVING SUM(SALARY)  > 9000000 ;

-- JOIN
-- ����Ŭ ���� ����
-- ���̺��� ��Ī�� AS ��������
-- E.DEPT_ID �� NULL �� ���� -> 2���� ������ ����
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

-- JOIN -> ANSI ǥ��(USING, ON)
-- JOIN ���̺� �� ON : ���� ��� ����
-- JOIN ���̺� �� USING : �θ��� �⺻Ű�� �ڽ��� �ܷ�Ű�� �÷����� ������ �� ���
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

-- OUTER JOIN : ������ �������� ���� �൵ ���
-- LEFT JOIN : JOIN�� �������� ���ʿ� �ִ� ���̺��� ��� �� ���
-- RIGTH JOIN : JOIN�� �������� �����ʿ� �ִ� ���̺��� ��� �� ���
-- FULL JOIN  : ��� ���̺� ���
SELECT EMP_NAME,
        DEPT_NAME
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT USING(DEPT_ID) ;

SELECT *
FROM SAL_GRADE ;

-- ������ �÷��� �������� �ʴ� ���̺� ���ؼ��� ���ΰ���
-- ������ �÷��� �������� �ʱ� ������ ���̺� ��Ī �ʿ����
SELECT EMP_NAME,
        SALARY,
        SLEVEL
FROM EMPLOYEE 
JOIN SAL_GRADE ON (SALARY BETWEEN LOWEST AND HIGHEST) ; 

-- �������
-- �򰥸�!
SELECT E.EMP_NAME, M.EMP_NAME, S.EMP_NAME
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON (E.MGR_ID = M.EMP_ID)
LEFT JOIN EMPLOYEE S ON (M.MGR_ID = S.EMP_ID)
ORDER BY 1 ;

SELECT *
FROM EMPLOYEE ;

-- ������ �븮�̰� ������ �ƽþƷ� ����
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
WHERE JOB_TITLE = '�븮' AND LOC_DESCRIBE LIKE '�ƽþ�%'
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

-- ����1�� 2�� ������ ���߱� ���� DUMMY COLUMN ���
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

-- UNION 50�� �μ����� ������/�������� �����ؼ� ǥ��
SELECT  EMP_ID,
        EMP_NAME,
        '����' AS ����
FROM EMPLOYEE
WHERE MGR_ID IS NOT NULL AND DEPT_ID = '50' 
UNION
SELECT EMP_ID,
        EMP_NAME,
        '������' AS ����
FROM EMPLOYEE
WHERE MGR_ID IS NULL AND DEPT_ID = '50' 
ORDER BY 3 ;

-- ����(JOB_TITLE)�� �븮 �Ǵ� ����� �������� ��ȸ(�̸�, ����)
SELECT EMP_NAME,
        JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
WHERE JOB_TITLE = '�븮'
UNION
SELECT EMP_NAME,
        JOB_TITLE
FROM EMPLOYEE
JOIN JOB USING(JOB_ID)
WHERE JOB_TITLE = '���' 
ORDER BY 2 

-- ��������
-- ���� ��/���� �� �����Ͽ� ������ ���
-- ���� �� ������ : >, >=, <, <=, <>
-- ���� �� ������ : IN, ANY, ALL
-- ���¿� �̸��� �̿��Ͽ� ������ �����ϰ�, ���¿����� �޿��� ����
-- ������ �̸�, ����, �޿� ��ȸ
SELECT EMP_NAME,
        JOB_ID,
        SALARY
FROM EMPLOYEE
WHERE JOB_ID = (SELECT JOB_ID
                FROM EMPLOYEE
                WHERE EMP_NAME = '���¿�')
AND   SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���¿�') ;         

-- �ּұ޿��� �޴� ����� �̸�, ����, �޿� ��ȸ
-- 1. �ּұ޿� Ȯ�� -> ���� ��
-- 2. �˻�
SELECT EMP_NAME, 
        JOB_ID,
        SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE ) ;

-- �μ��� �޿������� ���� ���� �μ��̸�, �޿����� ��ȸ
SELECT DEPT_NAME,
        SUM(SALARY)
FROM EMPLOYEE
JOIN DEPARTMENT USING (DEPT_ID)
GROUP BY DEPT_NAME
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_ID) ;
-- IN, NOT IN , ANY, ALL ������ ���� �� ������������ ��밡��
-- ������ ���������� NULL�� ���� -> NULL �� ����
SELECT EMP_ID,
        EMP_NAME,
        '������' AS ����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE)
UNION                    
SELECT EMP_ID,
        EMP_NAME,
        '����' AS ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT MGR_ID FROM EMPLOYEE
                        WHERE MGR_ID IS NOT NULL) ;
                        
-- ���� ��� �ٸ� ������� ����
SELECT EMP_ID,
       EMP_NAME,
       CASE WHEN EMP_ID IN (SELECT MGR_ID FROM EMPLOYEE) 
       THEN '������' ELSE '����' END
FROM EMPLOYEE

SELECT EMP_ID,
       EMP_NAME,
       CASE
            WHEN MGR_ID IS NOT NULL THEN '����'
        ELSE 
            '������'
        END AS ����
FROM EMPLOYEE ;

-- ���� �� �������� ANY ������
-- �ڽ� ��
-- < ANY : �� ��� �� �ִ밪 ���� ����
-- > ANY : �� ��� �� �ּҰ� ���� ŭ
-- �ڽ� ��
-- < ALL : �� ��� �� �ּҰ� ���� ����
-- > ALL : �� ��� �� �ִ밪 ���� ŭ
SELECT EMP_NAME,
        SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_ID)
WHERE JOB_TITLE = '�븮'
AND SALARY > ALL
                (SELECT SALARY
                FROM EMPLOYEE
                JOIN JOB USING (JOB_ID)
                WHERE JOB_TITLE = '����') ;
                
-- �ڱ� ����(JOB_ID)�� ��ձ޿��� �޴� ���� ��ȸ
-- ���� ��, ���� �� ��������
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

-- FROM ������ �������� �ۼ�����
SELECT EMP_NAME, 
        JOB_TITLE,
        SALARY
FROM (SELECT JOB_ID, TRUNC(AVG(SALARY),-5) AS JOBAVG
    FROM EMPLOYEE
    GROUP BY JOB_ID) V
JOIN EMPLOYEE E ON (V.JOB_ID = E.JOB_ID AND V.JOBAVG=E.SALARY)
JOIN JOB J ON (E.JOB_ID = J.JOB_ID) ;

-- ������� �������� : ������ ���� �޾� ���� ���� -> �ٽ� ���� ����
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
        '������' AS ����
FROM EMPLOYEE E
WHERE EXISTS (SELECT NULL
              FROM EMPLOYEE
              WHERE E.EMP_ID = MGR_ID)
UNION                    
SELECT EMP_ID,
        EMP_NAME,
        '����' AS ����
FROM EMPLOYEE E2
WHERE NOT EXISTS (SELECT NULL
              FROM EMPLOYEE
              WHERE E2.EMP_ID = MGR_ID);

                
















