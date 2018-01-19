
/* Drop Tables */

DROP TABLE CUSTOMERS CASCADE CONSTRAINTS;
DROP TABLE PROVIDERS CASCADE CONSTRAINTS;
DROP TABLE PRODUCTS CASCADE CONSTRAINTS;


/* Create Tables */
CREATE TABLE CUSTOMERS
(
	-- ��ID
	ID varchar2(30) NOT NULL,
	-- ��ȣ
	PASSWORD varchar2(30) NOT NULL,
	-- ����
	CUST_NAME varchar2(30) NOT NULL,
	-- �������
	BIRTH_DATE date,
	-- �̸���
	EMAIL varchar2(50) NOT NULL,
	-- �� ��ȭ��ȣ
	HOME_PHONE varchar2(30),
	-- �޴��� ��ȣ
	MOBILE_PHONE varchar2(30),
	-- �����ȣ
	POST_CODE varchar2(20),
	-- �ּ�
	ADDRESS varchar2(100),
	-- ����Ʈ
	POINT number(10) DEFAULT 0,
	PRIMARY KEY (ID)
);


CREATE TABLE PRODUCTS
(
	-- ��ǰ �ڵ�
	PROD_CODE varchar2(20) NOT NULL,
	-- ��ǰ��
	PROD_NAME varchar2(100) NOT NULL,
	-- ������
	PROD_SIZE varchar2(50),
	-- ����
	PROD_PIC varchar2(100),
	-- �󼼼���
	PROD_DETAIL varchar2(4000),
	-- �ܰ�
	PROD_COST number(10) DEFAULT 0,
	-- ���
	PROD_STOCK number(5) DEFAULT 0,
	-- �ּ��������
	PROD_STOCK_MIN number(5) DEFAULT 0,
	-- ����ڵ�Ϲ�ȣ
	PRO_NO varchar2(30) NOT NULL,
	PRIMARY KEY (PROD_CODE)
);


CREATE TABLE PROVIDERS
(
	-- ����ڵ�Ϲ�ȣ
	PRO_NO varchar2(30) NOT NULL,
	-- ����ڸ�
	PRO_NAME varchar2(30) NOT NULL,
	-- ��ǥ�̻� �̸�
	PRO_CEO varchar2(30),
	-- ��ǥ ��ȭ��ȣ
	PRO_PHONE varchar2(30),
	-- ��ǥ �ѽ���ȣ
	PRO_FAX varchar2(30),
	-- �����ȣ
	PRO_POST varchar2(20),
	-- �ּ�
	PRO_ADDRESS varchar2(100),
	-- �̸���
	PRO_EMAIL varchar2(50),
	-- ��ǰ �ڵ�
	PROD_CODE varchar2(20) NOT NULL,
	PRIMARY KEY (PRO_NO)
);

/* Create Foreign Keys */

ALTER TABLE PROVIDERS
	ADD FOREIGN KEY (PROD_CODE)
	REFERENCES PRODUCTS (PROD_CODE)
;

/* Comments */

COMMENT ON COLUMN CUSTOMERS.ID IS '��ID';
COMMENT ON COLUMN CUSTOMERS.PASSWORD IS '��ȣ';
COMMENT ON COLUMN CUSTOMERS.CUST_NAME IS '����';
COMMENT ON COLUMN CUSTOMERS.BIRTH_DATE IS '�������';
COMMENT ON COLUMN CUSTOMERS.EMAIL IS '�̸���';
COMMENT ON COLUMN CUSTOMERS.HOME_PHONE IS '�� ��ȭ��ȣ';
COMMENT ON COLUMN CUSTOMERS.MOBILE_PHONE IS '�޴��� ��ȣ';
COMMENT ON COLUMN CUSTOMERS.POST_CODE IS '�����ȣ';
COMMENT ON COLUMN CUSTOMERS.ADDRESS IS '�ּ�';
COMMENT ON COLUMN CUSTOMERS.POINT IS '����Ʈ';
COMMENT ON COLUMN PRODUCTS.PROD_CODE IS '��ǰ �ڵ�';
COMMENT ON COLUMN PRODUCTS.PROD_NAME IS '��ǰ��';
COMMENT ON COLUMN PRODUCTS.PROD_SIZE IS '������';
COMMENT ON COLUMN PRODUCTS.PROD_PIC IS '����';
COMMENT ON COLUMN PRODUCTS.PROD_DETAIL IS '�󼼼���';
COMMENT ON COLUMN PRODUCTS.PROD_COST IS '�ܰ�';
COMMENT ON COLUMN PRODUCTS.PROD_STOCK IS '���';
COMMENT ON COLUMN PRODUCTS.PROD_STOCK_MIN IS '�ּ��������';
COMMENT ON COLUMN PRODUCTS.PRO_NO IS '����ڵ�Ϲ�ȣ';
COMMENT ON COLUMN PROVIDERS.PRO_NO IS '����ڵ�Ϲ�ȣ';
COMMENT ON COLUMN PROVIDERS.PRO_NAME IS '����ڸ�';
COMMENT ON COLUMN PROVIDERS.PRO_CEO IS '��ǥ�̻� �̸�';
COMMENT ON COLUMN PROVIDERS.PRO_PHONE IS '��ǥ ��ȭ��ȣ';
COMMENT ON COLUMN PROVIDERS.PRO_FAX IS '��ǥ �ѽ���ȣ';
COMMENT ON COLUMN PROVIDERS.PRO_POST IS '�����ȣ';
COMMENT ON COLUMN PROVIDERS.PRO_ADDRESS IS '�ּ�';
COMMENT ON COLUMN PROVIDERS.PRO_EMAIL IS '�̸���';
COMMENT ON COLUMN PROVIDERS.PROD_CODE IS '��ǰ �ڵ�';

DESC PRODUCTS;
DESC PROVIDERS;
DESC CUSTOMERS;

insert into customers values('CSKIM','CSKIM1234','��ö��','90/04/27','CSKIM','02-111-1111','010-1111-1111','111-111','���� ������',0);
insert into customers values('YHLEE','YHLEE1234','�̿���','83/12/16','YHLEE','031-222-2222','010-2222-2222','222-222','�λ� ����',0);
insert into customers values('JKCHOI','JKCHOI1234','������','87/05/21','JKCHOI','064-333-3333','010-3333-3333','333-333','���� ������',0);
insert into customers values('JHKANG','JHKANG1234','����ȣ','93/01/14','JHKANG','033-444-4444','010-4444-4444','444-444','���� ȫ����',0);
insert into customers values('BKMIN','BKMIN1234','�κ���','88/08/03','BKMIN','042-555-5555','010-5555-5555','555-555','���� ���ε�',0);
insert into customers values('MSOH','MSHO1234','���μ�','89/02/25','MSOH','062-666-6666','010-6666-6666','666-666','���� �ϱ�',0);

insert into providers values('111-11-11111','�����ٳ�','��ö��','02-123-4567','02-123-4568','135-111','���� ������','GIO');
insert into providers values('MSOH','MSHO1234','���μ�','89/02/25','MSOH','062-666-6666','010-6666-6666','666-666','���� �ϱ�',0);
insert into providers values('MSOH','MSHO1234','���μ�','89/02/25','MSOH','062-666-6666','010-6666-6666','666-666','���� �ϱ�',0);
insert into providers values('MSOH','MSHO1234','���μ�','89/02/25','MSOH','062-666-6666','010-6666-6666','666-666','���� �ϱ�',0);

insert into products values('G001','�����','XL','G001.PNG','�����ٳ� �����',30000,50,5,'111-11-11111');
insert into products values('G002',',��Ʈ������Ƽ����','L','G002.PNG','�����ٳ� ��Ʈ������ Ƽ����',50000,30,5,'111-11-11111');
insert into products values('B001','����Ƽ����','S','B001.PNG','������ ����Ƽ����',20000,50,5,'222-22-22222');
insert into products values('B002','�е�','XXL','B002.PNG','������ �е�',100000,30,5,'222-22-22222');
insert into products values('P001','��Ʈ','L','P001.PNG','�� ��Ʈ',150000,10,2,'333-33-33333');
insert into products values('P002','���뽺','L','P002.PNG','�� ���뽺',20000,50,10,'333-33-33333');
insert into products values('U001','�ĵ尡���','S','U001.PNG','����Ŭ�� �ĵ尡���',70000,30,5,'444-44-44444');
insert into products values('U002','����Ƽ����','XXXL','U002.PNG','����Ŭ�� ����Ƽ����',25000,100,10,'444-44-44444');