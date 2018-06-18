-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 05, 2013 at 07:53 AM
-- Server version: 5.5.24
-- PHP Version: 5.3.10-1ubuntu3.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `saikiran enterprises`
--

-- --------------------------------------------------------

--
-- Table structure for table `administrators`
--

-- CREATING TABLES 

CREATE TABLE IF NOT EXISTS administrators (
  id serial primary key,
  email varchar(45) NOT NULL UNIQUE,
  password varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS category (
  id serial primary key,
  category_name varchar(30) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS sub_category (
  id serial primary key,
  sub_category_name varchar(30) NOT NULL,
  category_id bigint NOT NULL REFERENCES category(id),
  category_name varchar(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS product_company (
  id serial primary key,
  company_name varchar(40) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS products (
  id serial primary key,
  product_name varchar(60) NOT NULL UNIQUE,
  category_id bigint NOT NULL REFERENCES category(id),
  sub_category_name varchar(40) NOT NULL,
  sub_category_id bigint NOT NULL REFERENCES sub_category(id),
  category_name varchar(40) NOT NULL,
  company_name varchar(40) NOT NULL,
  price numeric(10,2) NOT NULL,
  summary text,
  tags varchar(255) NOT NULL,
  product_qty bigint NOT NULL,
  last_updated timestamp without time zone NOT NULL,
  hits bigint NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
  id serial primary key,
  email varchar(50) NOT NULL UNIQUE,
  password varchar(255) NOT NULL,
  registered_on timestamp without time zone NOT NULL,
  user_name varchar(50) NOT NULL UNIQUE,
  user_role varchar(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
  id serial primary key,
  user_id bigint NOT NULL REFERENCES users(id),
  status varchar(15) NOT NULL,
  shippers_name varchar(30) NOT NULL,
  address varchar(120) NOT NULL,
  location varchar(120) NOT NULL,
  location_charge numeric(10,2) NOT NULL,
  mobile_number varchar(10) NOT NULL,
  shippers_email varchar(45) NOT NULL,
  ordered_On timestamp without time zone NOT NULL,
  total_order_price numeric(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS images (
  id serial primary key,
  image_name varchar(255) NOT NULL,
  product_name varchar(255) NOT NULL,
  product_id bigint NOT NULL REFERENCES products(id)
);

CREATE TABLE IF NOT EXISTS expenses (
  id serial primary key,
  product_id bigint NOT NULL REFERENCES products(id),
  product_name varchar(250) NOT NULL,
  price float NOT NULL,
  purchase_date timestamp without time zone NOT NULL
);

CREATE TABLE IF NOT EXISTS sales (
  id serial primary key,
  order_id bigint NOT NULL REFERENCES orders(id),
  product_id bigint NOT NULL REFERENCES products(id),
  product_name varchar(255) NOT NULL,
  product_price numeric(10,2) NOT NULL,
  product_quantity bigint NOT NULL,
  sold_on timestamp without time zone NOT NULL,
  user_id bigint NOT NULL REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS user_details (
  id serial primary key,
  user_id bigint NOT NULL REFERENCES users(id),
  user_name varchar(30) NOT NULL UNIQUE,
  mobile_no varchar(10) NOT NULL UNIQUE,
  address varchar(100) NOT NULL,
  gender varchar(10) NOT NULL,
  user_image text NOT NULL
);

CREATE TABLE IF NOT EXISTS locations(
  id serial primary key,
  location_zone varchar(30) NOT NULL,
  location_name varchar(30) NOT NULL,
  location_charge numeric(10,2) NOT NULL
);

ALTER TABLE orders add column location varchar(120) NOT NULL;
ALTER TABLE orders add column location_charge numeric(10,2) NOT NULL;
-- DUMPING DATA
--
-- Dumping data for table `administrators`
--



INSERT INTO locations(location_zone,location_name,location_charge) VALUES('ZONE A','NAIROBI CBD',0);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone A','KAMKUNJI',100);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone A','KIRINYAGA RD',100);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone A','UNIVERSITY WAY',100);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone A','MUTHURWA',100);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone B','NSSF',150);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone B','CHIROMO',200);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone B','CITY STADIUM',200);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone B','ICEA(WAIYAKI WAY)',200);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone B','NGARA',200);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone B','VALLEY ROAD',200);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone B','MUSEUM HILL',200);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone B','GIKOMBA',200);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','KENYATTA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','NYAYO',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','PANGANI',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','RAPHTA ROAD(WESTY)',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','SARIT CENTER',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','COMMUNITY',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','MUTHUTHI ROAD(WESTY)',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','OJIJO RD',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','FPREST RD',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','UCHUMI JOGOO RD',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','STATEHSE RD',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone C','SURVEY',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','SAFARICOM HDSE',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','HURLINGUM',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','UPPEEHILL',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','INDUSTRIAL AREA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','SOUTH B/C',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','EASTLEIGH',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','CID HQ KIAMBU RD',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','PEPONI RD',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','KILIMANI',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','ALLSOPS',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','PSARKLANDS',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','HAMSA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','BELLEVUE',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','NAIROBI WEST',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone D','ABORETUM',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','GARDEN CITY',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','INDUSTRIAL AREA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','KILELESHWA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','MBAGATHI',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','PRESTIGE MALL',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','MADARAKA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','LENANA ROAD',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','UMOJA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','YAYA CENTER',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone E','BABA DOGO',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','BURUBURU',300);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','KANGEMI',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','IMARACDAIMA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','KASARANI',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','LAVINGTON',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','JUNCTION MALKL',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','TRM',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','KABETE',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','USIU',300);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','ZIMMERMAN',300);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','T-MALL',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone F','HURUMA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES(',Zone G','BURUBURU',300);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','CSABANAS',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','DONHOLM',300);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','GIGIRI',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','CARNIVORE',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','GITHURAI44/45',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','PIPELINE',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','KATIOBANGI',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','UTHIRU',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','DANDORA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','KAWANGWARE',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','HUNTERS KASARANI',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone G','RIRUTA SATELLITE',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','GALLERIA',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','SYOKIMAU',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','KAHAWA',350);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','KAREN SHOPPING CENTER',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','NYAYO ESTATE',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','RUAKA',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','GREENSPAN',300);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','MWIKI',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','KINOO',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','KIKUYU',300);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','LANGATA',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone H','KOMAROCK',250);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone I','MLOLONGO',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone I','KAREN',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone I','KU',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone I','TWO RIVERS MALL',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone I','BOMAS',350);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone I','UTAWALA',400);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone J','KITENGELA',500);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone J','ATHIRIVER',500);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone J','RUIRU',500);
INSERT INTO locations(location_zone,location_name,location_charge) VALUES('Zone J','NGONG',500);