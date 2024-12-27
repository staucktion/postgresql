--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2

-- Started on 2024-12-19 09:45:53 UTC

DO $$ 
BEGIN
    PERFORM pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = 'bank' AND pid <> pg_backend_pid();
END;
$$;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS bank;
--
-- TOC entry 3406 (class 1262 OID 16855)
-- Name: bank; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE bank WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE bank OWNER TO admin;

\connect bank

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16856)
-- Name: account; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.account (
    id integer NOT NULL,
    balance numeric(15,2) NOT NULL,
    provision numeric(15,2) DEFAULT 0 NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.account OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 16862)
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.account_id_seq OWNER TO admin;

--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 218
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


--
-- TOC entry 219 (class 1259 OID 16863)
-- Name: auditlog; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.auditlog (
    id integer NOT NULL,
    action character varying(255) NOT NULL,
    performed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.auditlog OWNER TO admin;

--
-- TOC entry 220 (class 1259 OID 16867)
-- Name: auditlog_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.auditlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auditlog_id_seq OWNER TO admin;

--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 220
-- Name: auditlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.auditlog_id_seq OWNED BY public.auditlog.id;


--
-- TOC entry 221 (class 1259 OID 16868)
-- Name: card; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.card (
    id integer NOT NULL,
    account_id integer NOT NULL,
    number character varying(16) NOT NULL,
    expiration_date character varying(5) NOT NULL,
    cvv character(3) NOT NULL
);


ALTER TABLE public.card OWNER TO admin;

--
-- TOC entry 222 (class 1259 OID 16871)
-- Name: card_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_id_seq OWNER TO admin;

--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 222
-- Name: card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.card_id_seq OWNED BY public.card.id;


--
-- TOC entry 223 (class 1259 OID 16872)
-- Name: transaction; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.transaction (
    id integer NOT NULL,
    sender_account_id integer,
    receiver_account_id integer,
    sender_card_id integer,
    amount numeric(15,2) NOT NULL,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description character varying(255)
);


ALTER TABLE public.transaction OWNER TO admin;

--
-- TOC entry 224 (class 1259 OID 16876)
-- Name: transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaction_id_seq OWNER TO admin;

--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 224
-- Name: transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.transaction_id_seq OWNED BY public.transaction.id;


--
-- TOC entry 3225 (class 2604 OID 16877)
-- Name: account id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


--
-- TOC entry 3229 (class 2604 OID 16878)
-- Name: auditlog id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auditlog ALTER COLUMN id SET DEFAULT nextval('public.auditlog_id_seq'::regclass);


--
-- TOC entry 3231 (class 2604 OID 16879)
-- Name: card id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.card ALTER COLUMN id SET DEFAULT nextval('public.card_id_seq'::regclass);


--
-- TOC entry 3232 (class 2604 OID 16880)
-- Name: transaction id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.transaction ALTER COLUMN id SET DEFAULT nextval('public.transaction_id_seq'::regclass);


--
-- TOC entry 3393 (class 0 OID 16856)
-- Dependencies: 217
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.account (id, balance, provision, created_at, updated_at) FROM stdin;
1	1000000000.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
2	100000.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
3	4380.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
4	98120.50	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
5	25000.25	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
6	34560.50	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
7	56230.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
8	49000.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
9	83010.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
10	72650.00	0.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705
\.


--
-- TOC entry 3395 (class 0 OID 16863)
-- Dependencies: 219
-- Data for Name: auditlog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.auditlog (id, action, performed_at) FROM stdin;
\.


--
-- TOC entry 3397 (class 0 OID 16868)
-- Dependencies: 221
-- Data for Name: card; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.card (id, account_id, number, expiration_date, cvv) FROM stdin;
1	1	4242424242424242	12/25	123
2	2	4000056655665556	04/26	678
3	2	5555555555554444	01/25	456
4	3	2223003122003222	02/27	890
5	3	5200828282828210	02/26	789
6	4	5105105105105100	01/25	321
7	5	378282246310005	07/26	654
8	6	371449635398431	11/27	987
9	7	6011111111111117	10/27	213
10	8	6011000990139424	05/27	432
11	9	6011981111111113	03/28	567
12	10	3056930009020004	06/29	876
\.


--
-- TOC entry 3399 (class 0 OID 16872)
-- Dependencies: 223
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.transaction (id, sender_account_id, receiver_account_id, sender_card_id, amount, transaction_date, description) FROM stdin;
\.


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 218
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.account_id_seq', 11, false);


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 220
-- Name: auditlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.auditlog_id_seq', 1, false);


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 222
-- Name: card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.card_id_seq', 13, false);


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 224
-- Name: transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.transaction_id_seq', 1, false);


--
-- TOC entry 3235 (class 2606 OID 16882)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 3237 (class 2606 OID 16884)
-- Name: auditlog auditlog_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auditlog
    ADD CONSTRAINT auditlog_pkey PRIMARY KEY (id);


--
-- TOC entry 3239 (class 2606 OID 16886)
-- Name: card card_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.card
    ADD CONSTRAINT card_pkey PRIMARY KEY (id);


--
-- TOC entry 3243 (class 2606 OID 16888)
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


--
-- TOC entry 3241 (class 2606 OID 16890)
-- Name: card unique_card_number; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.card
    ADD CONSTRAINT unique_card_number UNIQUE (number);


--
-- TOC entry 3244 (class 2606 OID 16891)
-- Name: card card_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.card
    ADD CONSTRAINT card_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.account(id) ON DELETE CASCADE NOT VALID;


--
-- TOC entry 3245 (class 2606 OID 16901)
-- Name: transaction transaction_receiver_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_receiver_account_id_fkey FOREIGN KEY (receiver_account_id) REFERENCES public.account(id) ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3246 (class 2606 OID 16896)
-- Name: transaction transaction_sender_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_sender_account_id_fkey FOREIGN KEY (sender_account_id) REFERENCES public.account(id) ON DELETE SET NULL NOT VALID;


--
-- TOC entry 3247 (class 2606 OID 16906)
-- Name: transaction transaction_sender_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_sender_card_id_fkey FOREIGN KEY (sender_card_id) REFERENCES public.card(id) ON DELETE SET NULL NOT VALID;


-- Completed on 2024-12-19 10:12:11 UTC

--
-- PostgreSQL database dump complete
--

