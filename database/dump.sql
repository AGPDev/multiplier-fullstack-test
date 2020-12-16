--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1
-- Dumped by pg_dump version 13.1

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
-- Name: categories; Type: TABLE; Schema: public; Owner: webadmin
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp(0) with time zone,
    updated_at timestamp(0) with time zone,
    deleted_at timestamp(0) with time zone
);


ALTER TABLE public.categories OWNER TO webadmin;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: webadmin
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO webadmin;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webadmin
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: webadmin
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO webadmin;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: webadmin
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO webadmin;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webadmin
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: webadmin
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    products jsonb NOT NULL,
    qty_products integer NOT NULL,
    total double precision NOT NULL,
    created_at timestamp(0) with time zone,
    updated_at timestamp(0) with time zone,
    deleted_at timestamp(0) with time zone
);


ALTER TABLE public.orders OWNER TO webadmin;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: webadmin
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO webadmin;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webadmin
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: webadmin
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    category_id integer NOT NULL,
    name character varying(255) NOT NULL,
    price double precision NOT NULL,
    created_at timestamp(0) with time zone,
    updated_at timestamp(0) with time zone,
    deleted_at timestamp(0) with time zone
);


ALTER TABLE public.products OWNER TO webadmin;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: webadmin
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO webadmin;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webadmin
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: webadmin
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp(0) with time zone,
    updated_at timestamp(0) with time zone,
    deleted_at timestamp(0) with time zone
);


ALTER TABLE public.users OWNER TO webadmin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: webadmin
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO webadmin;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webadmin
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: webadmin
--

INSERT INTO public.categories VALUES (1, 'Acessórios', '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.categories VALUES (2, 'Impressoras', '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.categories VALUES (3, 'Monitores', '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.categories VALUES (4, 'Mouse', '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.categories VALUES (5, 'Teclado', '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: webadmin
--

INSERT INTO public.migrations VALUES (1, '2020_12_10_141815_create_users_table', 1);
INSERT INTO public.migrations VALUES (2, '2020_12_12_184242_create_categories_table', 1);
INSERT INTO public.migrations VALUES (3, '2020_12_14_140511_create_products_table', 1);
INSERT INTO public.migrations VALUES (4, '2020_12_14_184322_create_orders_table', 1);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: webadmin
--

INSERT INTO public.orders VALUES (1, '[{"id": 1, "name": "APRESENTADOR LOGITECH R500 USB WIRELESS PRETO", "price": "144.89", "quantity": 1, "subtotal": 144.88999999999999, "created_at": "2020-12-16T00:05:16.000000Z", "deleted_at": null, "updated_at": "2020-12-16T00:05:16.000000Z", "category_id": 1}, {"id": 8, "name": "MONITOR LG 27\" IPS 5MS 4K FREESYNC HDR10 HDMI/DP, 27UL500-W", "price": "2489.08", "quantity": 7, "subtotal": 17423.559999999998, "created_at": "2020-12-16T00:05:16.000000Z", "deleted_at": null, "updated_at": "2020-12-16T00:05:16.000000Z", "category_id": 3}, {"id": 14, "name": "TECLADO NEWLINK BLUETOOTH ULTRA SLIM, TC101SNL", "price": "99.9", "quantity": 5, "subtotal": 499.5, "created_at": "2020-12-16T00:05:16.000000Z", "deleted_at": null, "updated_at": "2020-12-16T00:05:16.000000Z", "category_id": 5}]', 13, 18067.95, '2020-12-16 02:45:52+00', '2020-12-16 02:45:52+00', NULL);
INSERT INTO public.orders VALUES (2, '[{"id": 4, "name": "IMPRESSORA HP NEVERSTOP LASER MFP WIRELESS 1200W, 4RY26A", "price": "2109.9", "quantity": 1, "subtotal": 2109.9000000000001, "created_at": "2020-12-16T00:05:16.000000Z", "deleted_at": null, "updated_at": "2020-12-16T00:05:16.000000Z", "category_id": 2}, {"id": 14, "name": "TECLADO NEWLINK BLUETOOTH ULTRA SLIM, TC101SNL", "price": "99.9", "quantity": 2, "subtotal": 199.80000000000001, "created_at": "2020-12-16T00:05:16.000000Z", "deleted_at": null, "updated_at": "2020-12-16T00:05:16.000000Z", "category_id": 5}]', 3, 2309.7, '2020-12-16 02:53:53+00', '2020-12-16 02:53:53+00', NULL);
INSERT INTO public.orders VALUES (3, '[{"id": 6, "name": "IMPRESSORA 3D FLASHFORGE DREAMER NX, 30786", "price": "4300.03", "quantity": 10, "subtotal": 43000.299999999996, "created_at": "2020-12-16T00:05:16.000000Z", "deleted_at": null, "updated_at": "2020-12-16T00:05:16.000000Z", "category_id": 2}]', 10, 43000.3, '2020-12-16 04:07:34+00', '2020-12-16 04:07:34+00', NULL);
INSERT INTO public.orders VALUES (4, '[{"id": 11, "name": "MOUSE TRUST YVI WIRELESS USB PRETO/CINZA, T18519", "price": "47.49", "quantity": 5, "subtotal": 237.45000000000002, "created_at": "2020-12-16T00:05:16.000000Z", "deleted_at": null, "updated_at": "2020-12-16T00:05:16.000000Z", "category_id": 4}, {"id": 12, "name": "MOUSE THERMALTAKE TTESPORTS THERON INFRARED, MO-TRN006DTM", "price": "239.9", "quantity": 5, "subtotal": 1199.5, "created_at": "2020-12-16T00:05:16.000000Z", "deleted_at": null, "updated_at": "2020-12-16T00:05:16.000000Z", "category_id": 4}]', 10, 1436.95, '2020-12-16 10:35:06+00', '2020-12-16 10:35:06+00', NULL);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: webadmin
--

INSERT INTO public.products VALUES (1, 1, 'APRESENTADOR LOGITECH R500 USB WIRELESS PRETO', 144.89, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (2, 1, 'HUB USB NZXT INTERNO 5 PORTAS 2.0, AC-IUSBH-M1', 179.89, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (3, 1, 'PLACA DE CAPTURA DE VIDEO AVERMEDIA LIVE GAMER ULTRA 4K HDR, GC553', 1699.92, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (4, 2, 'IMPRESSORA HP NEVERSTOP LASER MFP WIRELESS 1200W, 4RY26A', 2109.9, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (5, 2, 'IMPRESSORA HP 517 MULTIFUNCIONAL WIRELESS SMART TANK, 1TJ10A', 1189.9, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (6, 2, 'IMPRESSORA 3D FLASHFORGE DREAMER NX, 30786', 4300.03, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (7, 3, 'MONITOR PHILIPS 49" SUPERWIDE W-LED CURVO LCD VA HDMI/DISPLAYPORT/USB-C + WEBCAM, 499P9H/00', 8999.28, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (8, 3, 'MONITOR LG 27" IPS 5MS 4K FREESYNC HDR10 HDMI/DP, 27UL500-W', 2489.08, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (9, 3, 'MONITOR LG 21,5" TN 75HZ 5MS FHD PRETO, 22MK400H-B', 749.02, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (10, 4, 'MOUSE GAMER REDRAGON GRIFFIN RGB 7200DPI, M607', 129.89, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (11, 4, 'MOUSE TRUST YVI WIRELESS USB PRETO/CINZA, T18519', 47.49, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (12, 4, 'MOUSE THERMALTAKE TTESPORTS THERON INFRARED, MO-TRN006DTM', 239.9, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (13, 5, 'TECLADO MECÂNICO CORSAIR K68 RGB SWITCH CHERRY MX RED, CH-9102010-NA', 1042.5, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (14, 5, 'TECLADO NEWLINK BLUETOOTH ULTRA SLIM, TC101SNL', 99.9, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.products VALUES (15, 5, 'TECLADO THERMALTAKE TT ESPORTS POSEIDON Z RGB SWITCH MARROM, KB-PZR-KBBRUS-01', 649.9, '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: webadmin
--

INSERT INTO public.users VALUES (1, 'Anderson Guilherme Porto', 'anderson.porto@agpdev.com', '$2y$10$9xCboqTYFijWqTIIwkgMuus.6hgWeKz2wc7VucgMRlQjBu75qFp.6', '2020-12-16 00:05:16+00', '2020-12-16 00:05:16+00', NULL);
INSERT INTO public.users VALUES (2, 'Retha Douglas', 'goyette.kaitlyn@example.net', '$2y$10$soAbxHvZZWaiNL2VXqMyJeDtNmaJNkIIGpDYhcNZwzoCQ6dk5Wqr2', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (3, 'Mr. Lloyd Mraz DDS', 'pfannerstill.karley@example.com', '$2y$10$UwD5LxmVlo1MDDX/FHLM4erIL3GJrXJNjrG/QDWxAQiL3g5WVVHP2', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (4, 'Dr. Beulah Rodriguez', 'feil.baby@example.net', '$2y$10$EQPKaJD/ITnKaNZ9qcjLVOkiTdRvdlrjkrAsng/rLTUkd2NahTm36', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (5, 'Prof. Christina Kuvalis Jr.', 'adonnelly@example.net', '$2y$10$Up1d4yV1eqHfYtpAedYnzesR1BPpuivG42BAEvofGm3rXCN4TIF8.', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (6, 'Miss Deja Crona IV', 'mohr.alice@example.org', '$2y$10$JmqAD5yLYYEiyBBcvc6xzewZVYqPkiGSEfYqgdqSAWSpplFkq6oVG', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (7, 'Janet Muller', 'kayleigh.schoen@example.org', '$2y$10$ZFBBhxbFW9ewZ3AMD3x2d.J3.ZdgiiEpxbjie40nglffi/kLMdBu6', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (8, 'Dr. Lyric Hettinger', 'aileen56@example.org', '$2y$10$H4Sv4mdeRVDEWns2EsbMluf5LcNAwQgijU/Bn42XDkEMasBGQK.xe', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (9, 'Otto Mills', 'christ.ernser@example.org', '$2y$10$em/DuMyX.Gw8rCBcCCNsBeVP9dc3dBCVF6Gu2Xh9wx38L0ewkk8Ie', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (10, 'Samanta Williamson', 'cheyenne.adams@example.org', '$2y$10$SrPsvX7bhUhP1fL6mIsUPuPaY7t21FFjF3jjwwBHcX/OzLtM7WZAy', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (11, 'Zechariah Davis', 'romaguera.ludie@example.com', '$2y$10$R4PZQ1LxDmUGzXnb9kFzJ.v8iTrmQKSY1PbkA020XVDrpbpjzPBnq', '2020-12-16 00:05:17+00', '2020-12-16 00:05:17+00', NULL);
INSERT INTO public.users VALUES (12, 'Rodrigo Cortez', 'rodrigo@multiplier.com.br', '$2y$10$qj.bWs7hX9aOhrmVdwyx5u/6yet.cCJNz7whavKHBh26VmEAxwX16', '2020-12-16 02:44:14+00', '2020-12-16 02:44:14+00', NULL);
INSERT INTO public.users VALUES (13, 'Fulano Beltrano', 'exemplo@multiplier.com.br', '$2y$10$Y7IyKOrOcTFzy3biOhLyxOHb0zIAJd1upDlrsSRec90JEpYXqlZFW', '2020-12-16 13:54:59+00', '2020-12-16 13:54:59+00', NULL);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: webadmin
--

SELECT pg_catalog.setval('public.categories_id_seq', 5, true);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: webadmin
--

SELECT pg_catalog.setval('public.migrations_id_seq', 4, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: webadmin
--

SELECT pg_catalog.setval('public.orders_id_seq', 4, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: webadmin
--

SELECT pg_catalog.setval('public.products_id_seq', 15, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: webadmin
--

SELECT pg_catalog.setval('public.users_id_seq', 13, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: products products_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- PostgreSQL database dump complete
--

