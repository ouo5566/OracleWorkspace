CREATE TABLE TEAMZ(
    TEAM_ID VARCHAR2(20) PRIMARY KEY,
    TEAM_NAME VARCHAR2(20)
);

CREATE TABLE MEMBERS(
    MEMBER_ID VARCHAR2(20) PRIMARY KEY,
    TEAM_ID VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_AGE DECIMAL,
    ROLL VARCHAR2(20) -- ����, ����
    --ȸ�����, �����۴��, �Խ��Ǵ��, �����ڴ��
);

ALTER TABLE MEMBERS ADD CONSTRAINT MEMBERS_FK_TEAM_ID FOREIGN KEY (TEAM_ID)
REFERENCES TEAMZ (TEAM_ID);

ALTER TABLE MEMBERS ADD (ROLL VARCHAR2(20));

INSERT INTO TEAMZ VALUES('AT','����Ƽ��');
INSERT INTO TEAMZ VALUES('HT','��ī��');
INSERT INTO TEAMZ VALUES('CT','������');
INSERT INTO TEAMZ VALUES('ST','�����');

INSERT INTO MEMBERS VALUES('01','AT','����',34);
INSERT INTO MEMBERS VALUES('02','AT','����',35);
INSERT INTO MEMBERS VALUES('03','AT','����',21);
INSERT INTO MEMBERS VALUES('04','AT','����',29);
INSERT INTO MEMBERS VALUES('05','AT','����',25);
INSERT INTO MEMBERS VALUES('06','HT','����',26);
INSERT INTO MEMBERS VALUES('07','HT','����',26);
INSERT INTO MEMBERS VALUES('08','HT','��',27);
INSERT INTO MEMBERS VALUES('09','HT','���',30);
INSERT INTO MEMBERS VALUES('10','HT','�ܾ�',26);
INSERT INTO MEMBERS VALUES('11','CT','������',32);
INSERT INTO MEMBERS VALUES('12','CT','��ȣ',31);
INSERT INTO MEMBERS VALUES('13','CT','����',29);
INSERT INTO MEMBERS VALUES('14','CT','����',23);
INSERT INTO MEMBERS VALUES('15','CT','����',30);
INSERT INTO MEMBERS VALUES('16','ST','��ȣ',27);
INSERT INTO MEMBERS VALUES('17','ST','����',26);
INSERT INTO MEMBERS VALUES('18','ST','�̽�',29);
INSERT INTO MEMBERS VALUES('19','ST','����',26);
INSERT INTO MEMBERS VALUES('20','ST','����',30);

SELECT * FROM TAB;

--DROP TABLE TEAMZ;
--DROP TABLE MEMBERS;

--������
SELECT
    TEAM_ID �����̵�,
    COUNT(MEMBER_ID) ������
FROM
    MEMBERS
GROUP BY
    TEAM_ID
;

--���� ������
SELECT
    TEAM_ID �����̵�,
    SUM(MEMBER_AGE) ������
FROM
    MEMBERS
GROUP BY
    TEAM_ID
;

--���� �ִ볪��
SELECT
    TEAM_ID �����̵�,
    MAX(MEMBER_AGE) �ִ볪��
FROM
    MEMBERS
GROUP BY
    TEAM_ID
;

--���� �ּҳ���
SELECT
    TEAM_ID �����̵�,
    MIN(MEMBER_AGE) �ּҳ���
FROM
    MEMBERS
GROUP BY
    TEAM_ID
;

--���� ��ճ���
SELECT
    TEAM_ID �����̵�,
    AVG(MEMBER_AGE) ��ճ���
FROM
    MEMBERS
GROUP BY
    TEAM_ID
;
--���� 5���� ����
SELECT
    M.TEAM_ID �����̵�,
    (SELECT TEAM_NAME
     FROM TEAMZ
     WHERE
        TEAM_ID LIKE M.TEAM_ID
    ) ����,
    COUNT(MEMBER_ID) ����,
    SUM(MEMBER_AGE) ������,
    MAX(MEMBER_AGE) �ִ볪��,
    MIN(MEMBER_AGE) �ּҳ���,
    AVG(MEMBER_AGE) ��ճ���
FROM
    MEMBERS M
GROUP BY
    M.TEAM_ID
HAVING
    AVG(MEMBER_AGE) >= 28
ORDER BY
    M.TEAM_ID
;

--�ο찪����
--UPDATE MEMBERS SET MEMBER_NAME = '����'
--WHERE MEMBER_NAME LIKE '�¿�';
ALTER TABLE MEMBERS ADD (ROLL VARCHAR2(20));

UPDATE MEMBERS SET ROLL = '����'
WHERE MEMBER_NAME IN ('����','������','����','��ȣ');

UPDATE MEMBERS SET ROLL = '����'
WHERE ROLL IS NULL;

UPDATE MEMBERS SET ROLL = NULL
WHERE ROLL LIKE '����';

UPDATE MEMBERS SET ROLL =
    CASE
        WHEN M.MEMBER_NAME IN ('����','������','����','��ȣ') THEN '����'
        ELSE '����'
    END
;

SELECT MEMBER_NAME, ROLL FROM MEMBERS;

SELECT
    (SELECT TEAM_NAME
     FROM TEAMZ
     WHERE
        TEAM_ID LIKE M.TEAM_ID)�����̵�,
    M.MEMBER_NAME �̸�,
    CASE
        WHEN M.MEMBER_NAME IN ('����','������','����','��ȣ') THEN '����'
        WHEN M.MEMBER_NAME IS NOT NULL THEN'����'
    END ��å
FROM
    MEMBERS M
ORDER BY TEAM_ID, ��å DESC
;

SELECT
    (SELECT TEAM_NAME
     FROM TEAMZ
     WHERE
        TEAM_ID LIKE M.TEAM_ID) ����,
    COUNT(M.MEMBER_ID) �ο���,
    SUM(M.MEMBER_ID) ������,
    MAX(M.MEMBER_AGE) �ִ볪��,
    MIN(M.MEMBER_AGE) �ּҳ���,
    AVG(M.MEMBER_AGE) ��ճ���,
    (SELECT MEMBER_NAME
     FROM MEMBERS
     WHERE
        ROLL LIKE '����'
        AND TEAM_ID LIKE M.TEAM_ID) ����
FROM
    MEMBERS M
GROUP BY
    M.TEAM_ID
ORDER BY M.TEAM_ID
;

ALTER TABLE TEAMZ
RENAME TO PROJECT_TEAM;
ALTER TABLE MEMBERS
RENAME TO MEMBER;

SELECT * FROM MEMBER;
--�÷��� ���� ALTER TABLE ���̺��� RENAME COLUMN �����÷��� TO �ٲ��÷���
ALTER TABLE MEMBER
RENAME COLUMN MEMBER_PW TO PASSWORD;
ALTER TABLE MEMBER
RENAME COLUMN MEMBER_AGE TO AGE;


------DB���� ȭ�����--------
CREATE SEQUENCE EXAM_SEQ;
CREATE SEQUENCE RECORD_SEQ;
CREATE SEQUENCE SUBJECT_SEQ;

CREATE TABLE EXAM(
    EXAM_SEQ DECIMAL PRIMARY KEY,
    MEMBER_ID VARCHAR2(20),
    SUBJECT_SEQ DECIMAL,
    MONTH VARCHAR2(20),
    SCORE VARCHAR2(20),
    RECORD_SEQ DECIMAL
);

CREATE TABLE RECORD(
    RECORD_SEQ DECIMAL PRIMARY KEY,
    AVERAGE VARCHAR2(20),
    GRADE VARCHAR2(20)
);

CREATE TABLE SUBJECT(
    SUBJECT_SEQ DECIMAL PRIMARY KEY,
    SUBJECT_NAME VARCHAR2(20)
);

ALTER TABLE EXAM ADD CONSTRAINT MEMBER_FK_MEMBER_ID FOREIGN KEY (MEMBER_ID)
REFERENCES MEMBER(MEMBER_ID);
ALTER TABLE EXAM ADD CONSTRAINT SUBJECT_FK_SUBJECT_SEQ FOREIGN KEY (SUBJECT_SEQ)
REFERENCES SUBJECT(SUBJECT_SEQ);
ALTER TABLE EXAM ADD CONSTRAINT RECORD_FK_RECORD_SEQ FOREIGN KEY (RECORD_SEQ)
REFERENCES RECORD(RECORD_SEQ);

INSERT INTO SUBJECT VALUES (SUBJECT_SEQ.NEXTVAL, 'Java');
INSERT INTO SUBJECT VALUES (SUBJECT_SEQ.NEXTVAL, 'SQL');
INSERT INTO SUBJECT VALUES (SUBJECT_SEQ.NEXTVAL, 'HTML5');
INSERT INTO SUBJECT VALUES (SUBJECT_SEQ.NEXTVAL, 'R');
INSERT INTO SUBJECT VALUES (SUBJECT_SEQ.NEXTVAL, 'Python');

SELECT * FROM MEMBER;

UPDATE MEMBER SET MEMBER_PW = MEMBER_ID;

SELECT ROWNUM, A.*
FROM( SELECT * FROM MEMBER) A;


ALTER TABLE MEMBER ADD (MEMBER_PW VARCHAR2(20));
INSERT INTO MEMBER(MEMBER_PW) VALUES ('123');

commit;

SELECT
    MEMBER_ID USERID,
    TEAM_ID TEAMID,
    NAME,
    SSN,
    ROLL,
    MEMBER_PW PW
FROM
    MEMBER
WHERE
    MEMBER_ID LIKE 'SJ25'
    AND MEMBER_PW LIKE 'SJ25'
;

ALTER TABLE MEMBER ADD (SUBJECT VARCHAR2(20));
ALTER TABLE MEMBER RENAME COLUMN TEMP TO SSN;
ALTER TABLE MEMBER MODIFY (SSN VARCHAR2(20));
ALTER TABLE MEMBER DROP COLUMN SSN;

UPDATE MEMBER SET SSN = SSN || '1'
WHERE NAME NOT IN('����', '����', '����', '����', '�ܾ�', '����', '�̽�');

UPDATE MEMBER SET AGE = 2018-(1900+SUBSTR(SSN,1,2))+1
WHERE AGE IS NULL;

UPDATE MEMBER SET GENDER = 
    CASE
        WHEN SUBSTR(SSN,8,1) LIKE '1' THEN '��'
        ELSE '��'
    END;

SELECT
    SUBSTR(SSN,3,2) �⵵
FROM MEMBER;

DELETE FROM MEMBER WHERE MEMBER_ID LIKE 'TEST%';

SELECT
    MEMBER_ID USERID
FROM
    MEMBER
WHERE
   TEAM_ID IS NULL
;

UPDATE MEMBER SET TEAM_ID = ''
WHERE ROLL IS NULL;
SELECT * FROM MEMBER;
SELECT * FROM PROJECT_TEAM;
SELECT * FROM TAB;

UPDATE MEMBER SET TEAM_ID = 
    CASE
        WHEN MEMBER_ID LIKE '%N%' THEN 'NOLJA'
        WHEN MEMBER_ID LIKE '%J%' THEN 'JIEUN_HOUSE'
        WHEN MEMBER_ID LIKE '%K%' THEN 'TURTLE_KING'
        WHEN MEMBER_ID LIKE '%D%' THEN 'CODDING_ZZANG'
    END
WHERE TEAM_ID IS NULL;

--PAGE�� ��������� ����--

SELECT COUNT(*)
FROM MEMBER;

--1. PAGE ���� ���ϴ� ����

SELECT
    ROUND(((ROWNUM+2)/5),0) PAGE,
    MEMBER_ID
FROM MEMBER;

--2. ROWNUM�� ���� ��

SELECT ROWNUM AS "NUM", A.MEMBER_ID, ROUND(((ROWNUM+2)/5),0) PAGE
FROM (SELECT ROWNUM RO, MEMBER_ID FROM MEMBER ORDER BY ROWNUM DESC)A ;

SELECT ROWNUM AS "NUM", A.MEMBER_ID
FROM (SELECT ROWNUM RO, MEMBER_ID FROM MEMBER ORDER BY ROWNUM DESC)A ;

--3. PAGE �� ȸ���� ID �� �����ִ� ����

SELECT B.*
FROM (
        SELECT ROWNUM AS "NUM", A.*, ROUND(((ROWNUM+2)/5),0) PAGE
        FROM (SELECT ROWNUM RO, M.* FROM MEMBER M ORDER BY ROWNUM DESC)A
     )B
WHERE B.PAGE LIKE '1';

SELECT B.*
FROM (
        SELECT ROWNUM AS "NUM", A.*
        FROM (SELECT * FROM MEMBER M
        WHERE TEAM_ID LIKE '%A%'
        ORDER BY ROWNUM DESC)A
     )B
WHERE B.NUM BETWEEN '1' AND '5'
;

INSERT INTO MEMBER (member_Id , team_Id , name , ssn , roll , password , age , gender , subject)
  VALUES  ( 'TEST2', 'JIEUN_HOUSE', '�׽�Ʈ2', '890430-1', 'back', 'TEST2', '30', '��', 'java' ) ;
  
  
 