--
-- PostgreSQL database dump
--

\restrict 9OOGhAHhNn1SZ40HrXLPf3Qgf98knIfAWjheBr5py8NR6x4zY3Zv0HuSkKRLXBl

-- Dumped from database version 16.11 (Debian 16.11-1.pgdg13+1)
-- Dumped by pg_dump version 16.11 (Debian 16.11-1.pgdg13+1)

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

SET default_table_access_method = heap;

--
-- Name: augment_materials; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.augment_materials (
    id integer NOT NULL,
    augment_id integer NOT NULL,
    material_id integer NOT NULL,
    quantity integer NOT NULL,
    reveal_order integer NOT NULL
);


ALTER TABLE public.augment_materials OWNER TO arcidle;

--
-- Name: augment_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.augment_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.augment_materials_id_seq OWNER TO arcidle;

--
-- Name: augment_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.augment_materials_id_seq OWNED BY public.augment_materials.id;


--
-- Name: augment_shields; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.augment_shields (
    id integer NOT NULL,
    augment_id integer NOT NULL,
    shield_id integer NOT NULL
);


ALTER TABLE public.augment_shields OWNER TO arcidle;

--
-- Name: augment_shields_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.augment_shields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.augment_shields_id_seq OWNER TO arcidle;

--
-- Name: augment_shields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.augment_shields_id_seq OWNED BY public.augment_shields.id;


--
-- Name: augments; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.augments (
    id integer NOT NULL,
    slug character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    rarity character varying(20) NOT NULL,
    image character varying(200),
    hq_image character varying(200),
    craftable boolean
);


ALTER TABLE public.augments OWNER TO arcidle;

--
-- Name: augments_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.augments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.augments_id_seq OWNER TO arcidle;

--
-- Name: augments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.augments_id_seq OWNED BY public.augments.id;


--
-- Name: blueprint_materials; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.blueprint_materials (
    id integer NOT NULL,
    blueprint_id integer NOT NULL,
    material_id integer NOT NULL,
    quantity integer NOT NULL,
    reveal_order integer NOT NULL
);


ALTER TABLE public.blueprint_materials OWNER TO arcidle;

--
-- Name: blueprint_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.blueprint_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blueprint_materials_id_seq OWNER TO arcidle;

--
-- Name: blueprint_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.blueprint_materials_id_seq OWNED BY public.blueprint_materials.id;


--
-- Name: blueprints; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.blueprints (
    id integer NOT NULL,
    slug character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    rarity character varying(20) NOT NULL,
    image character varying(200),
    hq_image character varying(200)
);


ALTER TABLE public.blueprints OWNER TO arcidle;

--
-- Name: blueprints_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.blueprints_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blueprints_id_seq OWNER TO arcidle;

--
-- Name: blueprints_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.blueprints_id_seq OWNED BY public.blueprints.id;


--
-- Name: daily_completions; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.daily_completions (
    id integer NOT NULL,
    date date NOT NULL,
    mode character varying(20) NOT NULL,
    player_id character varying(64) NOT NULL,
    attempts integer NOT NULL,
    completed_at timestamp without time zone
);


ALTER TABLE public.daily_completions OWNER TO arcidle;

--
-- Name: daily_completions_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.daily_completions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.daily_completions_id_seq OWNER TO arcidle;

--
-- Name: daily_completions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.daily_completions_id_seq OWNED BY public.daily_completions.id;


--
-- Name: daily_guesses; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.daily_guesses (
    id integer NOT NULL,
    date date NOT NULL,
    mode character varying(20) NOT NULL,
    guessed_slug character varying(100) NOT NULL,
    guessed_at timestamp without time zone
);


ALTER TABLE public.daily_guesses OWNER TO arcidle;

--
-- Name: daily_guesses_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.daily_guesses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.daily_guesses_id_seq OWNER TO arcidle;

--
-- Name: daily_guesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.daily_guesses_id_seq OWNED BY public.daily_guesses.id;


--
-- Name: favorite_votes; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.favorite_votes (
    id integer NOT NULL,
    date date NOT NULL,
    category character varying(30) NOT NULL,
    favorite_slug character varying(100) NOT NULL,
    player_id character varying(64) NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.favorite_votes OWNER TO arcidle;

--
-- Name: favorite_votes_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.favorite_votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favorite_votes_id_seq OWNER TO arcidle;

--
-- Name: favorite_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.favorite_votes_id_seq OWNED BY public.favorite_votes.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.locations (
    id integer NOT NULL,
    slug character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    image character varying(200),
    region character varying(100)
);


ALTER TABLE public.locations OWNER TO arcidle;

--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.locations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.locations_id_seq OWNER TO arcidle;

--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: materials; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.materials (
    id integer NOT NULL,
    slug character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    rarity character varying(20) NOT NULL,
    image character varying(200)
);


ALTER TABLE public.materials OWNER TO arcidle;

--
-- Name: materials_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.materials_id_seq OWNER TO arcidle;

--
-- Name: materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.materials_id_seq OWNED BY public.materials.id;


--
-- Name: run_plays; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.run_plays (
    id integer NOT NULL,
    player_id character varying(64) NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.run_plays OWNER TO arcidle;

--
-- Name: run_plays_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.run_plays_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.run_plays_id_seq OWNER TO arcidle;

--
-- Name: run_plays_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.run_plays_id_seq OWNED BY public.run_plays.id;


--
-- Name: run_scores; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.run_scores (
    id integer NOT NULL,
    nickname character varying(64) NOT NULL,
    score integer NOT NULL,
    player_id character varying(64),
    created_at timestamp without time zone
);


ALTER TABLE public.run_scores OWNER TO arcidle;

--
-- Name: run_scores_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.run_scores_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.run_scores_id_seq OWNER TO arcidle;

--
-- Name: run_scores_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.run_scores_id_seq OWNED BY public.run_scores.id;


--
-- Name: shield_materials; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.shield_materials (
    id integer NOT NULL,
    shield_id integer NOT NULL,
    material_id integer NOT NULL,
    quantity integer NOT NULL,
    reveal_order integer NOT NULL
);


ALTER TABLE public.shield_materials OWNER TO arcidle;

--
-- Name: shield_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.shield_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shield_materials_id_seq OWNER TO arcidle;

--
-- Name: shield_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.shield_materials_id_seq OWNED BY public.shield_materials.id;


--
-- Name: shields; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.shields (
    id integer NOT NULL,
    slug character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    rarity character varying(20) NOT NULL,
    image character varying(200),
    hq_image character varying(200)
);


ALTER TABLE public.shields OWNER TO arcidle;

--
-- Name: shields_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.shields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shields_id_seq OWNER TO arcidle;

--
-- Name: shields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.shields_id_seq OWNED BY public.shields.id;


--
-- Name: skills; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.skills (
    id integer NOT NULL,
    skill_id character varying(20) NOT NULL,
    name_en character varying(100) NOT NULL,
    name_ru character varying(100) NOT NULL,
    description_en character varying(500) NOT NULL,
    description_ru character varying(500) NOT NULL,
    category character varying(20) NOT NULL,
    position_x double precision NOT NULL,
    position_y double precision NOT NULL,
    prerequisites character varying(200),
    is_major boolean
);


ALTER TABLE public.skills OWNER TO arcidle;

--
-- Name: skills_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.skills_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.skills_id_seq OWNER TO arcidle;

--
-- Name: skills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.skills_id_seq OWNED BY public.skills.id;


--
-- Name: sounds; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.sounds (
    id integer NOT NULL,
    slug character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    category character varying(50) NOT NULL,
    sound_file character varying(200) NOT NULL,
    image character varying(200),
    hq_image character varying(200)
);


ALTER TABLE public.sounds OWNER TO arcidle;

--
-- Name: sounds_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.sounds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sounds_id_seq OWNER TO arcidle;

--
-- Name: sounds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.sounds_id_seq OWNED BY public.sounds.id;


--
-- Name: visits; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.visits (
    id integer NOT NULL,
    player_id character varying(64) NOT NULL,
    created_at timestamp without time zone
);


ALTER TABLE public.visits OWNER TO arcidle;

--
-- Name: visits_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.visits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.visits_id_seq OWNER TO arcidle;

--
-- Name: visits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.visits_id_seq OWNED BY public.visits.id;


--
-- Name: weapons; Type: TABLE; Schema: public; Owner: arcidle
--

CREATE TABLE public.weapons (
    id integer NOT NULL,
    slug character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    category character varying(30) NOT NULL,
    rarity character varying(20) NOT NULL,
    image character varying(200),
    hq_image character varying(200),
    damage double precision NOT NULL,
    fire_rate double precision NOT NULL,
    range double precision NOT NULL,
    stability double precision NOT NULL,
    agility double precision NOT NULL,
    stealth double precision NOT NULL,
    ammo_type character varying(20) NOT NULL,
    magazine_size integer NOT NULL,
    firing_mode character varying(20) NOT NULL,
    arc_armor_penetration character varying(20) NOT NULL,
    weight double precision NOT NULL,
    sell_price_1 integer NOT NULL,
    sell_price_2 integer NOT NULL,
    sell_price_3 integer NOT NULL,
    sell_price_4 integer NOT NULL,
    headshot_multiplier double precision
);


ALTER TABLE public.weapons OWNER TO arcidle;

--
-- Name: weapons_id_seq; Type: SEQUENCE; Schema: public; Owner: arcidle
--

CREATE SEQUENCE public.weapons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.weapons_id_seq OWNER TO arcidle;

--
-- Name: weapons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arcidle
--

ALTER SEQUENCE public.weapons_id_seq OWNED BY public.weapons.id;


--
-- Name: augment_materials id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augment_materials ALTER COLUMN id SET DEFAULT nextval('public.augment_materials_id_seq'::regclass);


--
-- Name: augment_shields id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augment_shields ALTER COLUMN id SET DEFAULT nextval('public.augment_shields_id_seq'::regclass);


--
-- Name: augments id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augments ALTER COLUMN id SET DEFAULT nextval('public.augments_id_seq'::regclass);


--
-- Name: blueprint_materials id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.blueprint_materials ALTER COLUMN id SET DEFAULT nextval('public.blueprint_materials_id_seq'::regclass);


--
-- Name: blueprints id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.blueprints ALTER COLUMN id SET DEFAULT nextval('public.blueprints_id_seq'::regclass);


--
-- Name: daily_completions id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.daily_completions ALTER COLUMN id SET DEFAULT nextval('public.daily_completions_id_seq'::regclass);


--
-- Name: daily_guesses id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.daily_guesses ALTER COLUMN id SET DEFAULT nextval('public.daily_guesses_id_seq'::regclass);


--
-- Name: favorite_votes id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.favorite_votes ALTER COLUMN id SET DEFAULT nextval('public.favorite_votes_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: materials id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.materials ALTER COLUMN id SET DEFAULT nextval('public.materials_id_seq'::regclass);


--
-- Name: run_plays id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.run_plays ALTER COLUMN id SET DEFAULT nextval('public.run_plays_id_seq'::regclass);


--
-- Name: run_scores id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.run_scores ALTER COLUMN id SET DEFAULT nextval('public.run_scores_id_seq'::regclass);


--
-- Name: shield_materials id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.shield_materials ALTER COLUMN id SET DEFAULT nextval('public.shield_materials_id_seq'::regclass);


--
-- Name: shields id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.shields ALTER COLUMN id SET DEFAULT nextval('public.shields_id_seq'::regclass);


--
-- Name: skills id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.skills ALTER COLUMN id SET DEFAULT nextval('public.skills_id_seq'::regclass);


--
-- Name: sounds id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.sounds ALTER COLUMN id SET DEFAULT nextval('public.sounds_id_seq'::regclass);


--
-- Name: visits id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.visits ALTER COLUMN id SET DEFAULT nextval('public.visits_id_seq'::regclass);


--
-- Name: weapons id; Type: DEFAULT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.weapons ALTER COLUMN id SET DEFAULT nextval('public.weapons_id_seq'::regclass);


--
-- Data for Name: augment_materials; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.augment_materials (id, augment_id, material_id, quantity, reveal_order) FROM stdin;
1	2	38	6	1
2	2	34	6	2
3	3	38	6	1
4	3	34	6	2
5	4	38	6	1
6	4	34	6	2
7	5	19	2	1
8	5	26	3	2
9	6	19	2	1
10	6	26	3	2
11	7	19	2	1
12	7	26	3	2
13	8	2	2	1
14	8	36	3	2
15	9	2	2	1
16	9	36	3	2
17	10	2	2	1
18	10	36	3	2
19	11	2	2	1
20	11	36	3	2
21	12	2	2	1
22	12	36	3	2
\.


--
-- Data for Name: augment_shields; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.augment_shields (id, augment_id, shield_id) FROM stdin;
1	1	1
2	2	1
3	3	1
4	3	2
5	4	1
6	4	2
7	5	1
8	6	1
9	6	2
10	6	3
11	7	1
12	7	2
13	8	1
14	8	2
15	9	1
16	10	1
17	10	2
18	11	1
19	12	1
20	12	2
21	12	3
\.


--
-- Data for Name: augments; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.augments (id, slug, name, rarity, image, hq_image, craftable) FROM stdin;
1	Free_Loadout_Augment	Free Loadout Augment	Common	augments/Free_Loadout_Augment.webp	augments/HQ/Free_Loadout_Augment.png	f
2	Looting_MK1	Looting MK.1	Uncommon	augments/Looting_MK_1.webp	augments/HQ/Looting_Mk._1.png	t
3	Combat_MK1	Combat MK.1	Uncommon	augments/Combat_MK_1.webp	augments/HQ/Combat_Mk._1.png	t
4	Tactical_MK1	Tactical MK.1	Uncommon	augments/Tactical_Mk1.webp	augments/HQ/Tactical_Mk._1.png	t
5	Looting_MK2	Looting MK.2	Rare	augments/Looting_MK2.webp	augments/HQ/Looting_Mk._2.png	t
6	Combat_MK2	Combat MK.2	Rare	augments/Combat_Mk2.webp	augments/HQ/Combat_Mk._2.png	t
7	Tactical_MK2	Tactical MK.2	Rare	augments/Tactical_Mk2.webp	augments/HQ/Tactical_Mk._2.png	t
8	Looting_MK3_Survivor	Looting MK.3 (Survivor)	Epic	augments/Looting_MK_Survivor.webp	augments/HQ/Looting_Mk._3_(Survivor).png	t
9	Looting_MK3_Cautious	Looting MK.3 (Cautious)	Epic	augments/Looting_MK3_Cautious.webp	augments/HQ/Looting_Mk._3_(Cautious).png	t
10	Tactical_MK3_Healing	Tactical MK.3 (Healing)	Epic	augments/Tactical_Mk3_Healing.webp	augments/HQ/Tactical_Mk._3_(Healing).png	t
11	Tactical_MK3_Revival	Tactical MK.3 (Revival)	Epic	augments/Tactical_MK3_Revival.webp	augments/HQ/Tactical_Mk._3_(Revival).png	t
12	Combat_MK3_Aggressive	Combat MK.3 (Aggressive)	Epic	augments/Combat_MK3_Aggresive.webp	augments/HQ/Combat_Mk._3_(Aggressive).png	t
\.


--
-- Data for Name: blueprint_materials; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.blueprint_materials (id, blueprint_id, material_id, quantity, reveal_order) FROM stdin;
1	1	46	3	1
2	1	19	2	2
3	2	42	2	1
4	2	28	2	2
5	3	14	10	1
6	3	23	2	2
7	4	8	8	1
8	5	8	8	1
9	6	25	2	1
10	6	29	2	2
11	6	24	2	3
12	7	14	6	1
13	8	22	14	1
14	9	34	8	1
15	9	38	4	2
16	10	16	2	1
17	10	33	2	2
18	11	40	4	1
19	12	40	4	1
20	13	40	4	1
21	14	3	2	1
22	14	10	2	2
23	15	30	7	1
24	15	38	3	2
25	16	42	2	1
26	16	28	2	2
27	17	2	2	1
28	17	9	2	2
\.


--
-- Data for Name: blueprints; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.blueprints (id, slug, name, rarity, image, hq_image) FROM stdin;
1	Advanced_Electrical_Components	Advanced Electrical Components	Uncommon	items/Advanced_Electrical_Components.webp	\N
2	Advanced_Mechanical_Components	Advanced Mechanical Components	Uncommon	items/Advanced_Mechanical_Components.webp	\N
3	Antiseptic	Antiseptic	Uncommon	items/Antiseptic.webp	\N
4	ARC_Circuitry	ARC Circuitry	Rare	items/ARC_Circuitry.webp	\N
5	ARC_Motion_Core	ARC Motion Core	Rare	items/ARC_Motion_Core.webp	\N
6	Complex_Gun_Parts	Complex Gun Parts	Rare	items/Complex_Gun_Parts.webp	\N
7	Crude_Explosives	Crude Explosives	Common	items/Crude_Explosives.webp	\N
8	Durable_Cloth	Durable Cloth	Uncommon	items/Durable_Cloth.webp	\N
9	Electrical_Components	Electrical Components	Common	items/Electrical_Components.webp	\N
10	Explosive_Compound	Explosive Compound	Uncommon	items/Explosive_Compound.webp	\N
11	Heavy_Gun_Parts	Heavy Gun Parts	Uncommon	items/Heavy_Gun_Parts.webp	\N
12	Light_Gun_Parts	Light Gun Parts	Uncommon	items/Light_Gun_Parts.webp	\N
13	Medium_Gun_Parts	Medium Gun Parts	Uncommon	items/Medium_Gun_Parts.webp	\N
14	Magnetic_Accelerator	Magnetic Accelerator	Rare	items/Magnetic_Accelerator.webp	\N
15	Mechanical_Components	Mechanical Components	Common	items/Mechanical_Components.webp	\N
16	Mod_Components	Mod Components	Uncommon	items/Mod_Components.webp	\N
17	PowerRod	Power Rod	Rare	items/PowerRod.webp	\N
\.


--
-- Data for Name: daily_completions; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.daily_completions (id, date, mode, player_id, attempts, completed_at) FROM stdin;
1	2026-02-09	weapon	9b979f04-87ae-4a2a-9878-f18c06e3774e	3	2026-02-09 10:40:39.857629
2	2026-02-09	location	9b979f04-87ae-4a2a-9878-f18c06e3774e	1	2026-02-09 10:40:52.835423
3	2026-02-09	blueprint	9b979f04-87ae-4a2a-9878-f18c06e3774e	2	2026-02-09 10:42:08.623418
4	2026-02-09	sound	9b979f04-87ae-4a2a-9878-f18c06e3774e	4	2026-02-09 10:42:51.429516
5	2026-02-09	skill	9b979f04-87ae-4a2a-9878-f18c06e3774e	1	2026-02-09 10:43:17.283052
6	2026-02-09	weapon	a9ebff73-73e0-4373-a629-a1c5cd9627ca	3	2026-02-09 11:16:24.052958
7	2026-02-09	location	a9ebff73-73e0-4373-a629-a1c5cd9627ca	1	2026-02-09 11:16:33.877565
8	2026-02-09	blueprint	a9ebff73-73e0-4373-a629-a1c5cd9627ca	2	2026-02-09 11:17:20.251875
9	2026-02-09	skill	a9ebff73-73e0-4373-a629-a1c5cd9627ca	6	2026-02-09 11:17:46.775331
10	2026-02-09	sound	a9ebff73-73e0-4373-a629-a1c5cd9627ca	1	2026-02-09 11:18:09.738459
11	2026-02-09	weapon	57cdcecb-8903-4af2-aacf-0b68867051c4	4	2026-02-09 11:19:15.188685
12	2026-02-09	location	57cdcecb-8903-4af2-aacf-0b68867051c4	1	2026-02-09 11:35:07.036915
13	2026-02-09	blueprint	57cdcecb-8903-4af2-aacf-0b68867051c4	2	2026-02-09 11:35:36.077429
14	2026-02-09	sound	57cdcecb-8903-4af2-aacf-0b68867051c4	1	2026-02-09 11:35:47.24778
15	2026-02-09	skill	57cdcecb-8903-4af2-aacf-0b68867051c4	1	2026-02-09 11:44:08.591253
16	2026-02-09	weapon	1e522662-8ba2-44ea-90e9-65969d11acce	4	2026-02-09 11:47:06.588126
17	2026-02-09	location	1e522662-8ba2-44ea-90e9-65969d11acce	3	2026-02-09 11:47:31.774039
18	2026-02-09	sound	1e522662-8ba2-44ea-90e9-65969d11acce	1	2026-02-09 11:48:24.815839
19	2026-02-09	skill	1e522662-8ba2-44ea-90e9-65969d11acce	1	2026-02-09 11:48:33.258233
20	2026-02-09	sound	7c9ac46a-dc30-41a6-89bb-3af2f377a505	1	2026-02-09 11:53:39.565042
21	2026-02-09	location	ecd180a5-545f-4f00-a962-5580d03d0f00	1	2026-02-09 11:53:46.259107
22	2026-02-09	location	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	1	2026-02-09 12:13:51.153164
23	2026-02-09	weapon	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	2	2026-02-09 12:14:09.568514
24	2026-02-09	blueprint	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	2	2026-02-09 12:14:35.532853
25	2026-02-09	sound	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	1	2026-02-09 12:15:00.214688
26	2026-02-09	skill	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	10	2026-02-09 12:15:24.804654
27	2026-02-09	weapon	e8dd8f60-5ec3-41a4-8153-5a66815e25a3	3	2026-02-09 12:46:43.275435
28	2026-02-09	location	e8dd8f60-5ec3-41a4-8153-5a66815e25a3	1	2026-02-09 12:46:56.142623
29	2026-02-09	blueprint	e8dd8f60-5ec3-41a4-8153-5a66815e25a3	2	2026-02-09 12:48:52.294562
30	2026-02-09	sound	e8dd8f60-5ec3-41a4-8153-5a66815e25a3	5	2026-02-09 13:06:37.858401
31	2026-02-09	skill	e8dd8f60-5ec3-41a4-8153-5a66815e25a3	3	2026-02-09 13:07:26.793454
32	2026-02-09	location	bc2f980e-700e-4261-858b-b7099ce75e78	2	2026-02-09 13:08:48.914154
33	2026-02-09	weapon	bc2f980e-700e-4261-858b-b7099ce75e78	3	2026-02-09 13:09:10.996028
34	2026-02-09	skill	bc2f980e-700e-4261-858b-b7099ce75e78	6	2026-02-09 13:09:53.367485
35	2026-02-09	weapon	2f875be2-9eaa-438d-9596-1dc9e74d3f4b	3	2026-02-09 14:09:21.03723
36	2026-02-09	location	2f875be2-9eaa-438d-9596-1dc9e74d3f4b	1	2026-02-09 14:09:37.279572
37	2026-02-09	blueprint	2f875be2-9eaa-438d-9596-1dc9e74d3f4b	3	2026-02-09 14:11:47.332827
38	2026-02-09	weapon	7f151d0f-ee02-48ef-a20b-db22019246e7	9	2026-02-09 14:11:53.843293
39	2026-02-09	location	7f151d0f-ee02-48ef-a20b-db22019246e7	2	2026-02-09 14:12:34.917716
40	2026-02-09	skill	2f875be2-9eaa-438d-9596-1dc9e74d3f4b	4	2026-02-09 14:13:51.85913
41	2026-02-09	blueprint	7f151d0f-ee02-48ef-a20b-db22019246e7	1	2026-02-09 14:14:57.194487
42	2026-02-09	sound	2f875be2-9eaa-438d-9596-1dc9e74d3f4b	12	2026-02-09 14:15:19.399107
43	2026-02-09	weapon	3895413e-cfc9-46af-86fe-408b7d0293e1	6	2026-02-09 14:32:56.061036
44	2026-02-09	blueprint	3895413e-cfc9-46af-86fe-408b7d0293e1	3	2026-02-09 14:36:12.252373
45	2026-02-09	sound	3895413e-cfc9-46af-86fe-408b7d0293e1	2	2026-02-09 14:37:01.803488
46	2026-02-09	skill	3895413e-cfc9-46af-86fe-408b7d0293e1	1	2026-02-09 14:39:15.610584
47	2026-02-09	location	3895413e-cfc9-46af-86fe-408b7d0293e1	2	2026-02-09 14:39:33.277925
48	2026-02-09	skill	b7415ebd-1e21-4d4a-82b8-84aba9aaaa23	18	2026-02-09 15:02:06.315995
49	2026-02-09	sound	7f151d0f-ee02-48ef-a20b-db22019246e7	3	2026-02-09 15:37:27.268503
50	2026-02-09	skill	7f151d0f-ee02-48ef-a20b-db22019246e7	3	2026-02-09 15:38:11.427355
51	2026-02-09	weapon	dfdbad65-7c53-4906-9b4a-6e68de8ff815	3	2026-02-09 16:01:28.178514
52	2026-02-09	location	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2	2026-02-09 16:02:09.664478
53	2026-02-09	blueprint	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2	2026-02-09 16:03:05.29473
54	2026-02-09	sound	dfdbad65-7c53-4906-9b4a-6e68de8ff815	8	2026-02-09 16:04:57.077653
55	2026-02-09	skill	dfdbad65-7c53-4906-9b4a-6e68de8ff815	1	2026-02-09 16:05:21.1265
56	2026-02-09	skill	e5a42393-36ba-4b3c-afba-b174e7ef157e	4	2026-02-09 16:11:47.25082
57	2026-02-09	sound	e5a42393-36ba-4b3c-afba-b174e7ef157e	2	2026-02-09 16:12:00.049251
58	2026-02-09	location	71a91031-5145-4b3a-a6f9-78c51c329012	1	2026-02-09 16:25:54.273773
59	2026-02-09	weapon	71a91031-5145-4b3a-a6f9-78c51c329012	5	2026-02-09 16:26:24.322095
60	2026-02-09	blueprint	71a91031-5145-4b3a-a6f9-78c51c329012	2	2026-02-09 16:28:08.010388
61	2026-02-09	sound	71a91031-5145-4b3a-a6f9-78c51c329012	12	2026-02-09 16:30:00.54896
62	2026-02-09	skill	71a91031-5145-4b3a-a6f9-78c51c329012	1	2026-02-09 16:30:24.950222
63	2026-02-09	weapon	1ec2f2db-47b5-4a62-aca6-c5073b8e141a	3	2026-02-09 16:36:48.849544
64	2026-02-09	location	1ec2f2db-47b5-4a62-aca6-c5073b8e141a	1	2026-02-09 16:37:05.132571
65	2026-02-09	blueprint	1ec2f2db-47b5-4a62-aca6-c5073b8e141a	4	2026-02-09 16:38:54.423943
66	2026-02-09	sound	1ec2f2db-47b5-4a62-aca6-c5073b8e141a	2	2026-02-09 16:39:12.807622
67	2026-02-09	skill	1ec2f2db-47b5-4a62-aca6-c5073b8e141a	18	2026-02-09 16:39:53.257838
68	2026-02-09	weapon	89fe37af-a8ef-409c-8686-42aeb311c81b	4	2026-02-09 17:59:23.753855
69	2026-02-09	location	89fe37af-a8ef-409c-8686-42aeb311c81b	1	2026-02-09 17:59:36.826812
70	2026-02-09	sound	89fe37af-a8ef-409c-8686-42aeb311c81b	4	2026-02-09 18:02:03.369423
71	2026-02-09	skill	89fe37af-a8ef-409c-8686-42aeb311c81b	6	2026-02-09 18:03:36.817362
72	2026-02-09	weapon	c1b86c62-a0be-4d90-b64b-190831c3ce66	3	2026-02-09 19:08:07.890473
73	2026-02-09	location	c1b86c62-a0be-4d90-b64b-190831c3ce66	4	2026-02-09 19:08:43.424384
74	2026-02-09	weapon	1d20a607-6143-408d-bc37-24e755fec8c8	3	2026-02-09 22:08:11.060492
75	2026-02-09	location	1d20a607-6143-408d-bc37-24e755fec8c8	1	2026-02-09 22:08:19.668388
76	2026-02-09	blueprint	1d20a607-6143-408d-bc37-24e755fec8c8	1	2026-02-09 22:09:41.285729
77	2026-02-09	skill	1d20a607-6143-408d-bc37-24e755fec8c8	3	2026-02-09 22:10:04.432319
78	2026-02-09	weapon	581cd452-728c-4f3b-bcc2-989f19014ae0	3	2026-02-09 22:23:55.968644
79	2026-02-09	location	581cd452-728c-4f3b-bcc2-989f19014ae0	2	2026-02-09 22:24:29.429534
80	2026-02-09	sound	581cd452-728c-4f3b-bcc2-989f19014ae0	2	2026-02-09 22:26:23.812547
81	2026-02-09	skill	581cd452-728c-4f3b-bcc2-989f19014ae0	9	2026-02-09 22:27:22.895405
82	2026-02-09	blueprint	581cd452-728c-4f3b-bcc2-989f19014ae0	4	2026-02-09 22:27:53.925829
83	2026-02-10	location	67ea79cc-9e7f-4950-a32a-3dc46c244780	1	2026-02-10 00:23:19.596214
84	2026-02-10	blueprint	67ea79cc-9e7f-4950-a32a-3dc46c244780	2	2026-02-10 00:23:49.889486
85	2026-02-10	weapon	7c9ac46a-dc30-41a6-89bb-3af2f377a505	5	2026-02-10 01:17:11.74221
86	2026-02-10	location	7c9ac46a-dc30-41a6-89bb-3af2f377a505	1	2026-02-10 01:17:18.526357
87	2026-02-10	blueprint	7c9ac46a-dc30-41a6-89bb-3af2f377a505	1	2026-02-10 01:17:26.893406
89	2026-02-10	skill	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2	2026-02-10 01:17:43.921401
88	2026-02-10	sound	7c9ac46a-dc30-41a6-89bb-3af2f377a505	1	2026-02-10 01:17:34.550122
90	2026-02-10	skill	d8eae26c-e074-4ae0-a5d3-55c730fa224d	1	2026-02-10 01:58:47.831032
91	2026-02-10	weapon	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	8	2026-02-10 02:14:11.078703
92	2026-02-10	location	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	3	2026-02-10 02:14:38.945454
93	2026-02-10	blueprint	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	1	2026-02-10 02:15:14.0616
94	2026-02-10	sound	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	1	2026-02-10 02:15:23.850906
95	2026-02-10	skill	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	1	2026-02-10 02:15:35.336399
96	2026-02-10	weapon	491320c9-3cc7-4688-8089-5eb00bf04052	1	2026-02-10 03:08:15.372414
97	2026-02-10	sound	491320c9-3cc7-4688-8089-5eb00bf04052	2	2026-02-10 03:09:04.102474
98	2026-02-10	skill	491320c9-3cc7-4688-8089-5eb00bf04052	2	2026-02-10 03:09:19.462684
99	2026-02-10	weapon	8af8ce1d-2be2-4c40-88c3-c3f8a56e5479	8	2026-02-10 04:26:01.421219
100	2026-02-10	location	8af8ce1d-2be2-4c40-88c3-c3f8a56e5479	1	2026-02-10 04:26:12.975672
101	2026-02-10	blueprint	8af8ce1d-2be2-4c40-88c3-c3f8a56e5479	1	2026-02-10 04:26:31.377877
102	2026-02-10	sound	8af8ce1d-2be2-4c40-88c3-c3f8a56e5479	3	2026-02-10 04:26:59.872984
103	2026-02-10	skill	8af8ce1d-2be2-4c40-88c3-c3f8a56e5479	1	2026-02-10 04:27:14.598639
104	2026-02-10	weapon	03cff583-1c5d-4bdb-aff5-4db1311be2ca	3	2026-02-10 04:52:41.691968
105	2026-02-10	location	03cff583-1c5d-4bdb-aff5-4db1311be2ca	1	2026-02-10 04:53:39.229612
106	2026-02-10	blueprint	03cff583-1c5d-4bdb-aff5-4db1311be2ca	2	2026-02-10 04:58:47.617508
107	2026-02-10	sound	03cff583-1c5d-4bdb-aff5-4db1311be2ca	2	2026-02-10 04:59:34.386172
108	2026-02-10	skill	03cff583-1c5d-4bdb-aff5-4db1311be2ca	1	2026-02-10 04:59:55.241875
109	2026-02-10	weapon	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	9	2026-02-10 08:41:28.327521
110	2026-02-10	location	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	1	2026-02-10 08:41:37.429889
111	2026-02-10	blueprint	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	2	2026-02-10 08:41:56.982348
112	2026-02-10	sound	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	3	2026-02-10 08:42:10.705933
113	2026-02-10	skill	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	3	2026-02-10 08:42:21.446289
114	2026-02-10	location	53131cd4-74f0-4c08-8eab-5e9083e3d65f	3	2026-02-10 09:21:32.058095
115	2026-02-10	weapon	53131cd4-74f0-4c08-8eab-5e9083e3d65f	6	2026-02-10 09:23:04.837292
116	2026-02-10	weapon	b853cd16-c74b-44d9-ad79-86bd6c75214d	8	2026-02-10 09:25:44.46463
117	2026-02-10	location	b853cd16-c74b-44d9-ad79-86bd6c75214d	1	2026-02-10 09:25:56.555338
118	2026-02-10	sound	b853cd16-c74b-44d9-ad79-86bd6c75214d	4	2026-02-10 09:26:21.659041
119	2026-02-10	skill	b853cd16-c74b-44d9-ad79-86bd6c75214d	2	2026-02-10 09:26:40.994446
120	2026-02-10	weapon	1fd58109-5de0-47c4-b1f1-5cfca39e21df	8	2026-02-10 11:01:27.131761
121	2026-02-10	location	1fd58109-5de0-47c4-b1f1-5cfca39e21df	3	2026-02-10 11:02:01.918161
122	2026-02-10	blueprint	1fd58109-5de0-47c4-b1f1-5cfca39e21df	1	2026-02-10 11:03:03.889157
123	2026-02-10	skill	1fd58109-5de0-47c4-b1f1-5cfca39e21df	1	2026-02-10 11:03:25.348921
124	2026-02-10	weapon	cc7393dd-e459-4f25-aae9-19294a6638d5	5	2026-02-10 11:48:37.300507
125	2026-02-10	location	cc7393dd-e459-4f25-aae9-19294a6638d5	1	2026-02-10 11:48:51.505045
126	2026-02-10	blueprint	cc7393dd-e459-4f25-aae9-19294a6638d5	2	2026-02-10 11:49:40.800975
127	2026-02-10	sound	cc7393dd-e459-4f25-aae9-19294a6638d5	6	2026-02-10 11:51:00.735357
128	2026-02-10	skill	cc7393dd-e459-4f25-aae9-19294a6638d5	1	2026-02-10 11:51:37.691303
129	2026-02-10	weapon	bac66f16-c7e8-4e50-932b-16c01fbec2d5	7	2026-02-10 14:42:28.300205
130	2026-02-10	location	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	3	2026-02-10 15:52:07.079315
131	2026-02-10	skill	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	7	2026-02-10 15:55:28.605927
132	2026-02-10	weapon	7f151d0f-ee02-48ef-a20b-db22019246e7	8	2026-02-10 16:19:18.809476
133	2026-02-10	location	7f151d0f-ee02-48ef-a20b-db22019246e7	1	2026-02-10 16:19:30.831264
134	2026-02-10	blueprint	7f151d0f-ee02-48ef-a20b-db22019246e7	1	2026-02-10 16:19:52.011457
135	2026-02-10	skill	7f151d0f-ee02-48ef-a20b-db22019246e7	1	2026-02-10 16:20:12.338845
136	2026-02-10	sound	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	15	2026-02-10 16:59:13.314817
137	2026-02-10	weapon	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	11	2026-02-10 17:00:35.653591
138	2026-02-10	blueprint	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	1	2026-02-10 17:00:54.808161
139	2026-02-10	weapon	cdcc1fa6-c641-4e2b-99c3-50ec97ab8c11	7	2026-02-10 18:47:25.363877
140	2026-02-10	location	cdcc1fa6-c641-4e2b-99c3-50ec97ab8c11	1	2026-02-10 18:47:44.217234
141	2026-02-10	blueprint	cdcc1fa6-c641-4e2b-99c3-50ec97ab8c11	2	2026-02-10 18:49:01.478524
142	2026-02-10	skill	cdcc1fa6-c641-4e2b-99c3-50ec97ab8c11	2	2026-02-10 18:49:21.794723
143	2026-02-10	weapon	72fee5f1-d4be-44cb-8af0-a8386619994b	3	2026-02-10 22:45:10.641983
144	2026-02-10	location	72fee5f1-d4be-44cb-8af0-a8386619994b	1	2026-02-10 22:45:18.65426
145	2026-02-10	blueprint	72fee5f1-d4be-44cb-8af0-a8386619994b	2	2026-02-10 22:45:38.728281
146	2026-02-10	sound	72fee5f1-d4be-44cb-8af0-a8386619994b	4	2026-02-10 22:45:58.843998
147	2026-02-10	skill	72fee5f1-d4be-44cb-8af0-a8386619994b	1	2026-02-10 22:46:20.330515
148	2026-02-10	weapon	447b920e-a2ea-4298-9c3e-2fecacacaefb	18	2026-02-10 23:39:01.536984
149	2026-02-10	location	447b920e-a2ea-4298-9c3e-2fecacacaefb	1	2026-02-10 23:39:52.637113
150	2026-02-10	sound	447b920e-a2ea-4298-9c3e-2fecacacaefb	7	2026-02-10 23:42:14.441704
151	2026-02-10	skill	447b920e-a2ea-4298-9c3e-2fecacacaefb	1	2026-02-10 23:42:48.144423
152	2026-02-11	blueprint	faa5fd3d-9577-42fc-b47a-05195d828cc6	3	2026-02-11 00:15:33.227748
153	2026-02-11	weapon	faa5fd3d-9577-42fc-b47a-05195d828cc6	3	2026-02-11 00:16:32.736867
154	2026-02-11	location	faa5fd3d-9577-42fc-b47a-05195d828cc6	1	2026-02-11 00:16:48.204724
155	2026-02-11	sound	faa5fd3d-9577-42fc-b47a-05195d828cc6	1	2026-02-11 00:17:09.808883
156	2026-02-11	skill	faa5fd3d-9577-42fc-b47a-05195d828cc6	1	2026-02-11 00:17:59.614256
157	2026-02-11	sound	7f151d0f-ee02-48ef-a20b-db22019246e7	1	2026-02-11 01:34:42.450744
158	2026-02-11	weapon	72fee5f1-d4be-44cb-8af0-a8386619994b	8	2026-02-11 02:31:25.738424
159	2026-02-11	location	72fee5f1-d4be-44cb-8af0-a8386619994b	1	2026-02-11 02:31:38.717809
160	2026-02-11	blueprint	72fee5f1-d4be-44cb-8af0-a8386619994b	4	2026-02-11 02:32:34.780535
161	2026-02-11	skill	72fee5f1-d4be-44cb-8af0-a8386619994b	1	2026-02-11 02:32:43.47088
162	2026-02-11	weapon	76ddb62b-d2db-4fb2-ba8c-73ae7923e84f	1	2026-02-11 05:04:25.17715
163	2026-02-11	location	76ddb62b-d2db-4fb2-ba8c-73ae7923e84f	1	2026-02-11 05:04:40.38162
164	2026-02-11	blueprint	76ddb62b-d2db-4fb2-ba8c-73ae7923e84f	2	2026-02-11 05:05:50.422571
165	2026-02-11	sound	76ddb62b-d2db-4fb2-ba8c-73ae7923e84f	1	2026-02-11 05:06:02.409882
166	2026-02-11	skill	76ddb62b-d2db-4fb2-ba8c-73ae7923e84f	1	2026-02-11 05:06:12.845326
\.


--
-- Data for Name: daily_guesses; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.daily_guesses (id, date, mode, guessed_slug, guessed_at) FROM stdin;
1	2026-02-09	weapon	Anvil	2026-02-09 10:40:28.307721
2	2026-02-09	weapon	Ferro	2026-02-09 10:40:33.84559
3	2026-02-09	weapon	Osprey	2026-02-09 10:40:39.65377
4	2026-02-09	location	The_Blue_Gates	2026-02-09 10:40:52.664126
5	2026-02-09	blueprint	Advanced_Mechanical_Components	2026-02-09 10:41:33.217412
6	2026-02-09	blueprint	Electrical_Components	2026-02-09 10:42:08.426993
7	2026-02-09	sound	ferro-sound	2026-02-09 10:42:26.2304
8	2026-02-09	sound	anvil-sound	2026-02-09 10:42:30.781033
9	2026-02-09	sound	osprey-sound	2026-02-09 10:42:34.2038
10	2026-02-09	sound	il-toro-sound	2026-02-09 10:42:51.233687
11	2026-02-09	skill	mob_5c	2026-02-09 10:43:17.086186
12	2026-02-09	weapon	Ferro	2026-02-09 11:16:03.065387
13	2026-02-09	weapon	Equalizer	2026-02-09 11:16:17.086496
14	2026-02-09	weapon	Osprey	2026-02-09 11:16:23.877693
15	2026-02-09	location	The_Blue_Gates	2026-02-09 11:16:33.706814
16	2026-02-09	blueprint	Explosive_Compound	2026-02-09 11:17:04.760448
17	2026-02-09	blueprint	Electrical_Components	2026-02-09 11:17:20.081729
18	2026-02-09	skill	cond_5l	2026-02-09 11:17:35.200176
19	2026-02-09	skill	cond_4l	2026-02-09 11:17:37.553968
20	2026-02-09	skill	cond_3l	2026-02-09 11:17:39.208808
21	2026-02-09	skill	cond_2l	2026-02-09 11:17:40.221141
22	2026-02-09	skill	cond_2r	2026-02-09 11:17:41.622021
23	2026-02-09	skill	mob_5c	2026-02-09 11:17:46.595819
24	2026-02-09	sound	il-toro-sound	2026-02-09 11:18:09.563648
25	2026-02-09	weapon	Anvil	2026-02-09 11:18:58.009382
26	2026-02-09	weapon	Renegade	2026-02-09 11:19:03.098153
27	2026-02-09	weapon	Ferro	2026-02-09 11:19:08.25671
28	2026-02-09	weapon	Osprey	2026-02-09 11:19:14.755462
29	2026-02-09	location	The_Blue_Gates	2026-02-09 11:35:06.699297
30	2026-02-09	blueprint	Advanced_Electrical_Components	2026-02-09 11:35:14.687821
31	2026-02-09	blueprint	Electrical_Components	2026-02-09 11:35:35.576818
32	2026-02-09	sound	il-toro-sound	2026-02-09 11:35:46.868127
33	2026-02-09	skill	mob_5c	2026-02-09 11:44:08.227446
34	2026-02-09	weapon	Anvil	2026-02-09 11:46:43.759577
35	2026-02-09	weapon	Burletta	2026-02-09 11:46:55.198792
36	2026-02-09	weapon	Bettina	2026-02-09 11:46:59.938541
37	2026-02-09	weapon	Osprey	2026-02-09 11:47:06.312314
38	2026-02-09	location	Spaceport	2026-02-09 11:47:17.376248
39	2026-02-09	location	Dam_Battlegrounds	2026-02-09 11:47:23.205972
40	2026-02-09	location	The_Blue_Gates	2026-02-09 11:47:31.508663
41	2026-02-09	blueprint	Advanced_Electrical_Components	2026-02-09 11:47:51.498419
42	2026-02-09	blueprint	Mod_Components	2026-02-09 11:48:02.25503
43	2026-02-09	sound	il-toro-sound	2026-02-09 11:48:24.558803
44	2026-02-09	skill	mob_5c	2026-02-09 11:48:33.002058
45	2026-02-09	sound	il-toro-sound	2026-02-09 11:53:39.544164
46	2026-02-09	location	The_Blue_Gates	2026-02-09 11:53:46.077674
47	2026-02-09	blueprint	Antiseptic	2026-02-09 11:54:31.102808
48	2026-02-09	location	The_Blue_Gates	2026-02-09 12:13:50.718563
49	2026-02-09	weapon	Anvil	2026-02-09 12:14:01.434768
50	2026-02-09	weapon	Osprey	2026-02-09 12:14:09.127722
51	2026-02-09	blueprint	Advanced_Electrical_Components	2026-02-09 12:14:26.688605
52	2026-02-09	blueprint	Electrical_Components	2026-02-09 12:14:35.319719
53	2026-02-09	sound	il-toro-sound	2026-02-09 12:15:00.000878
54	2026-02-09	skill	mob_5l	2026-02-09 12:15:14.604277
55	2026-02-09	skill	mob_6c	2026-02-09 12:15:19.483166
56	2026-02-09	skill	mob_4r	2026-02-09 12:15:20.298755
57	2026-02-09	skill	mob_4l	2026-02-09 12:15:20.783657
58	2026-02-09	skill	mob_3r	2026-02-09 12:15:21.479234
59	2026-02-09	skill	mob_3l	2026-02-09 12:15:21.813754
60	2026-02-09	skill	mob_2r	2026-02-09 12:15:22.893492
61	2026-02-09	skill	mob_2l	2026-02-09 12:15:23.129001
62	2026-02-09	skill	mob_1	2026-02-09 12:15:23.953923
63	2026-02-09	skill	mob_5c	2026-02-09 12:15:24.594407
64	2026-02-09	weapon	Anvil	2026-02-09 12:46:10.054139
65	2026-02-09	weapon	Tempest	2026-02-09 12:46:34.978321
66	2026-02-09	weapon	Osprey	2026-02-09 12:46:42.764136
67	2026-02-09	location	The_Blue_Gates	2026-02-09 12:46:55.831364
68	2026-02-09	blueprint	Advanced_Electrical_Components	2026-02-09 12:47:42.409791
69	2026-02-09	blueprint	Electrical_Components	2026-02-09 12:48:49.780138
70	2026-02-09	sound	ferro-sound	2026-02-09 12:49:08.112489
71	2026-02-09	sound	vulcano-sound	2026-02-09 12:49:40.242034
72	2026-02-09	sound	renegade-sound	2026-02-09 12:49:53.75304
73	2026-02-09	sound	osprey-sound	2026-02-09 12:50:16.347819
74	2026-02-09	sound	il-toro-sound	2026-02-09 13:06:37.551845
75	2026-02-09	skill	mob_5l	2026-02-09 13:07:05.321519
76	2026-02-09	skill	surv_4r	2026-02-09 13:07:20.784004
77	2026-02-09	skill	mob_5c	2026-02-09 13:07:26.406557
78	2026-02-09	location	Dam_Battlegrounds	2026-02-09 13:08:42.711237
79	2026-02-09	location	The_Blue_Gates	2026-02-09 13:08:48.33564
80	2026-02-09	weapon	Anvil	2026-02-09 13:08:59.861415
81	2026-02-09	weapon	Torrente	2026-02-09 13:09:02.811009
82	2026-02-09	weapon	Osprey	2026-02-09 13:09:10.540136
83	2026-02-09	skill	cond_5l	2026-02-09 13:09:39.053375
84	2026-02-09	skill	cond_4l	2026-02-09 13:09:41.463559
85	2026-02-09	skill	mob_6l	2026-02-09 13:09:43.763161
86	2026-02-09	skill	mob_6c	2026-02-09 13:09:44.646735
87	2026-02-09	skill	cond_6c	2026-02-09 13:09:46.385779
88	2026-02-09	skill	mob_5c	2026-02-09 13:09:52.797337
89	2026-02-09	skill	mob_5l	2026-02-09 13:09:53.790598
90	2026-02-09	location	Dam_Battlegrounds	2026-02-09 13:27:10.418888
91	2026-02-09	sound	ferro-sound	2026-02-09 13:27:34.613418
92	2026-02-09	weapon	Aphelion	2026-02-09 14:09:06.117694
93	2026-02-09	weapon	Bettina	2026-02-09 14:09:14.536112
94	2026-02-09	weapon	Osprey	2026-02-09 14:09:20.517117
95	2026-02-09	weapon	Vulcano	2026-02-09 14:09:21.410812
96	2026-02-09	weapon	Anvil	2026-02-09 14:09:28.81147
97	2026-02-09	weapon	Ferro	2026-02-09 14:09:33.621735
98	2026-02-09	location	The_Blue_Gates	2026-02-09 14:09:36.71461
99	2026-02-09	weapon	Hullcracker	2026-02-09 14:10:05.405271
100	2026-02-09	blueprint	Advanced_Mechanical_Components	2026-02-09 14:10:12.103964
101	2026-02-09	weapon	Tempest	2026-02-09 14:10:16.563239
102	2026-02-09	weapon	IL_Toro	2026-02-09 14:10:48.853443
103	2026-02-09	weapon	Arpeggio	2026-02-09 14:11:00.433809
104	2026-02-09	blueprint	Light_Gun_Parts	2026-02-09 14:11:06.612896
105	2026-02-09	weapon	Bettina	2026-02-09 14:11:25.134371
106	2026-02-09	blueprint	Electrical_Components	2026-02-09 14:11:46.808402
107	2026-02-09	weapon	Osprey	2026-02-09 14:11:53.566726
108	2026-02-09	skill	cond_6l	2026-02-09 14:12:15.684057
109	2026-02-09	location	Dam_Battlegrounds	2026-02-09 14:12:22.088335
110	2026-02-09	location	The_Blue_Gates	2026-02-09 14:12:34.638324
111	2026-02-09	skill	surv_2r	2026-02-09 14:12:35.608577
112	2026-02-09	skill	mob_3r	2026-02-09 14:13:08.92485
113	2026-02-09	skill	mob_5c	2026-02-09 14:13:51.340846
114	2026-02-09	sound	anvil-sound	2026-02-09 14:14:06.776209
115	2026-02-09	sound	osprey-sound	2026-02-09 14:14:16.35711
116	2026-02-09	sound	arpeggio-sound	2026-02-09 14:14:19.930198
117	2026-02-09	sound	hairpin-sound	2026-02-09 14:14:23.54735
118	2026-02-09	sound	bobcat-sound	2026-02-09 14:14:28.207555
119	2026-02-09	sound	burletta-sound	2026-02-09 14:14:31.363322
120	2026-02-09	sound	stitcher-sound	2026-02-09 14:14:41.799117
121	2026-02-09	sound	kettle-sound	2026-02-09 14:14:46.463034
122	2026-02-09	blueprint	Electrical_Components	2026-02-09 14:14:56.922447
123	2026-02-09	sound	ferro-sound	2026-02-09 14:14:58.50287
124	2026-02-09	sound	renegade-sound	2026-02-09 14:15:06.792769
125	2026-02-09	sound	torrente-sound	2026-02-09 14:15:12.387767
127	2026-02-09	sound	anvil-sound	2026-02-09 14:16:38.752751
130	2026-02-09	weapon	Bettina	2026-02-09 14:32:10.58286
136	2026-02-09	blueprint	Antiseptic	2026-02-09 14:35:56.378754
140	2026-02-09	skill	mob_5c	2026-02-09 14:39:15.44007
141	2026-02-09	location	Dam_Battlegrounds	2026-02-09 14:39:27.273335
145	2026-02-09	skill	cond_5r	2026-02-09 15:01:49.168212
154	2026-02-09	skill	cond_2r	2026-02-09 15:01:58.89791
157	2026-02-09	skill	mob_5r	2026-02-09 15:02:04.374054
163	2026-02-09	weapon	Ferro	2026-02-09 15:15:31.42403
168	2026-02-09	skill	mob_5c	2026-02-09 15:38:11.155476
171	2026-02-09	weapon	Ferro	2026-02-09 16:00:49.970329
172	2026-02-09	weapon	IL_Toro	2026-02-09 16:01:08.551443
175	2026-02-09	location	Dam_Battlegrounds	2026-02-09 16:01:55.6295
126	2026-02-09	sound	il-toro-sound	2026-02-09 14:15:18.834313
129	2026-02-09	weapon	Anvil	2026-02-09 14:31:52.913861
133	2026-02-09	weapon	Aphelion	2026-02-09 14:32:45.327617
137	2026-02-09	blueprint	Electrical_Components	2026-02-09 14:36:12.079427
139	2026-02-09	sound	il-toro-sound	2026-02-09 14:37:01.632919
149	2026-02-09	skill	cond_6c	2026-02-09 15:01:54.967113
152	2026-02-09	skill	cond_3l	2026-02-09 15:01:57.078853
153	2026-02-09	skill	cond_2l	2026-02-09 15:01:57.746538
156	2026-02-09	skill	cond_7r	2026-02-09 15:02:01.047776
159	2026-02-09	skill	mob_6c	2026-02-09 15:02:05.483416
160	2026-02-09	skill	mob_5c	2026-02-09 15:02:05.995992
164	2026-02-09	weapon	Bettina	2026-02-09 15:15:38.187727
165	2026-02-09	sound	il-toro-sound	2026-02-09 15:37:26.992617
169	2026-02-09	weapon	IL_Toro	2026-02-09 16:00:30.953981
174	2026-02-09	weapon	Osprey	2026-02-09 16:01:27.884298
176	2026-02-09	location	The_Blue_Gates	2026-02-09 16:02:09.367998
128	2026-02-09	sound	burletta-sound	2026-02-09 14:17:08.468103
131	2026-02-09	weapon	Jupiter	2026-02-09 14:32:21.005806
132	2026-02-09	weapon	Equalizer	2026-02-09 14:32:26.899991
135	2026-02-09	blueprint	Mechanical_Components	2026-02-09 14:35:25.123139
138	2026-02-09	sound	ferro-sound	2026-02-09 14:36:52.03759
144	2026-02-09	skill	cond_4l	2026-02-09 15:01:48.30331
148	2026-02-09	skill	cond_6l	2026-02-09 15:01:54.152536
151	2026-02-09	skill	cond_3r	2026-02-09 15:01:56.415896
158	2026-02-09	skill	mob_6r	2026-02-09 15:02:04.907883
162	2026-02-09	weapon	Anvil	2026-02-09 15:15:23.59698
166	2026-02-09	skill	cond_5l	2026-02-09 15:38:05.924649
134	2026-02-09	weapon	Osprey	2026-02-09 14:32:55.890054
142	2026-02-09	location	The_Blue_Gates	2026-02-09 14:39:33.107371
143	2026-02-09	skill	cond_4r	2026-02-09 15:01:46.544579
146	2026-02-09	skill	cond_5c	2026-02-09 15:01:49.915598
147	2026-02-09	skill	cond_5l	2026-02-09 15:01:53.247424
150	2026-02-09	skill	cond_6r	2026-02-09 15:01:55.508314
155	2026-02-09	skill	cond_7l	2026-02-09 15:02:00.440122
161	2026-02-09	weapon	Venator	2026-02-09 15:15:14.028521
167	2026-02-09	skill	cond_6l	2026-02-09 15:38:08.792101
170	2026-02-09	weapon	Kettle	2026-02-09 16:00:44.845883
173	2026-02-09	weapon	Renegade	2026-02-09 16:01:24.494063
177	2026-02-09	blueprint	PowerRod	2026-02-09 16:02:30.685072
178	2026-02-09	blueprint	Electrical_Components	2026-02-09 16:03:05.006468
179	2026-02-09	sound	renegade-sound	2026-02-09 16:03:22.146586
180	2026-02-09	sound	anvil-sound	2026-02-09 16:03:37.454543
181	2026-02-09	sound	hairpin-sound	2026-02-09 16:03:40.936468
182	2026-02-09	sound	osprey-sound	2026-02-09 16:03:55.8045
183	2026-02-09	sound	ferro-sound	2026-02-09 16:03:59.59327
184	2026-02-09	sound	vulcano-sound	2026-02-09 16:04:22.099077
185	2026-02-09	sound	burletta-sound	2026-02-09 16:04:47.731035
186	2026-02-09	sound	il-toro-sound	2026-02-09 16:04:56.775539
187	2026-02-09	skill	mob_5c	2026-02-09 16:05:20.835988
188	2026-02-09	sound	vulcano-sound	2026-02-09 16:11:15.444814
189	2026-02-09	skill	cond_6l	2026-02-09 16:11:36.140046
190	2026-02-09	skill	cond_6c	2026-02-09 16:11:36.970869
191	2026-02-09	skill	mob_6c	2026-02-09 16:11:45.355688
192	2026-02-09	skill	mob_5c	2026-02-09 16:11:46.906175
193	2026-02-09	sound	il-toro-sound	2026-02-09 16:11:59.72486
194	2026-02-09	blueprint	Antiseptic	2026-02-09 16:12:27.486844
195	2026-02-09	location	The_Blue_Gates	2026-02-09 16:25:54.011716
196	2026-02-09	weapon	Anvil	2026-02-09 16:26:02.97045
197	2026-02-09	weapon	Ferro	2026-02-09 16:26:05.647481
198	2026-02-09	weapon	Vulcano	2026-02-09 16:26:09.590474
199	2026-02-09	weapon	IL_Toro	2026-02-09 16:26:12.741982
200	2026-02-09	weapon	Osprey	2026-02-09 16:26:24.05608
201	2026-02-09	blueprint	Explosive_Compound	2026-02-09 16:26:52.181966
202	2026-02-09	blueprint	Electrical_Components	2026-02-09 16:28:07.744461
203	2026-02-09	sound	osprey-sound	2026-02-09 16:29:13.436566
204	2026-02-09	sound	anvil-sound	2026-02-09 16:29:37.603177
205	2026-02-09	sound	bobcat-sound	2026-02-09 16:29:39.113988
206	2026-02-09	sound	burletta-sound	2026-02-09 16:29:40.390113
207	2026-02-09	sound	arpeggio-sound	2026-02-09 16:29:41.818522
208	2026-02-09	sound	hairpin-sound	2026-02-09 16:29:43.092817
209	2026-02-09	sound	renegade-sound	2026-02-09 16:29:44.306654
210	2026-02-09	sound	vulcano-sound	2026-02-09 16:29:45.461338
211	2026-02-09	sound	stitcher-sound	2026-02-09 16:29:46.779948
212	2026-02-09	sound	ferro-sound	2026-02-09 16:29:50.066774
213	2026-02-09	sound	torrente-sound	2026-02-09 16:29:55.412879
214	2026-02-09	sound	il-toro-sound	2026-02-09 16:30:00.282848
215	2026-02-09	skill	mob_5c	2026-02-09 16:30:24.688882
216	2026-02-09	weapon	Burletta	2026-02-09 16:36:03.002922
217	2026-02-09	weapon	Anvil	2026-02-09 16:36:35.10387
218	2026-02-09	weapon	Osprey	2026-02-09 16:36:48.559826
219	2026-02-09	location	The_Blue_Gates	2026-02-09 16:37:04.849389
220	2026-02-09	blueprint	Advanced_Electrical_Components	2026-02-09 16:37:35.8274
221	2026-02-09	blueprint	Mechanical_Components	2026-02-09 16:38:10.747147
222	2026-02-09	blueprint	Advanced_Mechanical_Components	2026-02-09 16:38:42.494008
223	2026-02-09	blueprint	Electrical_Components	2026-02-09 16:38:53.982208
224	2026-02-09	sound	renegade-sound	2026-02-09 16:39:07.766415
225	2026-02-09	sound	il-toro-sound	2026-02-09 16:39:12.412166
226	2026-02-09	skill	cond_6l	2026-02-09 16:39:24.5679
227	2026-02-09	skill	cond_5l	2026-02-09 16:39:28.169839
228	2026-02-09	skill	mob_6r	2026-02-09 16:39:35.006372
229	2026-02-09	skill	cond_6r	2026-02-09 16:39:36.991207
230	2026-02-09	skill	cond_5r	2026-02-09 16:39:37.946586
231	2026-02-09	skill	cond_6c	2026-02-09 16:39:39.767301
232	2026-02-09	skill	cond_7l	2026-02-09 16:39:40.867234
233	2026-02-09	skill	cond_4l	2026-02-09 16:39:42.647157
234	2026-02-09	skill	cond_3l	2026-02-09 16:39:45.807022
235	2026-02-09	skill	cond_2l	2026-02-09 16:39:47.447914
236	2026-02-09	skill	cond_1	2026-02-09 16:39:48.247395
237	2026-02-09	skill	cond_2r	2026-02-09 16:39:48.847814
238	2026-02-09	skill	cond_4r	2026-02-09 16:39:49.567735
239	2026-02-09	skill	cond_5c	2026-02-09 16:39:50.087923
240	2026-02-09	skill	cond_7r	2026-02-09 16:39:50.727672
241	2026-02-09	skill	mob_6l	2026-02-09 16:39:52.132999
242	2026-02-09	skill	mob_6c	2026-02-09 16:39:52.447049
243	2026-02-09	skill	mob_5c	2026-02-09 16:39:52.966971
244	2026-02-09	skill	mob_4l	2026-02-09 16:39:53.427741
245	2026-02-09	weapon	Tempest	2026-02-09 17:58:52.942262
246	2026-02-09	weapon	Anvil	2026-02-09 17:58:58.920945
247	2026-02-09	weapon	Renegade	2026-02-09 17:59:05.613732
248	2026-02-09	weapon	Osprey	2026-02-09 17:59:23.489551
249	2026-02-09	location	The_Blue_Gates	2026-02-09 17:59:36.563793
250	2026-02-09	sound	vulcano-sound	2026-02-09 18:01:39.820299
251	2026-02-09	sound	osprey-sound	2026-02-09 18:01:54.668257
252	2026-02-09	sound	renegade-sound	2026-02-09 18:01:58.7802
253	2026-02-09	sound	il-toro-sound	2026-02-09 18:02:03.106273
254	2026-02-09	skill	cond_6l	2026-02-09 18:02:15.699335
255	2026-02-09	skill	cond_5l	2026-02-09 18:02:21.407847
256	2026-02-09	skill	cond_2r	2026-02-09 18:02:53.939929
257	2026-02-09	skill	cond_5c	2026-02-09 18:02:58.326793
258	2026-02-09	skill	surv_4l	2026-02-09 18:03:10.482886
259	2026-02-09	skill	mob_5c	2026-02-09 18:03:36.553766
260	2026-02-09	weapon	Rattler	2026-02-09 19:07:56.523688
261	2026-02-09	weapon	Renegade	2026-02-09 19:08:03.579198
262	2026-02-09	weapon	Osprey	2026-02-09 19:08:07.524698
263	2026-02-09	location	Buried_City	2026-02-09 19:08:25.110277
264	2026-02-09	location	Dam_Battlegrounds	2026-02-09 19:08:30.999647
265	2026-02-09	location	Spaceport	2026-02-09 19:08:33.660409
266	2026-02-09	location	The_Blue_Gates	2026-02-09 19:08:43.071436
267	2026-02-09	weapon	Anvil	2026-02-09 22:08:01.816635
268	2026-02-09	weapon	Tempest	2026-02-09 22:08:07.147044
269	2026-02-09	weapon	Osprey	2026-02-09 22:08:10.77432
270	2026-02-09	location	The_Blue_Gates	2026-02-09 22:08:19.382564
271	2026-02-09	blueprint	Electrical_Components	2026-02-09 22:09:40.996845
272	2026-02-09	skill	cond_6l	2026-02-09 22:09:55.903655
273	2026-02-09	skill	cond_5l	2026-02-09 22:09:57.541931
274	2026-02-09	skill	mob_5c	2026-02-09 22:10:04.146101
275	2026-02-09	weapon	Renegade	2026-02-09 22:23:37.716985
276	2026-02-09	weapon	Bettina	2026-02-09 22:23:46.928949
277	2026-02-09	weapon	Osprey	2026-02-09 22:23:55.225114
278	2026-02-09	location	Spaceport	2026-02-09 22:24:22.565634
279	2026-02-09	location	The_Blue_Gates	2026-02-09 22:24:28.708343
280	2026-02-09	blueprint	ARC_Circuitry	2026-02-09 22:25:24.008131
281	2026-02-09	sound	renegade-sound	2026-02-09 22:26:08.240465
282	2026-02-09	sound	il-toro-sound	2026-02-09 22:26:23.092431
283	2026-02-09	skill	cond_5l	2026-02-09 22:26:59.138274
284	2026-02-09	skill	cond_7l	2026-02-09 22:27:04.564653
285	2026-02-09	skill	cond_7r	2026-02-09 22:27:06.612267
286	2026-02-09	skill	surv_6r	2026-02-09 22:27:10.504601
287	2026-02-09	skill	mob_6r	2026-02-09 22:27:12.650682
288	2026-02-09	skill	mob_4r	2026-02-09 22:27:17.267217
289	2026-02-09	skill	mob_5r	2026-02-09 22:27:19.311062
290	2026-02-09	skill	mob_6c	2026-02-09 22:27:21.258719
291	2026-02-09	skill	mob_5c	2026-02-09 22:27:22.179447
292	2026-02-09	blueprint	ARC_Motion_Core	2026-02-09 22:27:32.928246
293	2026-02-09	blueprint	Light_Gun_Parts	2026-02-09 22:27:37.637268
295	2026-02-09	skill	mob_5r	2026-02-09 23:53:09.902412
297	2026-02-10	location	Buried_City	2026-02-10 00:23:19.286717
301	2026-02-10	weapon	Rattler	2026-02-10 01:16:55.57692
304	2026-02-10	weapon	Bettina	2026-02-10 01:17:11.731659
308	2026-02-10	skill	mob_5r	2026-02-10 01:17:39.291164
311	2026-02-10	weapon	Rattler	2026-02-10 01:58:34.092581
316	2026-02-10	weapon	Hairpin	2026-02-10 02:08:19.418572
294	2026-02-09	blueprint	Electrical_Components	2026-02-09 22:27:53.205213
299	2026-02-10	blueprint	Durable_Cloth	2026-02-10 00:23:49.521722
302	2026-02-10	weapon	Kettle	2026-02-10 01:16:59.491018
310	2026-02-10	weapon	Burletta	2026-02-10 01:58:27.614853
314	2026-02-10	skill	mob_2r	2026-02-10 01:58:47.418568
315	2026-02-10	weapon	Bobcat	2026-02-10 02:08:12.596239
296	2026-02-09	skill	mob_4r	2026-02-09 23:53:11.975919
303	2026-02-10	weapon	Arpeggio	2026-02-10 01:17:03.152899
305	2026-02-10	location	Buried_City	2026-02-10 01:17:18.517579
306	2026-02-10	blueprint	Durable_Cloth	2026-02-10 01:17:26.881541
307	2026-02-10	sound	osprey-sound	2026-02-10 01:17:34.542298
313	2026-02-10	weapon	Osprey	2026-02-10 01:58:45.565983
298	2026-02-10	blueprint	Advanced_Electrical_Components	2026-02-10 00:23:40.571776
300	2026-02-10	weapon	Venator	2026-02-10 01:16:48.602534
309	2026-02-10	skill	mob_2r	2026-02-10 01:17:43.912607
312	2026-02-10	weapon	Tempest	2026-02-10 01:58:39.413438
317	2026-02-10	weapon	Anvil	2026-02-10 02:14:06.367171
318	2026-02-10	weapon	Bettina	2026-02-10 02:14:10.826228
319	2026-02-10	location	Dam_Battlegrounds	2026-02-10 02:14:24.26509
320	2026-02-10	location	Spaceport	2026-02-10 02:14:28.822953
321	2026-02-10	location	Buried_City	2026-02-10 02:14:38.679814
322	2026-02-10	blueprint	Durable_Cloth	2026-02-10 02:15:13.805191
323	2026-02-10	sound	osprey-sound	2026-02-10 02:15:23.598657
324	2026-02-10	skill	mob_2r	2026-02-10 02:15:35.081058
325	2026-02-10	weapon	Bettina	2026-02-10 03:08:14.950794
326	2026-02-10	sound	ferro-sound	2026-02-10 03:08:59.514378
327	2026-02-10	sound	osprey-sound	2026-02-10 03:09:03.702545
328	2026-02-10	skill	mob_5r	2026-02-10 03:09:15.437288
329	2026-02-10	skill	mob_2r	2026-02-10 03:09:19.087472
330	2026-02-10	weapon	Stitcher	2026-02-10 04:24:44.075052
331	2026-02-10	weapon	Burletta	2026-02-10 04:25:04.49905
332	2026-02-10	weapon	Osprey	2026-02-10 04:25:08.852417
333	2026-02-10	weapon	IL_Toro	2026-02-10 04:25:13.153163
334	2026-02-10	weapon	Kettle	2026-02-10 04:25:18.82492
335	2026-02-10	weapon	Hairpin	2026-02-10 04:25:46.97848
336	2026-02-10	weapon	Anvil	2026-02-10 04:25:53.115756
337	2026-02-10	weapon	Bettina	2026-02-10 04:26:01.137501
338	2026-02-10	location	Buried_City	2026-02-10 04:26:12.693033
339	2026-02-10	blueprint	Durable_Cloth	2026-02-10 04:26:31.093513
340	2026-02-10	sound	ferro-sound	2026-02-10 04:26:40.367371
341	2026-02-10	sound	anvil-sound	2026-02-10 04:26:42.972486
342	2026-02-10	sound	osprey-sound	2026-02-10 04:26:59.59146
343	2026-02-10	skill	mob_2r	2026-02-10 04:27:14.316006
344	2026-02-10	weapon	Rattler	2026-02-10 04:52:03.966327
345	2026-02-10	weapon	Stitcher	2026-02-10 04:52:15.70443
346	2026-02-10	weapon	Bettina	2026-02-10 04:52:41.375295
347	2026-02-10	location	Buried_City	2026-02-10 04:53:38.912578
348	2026-02-10	blueprint	Mechanical_Components	2026-02-10 04:57:57.337964
349	2026-02-10	blueprint	Durable_Cloth	2026-02-10 04:58:47.304156
350	2026-02-10	sound	renegade-sound	2026-02-10 04:59:19.786484
351	2026-02-10	sound	osprey-sound	2026-02-10 04:59:34.071595
352	2026-02-10	skill	mob_2r	2026-02-10 04:59:54.93152
353	2026-02-10	weapon	Tempest	2026-02-10 08:40:30.867131
354	2026-02-10	weapon	Rattler	2026-02-10 08:40:49.241064
355	2026-02-10	weapon	Kettle	2026-02-10 08:40:59.401595
356	2026-02-10	weapon	Hullcracker	2026-02-10 08:41:02.992865
357	2026-02-10	weapon	Burletta	2026-02-10 08:41:07.496641
358	2026-02-10	weapon	Equalizer	2026-02-10 08:41:11.255587
359	2026-02-10	weapon	Torrente	2026-02-10 08:41:18.781753
360	2026-02-10	weapon	Hairpin	2026-02-10 08:41:24.888364
361	2026-02-10	weapon	Bettina	2026-02-10 08:41:28.115498
362	2026-02-10	location	Buried_City	2026-02-10 08:41:37.255141
363	2026-02-10	blueprint	Explosive_Compound	2026-02-10 08:41:47.064289
364	2026-02-10	blueprint	Durable_Cloth	2026-02-10 08:41:56.671763
365	2026-02-10	sound	anvil-sound	2026-02-10 08:42:05.996385
366	2026-02-10	sound	renegade-sound	2026-02-10 08:42:08.32059
367	2026-02-10	sound	osprey-sound	2026-02-10 08:42:10.410631
368	2026-02-10	skill	mob_1	2026-02-10 08:42:16.51192
369	2026-02-10	skill	surv_1	2026-02-10 08:42:17.581112
370	2026-02-10	skill	mob_2r	2026-02-10 08:42:21.251951
371	2026-02-10	location	Spaceport	2026-02-10 09:21:13.323473
372	2026-02-10	location	Dam_Battlegrounds	2026-02-10 09:21:21.750281
373	2026-02-10	location	Buried_City	2026-02-10 09:21:31.649329
374	2026-02-10	weapon	Stitcher	2026-02-10 09:21:59.933295
375	2026-02-10	weapon	Kettle	2026-02-10 09:22:11.091263
376	2026-02-10	weapon	Renegade	2026-02-10 09:22:19.309876
377	2026-02-10	weapon	Osprey	2026-02-10 09:22:29.387255
378	2026-02-10	weapon	Arpeggio	2026-02-10 09:22:51.870535
379	2026-02-10	weapon	Bettina	2026-02-10 09:23:04.43128
380	2026-02-10	sound	anvil-sound	2026-02-10 09:24:37.659995
381	2026-02-10	sound	renegade-sound	2026-02-10 09:24:47.60798
382	2026-02-10	weapon	Venator	2026-02-10 09:24:56.200475
383	2026-02-10	sound	ferro-sound	2026-02-10 09:24:59.468447
384	2026-02-10	weapon	Tempest	2026-02-10 09:25:06.95936
385	2026-02-10	weapon	Osprey	2026-02-10 09:25:10.366134
386	2026-02-10	weapon	Rattler	2026-02-10 09:25:23.272318
387	2026-02-10	weapon	Anvil	2026-02-10 09:25:29.83037
388	2026-02-10	weapon	IL_Toro	2026-02-10 09:25:34.309552
389	2026-02-10	weapon	Ferro	2026-02-10 09:25:37.207944
390	2026-02-10	weapon	Bettina	2026-02-10 09:25:44.277576
391	2026-02-10	location	Buried_City	2026-02-10 09:25:56.370718
392	2026-02-10	sound	anvil-sound	2026-02-10 09:26:10.085021
393	2026-02-10	sound	ferro-sound	2026-02-10 09:26:12.047908
394	2026-02-10	sound	Bettina	2026-02-10 09:26:14.220282
395	2026-02-10	sound	osprey-sound	2026-02-10 09:26:21.47325
396	2026-02-10	skill	mob_4l	2026-02-10 09:26:36.860528
397	2026-02-10	skill	mob_2r	2026-02-10 09:26:40.811286
398	2026-02-10	weapon	Rattler	2026-02-10 10:59:20.819628
399	2026-02-10	weapon	Kettle	2026-02-10 10:59:43.646036
400	2026-02-10	weapon	Stitcher	2026-02-10 10:59:54.534648
401	2026-02-10	weapon	Ferro	2026-02-10 11:00:09.054453
402	2026-02-10	weapon	Bobcat	2026-02-10 11:00:16.326912
403	2026-02-10	weapon	Tempest	2026-02-10 11:00:31.679423
404	2026-02-10	weapon	Anvil	2026-02-10 11:00:39.217671
405	2026-02-10	weapon	Bettina	2026-02-10 11:01:26.846402
406	2026-02-10	location	Spaceport	2026-02-10 11:01:50.191386
407	2026-02-10	location	Dam_Battlegrounds	2026-02-10 11:01:57.825376
408	2026-02-10	location	Buried_City	2026-02-10 11:02:01.747406
409	2026-02-10	blueprint	Durable_Cloth	2026-02-10 11:03:03.691737
410	2026-02-10	skill	mob_2r	2026-02-10 11:03:25.176852
411	2026-02-10	weapon	Hairpin	2026-02-10 11:47:41.804015
412	2026-02-10	weapon	Stitcher	2026-02-10 11:48:13.701027
413	2026-02-10	weapon	Renegade	2026-02-10 11:48:21.023435
414	2026-02-10	weapon	Kettle	2026-02-10 11:48:34.360264
415	2026-02-10	weapon	Bettina	2026-02-10 11:48:37.096282
416	2026-02-10	location	Buried_City	2026-02-10 11:48:51.311557
417	2026-02-10	blueprint	Explosive_Compound	2026-02-10 11:49:32.08335
418	2026-02-10	blueprint	Durable_Cloth	2026-02-10 11:49:40.598173
419	2026-02-10	sound	ferro-sound	2026-02-10 11:50:04.327335
420	2026-02-10	sound	Equalizer	2026-02-10 11:50:23.24503
421	2026-02-10	sound	Aphelion	2026-02-10 11:50:25.646755
422	2026-02-10	sound	Jupiter	2026-02-10 11:50:28.277901
423	2026-02-10	sound	anvil-sound	2026-02-10 11:50:50.056663
424	2026-02-10	sound	osprey-sound	2026-02-10 11:51:00.538781
425	2026-02-10	skill	mob_2r	2026-02-10 11:51:37.497402
426	2026-02-10	weapon	Bobcat	2026-02-10 14:40:09.64998
427	2026-02-10	weapon	Stitcher	2026-02-10 14:40:19.388023
428	2026-02-10	weapon	Rattler	2026-02-10 14:40:27.363329
429	2026-02-10	weapon	Torrente	2026-02-10 14:40:35.932972
430	2026-02-10	weapon	Equalizer	2026-02-10 14:41:39.132712
431	2026-02-10	weapon	Arpeggio	2026-02-10 14:42:10.911744
432	2026-02-10	weapon	Bettina	2026-02-10 14:42:27.775847
433	2026-02-10	location	Spaceport	2026-02-10 15:51:57.433718
434	2026-02-10	location	Dam_Battlegrounds	2026-02-10 15:52:02.492185
435	2026-02-10	location	Buried_City	2026-02-10 15:52:06.706139
436	2026-02-10	sound	anvil-sound	2026-02-10 15:52:38.776501
437	2026-02-10	sound	burletta-sound	2026-02-10 15:52:46.275239
438	2026-02-10	sound	hairpin-sound	2026-02-10 15:53:03.327143
439	2026-02-10	sound	arpeggio-sound	2026-02-10 15:53:30.43815
440	2026-02-10	sound	Equalizer	2026-02-10 15:53:48.120615
443	2026-02-10	sound	Jupiter	2026-02-10 15:54:09.311045
445	2026-02-10	sound	bobcat-sound	2026-02-10 15:54:21.175942
448	2026-02-10	sound	Rattler	2026-02-10 15:54:42.091488
463	2026-02-10	weapon	Rattler	2026-02-10 16:18:47.370545
466	2026-02-10	weapon	Bettina	2026-02-10 16:19:18.530417
468	2026-02-10	blueprint	Durable_Cloth	2026-02-10 16:19:51.738416
470	2026-02-10	sound	osprey-sound	2026-02-10 16:59:12.876126
473	2026-02-10	weapon	Tempest	2026-02-10 17:00:00.643799
475	2026-02-10	weapon	Hullcracker	2026-02-10 17:00:11.794539
482	2026-02-10	weapon	Bobcat	2026-02-10 18:46:49.488994
485	2026-02-10	weapon	Stitcher	2026-02-10 18:47:14.60167
490	2026-02-10	blueprint	Durable_Cloth	2026-02-10 18:49:01.288208
491	2026-02-10	skill	mob_5r	2026-02-10 18:49:14.964112
494	2026-02-10	sound	anvil-sound	2026-02-10 18:49:40.511026
441	2026-02-10	sound	ferro-sound	2026-02-10 15:53:54.536874
442	2026-02-10	sound	stitcher-sound	2026-02-10 15:54:05.489092
444	2026-02-10	sound	Hullcracker	2026-02-10 15:54:17.841948
446	2026-02-10	sound	renegade-sound	2026-02-10 15:54:27.708807
447	2026-02-10	sound	Aphelion	2026-02-10 15:54:38.514777
449	2026-02-10	sound	kettle-sound	2026-02-10 15:54:45.712452
455	2026-02-10	skill	mob_6c	2026-02-10 15:55:26.341721
458	2026-02-10	weapon	Kettle	2026-02-10 15:55:44.942533
459	2026-02-10	weapon	Venator	2026-02-10 16:16:57.688274
460	2026-02-10	weapon	Stitcher	2026-02-10 16:17:08.753309
461	2026-02-10	weapon	Arpeggio	2026-02-10 16:17:13.520633
464	2026-02-10	weapon	Kettle	2026-02-10 16:18:55.498082
465	2026-02-10	weapon	Bobcat	2026-02-10 16:19:14.524114
467	2026-02-10	location	Buried_City	2026-02-10 16:19:30.566016
469	2026-02-10	skill	mob_2r	2026-02-10 16:20:12.070032
472	2026-02-10	weapon	Renegade	2026-02-10 16:59:52.080184
474	2026-02-10	weapon	Hairpin	2026-02-10 17:00:07.466314
478	2026-02-10	weapon	Arpeggio	2026-02-10 17:00:27.065635
483	2026-02-10	weapon	Anvil	2026-02-10 18:46:57.034097
484	2026-02-10	weapon	Venator	2026-02-10 18:47:04.818117
489	2026-02-10	blueprint	Crude_Explosives	2026-02-10 18:48:39.834498
495	2026-02-10	sound	renegade-sound	2026-02-10 18:49:44.570149
450	2026-02-10	skill	mob_5l	2026-02-10 15:55:08.706962
451	2026-02-10	skill	mob_4l	2026-02-10 15:55:10.673723
452	2026-02-10	skill	mob_5r	2026-02-10 15:55:15.618801
453	2026-02-10	skill	mob_4r	2026-02-10 15:55:16.650108
454	2026-02-10	skill	mob_7l	2026-02-10 15:55:19.627974
456	2026-02-10	skill	mob_2r	2026-02-10 15:55:28.284571
457	2026-02-10	weapon	Stitcher	2026-02-10 15:55:38.52284
462	2026-02-10	weapon	Burletta	2026-02-10 16:17:29.043942
471	2026-02-10	weapon	Osprey	2026-02-10 16:59:43.1168
476	2026-02-10	weapon	Aphelion	2026-02-10 17:00:19.694688
477	2026-02-10	weapon	Anvil	2026-02-10 17:00:23.062362
479	2026-02-10	weapon	Bettina	2026-02-10 17:00:35.226271
480	2026-02-10	blueprint	Durable_Cloth	2026-02-10 17:00:54.408094
481	2026-02-10	weapon	Kettle	2026-02-10 18:46:38.662496
486	2026-02-10	weapon	Renegade	2026-02-10 18:47:20.62622
487	2026-02-10	weapon	Bettina	2026-02-10 18:47:25.175577
488	2026-02-10	location	Buried_City	2026-02-10 18:47:44.005903
492	2026-02-10	skill	mob_2r	2026-02-10 18:49:21.552612
493	2026-02-10	sound	ferro-sound	2026-02-10 18:49:32.711017
496	2026-02-10	sound	il-toro-sound	2026-02-10 18:50:14.34452
497	2026-02-10	sound	vulcano-sound	2026-02-10 18:51:13.331446
498	2026-02-10	weapon	Rattler	2026-02-10 22:45:00.259782
499	2026-02-10	weapon	Renegade	2026-02-10 22:45:08.4133
500	2026-02-10	weapon	Bettina	2026-02-10 22:45:10.593792
501	2026-02-10	location	Buried_City	2026-02-10 22:45:18.608208
502	2026-02-10	blueprint	Electrical_Components	2026-02-10 22:45:24.301933
503	2026-02-10	blueprint	Durable_Cloth	2026-02-10 22:45:38.67979
504	2026-02-10	sound	anvil-sound	2026-02-10 22:45:48.373116
505	2026-02-10	sound	il-toro-sound	2026-02-10 22:45:51.032839
506	2026-02-10	sound	Equalizer	2026-02-10 22:45:55.560214
507	2026-02-10	sound	osprey-sound	2026-02-10 22:45:58.797335
508	2026-02-10	skill	mob_2r	2026-02-10 22:46:15.430839
509	2026-02-10	weapon	Anvil	2026-02-10 23:34:40.517957
510	2026-02-10	weapon	Rattler	2026-02-10 23:35:20.982414
511	2026-02-10	weapon	Ferro	2026-02-10 23:35:34.200703
512	2026-02-10	weapon	Tempest	2026-02-10 23:35:51.424897
513	2026-02-10	weapon	Arpeggio	2026-02-10 23:36:07.123938
514	2026-02-10	weapon	Hullcracker	2026-02-10 23:36:33.907282
515	2026-02-10	weapon	Vulcano	2026-02-10 23:36:48.938284
516	2026-02-10	weapon	Venator	2026-02-10 23:37:10.107262
517	2026-02-10	weapon	IL_Toro	2026-02-10 23:37:16.633625
518	2026-02-10	weapon	Bobcat	2026-02-10 23:37:24.362923
519	2026-02-10	weapon	Hairpin	2026-02-10 23:37:32.369193
520	2026-02-10	weapon	Burletta	2026-02-10 23:37:44.313735
521	2026-02-10	weapon	Torrente	2026-02-10 23:37:58.161545
522	2026-02-10	weapon	Osprey	2026-02-10 23:38:15.552774
523	2026-02-10	weapon	Equalizer	2026-02-10 23:38:19.923749
524	2026-02-10	weapon	Jupiter	2026-02-10 23:38:36.632511
525	2026-02-10	weapon	Aphelion	2026-02-10 23:38:59.572924
526	2026-02-10	weapon	Bettina	2026-02-10 23:39:01.210592
527	2026-02-10	location	Buried_City	2026-02-10 23:39:52.313533
528	2026-02-10	sound	ferro-sound	2026-02-10 23:41:08.717513
529	2026-02-10	sound	Hullcracker	2026-02-10 23:41:43.885658
530	2026-02-10	sound	hairpin-sound	2026-02-10 23:41:49.847414
531	2026-02-10	sound	Jupiter	2026-02-10 23:41:59.13881
532	2026-02-10	sound	anvil-sound	2026-02-10 23:42:07.03485
533	2026-02-10	sound	stitcher-sound	2026-02-10 23:42:10.847368
534	2026-02-10	sound	osprey-sound	2026-02-10 23:42:14.119552
535	2026-02-10	skill	mob_2r	2026-02-10 23:42:47.823801
536	2026-02-11	blueprint	Advanced_Electrical_Components	2026-02-11 00:15:09.960577
537	2026-02-11	blueprint	Heavy_Gun_Parts	2026-02-11 00:15:25.897985
538	2026-02-11	blueprint	Light_Gun_Parts	2026-02-11 00:15:32.823601
539	2026-02-11	weapon	Bettina	2026-02-11 00:15:50.319151
540	2026-02-11	weapon	Kettle	2026-02-11 00:16:11.846375
541	2026-02-11	weapon	Burletta	2026-02-11 00:16:32.287692
542	2026-02-11	location	The_Blue_Gates	2026-02-11 00:16:47.778939
543	2026-02-11	sound	arpeggio-sound	2026-02-11 00:17:09.386637
544	2026-02-11	skill	cond_2r	2026-02-11 00:17:59.217218
545	2026-02-11	sound	arpeggio-sound	2026-02-11 01:34:42.177101
546	2026-02-11	weapon	Kettle	2026-02-11 02:30:21.682369
547	2026-02-11	weapon	Stitcher	2026-02-11 02:30:24.733826
548	2026-02-11	weapon	Tempest	2026-02-11 02:30:28.180202
549	2026-02-11	weapon	Rattler	2026-02-11 02:30:31.702414
550	2026-02-11	weapon	Bobcat	2026-02-11 02:30:37.769836
551	2026-02-11	weapon	Venator	2026-02-11 02:30:39.634773
552	2026-02-11	weapon	Arpeggio	2026-02-11 02:30:54.716806
553	2026-02-11	weapon	Burletta	2026-02-11 02:31:25.416181
554	2026-02-11	location	The_Blue_Gates	2026-02-11 02:31:38.394011
555	2026-02-11	blueprint	Complex_Gun_Parts	2026-02-11 02:32:19.119373
556	2026-02-11	blueprint	Heavy_Gun_Parts	2026-02-11 02:32:28.437993
557	2026-02-11	blueprint	Medium_Gun_Parts	2026-02-11 02:32:31.315567
558	2026-02-11	blueprint	Light_Gun_Parts	2026-02-11 02:32:34.460622
559	2026-02-11	skill	cond_2r	2026-02-11 02:32:43.149776
560	2026-02-11	sound	Venator	2026-02-11 02:32:57.916467
561	2026-02-11	sound	anvil-sound	2026-02-11 02:33:01.380445
562	2026-02-11	sound	bobcat-sound	2026-02-11 02:33:03.718595
563	2026-02-11	sound	Equalizer	2026-02-11 02:33:05.875219
564	2026-02-11	sound	Hullcracker	2026-02-11 02:33:07.955552
565	2026-02-11	sound	burletta-sound	2026-02-11 02:33:09.57864
566	2026-02-11	weapon	Burletta	2026-02-11 05:04:24.970007
567	2026-02-11	location	The_Blue_Gates	2026-02-11 05:04:40.17663
568	2026-02-11	blueprint	Heavy_Gun_Parts	2026-02-11 05:05:36.373651
569	2026-02-11	blueprint	Light_Gun_Parts	2026-02-11 05:05:50.215433
570	2026-02-11	sound	arpeggio-sound	2026-02-11 05:06:02.205568
571	2026-02-11	skill	cond_2r	2026-02-11 05:06:12.64209
\.


--
-- Data for Name: favorite_votes; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.favorite_votes (id, date, category, favorite_slug, player_id, created_at) FROM stdin;
1	2026-02-09	arc	ARC_Surveyor	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 13:33:12.390286
2	2026-02-09	arc	ARC_Surveyor	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:09:53.574625
3	2026-02-09	arc	ARC_Tick	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:32:05.38682
4	2026-02-10	trader	ARC_Surveyor	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:19:15.547085
6	2026-02-10	trader	ARC_Rocketeer	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 16:01:30.097073
5	2026-02-10	trader	ARC_Bastion	72fee5f1-d4be-44cb-8af0-a8386619994b	2026-02-10 05:34:30.527664
7	2026-02-11	arc	ARC_Surveyor	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:20:45.969721
8	2026-02-11	arc	ARC_Surveyor	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:37:36.960338
\.


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.locations (id, slug, name, image, region) FROM stdin;
1	The_Blue_Gates	The Blue Gates	\N	Veldt
2	Buried_City	Buried City	\N	Veldt
3	Dam_Battlegrounds	Dam Battlegrounds	\N	Veldt
4	Spaceport	Spaceport	\N	Veldt
5	Stella_Montis	Stella Montis	\N	Veldt
\.


--
-- Data for Name: materials; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.materials (id, slug, name, rarity, image) FROM stdin;
1	Advanced_ARC_Powercell	Advanced ARC Powercell	Rare	items/Advanced_ARC_Powercell.webp
2	Advanced_Electrical_Components	Advanced Electrical Components	Uncommon	items/Advanced_Electrical_Components.webp
3	Advanced_Mechanical_Components	Advanced Mechanical Components	Rare	items/Advanced_Mechanical_Components.webp
4	Agave	Agave	Common	items/Agave.webp
5	Agave_Juice	Agave Juice	Uncommon	items/Agave_Juice.webp
6	Antiseptic	Antiseptic	Uncommon	items/Antiseptic.webp
7	Apricot	Apricot	Common	items/Apricot.webp
8	ARC_Alloy	ARC Alloy	Rare	items/ARC_Alloy.webp
9	ARC_Circuitry	ARC Circuitry	Rare	items/ARC_Circuitry.webp
10	ARC_Motion_Core	ARC Motion Core	Rare	items/ARC_Motion_Core.webp
11	ARC_Powercell	ARC Powercell	Uncommon	items/ARC_Powercell.webp
12	Battery	Battery	Common	items/Battery.webp
13	Canister	Canister	Common	items/Canister.webp
14	Chemicals	Chemicals	Common	items/Chemicals.webp
15	Complex_Gun_Parts	Complex Gun Parts	Rare	items/Complex_Gun_Parts.webp
16	Crude_Explosives	Crude Explosives	Common	items/Crude_Explosives.webp
17	Duct_Tape	Duct Tape	Common	items/Duct_Tape.webp
18	Durable_Cloth	Durable Cloth	Uncommon	items/Durable_Cloth.webp
19	Electrical_Components	Electrical Components	Common	items/Electrical_Components.webp
20	Exodus_Modules	Exodus Modules	Legendary	items/Exodus_Modules.webp
21	Explosive_Compound	Explosive Compound	Uncommon	items/Explosive_Compound.webp
22	Fabric	Fabric	Common	items/Fabric.webp
23	Great_Mullein	Great Mullein	Common	items/Great_Mullein.webp
24	Heavy_Gun_Parts	Heavy Gun Parts	Uncommon	items/Heavy_Gun_Parts.webp
25	Light_Gun_Parts	Light Gun Parts	Uncommon	items/Light_Gun_Parts.webp
26	Magnet	Magnet	Common	items/Magnet.webp
27	Magnetic_Accelerator	Magnetic Accelerator	Rare	items/Magnetic_Accelerator.webp
28	Mechanical_Components	Mechanical Components	Common	items/Mechanical_Components.webp
29	Medium_Gun_Parts	Medium Gun Parts	Uncommon	items/Medium_Gun_Parts.webp
30	Metal_Parts	Metal Parts	Common	items/Metal_Parts.webp
31	Mod_Components	Mod Components	Uncommon	items/Mod_Components.webp
32	Moss	Moss	Common	items/Moss.webp
33	Oil	Oil	Common	items/Oil.webp
34	Plastic_Parts	Plastic Parts	Common	items/Plastic_Parts.webp
35	PowerRod	Power Rod	Rare	items/PowerRod.webp
36	Processor	Processor	Uncommon	items/Processor.webp
37	Rope	Rope	Common	items/Rope.webp
38	Rubber_Parts	Rubber Parts	Common	items/Rubber_Parts.webp
39	Sensors	Sensors	Uncommon	items/Sensors.webp
40	Simple_Gun_Parts	Simple Gun Parts	Common	items/Simple_Gun_Parts.webp
41	Speaker_Component	Speaker Component	Common	items/Speaker_Component.webp
42	Steel_Spring	Steel Spring	Common	items/Steel_Spring.webp
43	Synthesized_Fuel	Synthesized Fuel	Common	items/Synthesized_Fuel.webp
44	Syringe	Syringe	Common	items/Syringe.webp
45	Voltage_Converter	Voltage Converter	Uncommon	items/Voltage_Converter.webp
46	Wires	Wires	Common	items/Wires.webp
\.


--
-- Data for Name: run_plays; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.run_plays (id, player_id, created_at) FROM stdin;
1	a9ebff73-73e0-4373-a629-a1c5cd9627ca	2026-02-09 11:18:37.463818
2	a9ebff73-73e0-4373-a629-a1c5cd9627ca	2026-02-09 11:18:53.152356
3	a9ebff73-73e0-4373-a629-a1c5cd9627ca	2026-02-09 11:19:00.314792
4	e8dd8f60-5ec3-41a4-8153-5a66815e25a3	2026-02-09 13:08:07.509048
5	e8dd8f60-5ec3-41a4-8153-5a66815e25a3	2026-02-09 13:08:14.693017
6	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 13:33:42.317545
7	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 13:33:58.432584
8	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 13:34:06.770561
9	3895413e-cfc9-46af-86fe-408b7d0293e1	2026-02-09 14:39:57.053739
10	3895413e-cfc9-46af-86fe-408b7d0293e1	2026-02-09 14:40:10.361101
11	3895413e-cfc9-46af-86fe-408b7d0293e1	2026-02-09 14:40:19.978101
12	3895413e-cfc9-46af-86fe-408b7d0293e1	2026-02-09 14:40:27.686573
13	3895413e-cfc9-46af-86fe-408b7d0293e1	2026-02-09 14:40:36.777087
14	3895413e-cfc9-46af-86fe-408b7d0293e1	2026-02-09 14:40:49.619478
15	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:05:33.474405
16	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:05:42.946211
17	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:05:48.315335
18	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:05:53.373822
19	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:05:58.548911
20	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:04.266412
21	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:09.207446
22	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:13.894074
23	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:18.81404
24	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:24.207913
25	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:28.227483
26	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:33.360155
27	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:38.360231
28	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:42.424678
29	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:47.444596
30	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:52.069866
31	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:06:56.475024
32	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:01.891418
33	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:05.608359
34	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:09.754536
35	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:14.069338
36	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:18.006937
37	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:28.648095
38	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:32.405575
39	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:36.101778
40	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:39.925727
41	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:07:44.294858
42	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:08:12.516225
43	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:08:16.252347
44	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:08:20.582
45	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:08:25.109813
46	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:08:38.932042
47	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:08:42.527072
48	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:08:49.845086
49	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:08:55.885112
50	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:08:59.773117
51	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:09:03.847778
52	71a91031-5145-4b3a-a6f9-78c51c329012	2026-02-09 16:30:49.367157
53	71a91031-5145-4b3a-a6f9-78c51c329012	2026-02-09 16:30:55.853425
54	71a91031-5145-4b3a-a6f9-78c51c329012	2026-02-09 16:31:12.264131
55	71a91031-5145-4b3a-a6f9-78c51c329012	2026-02-09 16:31:26.74339
56	71a91031-5145-4b3a-a6f9-78c51c329012	2026-02-09 16:31:32.14606
57	71a91031-5145-4b3a-a6f9-78c51c329012	2026-02-09 16:31:36.220675
58	71a91031-5145-4b3a-a6f9-78c51c329012	2026-02-09 16:31:40.820925
59	71a91031-5145-4b3a-a6f9-78c51c329012	2026-02-09 16:31:45.467203
60	1ec2f2db-47b5-4a62-aca6-c5073b8e141a	2026-02-09 16:40:08.706263
61	1ec2f2db-47b5-4a62-aca6-c5073b8e141a	2026-02-09 16:40:45.281782
62	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:29:26.133366
63	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:29:34.273145
64	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:29:45.409305
65	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:29:54.161562
66	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:30:04.686927
67	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:30:19.149444
68	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:30:31.996144
69	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:30:49.986566
70	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:18:02.477881
71	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:18:07.351915
72	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:18:12.521162
73	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:18:16.743544
74	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:18:23.76103
75	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:18:29.042745
76	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:18:33.14869
77	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:18:38.794197
78	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:18:44.996661
79	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:16:27.55914
80	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:16:46.474958
81	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:16:52.886153
82	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:16:58.015341
83	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:17:03.67146
84	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:17:08.34008
85	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:17:13.536572
86	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:17:19.429199
87	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:17:29.372081
88	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:17:40.95976
89	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:17:58.703066
90	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:18:05.177975
91	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:18:10.104565
92	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:18:17.989454
93	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:18:23.950379
94	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:18:28.809161
95	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:18:34.417457
96	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 02:18:38.242071
97	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:56:44.654213
98	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:56:53.529545
99	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:57:07.291931
101	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:57:24.536641
100	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:57:14.396566
102	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:57:41.472718
103	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:57:57.952914
104	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:58:06.86648
105	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:58:12.763213
106	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:58:30.219444
107	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:58:41.816017
108	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:58:56.233399
109	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:59:03.613073
110	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:59:08.410597
111	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:59:15.325862
112	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:59:19.418666
113	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:59:24.103256
114	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:59:28.870422
115	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:59:35.828079
116	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:59:40.40219
117	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:59:44.459635
118	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:13:48.235318
119	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:14:03.147207
120	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:14:11.321954
121	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:18:35.861943
122	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:18:47.068746
123	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:18:52.740083
124	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:19:03.415806
125	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:19:22.341694
126	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:19:32.635714
127	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:19:36.555797
128	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:19:41.92327
129	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:19:45.963549
130	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:19:52.624286
131	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:35:32.892382
132	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:35:43.830367
133	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:35:50.603094
134	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:35:58.4735
135	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:36:04.076582
136	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:36:08.485619
137	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:36:13.563716
138	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:36:18.145053
139	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-11 01:36:24.700926
\.


--
-- Data for Name: run_scores; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.run_scores (id, nickname, score, player_id, created_at) FROM stdin;
1	juf	189603	\N	2026-02-09 11:19:10.227378
2	Tsotsi	217889	\N	2026-02-09 14:41:01.400838
3	Scowl	162530	\N	2026-02-09 16:07:22.133181
4	Scowl	200422	\N	2026-02-09 16:08:29.480634
5	Henlo57	46457	\N	2026-02-09 16:31:04.320534
6	Henlo57	65003	\N	2026-02-09 16:31:20.923516
7	Henlo57	231500	\N	2026-02-09 16:31:52.53572
8	Daylight	96989	\N	2026-02-09 16:40:29.077788
9	Lucker	232516	\N	2026-02-10 01:18:54.586371
10	Cyph	196524	\N	2026-02-10 02:17:50.953272
11	Operator	209835	\N	2026-02-10 15:57:51.507415
12	Operator	418619	\N	2026-02-10 15:58:49.564358
13	Bob	125013	\N	2026-02-11 00:19:11.982043
14	picobots	93119	\N	2026-02-11 01:36:33.12929
\.


--
-- Data for Name: shield_materials; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.shield_materials (id, shield_id, material_id, quantity, reveal_order) FROM stdin;
1	1	8	2	1
2	1	34	4	2
3	2	12	4	1
4	2	9	1	2
5	3	35	1	1
6	3	45	2	2
\.


--
-- Data for Name: shields; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.shields (id, slug, name, rarity, image, hq_image) FROM stdin;
1	Light_Shield	Light Shield	Uncommon	shields/Light_Shield.webp	shields/HQ/Light_Shield.png
2	Medium_Shield	Medium Shield	Rare	shields/Medium_Shield.webp	shields/HQ/Medium_Shield.png
3	Heavy_Shield	Heavy Shield	Epic	shields/Heavy_Shield.webp	shields/HQ/Heavy_Shield.png
\.


--
-- Data for Name: skills; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.skills (id, skill_id, name_en, name_ru, description_en, description_ru, category, position_x, position_y, prerequisites, is_major) FROM stdin;
1	cond_1	Used To The Weight	Привык к весу	Wearing a shield doesn't slow you down as much.	Ношение щита не так сильно замедляет вас.	conditioning	25	75	[]	t
2	cond_2l	Blast-Born	Рождённый взрывом	Your hearing is less affected by nearby explosions.	Ваш слух меньше страдает от близких взрывов.	conditioning	17	65	["cond_1"]	f
3	cond_2r	Gentle Pressure	Мягкое давление	You make less noise when breaching.	Вы производите меньше шума при взломе.	conditioning	33	65	["cond_1"]	f
4	cond_3l	Fight Or Flight	Бей или беги	When you're hurt in combat, regain a fixed amount of stamina. Has a cooldown between uses.	Когда вы получаете урон в бою, восстанавливается фиксированное количество выносливости. Имеет время восстановления между использованиями.	conditioning	17	55	["cond_2l"]	f
5	cond_3r	Proficient Pryer	Опытный взломщик	Breaching doors and containers takes less time	Взлом дверей и контейнеров занимает меньше времени	conditioning	33	55	["cond_2r"]	f
6	cond_4l	Survivor's Stamina	Выносливость выжившего	When you're critically hurt, your stamina regenerates faster.	Когда вы критически ранены, ваша выносливость восстанавливается быстрее.	conditioning	17	45	["cond_3l"]	t
7	cond_4r	Unburdened Roll	Облегчённый перекат	If your shield breaks, your first Dodge Roll within a few seconds does not cost stamina.	Если ваш щит ломается, первый перекат в течение нескольких секунд не расходует выносливость.	conditioning	33	45	["cond_3r"]	t
8	cond_5c	A Little Extra	Немного дополнительно	Breaching an object generates resources.	Взлом объекта генерирует ресурсы.	conditioning	25	35	["cond_4l", "cond_4r"]	f
9	cond_5l	Downed But Determined	Сбит, но полон решимости	When you're downed, it takes longer before you collapse.	Когда вас сбивают, до полного падения проходит больше времени.	conditioning	17	35	["cond_4l"]	f
10	cond_5r	Effortless Swing	Лёгкий замах	Melee abilities cost less stamina.	Способности ближнего боя расходуют меньше выносливости.	conditioning	33	35	["cond_4r"]	f
11	cond_6c	Loaded Arms	Привычное оружие	Your equipped weapon has less impact on your encumbrance.	Экипированное оружие меньше влияет на вашу нагрузку.	conditioning	25	25	["cond_5c"]	f
12	cond_6l	Turtle Crawl	Черепаший панцирь	While downed, you take less damage.	В состоянии при смерти вы получаете меньше урона.	conditioning	17	25	["cond_5l"]	f
13	cond_6r	Sky-Clearing Swing	Удар по небу	You deal more melee damage to drones.	Вы наносите больше урона дронам в ближнем бою.	conditioning	33	25	["cond_5r"]	f
14	cond_7l	Back On Your Feet	Снова на ногах	When you're critically hurt, your health regenerates until a certain limit.	Когда вы критически ранены, ваше здоровье восстанавливается до определённого предела.	conditioning	17	15	["cond_6l", "cond_6c"]	t
15	cond_7r	Flyswatter	Мухобойка	A single melee attack destroys a Tick, Pop, Wasp and Turret.	Одна атака ближнего боя уничтожает клеща, попа, осу и турель.	conditioning	33	15	["cond_6r", "cond_6c"]	t
16	mob_1	Nimble Climber	Ловкий скалолаз	You can climb and vault more quickly.	Вы можете быстрее карабкаться и перепрыгивать.	mobility	50	75	[]	t
17	mob_2l	Marathon Runner	Марафонец	Moving around costs less stamina.	Передвижение требует меньше выносливости.	mobility	42	65	["mob_1"]	f
18	mob_2r	Slip and Slide	Скольжение	You can slide further and faster.	Вы можете скользить дальше и быстрее.	mobility	58	65	["mob_1"]	f
19	mob_3l	Youthful Lungs	Молодые лёгкие	Increase your max stamina.	Увеличивает максимальную выносливость.	mobility	42	55	["mob_2l"]	f
20	mob_3r	Sturdy Ankles	Крепкие лодыжки	You take less fall damage when falling from a non-lethal height.	Вы получаете меньше урона от падения с несмертельной высоты.	mobility	58	55	["mob_2r"]	f
21	mob_4l	Carry The Momentum	Сохранить импульс	After a Sprint Dodge Roll, sprinting does not consume stamina for a short time. Has a cooldown between uses.	После перекатывания в спринте бег не расходует выносливость в течение короткого времени. Имеет время восстановления между использованиями.	mobility	42	45	["mob_3l"]	t
22	mob_4r	Calming Stroll	Спокойная прогулка	While walking, your stamina regenerates as if you were standing still.	Во время ходьбы ваша выносливость восстанавливается так же, как при стоянии на месте.	mobility	58	45	["mob_3r"]	t
23	mob_5c	Crawl Before You Walk	Сначала ползи	When you're downed, you crawl faster.	Когда вы сбиты с ног, вы ползаете быстрее.	mobility	50	35	["mob_4l", "mob_4r"]	f
24	mob_5l	Effortless Roll	Легкий перекат	Dodge Rolls cost less stamina.	Перекаты расходуют меньше выносливости.	mobility	42	35	["mob_4l"]	f
25	mob_5r	Off The Wall	От стены	You can Wall Leap further.	Вы можете прыгать от стены дальше.	mobility	58	35	["mob_4r"]	f
26	mob_6c	Vigorous Vaulter	Энергичный прыгун	Vaulting is no longer slowed down while exhausted.	Прыжки через препятствия больше не замедляются при истощении.	mobility	50	25	["mob_5c"]	f
27	mob_6l	Heroic Leap	Героический прыжок	You can Sprint Dodge Roll further.	Вы можете перекатываться в спринте дальше.	mobility	42	25	["mob_5l"]	f
28	mob_6r	Ready To Roll	Готов к перекату	When falling, your timing window to perform a Recovery Roll is increased.	При падении временное окно для выполнения восстанавливающего переката увеличивается.	mobility	58	25	["mob_5r"]	f
29	mob_7l	Vaults on Vaults on Vaults	Прыжок за прыжком	Vaulting no longer costs stamina.	Прыжки через препятствия больше не расходуют выносливость.	mobility	42	15	["mob_6l", "mob_6c"]	t
30	mob_7r	Vault Spring	Прыжок с разбега	Lets you jump at the end of a vault.	Позволяет прыгать в конце прыжка через препятствие.	mobility	58	15	["mob_6r", "mob_6c"]	t
31	surv_1	Agile Croucher	Проворный ползун	Your movement speed while crouching is increased.	Скорость передвижения в присяде увеличена.	survival	75	75	[]	t
32	surv_2l	Looter's Instincts	Инстинкты мародёра	When searching a container, loot is revealed faster.	При обыске контейнера добыча обнаруживается быстрее.	survival	67	65	["surv_1"]	f
33	surv_2r	Revitalizing Squat	Восстанавливающий присед	Stamina regeneration while crouched is increased.	Восстановление выносливости в присяде увеличено.	survival	83	65	["surv_1"]	f
34	surv_3l	Silent Scavenger	Тихий падальщик	You make less noise when looting	Вы производите меньше шума при мародёрстве	survival	67	55	["surv_2l"]	f
35	surv_3r	In-Round Crafting	Крафт в раунде	Unlocks the ability to field-craft items while topside.	Открывает возможность создавать предметы в полевых условиях на поверхности.	survival	83	55	["surv_2r"]	f
36	surv_4l	Suffer In Silence	Страдать молча	While critically hurt, your movement makes less noise.	В критическом состоянии ваши движения производят меньше шума.	survival	67	45	["surv_3l"]	t
37	surv_4r	Good As New	Как новенький	While under a healing effect, stamina regeneration is increased.	Под действием лечения восстановление выносливости увеличено.	survival	83	45	["surv_3r"]	t
38	surv_5c	Traveling Tinkerer	Странствующий мастер	Unlocks additional items to field craft.	Открывает дополнительные предметы для полевого крафта.	survival	75	35	["surv_4l", "surv_4r"]	f
39	surv_5l	Broad Shoulders	Широкие плечи	Increases the maximum amount of items you can carry.	Увеличивает максимальное количество предметов, которые вы можете нести.	survival	67	35	["surv_4l"]	f
40	surv_5r	Stubborn Mule	Упрямый мул	Your stamina regeneration is less affected by being over-encumbered.	Восстановление выносливости меньше зависит от перегруза.	survival	83	35	["surv_4r"]	f
41	surv_6c	One Raider's Scraps	Обрывки рейдера	When looting Raider containers, you have a small chance of finding additional field-crafted items.	При обыске контейнеров рейдеров у вас есть небольшой шанс найти дополнительные самодельные предметы.	survival	75	25	["surv_5c"]	f
42	surv_6l	Looter's Luck	Удача мародёра	While looting, there's a chance to reveal twice as many items at once.	Во время обыска есть шанс обнаружить вдвое больше предметов за раз.	survival	67	25	["surv_5l"]	f
43	surv_6r	Three Deep Breaths	Три глубоких вдоха	After an ability drains your stamina, you recover more quickly.	После того как способность истощает вашу выносливость, вы восстанавливаетесь быстрее.	survival	83	25	["surv_5r"]	f
44	surv_7l	Security Breach	Взлом защиты	Lets you breach Security Lockers.	Позволяет взламывать защищённые шкафчики.	survival	67	15	["surv_6l", "surv_6c"]	t
45	surv_7r	Minesweeper	Сапёр	Mines and explosive deployables can be defused when in close proximity.	Мины и взрывные устройства можно обезвредить, находясь рядом.	survival	83	15	["surv_6r", "surv_6c"]	t
\.


--
-- Data for Name: sounds; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.sounds (id, slug, name, category, sound_file, image, hq_image) FROM stdin;
1	anvil-sound	Anvil	weapon	weapons/sounds/Anvil.mp3	weapons/Anvil.webp	weapons/HQ/Anvil.png
2	arpeggio-sound	Arpeggio	weapon	weapons/sounds/Arpeggio.mp3	weapons/Arpeggio.webp	weapons/HQ/Arpeggio.png
3	bobcat-sound	Bobcat	weapon	weapons/sounds/Bobcat.mp3	weapons/Bobcat.webp	weapons/HQ/Bobcat.png
4	burletta-sound	Burletta	weapon	weapons/sounds/Burletta.mp3	weapons/Burletta.webp	weapons/HQ/Burletta.png
5	ferro-sound	Ferro	weapon	weapons/sounds/Ferro.mp3	weapons/Ferro.webp	weapons/HQ/Ferro.png
6	hairpin-sound	Hairpin	weapon	weapons/sounds/Hairpin.mp3	weapons/Hairpin.webp	weapons/HQ/Hairpin.png
7	il-toro-sound	IL Toro	weapon	weapons/sounds/IL_Toro.mp3	weapons/IL_Toro.webp	weapons/HQ/IL_Toro.png
8	kettle-sound	Kettle	weapon	weapons/sounds/Kettle.mp3	weapons/Kettle.webp	weapons/HQ/Kettle.png
9	osprey-sound	Osprey	weapon	weapons/sounds/Osprey.mp3	weapons/Osprey.webp	weapons/HQ/Osprey.png
10	renegade-sound	Renegade	weapon	weapons/sounds/Renegade.mp3	weapons/Renegade.webp	weapons/HQ/Renegade.png
11	stitcher-sound	Stitcher	weapon	weapons/sounds/Stitcher.mp3	weapons/Stitcher.webp	weapons/HQ/Stitcher.png
12	torrente-sound	Torrente	weapon	weapons/sounds/Torrente.mp3	weapons/Torrente.webp	weapons/HQ/Torrente.png
13	vulcano-sound	Vulcano	weapon	weapons/sounds/Vulcano.mp3	weapons/Vulcano.webp	weapons/HQ/Vulcano.png
\.


--
-- Data for Name: visits; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.visits (id, player_id, created_at) FROM stdin;
1	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 07:55:56.197628
2	6cccf27e-5969-4bb2-a1d6-8b43fd9d38e1	2026-02-09 08:01:42.679033
3	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 08:07:58.061948
4	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 08:21:37.110924
5	40112669-d17e-4443-9eda-23c99d6c9263	2026-02-09 08:21:42.854907
6	edd42fef-9c56-4a49-a76d-ebe8d48fe124	2026-02-09 08:22:03.579887
7	fad22945-cbc0-4f26-94c4-dfc0412acb31	2026-02-09 08:22:05.958755
8	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 08:22:19.564292
9	9fb0ca60-bdc8-40b1-83e2-cdca97ae5596	2026-02-09 08:22:22.771236
10	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 08:50:46.04492
11	4292fb8c-470a-4fd1-a8d4-d8608f2d0cad	2026-02-09 08:54:29.195986
12	4292fb8c-470a-4fd1-a8d4-d8608f2d0cad	2026-02-09 08:54:45.565182
13	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:00:56.492214
14	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:00:56.49273
15	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:08:44.963948
16	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:08:44.964565
17	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:09:46.209785
18	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:09:46.209488
19	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:10:14.791133
20	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:10:14.791626
21	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:10:23.826444
22	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:10:23.829724
23	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:10:56.870661
24	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:10:56.871093
25	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 09:16:05.974676
26	3e55b8d2-6943-403f-b317-537f8dc6041d	2026-02-09 09:20:08.097289
27	ba5a2f35-4f90-4194-ba10-ae9310a175f4	2026-02-09 09:21:30.225823
28	3a6f2e8a-bf45-4f65-8261-071502dee272	2026-02-09 09:21:33.462011
29	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:30:14.566679
30	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:30:14.580074
31	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:33:01.957578
32	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:33:01.957818
33	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 09:34:23.303412
34	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 09:35:28.563339
35	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:36:37.229267
36	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:36:37.246216
37	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:36:38.556705
38	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-09 09:36:38.566362
39	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 09:38:38.788893
40	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 09:38:57.932231
41	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 09:48:37.183492
42	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 10:37:39.799729
43	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 10:40:10.748542
44	9b979f04-87ae-4a2a-9878-f18c06e3774e	2026-02-09 10:40:18.967107
45	b63c33b6-39ee-4bdd-a266-4f6d8a57f615	2026-02-09 10:40:18.999978
46	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 10:43:41.975748
47	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 10:47:16.982139
48	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 10:50:32.400151
49	d0a090a6-78d1-494b-990f-0ffaa257fc5d	2026-02-09 10:52:03.664979
50	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 10:54:28.416235
51	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 10:56:18.401149
52	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 10:56:26.264707
53	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 11:05:50.563627
54	4ac17081-87f6-4a9f-ab88-f0b9a6b14a49	2026-02-09 11:06:32.264286
55	54d3cc88-2881-45ce-bd65-93035eef5812	2026-02-09 11:11:29.116421
56	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 11:13:07.800422
57	a9ebff73-73e0-4373-a629-a1c5cd9627ca	2026-02-09 11:15:55.462141
58	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 11:17:11.022569
59	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 11:17:50.672293
60	a9ebff73-73e0-4373-a629-a1c5cd9627ca	2026-02-09 11:18:19.902535
61	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 11:18:26.240217
62	e04e54a5-e9f7-471a-8e43-b95d2c3c0d72	2026-02-09 11:35:25.089379
63	592790d1-66c1-42db-b05f-fa6d728e3f7b	2026-02-09 11:35:25.928109
64	d8eae26c-e074-4ae0-a5d3-55c730fa224d	2026-02-09 11:41:49.955759
65	1e522662-8ba2-44ea-90e9-65969d11acce	2026-02-09 11:46:34.176607
66	ecd180a5-545f-4f00-a962-5580d03d0f00	2026-02-09 11:47:16.458613
67	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 11:52:45.02872
68	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 11:52:52.637439
69	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 11:53:33.948541
70	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-09 11:53:41.436577
71	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 11:56:26.050759
72	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 12:02:33.529384
73	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 12:03:26.293861
74	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 12:03:33.428235
75	f304e4a3-ee51-4988-992e-4edfd849ed76	2026-02-09 12:13:11.536749
76	67bd15a5-ee15-47ee-a347-79c0fc8e752c	2026-02-09 12:13:15.178935
77	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	2026-02-09 12:13:40.189597
78	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 12:39:29.201758
79	e8dd8f60-5ec3-41a4-8153-5a66815e25a3	2026-02-09 12:45:46.468409
80	e1f0908f-0edf-4ff6-a622-96f4d60eafce	2026-02-09 12:45:49.212446
81	49824496-8ad8-4479-a594-00e11a10b9f1	2026-02-09 12:54:44.858446
82	bc2f980e-700e-4261-858b-b7099ce75e78	2026-02-09 13:08:30.201374
83	1e522662-8ba2-44ea-90e9-65969d11acce	2026-02-09 13:25:00.567115
84	d7bf730d-8edc-4466-b264-fba628ef7674	2026-02-09 13:26:54.183535
85	b5bd4b30-988f-48c6-95c9-20c242d4e498	2026-02-09 13:29:47.03975
86	fc334888-f7f6-4dab-a69e-3c0f44753d79	2026-02-09 13:29:56.843281
87	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 13:33:30.221521
88	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 13:34:22.703002
89	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 13:35:31.420569
90	2b8a0a4f-43c4-4e00-8f33-06c29316cc03	2026-02-09 13:48:21.752382
91	d7bf730d-8edc-4466-b264-fba628ef7674	2026-02-09 13:58:46.076283
92	2f875be2-9eaa-438d-9596-1dc9e74d3f4b	2026-02-09 14:08:50.120211
93	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-09 14:08:59.360154
94	3895413e-cfc9-46af-86fe-408b7d0293e1	2026-02-09 14:31:41.611514
95	1a104071-aae0-45c7-af80-9285e0f0cd02	2026-02-09 14:33:39.500277
96	b7415ebd-1e21-4d4a-82b8-84aba9aaaa23	2026-02-09 15:01:11.394233
97	1c859459-b1d1-4325-b394-d164ea38c2a4	2026-02-09 15:15:00.969418
98	fc334888-f7f6-4dab-a69e-3c0f44753d79	2026-02-09 15:58:40.949321
103	bb7eb832-2249-4039-a3ff-9bffad38d11e	2026-02-09 17:44:11.705749
109	1d20a607-6143-408d-bc37-24e755fec8c8	2026-02-09 22:07:55.251709
111	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	2026-02-09 22:29:15.325819
117	7ba785fd-9491-4206-b153-2b957629971b	2026-02-09 23:48:35.473741
124	bad4b197-256b-4e28-913d-a57390ae31d3	2026-02-10 00:48:37.478824
130	d8eae26c-e074-4ae0-a5d3-55c730fa224d	2026-02-10 01:58:01.911046
99	dfdbad65-7c53-4906-9b4a-6e68de8ff815	2026-02-09 16:01:02.521986
101	71a91031-5145-4b3a-a6f9-78c51c329012	2026-02-09 16:25:32.82638
106	c1b86c62-a0be-4d90-b64b-190831c3ce66	2026-02-09 19:07:36.623794
107	06fdc843-1a41-4de5-b322-44ffc09c0bc5	2026-02-09 19:19:59.684574
112	bc2f980e-700e-4261-858b-b7099ce75e78	2026-02-09 23:17:00.478872
116	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 23:35:29.04174
118	f5cb6549-3190-4fc1-8e1d-15bb836c213f	2026-02-09 23:52:25.178338
120	acf18e40-6710-41ab-9022-4b996eed8a3d	2026-02-09 23:57:29.534032
125	ba24011c-8851-47f4-b6bb-952d2dfd29a7	2026-02-10 01:06:33.408164
128	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-10 01:28:08.230242
100	e5a42393-36ba-4b3c-afba-b174e7ef157e	2026-02-09 16:10:09.452093
104	89fe37af-a8ef-409c-8686-42aeb311c81b	2026-02-09 17:58:25.369037
108	27930cf7-3087-41b3-843f-a986f3f459f6	2026-02-09 21:45:16.813969
113	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 23:24:40.462687
115	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 23:27:04.389578
119	fe875278-7c46-4747-b513-860316880533	2026-02-09 23:52:30.08438
122	9f091b9d-715f-42dd-b4d3-0e0f5b63beb3	2026-02-10 00:17:17.625976
127	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 01:16:34.406189
131	10fb93f6-18fc-4e1b-8fd0-d81c4e53292b	2026-02-10 01:58:03.068934
102	1ec2f2db-47b5-4a62-aca6-c5073b8e141a	2026-02-09 16:35:31.839704
105	c1b86c62-a0be-4d90-b64b-190831c3ce66	2026-02-09 19:07:32.128384
110	581cd452-728c-4f3b-bcc2-989f19014ae0	2026-02-09 22:23:20.730941
114	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-09 23:24:53.216543
121	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-10 00:06:10.643672
123	67ea79cc-9e7f-4950-a32a-3dc46c244780	2026-02-10 00:23:08.668976
126	7cc58401-3dd9-4d0f-b9d1-f848bd1071c9	2026-02-10 01:06:36.222421
129	34b6e566-42ea-4ac8-9fc8-2a88d57236ea	2026-02-10 01:28:08.231327
132	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 02:10:05.235829
133	7c9ac46a-dc30-41a6-89bb-3af2f377a505	2026-02-10 02:10:38.372243
134	d39019c4-88e1-4987-b230-d6bd7e115cf8	2026-02-10 03:02:16.152044
135	491320c9-3cc7-4688-8089-5eb00bf04052	2026-02-10 03:08:00.169167
136	ff92426b-1be9-43a1-b423-d84c11b0849c	2026-02-10 03:11:38.741431
137	d1173609-8aec-4c6d-8bee-aa227a61075a	2026-02-10 03:13:07.191785
138	0c76121f-845d-44b8-94fb-7d93d19831d6	2026-02-10 03:20:52.136124
139	3cef2ef5-2d53-44b1-9650-7bd25edd7ea6	2026-02-10 03:21:55.47633
140	a109fc04-75be-42b2-a96c-b84d60c10413	2026-02-10 03:21:56.034539
141	41518e41-b7fa-4dcd-9e8e-cef7f505fb68	2026-02-10 03:53:53.632631
142	8af8ce1d-2be2-4c40-88c3-c3f8a56e5479	2026-02-10 04:24:37.22709
143	03cff583-1c5d-4bdb-aff5-4db1311be2ca	2026-02-10 04:51:47.133672
144	72fee5f1-d4be-44cb-8af0-a8386619994b	2026-02-10 05:33:58.683578
145	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	2026-02-10 07:09:57.27308
146	4560182a-1133-4a8d-99be-807934d1ae24	2026-02-10 07:49:14.22464
147	2b8a0a4f-43c4-4e00-8f33-06c29316cc03	2026-02-10 08:22:55.739825
148	8a78e7d0-4d5e-4706-ab00-554c0a62ed6a	2026-02-10 08:40:25.596961
149	53131cd4-74f0-4c08-8eab-5e9083e3d65f	2026-02-10 09:20:40.541904
150	b853cd16-c74b-44d9-ad79-86bd6c75214d	2026-02-10 09:24:42.219318
151	53131cd4-74f0-4c08-8eab-5e9083e3d65f	2026-02-10 09:25:12.603809
152	fc334888-f7f6-4dab-a69e-3c0f44753d79	2026-02-10 09:36:29.961811
153	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-10 10:00:36.828809
154	fc334888-f7f6-4dab-a69e-3c0f44753d79	2026-02-10 10:58:48.656325
155	1fd58109-5de0-47c4-b1f1-5cfca39e21df	2026-02-10 10:59:09.887686
156	cc7393dd-e459-4f25-aae9-19294a6638d5	2026-02-10 11:47:29.504133
157	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-10 13:58:05.334363
158	bac66f16-c7e8-4e50-932b-16c01fbec2d5	2026-02-10 14:40:00.760923
159	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 15:51:38.668498
160	7f151d0f-ee02-48ef-a20b-db22019246e7	2026-02-10 16:16:43.784585
161	5d88a3e1-2820-4fb7-a6ce-f6daac3d8998	2026-02-10 17:03:26.700924
162	cdcc1fa6-c641-4e2b-99c3-50ec97ab8c11	2026-02-10 18:46:25.745458
163	57cdcecb-8903-4af2-aacf-0b68867051c4	2026-02-10 20:46:04.136645
164	72fee5f1-d4be-44cb-8af0-a8386619994b	2026-02-10 22:29:44.477368
165	72fee5f1-d4be-44cb-8af0-a8386619994b	2026-02-10 22:45:39.633094
166	72fee5f1-d4be-44cb-8af0-a8386619994b	2026-02-10 23:27:07.609569
167	bc2f980e-700e-4261-858b-b7099ce75e78	2026-02-10 23:34:03.602811
168	447b920e-a2ea-4298-9c3e-2fecacacaefb	2026-02-10 23:34:23.041464
169	faa5fd3d-9577-42fc-b47a-05195d828cc6	2026-02-11 00:13:19.929909
170	bc2f980e-700e-4261-858b-b7099ce75e78	2026-02-11 00:40:43.559025
171	0575c1cb-411f-4179-a0b1-e45b606c09d3	2026-02-11 00:46:00.724217
172	72fee5f1-d4be-44cb-8af0-a8386619994b	2026-02-11 02:29:56.900914
173	72fee5f1-d4be-44cb-8af0-a8386619994b	2026-02-11 02:31:14.595651
174	72fee5f1-d4be-44cb-8af0-a8386619994b	2026-02-11 02:31:45.245225
175	b3295127-e84b-41a4-b515-3d63983f68c5	2026-02-11 03:02:59.262274
176	f836cf4b-9321-4b6e-84e9-9ce77fa6ea62	2026-02-11 04:34:33.74509
177	76ddb62b-d2db-4fb2-ba8c-73ae7923e84f	2026-02-11 05:04:18.264749
178	491320c9-3cc7-4688-8089-5eb00bf04052	2026-02-11 07:20:45.744721
179	7418bcd6-ba11-4659-82b5-13c2f2d7fd88	2026-02-11 10:21:58.593452
180	7418bcd6-ba11-4659-82b5-13c2f2d7fd88	2026-02-11 10:22:21.915312
\.


--
-- Data for Name: weapons; Type: TABLE DATA; Schema: public; Owner: arcidle
--

COPY public.weapons (id, slug, name, category, rarity, image, hq_image, damage, fire_rate, range, stability, agility, stealth, ammo_type, magazine_size, firing_mode, arc_armor_penetration, weight, sell_price_1, sell_price_2, sell_price_3, sell_price_4, headshot_multiplier) FROM stdin;
1	Kettle	Kettle	Assault Rifles	Common	weapons/Kettle.webp	weapons/HQ/Kettle.png	10	28	42.8	69.8	58.5	26	Light	20	Semi-Auto	Very Weak	7	840	2000	3000	5000	2.5
2	Rattler	Rattler	Assault Rifles	Common	weapons/Rattler.webp	weapons/HQ/Rattler.png	9	33.3	56.2	72.2	54.8	14	Medium	12	Auto	Moderate	6	1750	3000	5000	7000	2
3	Arpeggio	Arpeggio	Assault Rifles	Uncommon	weapons/Arpeggio.webp	weapons/HQ/Arpeggio.png	9.5	18.3	55.9	84	57.3	14	Medium	24	Burst	Moderate	7	5500	8000	11500	15000	2
4	Tempest	Tempest	Assault Rifles	Epic	weapons/Tempest.webp	weapons/HQ/Tempest.png	10	36.7	55.9	78.9	46	14	Medium	25	Auto	Moderate	11	13000	17000	22000	27000	1.5
5	Bettina	Bettina	Assault Rifles	Epic	weapons/Bettina.webp	weapons/HQ/Bettina.png	14	32	51.3	76.4	48.2	14	Heavy	22	Auto	Strong	11	8000	11000	14000	18000	1.5
6	Ferro	Ferro	Battle Rifles	Common	weapons/Ferro.webp	weapons/HQ/Ferro.png	40	6.6	53.1	78.1	32.1	8	Heavy	1	Single	Strong	8	475	1000	2000	2900	2.5
7	Renegade	Renegade	Battle Rifles	Rare	weapons/Renegade.webp	weapons/HQ/Renegade.png	35	21	68.8	85.7	55.8	16	Medium	8	Single	Moderate	10	7000	10000	13000	17000	2.25
8	Aphelion	Aphelion	Battle Rifles	Legendary	weapons/Aphelion.webp	weapons/HQ/Aphelion.png	25	9	76	88	39	16	Energy	10	Burst	Strong	10	27500	27500	27500	27500	2
9	Stitcher	Stitcher	Submachine Guns	Common	weapons/Stitcher.webp	weapons/HQ/Stitcher.png	7	45.3	42.1	45.3	73.8	19	Light	20	Auto	Very Weak	5	800	2000	3000	5000	2.5
10	Bobcat	Bobcat	Submachine Guns	Epic	weapons/Bobcat.webp	weapons/HQ/Bobcat.png	6	66.7	44	45.9	73.1	21	Light	20	Auto	Very Weak	7	13000	17000	22000	27000	2
11	IL_Toro	Il Toro	Shotguns	Uncommon	weapons/IL_Toro.webp	weapons/HQ/Il_Toro.png	67.5	14.3	20	80.6	61.1	18	Heavy	5	Single	Weak	8	5000	7000	10000	13000	\N
12	Vulcano	Vulcano	Shotguns	Epic	weapons/Vulcano.webp	weapons/HQ/Vulcano.png	49.5	26.3	26	68.6	70.3	15	Heavy	6	Semi-Auto	Weak	8	10000	13000	17000	22000	\N
13	Hairpin	Hairpin	Pistols	Common	weapons/Hairpin.webp	weapons/HQ/Hairpin.png	20	9	38.6	90.9	78.3	70	Light	8	Single	Very Weak	3	450	1000	2000	2900	2.5
14	Burletta	Burletta	Pistols	Uncommon	weapons/Burletta.webp	weapons/HQ/Burletta.png	10	28	41.7	74.5	84.4	24	Light	12	Semi-Auto	Very Weak	4	2900	5000	7000	10000	2.5
15	Venator	Venator	Pistols	Rare	weapons/Venator.webp	weapons/HQ/Venator.png	18	36.7	48.4	61.3	76.4	12	Medium	10	Semi-Auto	Moderate	5	7000	10000	13000	17000	2.5
16	Anvil	Anvil	Hand Cannons	Uncommon	weapons/Anvil.webp	weapons/HQ/Anvil.png	40	16.3	50.2	75.2	69.1	10	Heavy	6	Single	Strong	5	5000	7000	10000	13000	2.5
17	Torrente	Torrente	Light Machine Guns	Rare	weapons/Torrente.webp	weapons/HQ/Torrente.png	8	58.3	49.9	74.2	37.7	1	Medium	60	Auto	Moderate	12	7000	10000	13000	17000	2
18	Osprey	Osprey	Sniper Rifles	Rare	weapons/Osprey.webp	weapons/HQ/Osprey.png	45	17.7	80.3	89.4	45.9	12	Medium	8	Single	Moderate	7	7000	10000	13000	17000	2
19	Jupiter	Jupiter	Sniper Rifles	Legendary	weapons/Jupiter.webp	weapons/HQ/Jupiter.png	60	7.67	71.7	73.5	39.2	5	Energy	5	Single	Very Strong	9	27500	27500	27500	27500	2
20	Hullcracker	Hullcracker	Special	Epic	weapons/Hullcracker.webp	weapons/HQ/Hullcracker.png	100	20.3	38.9	97.2	67.9	1	Heavy	5	Single	Very Strong	7	10000	13000	17000	22000	\N
21	Equalizer	Equalizer	Special	Legendary	weapons/Equalizer.webp	weapons/HQ/Equalizer.png	8	33.33	50	84.6	44.6	10	Energy	50	Auto	Very Strong	14	27500	27500	27500	27500	2
\.


--
-- Name: augment_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.augment_materials_id_seq', 22, true);


--
-- Name: augment_shields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.augment_shields_id_seq', 21, true);


--
-- Name: augments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.augments_id_seq', 12, true);


--
-- Name: blueprint_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.blueprint_materials_id_seq', 28, true);


--
-- Name: blueprints_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.blueprints_id_seq', 17, true);


--
-- Name: daily_completions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.daily_completions_id_seq', 166, true);


--
-- Name: daily_guesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.daily_guesses_id_seq', 571, true);


--
-- Name: favorite_votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.favorite_votes_id_seq', 8, true);


--
-- Name: locations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.locations_id_seq', 5, true);


--
-- Name: materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.materials_id_seq', 46, true);


--
-- Name: run_plays_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.run_plays_id_seq', 139, true);


--
-- Name: run_scores_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.run_scores_id_seq', 14, true);


--
-- Name: shield_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.shield_materials_id_seq', 6, true);


--
-- Name: shields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.shields_id_seq', 3, true);


--
-- Name: skills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.skills_id_seq', 45, true);


--
-- Name: sounds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.sounds_id_seq', 13, true);


--
-- Name: visits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.visits_id_seq', 180, true);


--
-- Name: weapons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: arcidle
--

SELECT pg_catalog.setval('public.weapons_id_seq', 21, true);


--
-- Name: augment_materials augment_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augment_materials
    ADD CONSTRAINT augment_materials_pkey PRIMARY KEY (id);


--
-- Name: augment_shields augment_shields_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augment_shields
    ADD CONSTRAINT augment_shields_pkey PRIMARY KEY (id);


--
-- Name: augments augments_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augments
    ADD CONSTRAINT augments_pkey PRIMARY KEY (id);


--
-- Name: augments augments_slug_key; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augments
    ADD CONSTRAINT augments_slug_key UNIQUE (slug);


--
-- Name: blueprint_materials blueprint_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.blueprint_materials
    ADD CONSTRAINT blueprint_materials_pkey PRIMARY KEY (id);


--
-- Name: blueprints blueprints_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.blueprints
    ADD CONSTRAINT blueprints_pkey PRIMARY KEY (id);


--
-- Name: blueprints blueprints_slug_key; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.blueprints
    ADD CONSTRAINT blueprints_slug_key UNIQUE (slug);


--
-- Name: daily_completions daily_completions_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.daily_completions
    ADD CONSTRAINT daily_completions_pkey PRIMARY KEY (id);


--
-- Name: daily_guesses daily_guesses_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.daily_guesses
    ADD CONSTRAINT daily_guesses_pkey PRIMARY KEY (id);


--
-- Name: favorite_votes favorite_votes_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.favorite_votes
    ADD CONSTRAINT favorite_votes_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: locations locations_slug_key; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_slug_key UNIQUE (slug);


--
-- Name: materials materials_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_pkey PRIMARY KEY (id);


--
-- Name: materials materials_slug_key; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.materials
    ADD CONSTRAINT materials_slug_key UNIQUE (slug);


--
-- Name: run_plays run_plays_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.run_plays
    ADD CONSTRAINT run_plays_pkey PRIMARY KEY (id);


--
-- Name: run_scores run_scores_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.run_scores
    ADD CONSTRAINT run_scores_pkey PRIMARY KEY (id);


--
-- Name: shield_materials shield_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.shield_materials
    ADD CONSTRAINT shield_materials_pkey PRIMARY KEY (id);


--
-- Name: shields shields_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.shields
    ADD CONSTRAINT shields_pkey PRIMARY KEY (id);


--
-- Name: shields shields_slug_key; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.shields
    ADD CONSTRAINT shields_slug_key UNIQUE (slug);


--
-- Name: skills skills_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_pkey PRIMARY KEY (id);


--
-- Name: skills skills_skill_id_key; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.skills
    ADD CONSTRAINT skills_skill_id_key UNIQUE (skill_id);


--
-- Name: sounds sounds_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.sounds
    ADD CONSTRAINT sounds_pkey PRIMARY KEY (id);


--
-- Name: sounds sounds_slug_key; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.sounds
    ADD CONSTRAINT sounds_slug_key UNIQUE (slug);


--
-- Name: visits visits_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.visits
    ADD CONSTRAINT visits_pkey PRIMARY KEY (id);


--
-- Name: weapons weapons_pkey; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.weapons
    ADD CONSTRAINT weapons_pkey PRIMARY KEY (id);


--
-- Name: weapons weapons_slug_key; Type: CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.weapons
    ADD CONSTRAINT weapons_slug_key UNIQUE (slug);


--
-- Name: augment_materials augment_materials_augment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augment_materials
    ADD CONSTRAINT augment_materials_augment_id_fkey FOREIGN KEY (augment_id) REFERENCES public.augments(id);


--
-- Name: augment_materials augment_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augment_materials
    ADD CONSTRAINT augment_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materials(id);


--
-- Name: augment_shields augment_shields_augment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augment_shields
    ADD CONSTRAINT augment_shields_augment_id_fkey FOREIGN KEY (augment_id) REFERENCES public.augments(id);


--
-- Name: augment_shields augment_shields_shield_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.augment_shields
    ADD CONSTRAINT augment_shields_shield_id_fkey FOREIGN KEY (shield_id) REFERENCES public.shields(id);


--
-- Name: blueprint_materials blueprint_materials_blueprint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.blueprint_materials
    ADD CONSTRAINT blueprint_materials_blueprint_id_fkey FOREIGN KEY (blueprint_id) REFERENCES public.blueprints(id);


--
-- Name: blueprint_materials blueprint_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.blueprint_materials
    ADD CONSTRAINT blueprint_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materials(id);


--
-- Name: shield_materials shield_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.shield_materials
    ADD CONSTRAINT shield_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.materials(id);


--
-- Name: shield_materials shield_materials_shield_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arcidle
--

ALTER TABLE ONLY public.shield_materials
    ADD CONSTRAINT shield_materials_shield_id_fkey FOREIGN KEY (shield_id) REFERENCES public.shields(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 9OOGhAHhNn1SZ40HrXLPf3Qgf98knIfAWjheBr5py8NR6x4zY3Zv0HuSkKRLXBl

