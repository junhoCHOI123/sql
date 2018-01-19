
/* Drop Tables */

DROP TABLE CUSTOMERS CASCADE CONSTRAINTS;
DROP TABLE PROVIDERS CASCADE CONSTRAINTS;
DROP TABLE PRODUCTS CASCADE CONSTRAINTS;


/* Create Tables */
CREATE TABLE CUSTOMERS
(
	-- 고객ID
	ID varchar2(30) NOT NULL,
	-- 암호
	PASSWORD varchar2(30) NOT NULL,
	-- 고객명
	CUST_NAME varchar2(30) NOT NULL,
	-- 생년월일
	BIRTH_DATE date,
	-- 이메일
	EMAIL varchar2(50) NOT NULL,
	-- 집 전화번호
	HOME_PHONE varchar2(30),
	-- 휴대폰 번호
	MOBILE_PHONE varchar2(30),
	-- 우편번호
	POST_CODE varchar2(20),
	-- 주소
	ADDRESS varchar2(100),
	-- 포인트
	POINT number(10) DEFAULT 0,
	PRIMARY KEY (ID)
);


CREATE TABLE PRODUCTS
(
	-- 상품 코드
	PROD_CODE varchar2(20) NOT NULL,
	-- 상품명
	PROD_NAME varchar2(100) NOT NULL,
	-- 사이즈
	PROD_SIZE varchar2(50),
	-- 사진
	PROD_PIC varchar2(100),
	-- 상세설명
	PROD_DETAIL varchar2(4000),
	-- 단가
	PROD_COST number(10) DEFAULT 0,
	-- 재고
	PROD_STOCK number(5) DEFAULT 0,
	-- 최소유지재고
	PROD_STOCK_MIN number(5) DEFAULT 0,
	-- 사업자등록번호
	PRO_NO varchar2(30) NOT NULL,
	PRIMARY KEY (PROD_CODE)
);


CREATE TABLE PROVIDERS
(
	-- 사업자등록번호
	PRO_NO varchar2(30) NOT NULL,
	-- 사업자명
	PRO_NAME varchar2(30) NOT NULL,
	-- 대표이사 이름
	PRO_CEO varchar2(30),
	-- 대표 전화번호
	PRO_PHONE varchar2(30),
	-- 대표 팩스번호
	PRO_FAX varchar2(30),
	-- 우편번호
	PRO_POST varchar2(20),
	-- 주소
	PRO_ADDRESS varchar2(100),
	-- 이메일
	PRO_EMAIL varchar2(50),
	-- 상품 코드
	PROD_CODE varchar2(20) NOT NULL,
	PRIMARY KEY (PRO_NO)
);

/* Create Foreign Keys */

ALTER TABLE PROVIDERS
	ADD FOREIGN KEY (PROD_CODE)
	REFERENCES PRODUCTS (PROD_CODE)
;

/* Comments */

COMMENT ON COLUMN CUSTOMERS.ID IS '고객ID';
COMMENT ON COLUMN CUSTOMERS.PASSWORD IS '암호';
COMMENT ON COLUMN CUSTOMERS.CUST_NAME IS '고객명';
COMMENT ON COLUMN CUSTOMERS.BIRTH_DATE IS '생년월일';
COMMENT ON COLUMN CUSTOMERS.EMAIL IS '이메일';
COMMENT ON COLUMN CUSTOMERS.HOME_PHONE IS '집 전화번호';
COMMENT ON COLUMN CUSTOMERS.MOBILE_PHONE IS '휴대폰 번호';
COMMENT ON COLUMN CUSTOMERS.POST_CODE IS '우편번호';
COMMENT ON COLUMN CUSTOMERS.ADDRESS IS '주소';
COMMENT ON COLUMN CUSTOMERS.POINT IS '포인트';
COMMENT ON COLUMN PRODUCTS.PROD_CODE IS '상품 코드';
COMMENT ON COLUMN PRODUCTS.PROD_NAME IS '상품명';
COMMENT ON COLUMN PRODUCTS.PROD_SIZE IS '사이즈';
COMMENT ON COLUMN PRODUCTS.PROD_PIC IS '사진';
COMMENT ON COLUMN PRODUCTS.PROD_DETAIL IS '상세설명';
COMMENT ON COLUMN PRODUCTS.PROD_COST IS '단가';
COMMENT ON COLUMN PRODUCTS.PROD_STOCK IS '재고';
COMMENT ON COLUMN PRODUCTS.PROD_STOCK_MIN IS '최소유지재고';
COMMENT ON COLUMN PRODUCTS.PRO_NO IS '사업자등록번호';
COMMENT ON COLUMN PROVIDERS.PRO_NO IS '사업자등록번호';
COMMENT ON COLUMN PROVIDERS.PRO_NAME IS '사업자명';
COMMENT ON COLUMN PROVIDERS.PRO_CEO IS '대표이사 이름';
COMMENT ON COLUMN PROVIDERS.PRO_PHONE IS '대표 전화번호';
COMMENT ON COLUMN PROVIDERS.PRO_FAX IS '대표 팩스번호';
COMMENT ON COLUMN PROVIDERS.PRO_POST IS '우편번호';
COMMENT ON COLUMN PROVIDERS.PRO_ADDRESS IS '주소';
COMMENT ON COLUMN PROVIDERS.PRO_EMAIL IS '이메일';
COMMENT ON COLUMN PROVIDERS.PROD_CODE IS '상품 코드';

DESC PRODUCTS;
DESC PROVIDERS;
DESC CUSTOMERS;

insert into customers values('CSKIM','CSKIM1234','김철수','90/04/27','CSKIM','02-111-1111','010-1111-1111','111-111','서울 강남구',0);
insert into customers values('YHLEE','YHLEE1234','이영희','83/12/16','YHLEE','031-222-2222','010-2222-2222','222-222','부산 서면',0);
insert into customers values('JKCHOI','JKCHOI1234','최진국','87/05/21','JKCHOI','064-333-3333','010-3333-3333','333-333','제주 동광양',0);
insert into customers values('JHKANG','JHKANG1234','강준호','93/01/14','JHKANG','033-444-4444','010-4444-4444','444-444','강릉 홍제동',0);
insert into customers values('BKMIN','BKMIN1234','민병국','88/08/03','BKMIN','042-555-5555','010-5555-5555','555-555','대전 전민동',0);
insert into customers values('MSOH','MSHO1234','오민수','89/02/25','MSOH','062-666-6666','010-6666-6666','666-666','광주 북구',0);

insert into providers values('111-11-11111','지오다노','이철수','02-123-4567','02-123-4568','135-111','서울 강남구','GIO');
insert into providers values('MSOH','MSHO1234','오민수','89/02/25','MSOH','062-666-6666','010-6666-6666','666-666','광주 북구',0);
insert into providers values('MSOH','MSHO1234','오민수','89/02/25','MSOH','062-666-6666','010-6666-6666','666-666','광주 북구',0);
insert into providers values('MSOH','MSHO1234','오민수','89/02/25','MSOH','062-666-6666','010-6666-6666','666-666','광주 북구',0);

insert into products values('G001','면바지','XL','G001.PNG','지오다노 면바지',30000,50,5,'111-11-11111');
insert into products values('G002',',스트라이프티셔츠','L','G002.PNG','지오다노 스트라이프 티셔츠',50000,30,5,'111-11-11111');
insert into products values('B001','긴팔티셔츠','S','B001.PNG','베네통 긴팔티셔츠',20000,50,5,'222-22-22222');
insert into products values('B002','패딩','XXL','B002.PNG','베네통 패딩',100000,30,5,'222-22-22222');
insert into products values('P001','코트','L','P001.PNG','갭 코트',150000,10,2,'333-33-33333');
insert into products values('P002','레깅스','L','P002.PNG','갭 레깅스',20000,50,10,'333-33-33333');
insert into products values('U001','후드가디건','S','U001.PNG','유니클로 후드가디건',70000,30,5,'444-44-44444');
insert into products values('U002','반팔티셔츠','XXXL','U002.PNG','유니클로 반팔티셔츠',25000,100,10,'444-44-44444');