--
-- PostgreSQL database dump
--

-- Dumped from database version 11.4 (Debian 11.4-1.pgdg90+1)
-- Dumped by pg_dump version 11.5

-- Started on 2019-10-23 22:29:20 EEST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 16386)
-- Name: game; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game (
    id bigint NOT NULL,
    title character varying(255),
    price double precision NOT NULL,
    tags character varying[],
    release date NOT NULL,
    publisher bigint NOT NULL
);


ALTER TABLE public.game OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16384)
-- Name: game_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_id_seq OWNER TO postgres;

--
-- TOC entry 2893 (class 0 OID 0)
-- Dependencies: 196
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;


--
-- TOC entry 199 (class 1259 OID 16460)
-- Name: publisher; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.publisher (
    id bigint NOT NULL,
    name character varying NOT NULL,
    siret bigint,
    phone character varying
);


ALTER TABLE public.publisher OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16472)
-- Name: game_publisher_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.game_publisher_view WITH (security_barrier='false') AS
 SELECT game.id,
    game.title,
    game.price,
    game.tags,
    game.release,
    publisher.name,
    publisher.siret,
    publisher.phone,
        CASE
            WHEN ((game.release > (date_trunc('day'::text, now()) - '1 year 6 mons'::interval)) AND (game.release < (date_trunc('day'::text, now()) - '1 year'::interval))) THEN (game.price * (0.2)::double precision)
            ELSE (0)::double precision
        END AS discount,
    publisher.id AS publisher_id
   FROM public.game,
    public.publisher
  WHERE ((game.publisher = publisher.id) AND (game.release > (date_trunc('month'::text, now()) - '1 year 6 mons'::interval)));


ALTER TABLE public.game_publisher_view OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16458)
-- Name: publisher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.publisher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.publisher_id_seq OWNER TO postgres;

--
-- TOC entry 2894 (class 0 OID 0)
-- Dependencies: 198
-- Name: publisher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.publisher_id_seq OWNED BY public.publisher.id;


--
-- TOC entry 2752 (class 2604 OID 16389)
-- Name: game id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);


--
-- TOC entry 2753 (class 2604 OID 16463)
-- Name: publisher id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publisher ALTER COLUMN id SET DEFAULT nextval('public.publisher_id_seq'::regclass);


--
-- TOC entry 2885 (class 0 OID 16386)
-- Dependencies: 197
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game (id, title, price, tags, release, publisher) FROM stdin;
1	BioShock: The Collection	950	{"First-person shooter"}	2018-09-01	1
47	A Way Out	1000	{Action-adventure,"EA DICE"}	2019-03-23	1
48	Battlefield V	1000	{First-person,shooter}	2018-10-19	1
49	Assassin's Creed III Remastered	1000	{Action-adventure,stealth}	2019-03-29	41
50	Battleship	1000	{Strategy}	2016-08-12	41
51	The Crew 2	1000	{Racing}	2019-01-29	41
52	Civilization VI	1000	{4X,"turn-based strategy"}	2019-11-22	44
53	Deadpool	1000	{Action,"beat 'em up"}	2016-11-20	45
54	Call of Duty: Black Ops IIII	1000	{"First-person shooter",Treyarch}	2018-10-12	45
\.


--
-- TOC entry 2887 (class 0 OID 16460)
-- Dependencies: 199
-- Data for Name: publisher; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.publisher (id, name, siret, phone) FROM stdin;
1	Electronic Arts	\N	\N
41	Ubisoft	1000	123
44	2K Games	2001	\N
45	Activision	3001	\N
\.


--
-- TOC entry 2895 (class 0 OID 0)
-- Dependencies: 196
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_id_seq', 54, true);


--
-- TOC entry 2896 (class 0 OID 0)
-- Dependencies: 198
-- Name: publisher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.publisher_id_seq', 46, true);


--
-- TOC entry 2755 (class 2606 OID 16394)
-- Name: game game_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);


--
-- TOC entry 2759 (class 2606 OID 16468)
-- Name: publisher publisher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT publisher_pkey PRIMARY KEY (id);


--
-- TOC entry 2761 (class 2606 OID 16470)
-- Name: publisher uniq_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.publisher
    ADD CONSTRAINT uniq_name UNIQUE (name);


--
-- TOC entry 2757 (class 2606 OID 16478)
-- Name: game unique_game_via_publisher; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT unique_game_via_publisher UNIQUE (title, publisher);


-- Completed on 2019-10-23 22:29:24 EEST

--
-- PostgreSQL database dump complete
--

