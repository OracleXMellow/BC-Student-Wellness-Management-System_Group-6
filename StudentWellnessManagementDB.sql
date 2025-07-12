--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

-- Started on 2025-07-12 15:59:20

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
-- TOC entry 217 (class 1259 OID 16426)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    student_number character varying(20) NOT NULL,
    name character varying(50) NOT NULL,
    surname character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(20) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_email_check CHECK (((email)::text ~~ '%@%.%'::text)),
    CONSTRAINT users_phone_check CHECK (((phone)::text ~ '^[0-9]{10}$'::text))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 4826 (class 0 OID 0)
-- Dependencies: 217
-- Name: TABLE users; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.users IS 'Stores student registration details for login system.';


--
-- TOC entry 4827 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.student_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.student_number IS 'Unique student ID';


--
-- TOC entry 4828 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.email IS 'Must be unique and properly formatted';


--
-- TOC entry 4829 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.phone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.phone IS '10-digit South African phone number';


--
-- TOC entry 4830 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.password; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.password IS 'Hashed user password';


--
-- TOC entry 4831 (class 0 OID 0)
-- Dependencies: 217
-- Name: COLUMN users.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.users.created_at IS 'Timestamp of registration';


--
-- TOC entry 222 (class 1259 OID 16456)
-- Name: full_user_info; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.full_user_info AS
 SELECT student_number,
    name,
    surname,
    email,
    phone,
    password,
    created_at
   FROM public.users
  ORDER BY created_at DESC;


ALTER VIEW public.full_user_info OWNER TO postgres;

--
-- TOC entry 4832 (class 0 OID 0)
-- Dependencies: 222
-- Name: VIEW full_user_info; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.full_user_info IS 'View for full user records, sorted by latest registration.';


--
-- TOC entry 221 (class 1259 OID 16452)
-- Name: registration_stats; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.registration_stats AS
 SELECT date(created_at) AS registration_date,
    count(*) AS total_users
   FROM public.users
  GROUP BY (date(created_at))
  ORDER BY (date(created_at));


ALTER VIEW public.registration_stats OWNER TO postgres;

--
-- TOC entry 4833 (class 0 OID 0)
-- Dependencies: 221
-- Name: VIEW registration_stats; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.registration_stats IS 'Shows total number of users registered per day.';


--
-- TOC entry 219 (class 1259 OID 16439)
-- Name: user_audit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_audit (
    log_id integer NOT NULL,
    email character varying(100),
    action character varying(50),
    logged_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_audit OWNER TO postgres;

--
-- TOC entry 4834 (class 0 OID 0)
-- Dependencies: 219
-- Name: TABLE user_audit; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.user_audit IS 'Logs registration and login activity from the system.';


--
-- TOC entry 4835 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN user_audit.email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_audit.email IS 'User email involved in the action';


--
-- TOC entry 4836 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN user_audit.action; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_audit.action IS 'Action type e.g., REGISTERED, LOGGED IN';


--
-- TOC entry 4837 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN user_audit.logged_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.user_audit.logged_at IS 'Timestamp of the action';


--
-- TOC entry 218 (class 1259 OID 16438)
-- Name: user_audit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_audit_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_audit_log_id_seq OWNER TO postgres;

--
-- TOC entry 4838 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_audit_log_id_seq OWNED BY public.user_audit.log_id;


--
-- TOC entry 220 (class 1259 OID 16448)
-- Name: user_summary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.user_summary AS
 SELECT student_number,
    name,
    surname,
    email
   FROM public.users;


ALTER VIEW public.user_summary OWNER TO postgres;

--
-- TOC entry 4839 (class 0 OID 0)
-- Dependencies: 220
-- Name: VIEW user_summary; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON VIEW public.user_summary IS 'Summarized user view with non-sensitive info.';


--
-- TOC entry 4658 (class 2604 OID 16442)
-- Name: user_audit log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_audit ALTER COLUMN log_id SET DEFAULT nextval('public.user_audit_log_id_seq'::regclass);


--
-- TOC entry 4820 (class 0 OID 16439)
-- Dependencies: 219
-- Data for Name: user_audit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_audit (log_id, email, action, logged_at) FROM stdin;
1	lebo@bc.edu	REGISTERED	2025-07-12 15:40:31.670717
2	sipho@bc.edu	REGISTERED	2025-07-12 15:40:31.670717
3	amy@bc.edu	REGISTERED	2025-07-12 15:40:31.670717
4	john@bc.edu	REGISTERED	2025-07-12 15:40:31.670717
5	sarah@bc.edu	REGISTERED	2025-07-12 15:40:31.670717
\.


--
-- TOC entry 4818 (class 0 OID 16426)
-- Dependencies: 217
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (student_number, name, surname, email, phone, password, created_at) FROM stdin;
S001	Lebo	Mokoena	lebo@bc.edu	0812345678	$2a$10$ALc.zMcihU.C2N4L8vLymuF0DhhnSTkPzIFRPysWgKbeyLbXWePvK	2025-07-12 15:40:31.670717
S002	Sipho	Zulu	sipho@bc.edu	0723456789	$2a$10$XcF1CVMSDBfMHDZTQAt8yOZFOpGpFbToAvN3M8NKtUL47yLS0cETK	2025-07-12 15:40:31.670717
S003	Amy	Naidoo	amy@bc.edu	0734567890	$2a$10$7cNznsXAcG6Cug1j6SBGwuXMx5HKoeVAYhzltBtNSLtHRj8FjGyXO	2025-07-12 15:40:31.670717
S004	John	Smith	john@bc.edu	0745678901	$2a$10$CyA.GdDpRhxHbvw38JuWW.FfrQa.lKKo4sUNUJ9b1yyD5vCd3BzTa	2025-07-12 15:40:31.670717
S005	Sarah	Mabaso	sarah@bc.edu	0756789012	$2a$10$9ZSDWyQilHeZai5pUswqQ.lvlRzYeyydoa01wKNj0PQl3rR6KlR1K	2025-07-12 15:40:31.670717
\.


--
-- TOC entry 4840 (class 0 OID 0)
-- Dependencies: 218
-- Name: user_audit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_audit_log_id_seq', 5, true);


--
-- TOC entry 4669 (class 2606 OID 16445)
-- Name: user_audit user_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_audit
    ADD CONSTRAINT user_audit_pkey PRIMARY KEY (log_id);


--
-- TOC entry 4665 (class 2606 OID 16437)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4667 (class 2606 OID 16435)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (student_number);


--
-- TOC entry 4662 (class 1259 OID 16446)
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 4662
-- Name: INDEX idx_users_email; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_users_email IS 'Index to optimize login lookups by email.';


--
-- TOC entry 4663 (class 1259 OID 16447)
-- Name: idx_users_student_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_student_number ON public.users USING btree (student_number);


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 4663
-- Name: INDEX idx_users_student_number; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON INDEX public.idx_users_student_number IS 'Index to optimize lookups by student number.';


-- Completed on 2025-07-12 15:59:20

--
-- PostgreSQL database dump complete
--

