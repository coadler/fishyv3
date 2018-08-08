--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: easter_egg_type; Type: TYPE; Schema: public; Owner: colinadler
--

CREATE TYPE public.easter_egg_type AS ENUM (
    'no_rod'
);


ALTER TYPE public.easter_egg_type OWNER TO colinadler;

--
-- Name: item; Type: TYPE; Schema: public; Owner: colinadler
--

CREATE TYPE public.item AS ENUM (
    'bait',
    'rod',
    'hook',
    'vehicle',
    'bait_box'
);


ALTER TYPE public.item OWNER TO colinadler;

--
-- Name: location; Type: TYPE; Schema: public; Owner: colinadler
--

CREATE TYPE public.location AS ENUM (
    'lake',
    'river',
    'ocean'
);


ALTER TYPE public.location OWNER TO colinadler;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bait_inventory; Type: TABLE; Schema: public; Owner: colinadler
--

CREATE TABLE public.bait_inventory (
    "user" text NOT NULL,
    tier_1 integer NOT NULL,
    tier_2 integer NOT NULL,
    tier_3 integer NOT NULL,
    tier_4 integer NOT NULL,
    tier_5 integer NOT NULL,
    current integer NOT NULL,
    gathering boolean NOT NULL
);


ALTER TABLE public.bait_inventory OWNER TO colinadler;

--
-- Name: inventory; Type: TABLE; Schema: public; Owner: colinadler
--

CREATE TABLE public.inventory (
    "user" text NOT NULL,
    fish integer NOT NULL,
    garbage integer NOT NULL,
    legendary integer NOT NULL,
    worth integer NOT NULL
);


ALTER TABLE public.inventory OWNER TO colinadler;

--
-- Name: bait_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: colinadler
--

CREATE SEQUENCE public.bait_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bait_inventory_id_seq OWNER TO colinadler;

--
-- Name: bait_inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colinadler
--

ALTER SEQUENCE public.bait_inventory_id_seq OWNED BY public.inventory."user";


--
-- Name: blacklist; Type: TABLE; Schema: public; Owner: colinadler
--

CREATE TABLE public.blacklist (
    id integer NOT NULL,
    "user" text NOT NULL
);


ALTER TABLE public.blacklist OWNER TO colinadler;

--
-- Name: blacklist_id_seq; Type: SEQUENCE; Schema: public; Owner: colinadler
--

CREATE SEQUENCE public.blacklist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blacklist_id_seq OWNER TO colinadler;

--
-- Name: blacklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colinadler
--

ALTER SEQUENCE public.blacklist_id_seq OWNED BY public.blacklist.id;


--
-- Name: easter_eggs; Type: TABLE; Schema: public; Owner: colinadler
--

CREATE TABLE public.easter_eggs (
    id integer NOT NULL,
    "user" text NOT NULL,
    easter_egg public.easter_egg_type NOT NULL,
    amt integer
);


ALTER TABLE public.easter_eggs OWNER TO colinadler;

--
-- Name: easter_eggs_id_seq; Type: SEQUENCE; Schema: public; Owner: colinadler
--

CREATE SEQUENCE public.easter_eggs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easter_eggs_id_seq OWNER TO colinadler;

--
-- Name: easter_eggs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colinadler
--

ALTER SEQUENCE public.easter_eggs_id_seq OWNED BY public.easter_eggs.id;


--
-- Name: equipped_items; Type: TABLE; Schema: public; Owner: colinadler
--

CREATE TABLE public.equipped_items (
    "user" text NOT NULL,
    bait integer NOT NULL,
    rod integer NOT NULL,
    hook integer NOT NULL,
    vehicle integer NOT NULL,
    bait_box integer NOT NULL
);


ALTER TABLE public.equipped_items OWNER TO colinadler;

--
-- Name: global_rankings; Type: TABLE; Schema: public; Owner: colinadler
--

CREATE TABLE public.global_rankings (
    "user" text NOT NULL,
    score integer NOT NULL,
    garbage integer NOT NULL,
    fish integer NOT NULL,
    avg_length numeric NOT NULL,
    casts integer NOT NULL
);


ALTER TABLE public.global_rankings OWNER TO colinadler;

--
-- Name: global_rankings_id_seq; Type: SEQUENCE; Schema: public; Owner: colinadler
--

CREATE SEQUENCE public.global_rankings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.global_rankings_id_seq OWNER TO colinadler;

--
-- Name: global_rankings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colinadler
--

ALTER SEQUENCE public.global_rankings_id_seq OWNED BY public.global_rankings."user";


--
-- Name: guild_rankings; Type: TABLE; Schema: public; Owner: colinadler
--

CREATE TABLE public.guild_rankings (
    id integer NOT NULL,
    "user" text NOT NULL,
    guild text NOT NULL,
    score integer NOT NULL,
    garbage integer NOT NULL,
    fish integer NOT NULL,
    casts integer NOT NULL,
    avg_length numeric NOT NULL
);


ALTER TABLE public.guild_rankings OWNER TO colinadler;

--
-- Name: guild_rankings_id_seq; Type: SEQUENCE; Schema: public; Owner: colinadler
--

CREATE SEQUENCE public.guild_rankings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guild_rankings_id_seq OWNER TO colinadler;

--
-- Name: guild_rankings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colinadler
--

ALTER SEQUENCE public.guild_rankings_id_seq OWNED BY public.guild_rankings.id;


--
-- Name: location_density; Type: TABLE; Schema: public; Owner: colinadler
--

CREATE TABLE public.location_density (
    "user" text NOT NULL,
    lake integer NOT NULL,
    river integer NOT NULL,
    ocean integer NOT NULL,
    location public.location NOT NULL
);


ALTER TABLE public.location_density OWNER TO colinadler;

--
-- Name: owned_items; Type: TABLE; Schema: public; Owner: colinadler
--

CREATE TABLE public.owned_items (
    "user" text NOT NULL,
    item public.item NOT NULL,
    tier integer NOT NULL
);


ALTER TABLE public.owned_items OWNER TO colinadler;

--
-- Name: blacklist id; Type: DEFAULT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.blacklist ALTER COLUMN id SET DEFAULT nextval('public.blacklist_id_seq'::regclass);


--
-- Name: easter_eggs id; Type: DEFAULT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.easter_eggs ALTER COLUMN id SET DEFAULT nextval('public.easter_eggs_id_seq'::regclass);


--
-- Name: guild_rankings id; Type: DEFAULT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.guild_rankings ALTER COLUMN id SET DEFAULT nextval('public.guild_rankings_id_seq'::regclass);


--
-- Data for Name: bait_inventory; Type: TABLE DATA; Schema: public; Owner: colinadler
--

COPY public.bait_inventory ("user", tier_1, tier_2, tier_3, tier_4, tier_5, current, gathering) FROM stdin;
\.


--
-- Data for Name: blacklist; Type: TABLE DATA; Schema: public; Owner: colinadler
--

COPY public.blacklist (id, "user") FROM stdin;
0	105484726235607040
\.


--
-- Data for Name: easter_eggs; Type: TABLE DATA; Schema: public; Owner: colinadler
--

COPY public.easter_eggs (id, "user", easter_egg, amt) FROM stdin;
\.


--
-- Data for Name: equipped_items; Type: TABLE DATA; Schema: public; Owner: colinadler
--

COPY public.equipped_items ("user", bait, rod, hook, vehicle, bait_box) FROM stdin;
\.


--
-- Data for Name: global_rankings; Type: TABLE DATA; Schema: public; Owner: colinadler
--

COPY public.global_rankings ("user", score, garbage, fish, avg_length, casts) FROM stdin;
\.


--
-- Data for Name: guild_rankings; Type: TABLE DATA; Schema: public; Owner: colinadler
--

COPY public.guild_rankings (id, "user", guild, score, garbage, fish, casts, avg_length) FROM stdin;
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: colinadler
--

COPY public.inventory ("user", fish, garbage, legendary, worth) FROM stdin;
\.


--
-- Data for Name: location_density; Type: TABLE DATA; Schema: public; Owner: colinadler
--

COPY public.location_density ("user", lake, river, ocean, location) FROM stdin;
\.


--
-- Data for Name: owned_items; Type: TABLE DATA; Schema: public; Owner: colinadler
--

COPY public.owned_items ("user", item, tier) FROM stdin;
\.


--
-- Name: bait_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colinadler
--

SELECT pg_catalog.setval('public.bait_inventory_id_seq', 1, false);


--
-- Name: blacklist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colinadler
--

SELECT pg_catalog.setval('public.blacklist_id_seq', 7, true);


--
-- Name: easter_eggs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colinadler
--

SELECT pg_catalog.setval('public.easter_eggs_id_seq', 1, false);


--
-- Name: global_rankings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colinadler
--

SELECT pg_catalog.setval('public.global_rankings_id_seq', 1, false);


--
-- Name: guild_rankings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colinadler
--

SELECT pg_catalog.setval('public.guild_rankings_id_seq', 1, false);


--
-- Name: inventory bait_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT bait_inventory_pkey PRIMARY KEY ("user");


--
-- Name: blacklist blacklist_pkey; Type: CONSTRAINT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.blacklist
    ADD CONSTRAINT blacklist_pkey PRIMARY KEY (id);


--
-- Name: easter_eggs easter_eggs_pkey; Type: CONSTRAINT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.easter_eggs
    ADD CONSTRAINT easter_eggs_pkey PRIMARY KEY (id);


--
-- Name: equipped_items equipped_items_pkey; Type: CONSTRAINT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.equipped_items
    ADD CONSTRAINT equipped_items_pkey PRIMARY KEY ("user");


--
-- Name: global_rankings global_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.global_rankings
    ADD CONSTRAINT global_rankings_pkey PRIMARY KEY ("user");


--
-- Name: guild_rankings guild_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.guild_rankings
    ADD CONSTRAINT guild_rankings_pkey PRIMARY KEY (id);


--
-- Name: bait_inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.bait_inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY ("user");


--
-- Name: location_density location_density_pkey; Type: CONSTRAINT; Schema: public; Owner: colinadler
--

ALTER TABLE ONLY public.location_density
    ADD CONSTRAINT location_density_pkey PRIMARY KEY ("user");


--
-- Name: user; Type: INDEX; Schema: public; Owner: colinadler
--

CREATE UNIQUE INDEX "user" ON public.blacklist USING btree ("user");


--
-- Name: user_easter_egg; Type: INDEX; Schema: public; Owner: colinadler
--

CREATE UNIQUE INDEX user_easter_egg ON public.easter_eggs USING btree ("user", easter_egg);


--
-- Name: user_guild; Type: INDEX; Schema: public; Owner: colinadler
--

CREATE UNIQUE INDEX user_guild ON public.guild_rankings USING btree ("user", guild);


--
-- Name: user_guild_score; Type: INDEX; Schema: public; Owner: colinadler
--

CREATE INDEX user_guild_score ON public.guild_rankings USING btree ("user", guild, score);


--
-- Name: user_index; Type: INDEX; Schema: public; Owner: colinadler
--

CREATE INDEX user_index ON public.owned_items USING btree ("user");


--
-- Name: user_item; Type: INDEX; Schema: public; Owner: colinadler
--

CREATE INDEX user_item ON public.owned_items USING btree ("user", item);


--
-- Name: user_item_tier; Type: INDEX; Schema: public; Owner: colinadler
--

CREATE UNIQUE INDEX user_item_tier ON public.owned_items USING btree ("user", item, tier);


--
-- Name: user_score; Type: INDEX; Schema: public; Owner: colinadler
--

CREATE INDEX user_score ON public.global_rankings USING btree ("user", score);


--
-- PostgreSQL database dump complete
--

