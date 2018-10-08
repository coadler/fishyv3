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
-- Name: easter_egg_type; Type: TYPE; Schema: public; Owner: colin
--

CREATE TYPE public.easter_egg_type AS ENUM (
    'no_rod'
);


ALTER TYPE public.easter_egg_type OWNER TO colin;

--
-- Name: itemtype; Type: TYPE; Schema: public; Owner: colin
--

CREATE TYPE public.itemtype AS ENUM (
    'bait',
    'rod',
    'hook',
    'vehicle',
    'bait_box'
);


ALTER TYPE public.itemtype OWNER TO colin;

--
-- Name: location; Type: TYPE; Schema: public; Owner: colin
--

CREATE TYPE public.location AS ENUM (
    'lake',
    'river',
    'ocean'
);


ALTER TYPE public.location OWNER TO colin;

--
-- Name: timeofday; Type: TYPE; Schema: public; Owner: colin
--

CREATE TYPE public.timeofday AS ENUM (
    'both',
    'morning',
    'night'
);


ALTER TYPE public.timeofday OWNER TO colin;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bait_inventory; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.bait_inventory (
    "user" text NOT NULL,
    tier_1 integer NOT NULL,
    tier_2 integer NOT NULL,
    tier_3 integer NOT NULL,
    tier_4 integer NOT NULL,
    tier_5 integer NOT NULL,
    current integer DEFAULT 1 NOT NULL,
    gathering timestamp with time zone NOT NULL
);


ALTER TABLE public.bait_inventory OWNER TO colin;

--
-- Name: inventory; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.inventory (
    "user" text NOT NULL,
    fish integer NOT NULL,
    garbage integer NOT NULL,
    legendary integer NOT NULL,
    worth integer NOT NULL
);


ALTER TABLE public.inventory OWNER TO colin;

--
-- Name: bait_inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.bait_inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bait_inventory_id_seq OWNER TO colin;

--
-- Name: bait_inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.bait_inventory_id_seq OWNED BY public.inventory."user";


--
-- Name: blacklist; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.blacklist (
    id integer NOT NULL,
    "user" text NOT NULL
);


ALTER TABLE public.blacklist OWNER TO colin;

--
-- Name: blacklist_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.blacklist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blacklist_id_seq OWNER TO colin;

--
-- Name: blacklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.blacklist_id_seq OWNED BY public.blacklist.id;


--
-- Name: easter_eggs; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.easter_eggs (
    id integer NOT NULL,
    "user" text NOT NULL,
    easter_egg public.easter_egg_type NOT NULL,
    amt integer NOT NULL
);


ALTER TABLE public.easter_eggs OWNER TO colin;

--
-- Name: easter_eggs_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.easter_eggs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easter_eggs_id_seq OWNER TO colin;

--
-- Name: easter_eggs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.easter_eggs_id_seq OWNED BY public.easter_eggs.id;


--
-- Name: equipped_items; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.equipped_items (
    "user" text NOT NULL,
    bait integer NOT NULL,
    rod integer NOT NULL,
    hook integer NOT NULL,
    vehicle integer NOT NULL,
    bait_box integer NOT NULL
);


ALTER TABLE public.equipped_items OWNER TO colin;

--
-- Name: fish; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.fish (
    id integer NOT NULL,
    low integer NOT NULL,
    high integer NOT NULL,
    "time" public.timeofday NOT NULL,
    pun text NOT NULL,
    image text NOT NULL,
    location public.location NOT NULL,
    tier integer NOT NULL
);


ALTER TABLE public.fish OWNER TO colin;

--
-- Name: fish_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.fish_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.fish_id_seq OWNER TO colin;

--
-- Name: fish_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.fish_id_seq OWNED BY public.fish.id;


--
-- Name: garbage; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.garbage (
    id integer NOT NULL,
    text text NOT NULL,
    "user" text NOT NULL
);


ALTER TABLE public.garbage OWNER TO colin;

--
-- Name: garbage_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.garbage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.garbage_id_seq OWNER TO colin;

--
-- Name: garbage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.garbage_id_seq OWNED BY public.garbage.id;


--
-- Name: global_rankings; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.global_rankings (
    "user" text NOT NULL,
    score integer NOT NULL,
    garbage integer NOT NULL,
    fish integer NOT NULL,
    avg_length numeric NOT NULL,
    casts integer NOT NULL
);


ALTER TABLE public.global_rankings OWNER TO colin;

--
-- Name: global_rankings_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.global_rankings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.global_rankings_id_seq OWNER TO colin;

--
-- Name: global_rankings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.global_rankings_id_seq OWNED BY public.global_rankings."user";


--
-- Name: guild_rankings; Type: TABLE; Schema: public; Owner: colin
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


ALTER TABLE public.guild_rankings OWNER TO colin;

--
-- Name: guild_rankings_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.guild_rankings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guild_rankings_id_seq OWNER TO colin;

--
-- Name: guild_rankings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.guild_rankings_id_seq OWNED BY public.guild_rankings.id;


--
-- Name: items; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.items (
    id integer NOT NULL,
    type public.itemtype NOT NULL,
    tier integer NOT NULL,
    price integer NOT NULL,
    effect numeric NOT NULL,
    description text NOT NULL
);


ALTER TABLE public.items OWNER TO colin;

--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.items_id_seq OWNER TO colin;

--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.items_id_seq OWNED BY public.items.id;


--
-- Name: location_density; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.location_density (
    "user" text NOT NULL,
    lake integer NOT NULL,
    river integer NOT NULL,
    ocean integer NOT NULL,
    location public.location NOT NULL
);


ALTER TABLE public.location_density OWNER TO colin;

--
-- Name: owned_items; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.owned_items (
    "user" text NOT NULL,
    item public.itemtype NOT NULL,
    tier integer NOT NULL,
    id integer NOT NULL
);


ALTER TABLE public.owned_items OWNER TO colin;

--
-- Name: owned_items_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.owned_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.owned_items_id_seq OWNER TO colin;

--
-- Name: owned_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.owned_items_id_seq OWNED BY public.owned_items.id;


--
-- Name: blacklist id; Type: DEFAULT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.blacklist ALTER COLUMN id SET DEFAULT nextval('public.blacklist_id_seq'::regclass);


--
-- Name: easter_eggs id; Type: DEFAULT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.easter_eggs ALTER COLUMN id SET DEFAULT nextval('public.easter_eggs_id_seq'::regclass);


--
-- Name: fish id; Type: DEFAULT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.fish ALTER COLUMN id SET DEFAULT nextval('public.fish_id_seq'::regclass);


--
-- Name: garbage id; Type: DEFAULT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.garbage ALTER COLUMN id SET DEFAULT nextval('public.garbage_id_seq'::regclass);


--
-- Name: guild_rankings id; Type: DEFAULT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.guild_rankings ALTER COLUMN id SET DEFAULT nextval('public.guild_rankings_id_seq'::regclass);


--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.items ALTER COLUMN id SET DEFAULT nextval('public.items_id_seq'::regclass);


--
-- Name: owned_items id; Type: DEFAULT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.owned_items ALTER COLUMN id SET DEFAULT nextval('public.owned_items_id_seq'::regclass);


--
-- Data for Name: bait_inventory; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.bait_inventory ("user", tier_1, tier_2, tier_3, tier_4, tier_5, current, gathering) FROM stdin;
320896491596283906	0	0	0	0	0	1	2018-08-10 07:39:25.967822-04
\.


--
-- Data for Name: blacklist; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.blacklist (id, "user") FROM stdin;
0	105484726235607040
\.


--
-- Data for Name: easter_eggs; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.easter_eggs (id, "user", easter_egg, amt) FROM stdin;
\.


--
-- Data for Name: equipped_items; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.equipped_items ("user", bait, rod, hook, vehicle, bait_box) FROM stdin;
\.


--
-- Data for Name: fish; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.fish (id, low, high, "time", pun, image, location, tier) FROM stdin;
\.


--
-- Data for Name: garbage; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.garbage (id, text, "user") FROM stdin;
\.


--
-- Data for Name: global_rankings; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.global_rankings ("user", score, garbage, fish, avg_length, casts) FROM stdin;
\.


--
-- Data for Name: guild_rankings; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.guild_rankings (id, "user", guild, score, garbage, fish, casts, avg_length) FROM stdin;
1	7903651766574111723	320896491596283906	177	164	252	341	0
2	7903651766645297691	320896491596283906	414	387	5	122	0
3	7903651766682455611	320896491596283906	124	263	160	14	0
4	7903651766724877483	320896491596283906	31	20	202	306	0
5	7903651766791945275	320896491596283906	220	399	87	297	0
6	7903651766915412731	320896491596283906	180	429	35	316	0
7	7903651766978670075	320896491596283906	141	488	455	239	0
8	7903651767019456411	320896491596283906	52	120	349	332	0
9	7903651767077027579	320896491596283906	351	271	186	132	0
10	7903651767170877643	320896491596283906	299	105	411	337	0
11	7903651767198366571	320896491596283906	259	109	117	17	0
12	7903651767316963019	320896491596283906	267	349	54	13	0
13	7903651767354356347	320896491596283906	23	392	309	216	0
14	7903651767424262123	320896491596283906	471	361	48	287	0
15	7903651767466672139	320896491596283906	278	126	25	66	0
16	7903651767569282891	320896491596283906	370	315	30	196	0
17	7903651767597947147	320896491596283906	335	286	335	76	0
18	7903651767719287723	320896491596283906	403	102	287	394	0
19	7903651767757776299	320896491596283906	325	227	393	7	0
20	7903651767817430827	320896491596283906	430	112	261	125	0
21	7903652436599703963	320896491596283906	452	86	398	430	0
22	7903652436645505851	320896491596283906	93	473	484	109	0
23	7903652436676459355	320896491596283906	423	183	380	279	0
24	7903652436773345883	320896491596283906	465	6	20	289	0
25	7903652436829307275	320896491596283906	287	172	202	365	0
26	7903652436926730155	320896491596283906	221	495	118	305	0
27	7903652436997660075	320896491596283906	274	376	293	367	0
28	7903652437037505275	320896491596283906	386	69	434	409	0
29	7903652437091609915	320896491596283906	69	411	374	365	0
30	7903652437156424059	320896491596283906	274	136	471	242	0
31	7903652437235525051	320896491596283906	29	364	215	472	0
32	7903652437338128987	320896491596283906	138	492	448	123	0
33	7903652437407724219	320896491596283906	371	107	393	155	0
34	7903652437464623899	320896491596283906	315	170	371	91	0
35	7903652437527830171	320896491596283906	215	128	423	34	0
36	7903652437552461419	320896491596283906	7	154	133	307	0
37	7903652437674790267	320896491596283906	457	0	219	316	0
38	7903652437705869531	320896491596283906	484	0	114	301	0
39	7903652437798375579	320896491596283906	171	283	325	386	0
40	7903652437820128587	320896491596283906	160	276	407	157	0
41	7903652470960725051	320896491596283906	462	412	160	380	0
42	7903652471015113787	320896491596283906	70	283	368	12	0
43	7903652471082361883	320896491596283906	22	416	149	114	0
44	7903652471141766891	320896491596283906	241	109	494	128	0
45	7903652471208543483	320896491596283906	367	496	441	169	0
46	7903652471262669371	320896491596283906	438	425	163	190	0
47	7903652471318135227	320896491596283906	235	34	187	397	0
48	7903652471374426843	320896491596283906	297	99	239	253	0
49	7903652471490172267	320896491596283906	340	68	448	458	0
50	7903652471516571323	320896491596283906	392	27	249	150	0
51	7903652471628729723	320896491596283906	202	43	65	474	0
52	7903652471639110651	320896491596283906	46	50	325	252	0
53	7903652471710677243	320896491596283906	399	99	16	449	0
54	7903652471800392811	320896491596283906	18	455	26	285	0
55	7903652471854143851	320896491596283906	135	473	38	468	0
56	7903652471954702555	320896491596283906	8	263	187	416	0
57	7903652472009449707	320896491596283906	377	360	64	427	0
58	7903652472046479659	320896491596283906	445	284	143	309	0
59	7903652472114959403	320896491596283906	323	194	32	52	0
60	7903652472224054795	320896491596283906	26	484	363	366	0
61	7903652505296208459	320896491596283906	148	294	24	492	0
62	7903652505361576075	320896491596283906	465	157	400	302	0
63	7903652505396267259	320896491596283906	395	230	37	216	0
64	7903652505470622763	320896491596283906	257	240	402	466	0
65	7903652505586595371	320896491596283906	201	480	217	47	0
66	7903652505640886411	320896491596283906	16	357	219	114	0
67	7903652505698385035	320896491596283906	354	440	429	434	0
68	7903652505743349851	320896491596283906	385	77	468	146	0
69	7903652505809356331	320896491596283906	80	406	492	46	0
70	7903652505867538619	320896491596283906	136	193	311	227	0
71	7903652505987843579	320896491596283906	343	3	369	380	0
72	7903652505999636075	320896491596283906	112	154	45	311	0
73	7903652506112976251	320896491596283906	13	374	57	110	0
74	7903652506137488411	320896491596283906	31	222	289	190	0
75	7903652506260609019	320896491596283906	15	397	166	358	0
76	7903652506299573243	320896491596283906	132	413	104	252	0
77	7903652506344503227	320896491596283906	166	282	138	188	0
78	7903652506411054699	320896491596283906	400	219	101	150	0
79	7903652506520460299	320896491596283906	214	103	231	77	0
80	7903652506557465611	320896491596283906	101	191	427	86	0
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.inventory ("user", fish, garbage, legendary, worth) FROM stdin;
\.


--
-- Data for Name: items; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.items (id, type, tier, price, effect, description) FROM stdin;
\.


--
-- Data for Name: location_density; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.location_density ("user", lake, river, ocean, location) FROM stdin;
\.


--
-- Data for Name: owned_items; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.owned_items ("user", item, tier, id) FROM stdin;
105484726235607040	bait	0	0
122221539377676289	bait	0	1
320896491596283906	bait	0	5
\.


--
-- Name: bait_inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.bait_inventory_id_seq', 1, false);


--
-- Name: blacklist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.blacklist_id_seq', 7, true);


--
-- Name: easter_eggs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.easter_eggs_id_seq', 1, false);


--
-- Name: fish_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.fish_id_seq', 1, false);


--
-- Name: garbage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.garbage_id_seq', 1, false);


--
-- Name: global_rankings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.global_rankings_id_seq', 1, false);


--
-- Name: guild_rankings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.guild_rankings_id_seq', 80, true);


--
-- Name: items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.items_id_seq', 1, false);


--
-- Name: owned_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.owned_items_id_seq', 5, true);


--
-- Name: inventory bait_inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT bait_inventory_pkey PRIMARY KEY ("user");


--
-- Name: blacklist blacklist_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.blacklist
    ADD CONSTRAINT blacklist_pkey PRIMARY KEY (id);


--
-- Name: easter_eggs easter_eggs_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.easter_eggs
    ADD CONSTRAINT easter_eggs_pkey PRIMARY KEY (id);


--
-- Name: equipped_items equipped_items_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.equipped_items
    ADD CONSTRAINT equipped_items_pkey PRIMARY KEY ("user");


--
-- Name: fish fish_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.fish
    ADD CONSTRAINT fish_pkey PRIMARY KEY (id);


--
-- Name: garbage garbage_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.garbage
    ADD CONSTRAINT garbage_pkey PRIMARY KEY (id);


--
-- Name: global_rankings global_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.global_rankings
    ADD CONSTRAINT global_rankings_pkey PRIMARY KEY ("user");


--
-- Name: guild_rankings guild_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.guild_rankings
    ADD CONSTRAINT guild_rankings_pkey PRIMARY KEY (id);


--
-- Name: bait_inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.bait_inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY ("user");


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: location_density location_density_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.location_density
    ADD CONSTRAINT location_density_pkey PRIMARY KEY ("user");


--
-- Name: owned_items owned_items_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.owned_items
    ADD CONSTRAINT owned_items_pkey PRIMARY KEY (id);


--
-- Name: user; Type: INDEX; Schema: public; Owner: colin
--

CREATE UNIQUE INDEX "user" ON public.blacklist USING btree ("user");


--
-- Name: user_easter_egg; Type: INDEX; Schema: public; Owner: colin
--

CREATE UNIQUE INDEX user_easter_egg ON public.easter_eggs USING btree ("user", easter_egg);


--
-- Name: user_guild; Type: INDEX; Schema: public; Owner: colin
--

CREATE UNIQUE INDEX user_guild ON public.guild_rankings USING btree ("user", guild);


--
-- Name: user_guild_score; Type: INDEX; Schema: public; Owner: colin
--

CREATE INDEX user_guild_score ON public.guild_rankings USING btree ("user", guild, score);


--
-- Name: user_index; Type: INDEX; Schema: public; Owner: colin
--

CREATE INDEX user_index ON public.owned_items USING btree ("user");


--
-- Name: user_item; Type: INDEX; Schema: public; Owner: colin
--

CREATE INDEX user_item ON public.owned_items USING btree ("user", item);


--
-- Name: user_item_tier; Type: INDEX; Schema: public; Owner: colin
--

CREATE UNIQUE INDEX user_item_tier ON public.owned_items USING btree ("user", item, tier);


--
-- Name: user_score; Type: INDEX; Schema: public; Owner: colin
--

CREATE INDEX user_score ON public.global_rankings USING btree ("user", score);


--
-- PostgreSQL database dump complete
--

