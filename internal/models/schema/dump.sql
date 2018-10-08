--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

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
    'no_rod',
    'no_hook'
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
-- Name: easter_egg_strings; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.easter_egg_strings (
    id integer NOT NULL,
    data text NOT NULL,
    "order" integer NOT NULL,
    type public.easter_egg_type NOT NULL
);


ALTER TABLE public.easter_egg_strings OWNER TO colin;

--
-- Name: easter_egg_strings_id_seq; Type: SEQUENCE; Schema: public; Owner: colin
--

CREATE SEQUENCE public.easter_egg_strings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.easter_egg_strings_id_seq OWNER TO colin;

--
-- Name: easter_egg_strings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: colin
--

ALTER SEQUENCE public.easter_egg_strings_id_seq OWNED BY public.easter_egg_strings.id;


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
    tier integer NOT NULL,
    name text DEFAULT ''::text NOT NULL
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
-- Name: tiers; Type: TABLE; Schema: public; Owner: colin
--

CREATE TABLE public.tiers (
    tier integer NOT NULL,
    required integer NOT NULL
);


ALTER TABLE public.tiers OWNER TO colin;

--
-- Name: blacklist id; Type: DEFAULT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.blacklist ALTER COLUMN id SET DEFAULT nextval('public.blacklist_id_seq'::regclass);


--
-- Name: easter_egg_strings id; Type: DEFAULT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.easter_egg_strings ALTER COLUMN id SET DEFAULT nextval('public.easter_egg_strings_id_seq'::regclass);


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
320896491596283906	0	0	0	0	0	1	2018-08-10 06:39:25.967822-05
\.


--
-- Data for Name: blacklist; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.blacklist (id, "user") FROM stdin;
0	105484726235607040
\.


--
-- Data for Name: easter_egg_strings; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.easter_egg_strings (id, data, "order", type) FROM stdin;
1	You pretend to fish with an imaginary fishing rod\nThe other fishermen look at you in disgust. (*maybe you should buy a fishing rod*)	0	no_rod
2	Your determination to catch a fish with your imaginary fishing rod starts to draw a crowd.\nWill you triumph?	1	no_rod
3	The crowd begins to disperse, but your determination is higher than ever.	2	no_rod
4	An old fisherman approaches you, and hands you a fishing rod and hook with great pity. *was this your plan all along?*\nYou gain a tier 1 rod and hook. Good job.	3	no_rod
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

COPY public.fish (id, low, high, "time", pun, image, location, tier, name) FROM stdin;
39	2	9	both	Maybe you'll put it in a chili dish!	https://cdn.discordapp.com/attachments/288505799905378304/322970149395365888/Killifish.png	lake	1	Killifish
40	3	10	night	I'm sure it will grow on you.	https://cdn.discordapp.com/attachments/288505799905378304/322970325463728138/Tadpole_HHD_Icon.png	lake	1	Tadpole
41	6	15	morning	Watch those pinchers!	https://cdn.discordapp.com/attachments/288505799905378304/322970086220627968/Crawfish_HHD_Icon.png	lake	1	Crawfish
42	14	33	both	It looks happy to see you!	https://cdn.discordapp.com/attachments/288505799905378304/322970062443249665/Chub_HHD_Icon.png	lake	1	Chub
43	15	25	both	It could sure use a bath!	https://cdn.discordapp.com/attachments/288505799905378304/322970227476267010/Pond_Smelt_HHD_Icon.png	lake	1	Pond Smelt
44	10	15	night	Hop to it, froggie!	https://cdn.discordapp.com/attachments/288505799905378304/322970118764363776/Frog_HHD_Icon.png	lake	2	Frog
45	16	30	morning	I thought we were catching fish...	https://cdn.discordapp.com/attachments/288505799905378304/325397737409347585/Bullhead_HHD_Icon.png	lake	2	Bullhead
46	32	70	both	You really seized the diem!	https://cdn.discordapp.com/attachments/288505799905378304/322970373073403904/Carp_HHD_Icon.png	lake	2	Carp
47	22	69	both	Now You just need a small bass amp	https://cdn.discordapp.com/attachments/288505799905378304/325397730207727616/Smallmouth_Bass_HHD_Icon.png	lake	2	Smallmouth Bass
48	100	160	both	Do you think it has 9 lives?	https://cdn.discordapp.com/attachments/288505799905378304/322973264982966272/Catfish_HHD_Icon.png	lake	3	Catfish
49	35	61	morning	Well, it's pretty big...I guess...	https://cdn.discordapp.com/attachments/288505799905378304/322970157079330816/Largemouth_Bass_HHD_Icon.png	lake	3	Largemouth Bass
50	10	25	both	Well, it's pretty big...I guess...	https://cdn.discordapp.com/attachments/288505799905378304/325396865027801089/Perch_HHD_Icon.png	lake	3	Perch
51	30	51	night	LGBT friendly	https://cdn.discordapp.com/attachments/288505799905378304/322973486001684480/Rainbow_Trout_HHD_Icon.png	lake	3	Rainbow Trout
52	210	370	morning	Caught with Sturgical precision	https://cdn.discordapp.com/attachments/288505799905378304/322975606977462274/unknown.png	lake	4	Sturgeon
53	50	91	night	Can you spot him?	https://cdn.discordapp.com/attachments/288505799905378304/325396770156969996/Walleye_HHD_Icon.png	lake	4	Walleye
54	76	140	both	A syntactician in principle, and parameter.	https://cdn.discordapp.com/attachments/288505799905378304/322975606977462274/unknown.png	lake	4	Lingcod
55	6	9	both	Bar!	https://cdn.discordapp.com/attachments/288505799905378304/322975606977462274/unknown.png	lake	5	Foo
56	122	152	morning	But where's the rest of the snake?	https://cdn.discordapp.com/attachments/288505799905378304/322970127874129920/Giant_Snakehead_HHD_Icon.png	lake	5	Giant Snakehead
57	152	213	night	It ain't gettin' too far!	https://cdn.discordapp.com/attachments/288505799905378304/322970123663179777/Gar_HHD_Icon.png	lake	5	Gar
58	5	9	both	What's it so bitter about?	https://cdn.discordapp.com/attachments/288505799905378304/322970349786365952/Bitterling_HHD_Icon.png	river	1	Bitterling
59	5	15	night	You fresh, goby!	https://cdn.discordapp.com/attachments/288505799905378304/322970113567621121/Freshwater_Goby_HHD_Icon.png	river	1	Freshwater Goby
60	15	40	both	What a crucial catch!	https://cdn.discordapp.com/attachments/288505799905378304/322970089693511680/Crucian_Carp_HHD_Icon.png	river	1	Crucian Carp
61	10	40	morning	There's a lot in this ville!	https://cdn.discordapp.com/attachments/288505799905378304/322970365011689472/Bluegill_HHD_Icon.png	river	1	Bluegill
62	10	30	both	I wonder if birds usually stand on it?	https://cdn.discordapp.com/attachments/288505799905378304/322970338306686977/Yellow_Perch_HHD_Icon.png	river	1	Yellow Perch
63	2	5	morning	Wow, that's far out, man!	https://cdn.discordapp.com/attachments/288505799905378304/322970173743169546/Neon_Tetra_HHD_Icon.png	river	1	Neon Tetra
64	25	110	night	It just needs a barbel saddle!	https://cdn.discordapp.com/attachments/288505799905378304/322969936915857409/Barbel_Steed_HHD_Icon.png	river	1	Barbel Steed
65	10	21	morning	It should have eaten its spinach!	https://cdn.discordapp.com/attachments/288505799905378304/322970236741615616/Popeyed_Goldfish_HHD_Icon.png	river	2	Popeyed Goldfish
66	2	8	morning	You gotta show off this puppy!	https://cdn.discordapp.com/attachments/288505799905378304/322970137311576067/Guppy_HHD_Icon.png	river	2	Guppy
67	9	30	night	I'm smitten, crab!	https://cdn.discordapp.com/attachments/288505799905378304/322970160954867724/Mitten_Crab_HHD_Icon.png	river	2	Mitten Crab
68	38	76	night	Things just got REAL!	https://cdn.discordapp.com/attachments/288505799905378304/322970102926540800/Eel_HHD_Icon.png	river	2	Eel
69	15	31	both	Is that a lollipop in it's mouth?	https://cdn.discordapp.com/attachments/288505799905378304/322970321059708928/Sweetfish_HHD_Icon.png	river	2	Sweetfish
70	64	86	both	Oh, that's slammin'!	https://cdn.discordapp.com/attachments/288505799905378304/322970265862668318/Salmon_HHD_Icon.png	river	2	Salmon
71	33	122	morning	Spearfishing anyone?	https://cdn.discordapp.com/attachments/288505799905378304/322970188842795008/Pike_HHD_Icon.png	river	3	Pike
72	5	18	night	Now where's its harp?	https://cdn.discordapp.com/attachments/288505799905378304/322969564902064139/Angelfish_HHD_Icon.png	river	3	Angelfish
73	25	46	both	You can really shell it out!	https://cdn.discordapp.com/attachments/288505799905378304/322970299421294594/Soft-Shelled_Turtle_HHD_Icon.png	river	3	Soft-Shelled Turtle
74	12	36	both	Or did it catch YOU?!	https://cdn.discordapp.com/attachments/288505799905378304/322970205275815937/Piranha_HHD_Icon.png	river	3	Piranha
75	38	76	night	You remove the saddle...	https://cdn.discordapp.com/attachments/288505799905378304/322970259042598912/Saddled_Bichir_HHD_Icon.png	river	4	Saddled Bichir
76	50	70	both	Can't play koi with you!	https://cdn.discordapp.com/attachments/288505799905378304/322970153065250817/Koi_HHD_Icon.png	river	4	Koi
77	25	38	morning	Did you just hear a meow?	https://cdn.discordapp.com/attachments/288505799905378304/322975606977462274/unknown.png	river	4	Tiger Trout
78	76	127	night	But where's its bow?	https://cdn.discordapp.com/attachments/288505799905378304/322969890669723658/Arowana_HHD_Icon.png	river	5	Arowana
79	85	140	morning	You should make that your motto!	https://cdn.discordapp.com/attachments/288505799905378304/322970097843175426/Dorado_HHD_Icon.png	river	5	Dorado
80	256	325	night	And it looks like it's in its prime-a!	https://cdn.discordapp.com/attachments/288505799905378304/322969795043655680/Arapaima_HHD_Icon.png	river	5	Arapaima
81	130	190	morning	Your theory really paid off!	https://cdn.discordapp.com/attachments/288505799905378304/322970310938853379/Stringfish_HHD_Icon.png	river	5	Stringfish
82	15	55	both	That's no horse...	https://cdn.discordapp.com/attachments/288505799905378304/322970144945209344/Horse_Mackerel_HHD_Icon.png	ocean	1	Horse Mackerel
83	24	43	both	Favorite fish of American football players, hip-hop artists, and prepubescents everywhere.	https://cdn.discordapp.com/attachments/288505799905378304/322970094164770816/Dab_HHD_Icon.png	ocean	1	Dab
84	50	74	both	Yes, you did!	https://cdn.discordapp.com/attachments/288505799905378304/322970304856981506/Squid_HHD_Icon.png	ocean	1	Squid
85	26	61	morning	And that's not just hot air!	https://cdn.discordapp.com/attachments/288505799905378304/322970355125977088/Blowfish_HHD_Icon.png	ocean	1	Blowfish
86	20	43	night	What are you? Make up your mind!	https://cdn.discordapp.com/attachments/288505799905378304/322970344509931521/Zebra_Turkeyfish_HHD_Icon.png	ocean	1	Zebra Turkeyfish
87	38	61	both	What?! You again?!	https://cdn.discordapp.com/attachments/288505799905378304/322970277560582144/Sea_Bass_HHD_Icon.png	ocean	1	Sea Bass
88	5	13	both	Who's laughing now?	https://cdn.discordapp.com/attachments/288505799905378304/322970068793294851/Clownfish_HHD_Icon.png	ocean	2	Clownfish
89	1	2	morning	You didn't even use a net!	https://cdn.discordapp.com/attachments/288505799905378304/322970282878959626/Sea_Butterfly_HHD_Icon_1.png	ocean	2	Sea Butterfly
90	18	35	both	You meant to, of course!	https://cdn.discordapp.com/attachments/288505799905378304/322970293389754378/Sea_Horse_HHD_Icon.png	ocean	2	Seahorse
91	22	33	night	It was a simple operation, though!	https://cdn.discordapp.com/attachments/288505799905378304/322970315560976385/Surgeonfish_HHD_Icon.png	ocean	2	Surgeonfish
92	10	22	both	Keep flying, fishy!	https://cdn.discordapp.com/attachments/288505799905378304/322970369168506883/Butterflyfish_HHD_Icon.png	ocean	2	Butterfly Fish
93	76	127	both	In a romantic relationship with the Popeyed Goldfish.	https://cdn.discordapp.com/attachments/288505799905378304/322970185046949890/Olive_Flounder_HHD_Icon.png	ocean	2	Olive Flounder
94	55	102	both	You just snapped it up!	https://cdn.discordapp.com/attachments/288505799905378304/322970251786584064/Red_Snapper_HHD_Icon.png	ocean	3	Red Snapper
95	56	82	both	You'll have to use it to cut veggies!	https://cdn.discordapp.com/attachments/288505799905378304/322969944331517954/Barred_Knifejaw_HHD_Icon.png	ocean	3	Barred Knifejaw
96	50	78	night	Thanks to your fishing tackle!	https://cdn.discordapp.com/attachments/288505799905378304/322970108064694273/Football_Fish_HHD_Icon.png	ocean	3	Football Fish
97	85	189	both	No way! Deal!	https://cdn.discordapp.com/attachments/288505799905378304/322970165094514689/Moray_Eel_HHD_Icon.png	ocean	3	Moray Eel
98	370	475	morning	And now it's stuck in my head!	https://cdn.discordapp.com/attachments/288505799905378304/322970332413689866/Tuna_HHD_Icon.png	ocean	3	Tuna
99	150	199	night	My day is brighter already!	https://cdn.discordapp.com/attachments/288505799905378304/322970181271945217/Ocean_Sunfish_HHD_Icon.png	ocean	3	Ocean Sunfish
100	1000	1420	both	Good, you needed a paddle!	https://cdn.discordapp.com/attachments/288505799905378304/322970177408991244/Oarfish_HHD_Icon.png	ocean	4	Oarfish
101	340	678	morning	That made my day!	https://cdn.discordapp.com/attachments/288505799905378304/322970244366860289/Ray_HHD_Icon.png	ocean	4	Ray
102	300	427	both	What a true darlin'!	https://cdn.discordapp.com/attachments/288505799905378304/322970359026679811/Blue_Marlin_HHD_Icon.png	ocean	4	Blue Marlin
103	80	200	night	Vive la me!	https://cdn.discordapp.com/attachments/288505799905378304/322970169548996618/Napoleonfish_HHD_Icon.png	ocean	4	Napoleanfish
104	180	246	night	Am I saying it right?	https://cdn.discordapp.com/attachments/288505799905378304/322970082231975938/Coelacanth_HHD_Icon.png	ocean	5	Coelcanth
105	542	675	morning	You really nailed it!	https://cdn.discordapp.com/attachments/288505799905378304/322970141589635073/Hammerhead_Shark_HHD_Icon.png	ocean	5	Hammerhead Shark
106	457	640	night	You’re going to need a bigger boat...	https://cdn.discordapp.com/attachments/288505799905378304/322970132341063682/Great_White_Shark_HHD_Icon.png	ocean	5	Great White Shark
107	145	199	morning	And yet it didn't see you coming!	https://cdn.discordapp.com/attachments/288505799905378304/322970271705202688/Saw_Shark_HHD_Icon.png	ocean	5	Saw Shark
\.


--
-- Data for Name: garbage; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.garbage (id, text, "user") FROM stdin;
1	an old left boot.	ode
2	an old (but somehow dry) right boot.	ode
3	a stick carved into a point.	ode
4	a vaguely human-shaped tangle of grass.	ode
5	a waterlogged copy of E.T. for the Atari 2600.	Esja
6	a soaked copy of "Fishing for Dummies".	Esja
7	Saitama's swim trunks.	Esja
8	a broken GoPro.	Esja
9	your personal demons.	Esja
10	some *very* soggy noodles.	Esja
11	a perfectly functional Nokia phone.	Esja
12	an empty bottle of Abraxo Industrial Grade Cleaner.	ode
13	a ballpoint pen that doesn't open.	ode
14	an old rusted bonesaw.	ode
15	a perfectly spherical rock. How did you even catch that?	ode
16	a deflated football.	Esja
17	green eggs as well as ham.	Esja
18	an unusual amount of WD40.	Esja
19	an extended cut DVD of The Love Guru.	Esja
20	Bill O'Reily's career.	Esja
21	a fidget spinner that doesn't spin anymore.	ode
22	a bucket of what looks and feels like spent uranium fuel rods.	ode
23	a broken Mr. Meeseeks box.	unknown
24	a piece of cardboard that has a face sharpied on it.	ode
25	a fish disguised as garbage disguised as fish disguised as garbage.	Esja
26	a mystical, glowing drop of water hanging on to the end of your hook.	unknown
27	the inspiration to keep fishing. Go get em champ!	Esja
28	a picture shipping thy and ode.	unknown
29	a copy of Love Live on Blueray.	ode
30	a 1GB flashdrive with the Sword Art Online opening on it.	Weeajew
31	an empty garbage bag with the letters 'B-I-N-S-E-E' written on it in silver sharpie	ode
32	a chicken plushy with a name tag that says 'David'.	Scarletto
33	IT'S A HAND!!! Oh, it's just a rubber one.	Scarletto
34	We Are Number One, but it's wet.	Scarletto
35	a voucher for 10,000 credits. You throw it away, since you're really here for the passion of fishing.	Esja
36	like thirty cats.	Esja
37	a broken disk for Half-Life 3.	Rick
38	a cuet tomatoe.	Kinoe
39	a bag of soggy Cheetos. Don't try to eat that.	Silver Blues
40	a sock bunched up inside a sock bunched up inside a sock...	Silver Blues
41	half a bathtub. At least it's the half with the faucet...	Silver Blues
42	a bottle with a message inside...	Rick
43	someone's diary. They'd be glad you can't read its drenched pages.	Silver Blues
44	a rainbow afro wig. Perhaps you can still wear it?	Silver Blues
45	a slightly worse fishing pole.	Esja
46	the American judicial system.	Esja
47	a Club Penguin membership card.	Esja
48	a 4 Strength, 4 Stam leather belt!	unknown
49	a penny from the year you were born!	Rick
50	a penny not from the year you were born. :(	Esja
51	something that resembles Pandora's Jar	Rick
52	a very tiny fisherman.	Esja
53	someone else's fishing net.  Oops.	Esja
54	a professional League of Legends team.	Esja
55	a used copy of Windows ME.	Esja
56	the stuff they use to pixelate hentai.	Esja
57	a USB with 'Virus' written on it. Install now?	Rick
58	someone else's grocery list.	Rick
59	an unopened poptart.	Rick
60	an English to Chinese dictionary.	Esja
61	a statuette of a pink cow	Esja
62	a popped floatie ring.	Rick
63	an old Blockbuster card.	Esja
64	[ERROR -- FISH NOT FOUND]	Esja
65	a ticket to a lakers game.	Rick
66	404 FISH NOT FOUND	Rick
67	some broken piano keys.	Rick
68	a list of rejected garbage ideas.	Esja
69	a gooey wad of JuicyFruit.	Esja
70	some kind of meta BS.	Rick
71	an arrow to the knee.	Esja
72	a baseball some kid hit towards you.  Lucky!	Esja
73	a half-eaten Mars Bars.	Rick
74	a plan for World Domination scribbled on a napkin.	Rick
75	the flu.  Unfortunate. :(	Esja
76	nothing.  We're all very disappointed.	Esja
77	a whip. Wonder what it was used for?	Rick
78	a dark matter fish.  It cancels out the other fish you would have caught.	Esja
79	a paper clip, now your papers will be more organized.	Gatete
80	a pair of headphones. You can hear the sound of the waves with it on!	Silver Blues
81	a carpet. It might be a magical flying one, who knows...	Silver Blues
82	te amasing gramar som peepol hab	Scarletto
83	a rubber duck. Not a fish, but a duck!	Silver Blues
84	a broken fishing rod. At least you still have yours.	xaanit
85	a clock, could the time still be right?	xaanit
86	a snorkel. Let's hope it's not still needed.	xaanit
87	a camera. What pictures could be on it?	xaanit
88	a swimsuit, who could have lost it?	xaanit
89	a bouquet of flowers. A fishy secret admirer?	Silver Blues
90	a stop sign. That won't stop you, though.	Silver Blues
91	a lamp shade. Wear it on your head to fish.	Silver Blues
92	a cloth hanger. It matches your hook!	Silver Blues
93	a glowstick. Either the fish were scared, or having finny fun...	Silver Blues
94	something repugnant from Davy Jones' Locker.	Draxx
95	a busted pair of ear-buds.	TheDarkMysteryMan
96	a piano key. Hopefully the rest of the piano isn't down there.	Silver Blues
97	your car keys, what where they doing here?	nitrome
98	a pair of broken sunglasses.	TheDarkMysteryMan
99	a necklace made of bottle caps. It's actually pretty.	Silver Blues
100	an entire body pillow. You wonder if it is still usable...	Silver Blues
101	a way to find fish in the json based on time	ode
102	my eye. Not my fault you're always so sexy!	saksophoneee
103	some candy wrapped in clingfilm.. safe to eat?	Rick
104	a pair of pants. ...Oops?	Silver Blues
105	a perfume bottle. This is where they get the "ocean" fragrance.	Silver Blues
106	golang	ode
107	Pineapple Pizza	Zeniate
108	a bag of air. Smells fresh!	Nico
109	error #231. Your PC will shut down shortly.	Nico
110	a backdoor trojan. We can see you...	Nico
111	a new dimension! Oh wait no that's just a shard of glass.	Nico
112	A 199/200 *pro genji* that needs healing.	Zeniate
113	a book of the worst fanfiction you've ever read.	ViKomprenas
114	a goose by mistake! RUN AWAY.	Silver Blues
115	a guide titled "How to catch rarefish", too bad the water found it first.	Izuna Neko
116	a pillow, but the fish don't want to sleep with you.	Izuna Neko
117	a botter's guide to getting banned.	Izuna Neko
118	an honest man's guide to getting rich. It says "stay honest".	Izuna Neko
119	a one line if-statement.	ode
120	a magikarp. it used splash and got away.	Izuna Neko
121	an old, empty chest that's falling apart from years underwater.	Saederup
122	Memedog. You suddenly understand how polluted this river is.	deatcoca
123	a broken pokeball.	deatcoca
124	a torned up Pokemon card.The name of the pokemon has long since disappeared.	deatcoca
125	a master bait. Oh no! It's broken.	deatcoca
126	a can of Surströmming.	deatcoca
127	a banne.	deatcoca
128	dead memes.	Saederup
129	a dry seastar and a used sponge.	Saederup
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
6	bait	1	10	0	
7	bait	2	25	0.05	
8	bait	3	50	0.1	
9	bait	4	75	0.2	
10	bait	5	100	0.3	
11	rod	1	500	0	The storeowner looks at you with pity. He walks over to a closet and rummages around for a bit. He comes back with a standard wooden fishing rod. It seems a bit beaten up, but it'll get the job done.
12	rod	2	5000	0.05	One of the new fiberglass rods displayed on the shelf behind the storeowner. It's a slightly stronger and sturdier rod that seems like it will be able to handle some of the bigger fish.
13	rod	3	10000	0.1	A rod kept inside a glass case. It's seems like it's made almost entierly out of carbon fiber and nearly unbreakable. Surely well worth the price.
14	rod	4	25000	0.2	The storeowner looks at you for a long moment before reaching underneath the counter and pulling out a silvery-metal fishing rod. It seems out place being lit by the dingy yellow lamp above the counter. As it catches the light you can feel a certain radiance coming off of the cool metal surface.
15	rod	5	50000	0.3	The storeowner seems like he doesn't hear you ask to see the new fishing rod. It's not until the last customer leaves before he motions you behind the counter. He leads you back into a room that has a faint purple glow in the center of an otherwise pitch black room. He turns on the light, but it makes little difference. Whatever is in the center of this room is absorbing all of the light...
16	hook	1	100	0	A simple curved piece of metal with a pointy side. That's about all it needs to be, right?
17	hook	2	1000	0.1	Three times the pointy sides, three times the catching power! (Disclaimer, not actually 3x)
18	hook	3	2500	0.2	The fish would probably love the little feathery bits!
19	hook	4	5000	0.3	
20	hook	4	5000	0	
21	hook	5	10000	0.4	
22	vehicle	2	1000	50	Three times the pointy sides, three times the catching power! (Disclaimer, not actually 3x)
23	vehicle	3	5000	100	The fish would probably love the little feathery bits!
24	vehicle	4	15000	250	
25	vehicle	5	100000	500	
26	bait_box	1	100	25	
27	bait_box	2	500	50	
28	bait_box	3	1000	75	
29	bait_box	4	2500	100	
30	bait_box	5	5000	150	
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
-- Data for Name: tiers; Type: TABLE DATA; Schema: public; Owner: colin
--

COPY public.tiers (tier, required) FROM stdin;
1	0
2	50
3	250
4	1000
5	5000
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
-- Name: easter_egg_strings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.easter_egg_strings_id_seq', 4, true);


--
-- Name: easter_eggs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.easter_eggs_id_seq', 1, false);


--
-- Name: fish_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.fish_id_seq', 107, true);


--
-- Name: garbage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: colin
--

SELECT pg_catalog.setval('public.garbage_id_seq', 129, true);


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

SELECT pg_catalog.setval('public.items_id_seq', 30, true);


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
-- Name: easter_egg_strings easter_egg_strings_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.easter_egg_strings
    ADD CONSTRAINT easter_egg_strings_pkey PRIMARY KEY (id);


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
-- Name: tiers tiers_pkey; Type: CONSTRAINT; Schema: public; Owner: colin
--

ALTER TABLE ONLY public.tiers
    ADD CONSTRAINT tiers_pkey PRIMARY KEY (tier);


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

