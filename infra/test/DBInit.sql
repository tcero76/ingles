--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1 (Debian 12.1-1.pgdg100+1)
-- Dumped by pg_dump version 12.1 (Debian 12.1-1.pgdg100+1)

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

--
-- Name: vocabulario; Type: SCHEMA; Schema: -; Owner: tcero
--

CREATE SCHEMA vocabulario;


ALTER SCHEMA vocabulario OWNER TO tcero;

--
-- Name: categoria; Type: TYPE; Schema: public; Owner: tcero
--

CREATE TYPE public.categoria AS ENUM (
    'PREPOSICION',
    'VERBO_COMPUESTO',
    'VERBO',
    'ADJETIVO',
    'NOMBRE',
    'ADVERBIO',
    'ADVERBIOS_COMUNES',
    'CONECTORES_LOGICOS',
    'ADJETIVOS_FRECUENTES',
    'SUSTANTIVOS_ABSTRACTOS',
    'MODISMOS_Y_EXPRESIONES_COMUNES',
    'FORMAS_VERBALES_IRREGULARES_Y_ESTRUCTURAS_GRAMATICALES_CLAVE'
);


ALTER TYPE public.categoria OWNER TO tcero;

--
-- Name: palabra_status; Type: TYPE; Schema: public; Owner: tcero
--

CREATE TYPE public.palabra_status AS ENUM (
    'PENDIENTE',
    'TERMINADA'
);


ALTER TYPE public.palabra_status OWNER TO tcero;

--
-- Name: status; Type: TYPE; Schema: public; Owner: tcero
--

CREATE TYPE public.status AS ENUM (
    'PENDIENTE',
    'COMPLETADO'
);


ALTER TYPE public.status OWNER TO tcero;

--
-- Name: palabra_status; Type: TYPE; Schema: vocabulario; Owner: tcero
--

CREATE TYPE vocabulario.palabra_status AS ENUM (
    'pendiente',
    'completada'
);


ALTER TYPE vocabulario.palabra_status OWNER TO tcero;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: palabras; Type: TABLE; Schema: public; Owner: tcero
--

CREATE TABLE public.palabras (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    palabra text NOT NULL,
    frase text,
    significado text,
    level bigint NOT NULL,
    categoria public.categoria NOT NULL,
    status public.status NOT NULL,
    nintentos integer DEFAULT 0 NOT NULL,
    nfallos integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.palabras OWNER TO tcero;

--
-- Name: palabras_id_seq; Type: SEQUENCE; Schema: public; Owner: tcero
--

CREATE SEQUENCE public.palabras_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.palabras_id_seq OWNER TO tcero;

--
-- Name: palabras_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tcero
--

ALTER SEQUENCE public.palabras_id_seq OWNED BY public.palabras.id;


--
-- Name: palabras id; Type: DEFAULT; Schema: public; Owner: tcero
--

ALTER TABLE ONLY public.palabras ALTER COLUMN id SET DEFAULT nextval('public.palabras_id_seq'::regclass);


--
-- Name: palabras palabras_pkey; Type: CONSTRAINT; Schema: public; Owner: tcero
--

ALTER TABLE ONLY public.palabras
    ADD CONSTRAINT palabras_pkey PRIMARY KEY (id);


--
-- Name: palabras uniq_palabras_palabra; Type: CONSTRAINT; Schema: public; Owner: tcero
--

ALTER TABLE ONLY public.palabras
    ADD CONSTRAINT uniq_palabras_palabra UNIQUE (palabra);


--
-- Name: idx_palabras_deleted_at; Type: INDEX; Schema: public; Owner: tcero
--

CREATE INDEX idx_palabras_deleted_at ON public.palabras USING btree (deleted_at);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.1 (Debian 12.1-1.pgdg100+1)
-- Dumped by pg_dump version 12.1 (Debian 12.1-1.pgdg100+1)

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

--
-- Data for Name: palabras; Type: TABLE DATA; Schema: public; Owner: tcero
--

COPY public.palabras (id, created_at, updated_at, deleted_at, palabra, frase, significado, level, categoria, status, nintentos, nfallos) FROM stdin;
90	2025-02-22 14:40:07.998052-03	2025-04-23 11:55:05.561256-04	\N	with respect to	With respect to the schedule, it’s flexible	con respecto a	5	PREPOSICION	PENDIENTE	3	0
86	2025-02-22 14:40:07.998052-03	2025-04-23 11:55:42.139222-04	\N	in case of	Take an umbrella in case of rain	en caso de	5	PREPOSICION	PENDIENTE	2	0
87	2025-02-22 14:40:07.998052-03	2025-04-24 14:58:36.889508-04	\N	in comparison with	This is small in comparison with that	en comparación con	5	PREPOSICION	PENDIENTE	2	0
31	2023-05-11 01:13:45.520013-04	2025-04-24 14:58:49.872666-04	\N	tangle	Having a tangle of power cables near the monitor.	maraña	5	NOMBRE	PENDIENTE	4	0
135	2025-04-06 15:02:51.176598-04	2025-04-24 14:59:16.489954-04	\N	get cold feet	 He got cold feet before the presentation and couldn’t go through with it.	 tener miedo de hacer algo	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	5	2
32	2023-05-11 01:18:32.613295-04	2025-04-28 16:52:41.448742-04	\N	breakthrough	The new medicine is an important breakthrough.	Innovación	3	NOMBRE	PENDIENTE	7	2
134	2025-04-06 15:02:51.176598-04	2025-04-24 14:59:53.770201-04	\N	by the book	 He always does everything by the book at work.	 seguir las reglas	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	5	1
88	2025-02-22 14:40:07.998052-03	2025-04-24 15:01:21.090192-04	\N	in terms of	She excels in terms of creativity	en términos de	5	PREPOSICION	PENDIENTE	2	0
93	2025-02-22 14:40:07.998052-03	2025-04-24 15:01:28.938563-04	\N	in line with	This is in line with our goals	en línea con	5	PREPOSICION	PENDIENTE	2	0
97	2025-02-22 14:40:07.998052-03	2025-04-24 15:01:39.291838-04	\N	in charge of	She’s in charge of the project	a cargo de	5	PREPOSICION	PENDIENTE	5	1
100	2025-02-22 14:40:07.998052-03	2025-04-24 15:02:49.114828-04	\N	on the part of	There was effort on the part of everyone	por parte de	4	PREPOSICION	PENDIENTE	7	4
39	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:02:52.042795-04	\N	at	He is at the park	en	5	PREPOSICION	PENDIENTE	5	1
103	2025-02-22 14:40:07.998052-03	2025-04-24 15:03:24.619028-04	\N	in the face of	He stayed calm in the face of danger	frente a	5	PREPOSICION	PENDIENTE	4	0
137	2025-04-06 15:02:51.176598-04	2025-04-24 15:03:39.099313-04	\N	burn the midnight oil	 She had to burn the midnight oil to finish her thesis on time.	 trasnochar	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	5	1
128	2025-04-06 15:02:51.176598-04	2025-04-24 15:04:03.283783-04	\N	hit the nail on the head	 You hit the nail on the head with your analysis of the situation.	 dar en el clavo	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	5	2
130	2025-04-06 15:02:51.176598-04	2025-04-24 15:04:12.491539-04	\N	once in a blue moon	 I only see my cousins once in a blue moon.	 una vez en la vida	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	5	1
2	2023-04-20 23:59:43.605435-04	2025-04-24 15:04:42.171505-04	\N	inward	Now is not the time for us to start turning inward	hacia dentro	5	ADJETIVO	PENDIENTE	4	0
133	2025-04-06 15:02:51.176598-04	2025-04-28 17:02:19.67963-04	\N	at the drop of a hat	 She’ll help you at the drop of a hat.	 en un abrir y cerrar de ojos	3	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	8	4
136	2025-04-06 15:02:51.176598-04	2025-05-01 21:44:48.282244-04	\N	let someone off the hook	 The teacher let me off the hook for my late assignment because I had an excuse.	 librar a alguien de una obligación	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	7	3
83	2025-02-22 14:40:07.998052-03	2025-04-23 11:55:12.418129-04	\N	in addition to	In addition to coffee, we need sugar	además de	5	PREPOSICION	PENDIENTE	2	0
28	2023-05-04 21:38:05.165473-04	2025-04-24 15:07:01.069975-04	\N	polls	The polls reflect a shift in the opinion of voters.	Encuestas	6	NOMBRE	PENDIENTE	1	0
127	2025-04-06 15:02:51.176598-04	2025-04-24 15:08:46.237966-04	\N	break the ice	 He told a funny joke to break the ice at the party.	 romper el hielo	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
3	2023-04-21 10:12:03.290562-04	2025-04-24 15:09:37.125345-04	\N	meaningful	It needs to be targeted with meaningful controls.	significativo	6	ADJETIVO	PENDIENTE	1	0
33	2023-05-11 10:25:11.655398-04	2025-04-24 15:10:08.893714-04	\N	meanwhile	meanwhile, people demand a solution.	mientras tanto	4	ADVERBIO	PENDIENTE	6	2
131	2025-04-06 15:02:51.176598-04	2025-04-24 15:10:32.134344-04	\N	let the cat out of the bag	 He accidentally let the cat out of the bag about the surprise gift.	 dejar escapar un secreto	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	5	1
27	2023-04-30 13:53:19.726065-04	2025-04-23 11:55:19.987225-04	\N	strengthen	I do exercises to strengthen my body.	fortalecer	5	VERBO	PENDIENTE	3	0
132	2025-04-06 15:02:51.176598-04	2025-04-24 15:10:34.104566-04	\N	when pigs fly	 She’ll finish the report when pigs fly.	 cuando las ranas críen pelo	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
105	2025-02-22 14:40:07.998052-03	2025-04-24 15:11:01.199733-04	\N	with a view to	We’re saving with a view to buying a house	con vistas a	4	PREPOSICION	PENDIENTE	5	2
95	2025-02-22 14:40:07.998052-03	2025-04-24 15:11:36.65567-04	\N	on account of	We stayed home on account of the storm	a causa de	4	PREPOSICION	PENDIENTE	5	2
84	2025-02-22 14:40:07.998052-03	2025-04-24 15:11:38.558493-04	\N	in spite of	They went out in spite of the storm	a pesar de	5	PREPOSICION	PENDIENTE	2	0
85	2025-02-22 14:40:07.998052-03	2025-04-24 15:11:40.094231-04	\N	instead of	He chose tea instead of coffee	en lugar de.	5	PREPOSICION	PENDIENTE	2	0
102	2025-02-22 14:40:07.998052-03	2025-04-23 11:54:51.243988-04	\N	in the light of	In the light of new evidence, we’ll reconsider	a la luz de	5	PREPOSICION	PENDIENTE	3	0
1	2023-04-20 19:27:21.291732-04	2025-04-24 15:11:59.006692-04	\N	overhead	The company reduced costs by cutting overhead.	gastos generales	5	NOMBRE	PENDIENTE	3	0
101	2025-02-22 14:40:07.998052-03	2025-04-24 15:37:27.299575-04	\N	by virtue of	She won by virtue of her skills	en virtud de	5	PREPOSICION	PENDIENTE	3	0
104	2025-02-22 14:40:07.998052-03	2025-04-24 15:37:30.757538-04	\N	in response to	In response to your email, here’s the info	en respuesta a	5	PREPOSICION	PENDIENTE	3	0
89	2025-02-22 14:40:07.998052-03	2025-04-24 15:37:34.916944-04	\N	with regard to	With regard to your question, I’ll check	con respecto a	5	PREPOSICION	PENDIENTE	3	0
26	2023-04-21 20:14:00.286618-04	2025-04-24 15:37:55.477671-04	\N	steadily	The quantity of publications and new customers continues to grow steadily.	constantemente	4	ADVERBIO	PENDIENTE	5	1
38	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:37:58.951755-04	\N	on	The book is on the table	sobre	5	PREPOSICION	PENDIENTE	2	0
40	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:38:00.637655-04	\N	under	The cat is under the bed	debajo	5	PREPOSICION	PENDIENTE	2	0
82	2025-02-22 14:40:07.998052-03	2025-04-24 15:38:06.951911-04	\N	as well as	She sings as well as plays guitar	así como	5	PREPOSICION	PENDIENTE	2	0
129	2025-04-06 15:02:51.176598-04	2025-04-28 15:09:58.42818-04	\N	beyond the pale	 His actions at the meeting were beyond the pale.	 fuera de lugar	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	7	3
98	2025-02-22 14:40:07.998052-03	2025-04-24 15:03:06.250769-04	\N	in place of	Use honey in place of sugar	en lugar de	5	PREPOSICION	PENDIENTE	2	0
147	2025-04-06 15:02:51.176598-04	2025-04-24 15:38:36.390721-04	\N	a penny for your thoughts	 You’ve been quiet all day, a penny for your thoughts?	 un penny por tus pensamientos	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
29	2023-05-06 13:00:52.96602-04	2025-04-24 15:48:00.523549-04	\N	hangover	If I drink too much, I will wake up tomorrow with a hangover	resaca	5	NOMBRE	PENDIENTE	4	0
140	2025-04-06 15:02:51.176598-04	2025-04-24 15:48:21.164006-04	\N	get the show on the road	 We’ve been talking long enough; let’s get the show on the road.	 poner en marcha algo	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	5	2
37	2025-02-21 01:28:41.682562-03	2025-04-29 13:46:14.369053-04	\N	in	I left your book in the car.	en	6	PREPOSICION	PENDIENTE	2	0
45	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:52:07.324221-04	\N	in front of	The car is in front of the house	delante de	5	PREPOSICION	PENDIENTE	2	0
46	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:52:08.907208-04	\N	to	I go to the market	a	5	PREPOSICION	PENDIENTE	2	0
47	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:52:09.953861-04	\N	from	She comes from Spain	de	5	PREPOSICION	PENDIENTE	2	0
48	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:52:48.219661-04	\N	with	He writes with a pen	con	5	PREPOSICION	PENDIENTE	2	0
52	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:52:49.249452-04	\N	above	The lamp is above the table	sobre	5	PREPOSICION	PENDIENTE	2	0
195	2025-04-08 08:02:51.176598-04	2025-04-29 13:46:32.977449-04	\N	Hold back	He was unable to hold back his tears after hearing the news.	Contener, retener.	1	VERBO_COMPUESTO	PENDIENTE	2	2
148	2025-04-06 15:02:51.176598-04	2025-04-24 15:53:02.122034-04	\N	the ball is in your court	 I’ve done my part, now the ball is in your court.	 la pelota está en tu campo	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	1
55	2025-02-22 14:40:07.998052-03	2025-04-24 15:53:03.721152-04	\N	by	She stood by the window	junto a	5	PREPOSICION	PENDIENTE	5	1
144	2025-04-06 15:02:51.176598-04	2025-04-24 15:53:27.819548-04	\N	the early bird catches the worm	 The early bird catches the worm, so I always wake up early to start my day.	 el que madruga,  Dios le ayuda	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
150	2025-04-06 15:02:51.176598-04	2025-04-24 15:53:31.770548-04	\N	off the hook	 I thought I was in trouble, but they let me off the hook because it wasn’t my fault.	 libre de responsabilidad	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	6	3
154	2025-04-06 15:02:51.176598-04	2025-04-24 15:53:34.29893-04	\N	make a long story short	 To make a long story short, we missed the flight and had to book another one.	 para hacer la historia corta	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	1
141	2025-04-06 15:02:51.176598-04	2025-04-24 15:53:37.066726-04	\N	put all your eggs in one basket	 Don’t put all your eggs in one basket; diversify your investments.	 poner todos los huevos en una sola canasta	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
145	2025-04-06 15:02:51.176598-04	2025-04-24 15:53:43.786799-04	\N	caught between a rock and a hard place	 He was caught between a rock and a hard place, not knowing whether to stay or leave.	 estar entre la espada y la pared	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
138	2025-04-06 15:02:51.176598-04	2025-04-24 15:53:46.307336-04	\N	spill the beans	 She accidentally spilled the beans about the surprise party.	 revelar un secreto	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
34	2023-05-11 15:54:17.149349-04	2025-04-24 15:53:48.140728-04	\N	pull out	The investors pulled out their funds when the company closed down.	sacar	5	VERBO_COMPUESTO	PENDIENTE	4	0
53	2025-02-22 14:40:07.998052-03	2025-04-24 15:38:39.536861-04	\N	below	The fish swim below the surface	debajo	5	PREPOSICION	PENDIENTE	3	0
146	2025-04-06 15:02:51.176598-04	2025-04-24 15:53:50.659827-04	\N	hit the sack	 I’m really tired, I think I’m going to hit the sack early tonight.	 irse a la cama	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	6	2
152	2025-04-06 15:02:51.176598-04	2025-04-24 15:53:52.314486-04	\N	hit the road	 It’s getting late, we should hit the road before it gets dark.	 salir de viaje	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	5	2
54	2025-02-22 14:40:07.998052-03	2025-04-24 15:53:53.515242-04	\N	near	The school is near the park	cerca de	5	PREPOSICION	PENDIENTE	3	0
56	2025-02-22 14:40:07.998052-03	2025-04-24 15:53:57.139258-04	\N	through	We walked through the forest	a través de	5	PREPOSICION	PENDIENTE	3	0
41	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:54:01.364359-04	\N	over	The plane flies over the city	sobre	5	PREPOSICION	PENDIENTE	2	0
42	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:54:03.11037-04	\N	next to	The store is next to the bank	al lado de	5	PREPOSICION	PENDIENTE	2	0
43	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:54:04.171319-04	\N	behind	The dog is behind the door	detrás	5	PREPOSICION	PENDIENTE	2	0
44	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:54:05.099687-04	\N	between	The park is between the school and the library	entre	5	PREPOSICION	PENDIENTE	2	0
30	2023-05-11 01:06:58.600519-04	2025-04-24 15:38:59.303654-04	\N	overwhelming	I felt overwhelming happiness when I heard the news.	inmenso	5	ADJETIVO	PENDIENTE	4	0
49	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:54:06.379649-04	\N	without	She left without her bag	sin	5	PREPOSICION	PENDIENTE	2	0
149	2025-04-06 15:02:51.176598-04	2025-04-28 11:40:35.168353-04	\N	call it a day	 We’ve been working for hours, let’s call it a day.	 dar por terminado	2	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	8	6
50	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:54:07.228589-04	\N	for	This gift is for you	para	5	PREPOSICION	PENDIENTE	2	0
51	0001-12-31 19:17:14-04:42:46 BC	2025-04-24 15:54:08.07928-04	\N	about	We talked about the weather	sobre.	5	PREPOSICION	PENDIENTE	2	0
142	2025-04-06 15:02:51.176598-04	2025-04-24 15:47:20.959299-04	\N	back to the drawing board	 Our proposal didn’t work, so it’s back to the drawing board.	 volver a empezar	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
143	2025-04-06 15:02:51.176598-04	2025-04-24 15:47:39.878593-04	\N	barking up the wrong tree	 If you think I’ll help you with this project, you’re barking up the wrong tree.	 estar equivocado	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
153	2025-04-06 15:02:51.176598-04	2025-04-24 15:38:33.52671-04	\N	let sleeping dogs lie	 Don’t bring up the argument again, just let sleeping dogs lie.	 dejar las cosas como están	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	5	2
151	2025-04-06 15:02:51.176598-04	2025-04-24 15:52:40.379426-04	\N	bite the bullet	 I didn’t want to go to the dentist, but I had to bite the bullet and make the appointment.	 aceptar algo difícil	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	6	3
193	2025-04-08 08:02:51.176598-04	2025-04-28 17:02:31.086013-04	\N	Work out	I hope we can work out this issue soon.	Ejercitarse, resolver un problema.	1	VERBO_COMPUESTO	PENDIENTE	2	2
194	2025-04-08 08:02:51.176598-04	2025-04-28 18:15:02.724152-04	\N	Watch out	Watch out for the car! It’s coming fast.	Tener cuidado.	1	VERBO_COMPUESTO	PENDIENTE	2	2
192	2025-04-08 08:02:51.176598-04	2025-04-29 13:46:12.29028-04	\N	Turn down	He turned down the job offer because it didn’t meet his expectations.	Rechazar, bajar el volumen.	1	VERBO_COMPUESTO	PENDIENTE	3	3
196	2025-04-08 08:02:51.176598-04	2025-04-29 13:46:59.585407-04	\N	Look up	I will look up the address for you.	Buscar (información), mirar hacia arriba.	1	VERBO_COMPUESTO	PENDIENTE	2	2
197	2025-04-08 08:02:51.176598-04	2025-04-29 13:47:40.31449-04	\N	Make out	I can’t make out what he’s saying in that video.	Distinguir, entender (a veces con dificultad).	1	VERBO_COMPUESTO	PENDIENTE	2	2
198	2025-04-08 08:02:51.176598-04	2025-04-29 13:49:25.897763-04	\N	Pick out	She picked out a beautiful dress for the event.	Elegir, seleccionar.	2	VERBO_COMPUESTO	PENDIENTE	2	1
139	2025-04-06 15:02:51.176598-04	2025-04-28 11:34:39.756423-04	\N	the last straw	 Missing the train was the last straw; I was already late for the meeting.	 la gota que colma el vaso	2	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	7	4
156	2025-04-06 15:02:51.176598-04	2025-04-27 17:23:05.091544-04	\N	although	 Although it was raining, they decided to go hiking.	 aunque	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
164	2025-04-08 08:02:51.176598-04	2025-04-29 13:55:16.99799-04	\N	Look after	Can you look after my cat while I’m on vacation?	Cuidar de alguien o algo.	1	VERBO_COMPUESTO	PENDIENTE	2	2
165	2025-04-08 08:02:51.176598-04	2025-04-29 13:55:39.326363-04	\N	Run into	I ran into an old friend at the grocery store.	Encontrarse con alguien por casualidad.	1	VERBO_COMPUESTO	PENDIENTE	1	1
57	2025-02-22 14:40:07.998052-03	2025-04-27 17:22:45.794511-04	\N	across	He swam across the river	al otro lado de	5	PREPOSICION	PENDIENTE	5	1
74	2025-02-22 14:40:07.998052-03	2025-04-29 13:55:43.774134-04	\N	up	The balloon floated up in the sky	arriba	5	PREPOSICION	PENDIENTE	4	0
73	2025-02-22 14:40:07.998052-03	2025-04-27 17:23:42.571199-04	\N	outside of	He waited outside of the building	fuera de	5	PREPOSICION	PENDIENTE	4	0
163	2025-04-08 08:02:51.176598-04	2025-04-27 17:23:57.27415-04	\N	Give up	She gave up smoking last year and feels much better now.	Rendirse, dejar de hacer algo.	2	VERBO_COMPUESTO	PENDIENTE	1	0
167	2025-04-08 08:02:51.176598-04	2025-04-29 13:56:49.478619-04	\N	Take off	The plane took off on time.	Despegar (avión), quitarse (ropa), volverse exitoso rápidamente.	1	VERBO_COMPUESTO	PENDIENTE	1	1
71	2025-02-22 14:40:07.998052-03	2025-04-28 11:40:37.751698-04	\N	along	We walked along the river	a lo largo de	5	PREPOSICION	PENDIENTE	3	0
58	2025-02-22 14:40:07.998052-03	2025-04-28 11:40:38.863868-04	\N	around	They sat around the fire	alrededor de	5	PREPOSICION	PENDIENTE	3	0
157	2025-04-06 15:02:51.176598-04	2025-04-24 15:54:08.969186-04	\N	therefore	 It’s raining, therefore, we should stay inside.	 por lo tanto	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	1
59	2025-02-22 14:40:07.998052-03	2025-04-28 11:40:39.81563-04	\N	inside	The keys are inside the box	dentro de	5	PREPOSICION	PENDIENTE	3	0
160	2025-04-06 15:02:51.176598-04	2025-04-24 15:55:59.788351-04	\N	wisdom	 Wisdom comes with experience and learning from mistakes.	 sabiduría	4	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	1
60	2025-02-22 14:40:07.998052-03	2025-04-28 11:40:40.407661-04	\N	outside	The dog is outside the house	fuera de	5	PREPOSICION	PENDIENTE	3	0
68	2025-02-22 14:40:07.998052-03	2025-04-24 15:56:08.149037-04	\N	on top of	The cat is on top of the roof	encima de	5	PREPOSICION	PENDIENTE	5	1
61	2025-02-22 14:40:07.998052-03	2025-04-28 11:40:41.327681-04	\N	before	We arrived before the movie started	antes de	5	PREPOSICION	PENDIENTE	3	0
75	2025-02-22 14:40:07.998052-03	2025-04-29 13:55:46.57319-04	\N	down	The ball rolled down the hill	abajo	5	PREPOSICION	PENDIENTE	4	0
76	2025-02-22 14:40:07.998052-03	2025-04-29 13:55:50.733696-04	\N	into	She jumped into the pool	dentro de	5	PREPOSICION	PENDIENTE	4	0
166	2025-04-08 08:02:51.176598-04	2025-04-29 13:56:22.430112-04	\N	Carry on	Despite the interruption, she carried on with her presentation.	Continuar.	1	VERBO_COMPUESTO	PENDIENTE	1	1
77	2025-02-22 14:40:07.998052-03	2025-04-29 13:57:05.479145-04	\N	out of	He ran out of the room	fuera de	1	PREPOSICION	PENDIENTE	4	1
72	2025-02-22 14:40:07.998052-03	2025-04-27 17:22:48.218118-04	\N	inside of	The toy is inside of the box	dentro de	5	PREPOSICION	PENDIENTE	4	0
78	2025-02-22 14:40:07.998052-03	2025-04-29 15:33:50.52918-04	\N	by means of	They communicated by means of letters	por medio de	5	PREPOSICION	PENDIENTE	4	0
79	2025-02-22 14:40:07.998052-03	2025-04-29 15:34:48.453899-04	\N	because of	The game was canceled because of the rain	debido a	5	PREPOSICION	PENDIENTE	4	0
80	2025-02-22 14:40:07.998052-03	2025-04-29 15:34:51.557661-04	\N	due to	The delay was due to traffic	debido a	5	PREPOSICION	PENDIENTE	4	0
62	2025-02-22 14:40:07.998052-03	2025-04-29 15:35:24.886211-04	\N	after	She called after the meeting	después de	5	PREPOSICION	PENDIENTE	3	0
63	2025-02-22 14:40:07.998052-03	2025-04-29 15:35:26.334339-04	\N	during	He slept during the flight	durante	5	PREPOSICION	PENDIENTE	3	0
64	2025-02-22 14:40:07.998052-03	2025-04-29 15:35:27.438113-04	\N	until	They waited until midnight	hasta	5	PREPOSICION	PENDIENTE	3	0
155	2025-04-06 15:02:51.176598-04	2025-04-27 17:22:49.650273-04	\N	so	 I didn’t have time to study, so I failed the test.	 así que	5	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	4	0
162	2025-04-13 21:18:55.398665-04	2025-04-29 13:49:58.584825-04	\N	overcome	You must overcome all difficulties	superar	2	PREPOSICION	PENDIENTE	4	3
159	2025-04-06 15:02:51.176598-04	2025-04-29 13:53:31.106959-04	\N	nevertheless	 It was difficult, nevertheless, she managed to finish the project.	 sin embargo	2	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	8	5
81	2025-02-22 14:40:07.998052-03	2025-04-29 13:54:37.364616-04	\N	as for	As for the plans, we’ll decide tomorrow	en cuanto a	1	PREPOSICION	PENDIENTE	10	10
168	2025-04-08 08:02:51.176598-04	2025-04-29 15:35:23.014571-04	\N	Break down	My car broke down on the way to work.	Averiarse, colapsar emocionalmente.	1	VERBO_COMPUESTO	PENDIENTE	1	1
158	2025-04-06 15:02:51.176598-04	2025-04-11 07:53:41.525174-04	\N	however	 She studied hard, however, she still failed the exam.	 sin embargo	3	MODISMOS_Y_EXPRESIONES_COMUNES	PENDIENTE	2	0
161	2025-04-11 18:35:14.198455-04	2025-04-14 00:59:50.1459-04	\N	throughput	The network throughput increased after upgrading the router.	rendimiento	2	NOMBRE	PENDIENTE	2	1
66	2025-02-22 14:40:07.998052-03	2025-04-11 07:53:46.213593-04	\N	towards	She walked towards the door	hacia.	3	PREPOSICION	PENDIENTE	3	1
169	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Turn up	He turned up late to the meeting.	Aparecer, llegar (a veces inesperadamente).	1	VERBO_COMPUESTO	PENDIENTE	0	0
170	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Put off	We had to put off our trip because of the storm.	Posponer, desalentar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
65	2025-02-22 14:40:07.998052-03	2025-04-11 07:53:50.575963-04	\N	since	I’ve lived here since 2010	desde	4	PREPOSICION	PENDIENTE	2	0
70	2025-02-22 14:40:07.998052-03	2025-04-11 07:53:56.340755-04	\N	beside	She sat beside her friend	al lado de	4	PREPOSICION	PENDIENTE	2	0
171	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Come across	I came across an interesting article while browsing the web.	Encontrar algo por casualidad.	1	VERBO_COMPUESTO	PENDIENTE	0	0
172	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Set up	They set up a new company to develop software.	Establecer, montar (un negocio, una reunión, etc.).	1	VERBO_COMPUESTO	PENDIENTE	0	0
173	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Break up	They decided to break up after three years of dating.	Romper una relación.	1	VERBO_COMPUESTO	PENDIENTE	0	0
122	2025-02-22 14:40:07.998052-03	2025-04-11 19:57:37.705612-04	\N	at the expense of	He succeeded at the expense of his health	a costa de	3	PREPOSICION	PENDIENTE	3	1
91	2025-02-22 14:40:07.998052-03	2025-04-11 19:57:48.161432-04	\N	in favor of	They voted in favor of the proposal	a favor de	3	PREPOSICION	PENDIENTE	4	1
107	2025-02-22 14:40:07.998052-03	2025-04-12 21:53:43.067022-04	\N	in accordance with	This is in accordance with the rules	de acuerdo con	4	PREPOSICION	PENDIENTE	3	0
114	2025-02-22 14:40:07.998052-03	2025-04-13 12:46:28.16584-04	\N	on the grounds of	He was fired on the grounds of misconduct	por motivos de.	2	PREPOSICION	PENDIENTE	5	4
121	2025-02-22 14:40:07.998052-03	2025-04-13 12:50:05.752773-04	\N	on the heels of	Rain came on the heels of the wind	inmediatamente después de	2	PREPOSICION	PENDIENTE	5	4
108	2025-02-22 14:40:07.998052-03	2025-04-14 00:59:58.473675-04	\N	in pursuit of	They’re in pursuit of happiness	en busca de	4	PREPOSICION	PENDIENTE	3	0
110	2025-02-22 14:40:07.998052-03	2025-04-14 01:00:00.217211-04	\N	in relation to	In relation to your comment, I agree	en relación con	4	PREPOSICION	PENDIENTE	3	0
112	2025-02-22 14:40:07.998052-03	2025-04-14 01:00:02.041281-04	\N	in regard to	In regard to the payment, it’s settled	con respecto a	4	PREPOSICION	PENDIENTE	3	0
116	2025-02-22 14:40:07.998052-03	2025-04-14 01:00:05.273853-04	\N	in view of	In view of the weather, we’ll stay indoors	en vista de	4	PREPOSICION	PENDIENTE	3	0
117	2025-02-22 14:40:07.998052-03	2025-04-14 01:00:18.329132-04	\N	on the basis of	He was hired on the basis of his experience	sobre la base de	4	PREPOSICION	PENDIENTE	3	0
125	2025-02-22 14:40:07.998052-03	2025-04-14 01:00:20.897102-04	\N	in the context of	In the context of this discussion, it makes sense	en el contexto de	4	PREPOSICION	PENDIENTE	3	0
92	2025-02-22 14:40:07.998052-03	2025-04-14 19:27:56.98644-04	\N	on behalf of	I speak on behalf of the team	en nombre de	3	PREPOSICION	PENDIENTE	5	3
119	2025-02-22 14:40:07.998052-03	2025-04-14 19:28:10.458217-04	\N	in the wake of	Changes came in the wake of the crisis	a raíz de	3	PREPOSICION	PENDIENTE	5	3
174	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Bring up	She brought up an interesting point during the meeting.	Mencionar, sacar un tema.	1	VERBO_COMPUESTO	PENDIENTE	0	0
175	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Call off	The game was called off due to rain.	Cancelar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
176	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Check in	We need to check in at the airport two hours before our flight.	Registrarse (en un hotel, aeropuerto, etc.).	1	VERBO_COMPUESTO	PENDIENTE	0	0
177	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Check out	You should check out this new restaurant; it’s amazing.	Revisar, verificar, dejar el hotel.	1	VERBO_COMPUESTO	PENDIENTE	0	0
178	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Come up with	He came up with a brilliant idea for the project.	Pensar en algo, idear algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
179	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Cut off	The electricity was cut off due to the storm.	Cortar, interrumpir (conexión, suministro).	1	VERBO_COMPUESTO	PENDIENTE	0	0
180	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get along	They get along very well despite their differences.	Llevarse bien con alguien.	1	VERBO_COMPUESTO	PENDIENTE	0	0
181	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Give in	After hours of negotiation, he finally gave in to their demands.	Ceder, rendirse ante algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
182	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Go on	The show must go on, no matter what.	Continuar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
183	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Hold on	Hold on a second, I’ll be right back.	Esperar, sostenerse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
184	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Look forward to	I’m looking forward to meeting you tomorrow.	Esperar con ansias.	1	VERBO_COMPUESTO	PENDIENTE	0	0
185	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Make up	She made up an excuse for being late.	Inventar, reconciliarse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
186	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Pick up	Can you pick up some groceries on your way home?	Recoger, mejorar, aprender algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
187	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Point out	He pointed out the mistakes in the report.	Señalar, indicar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
188	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Put up with	I can’t put up with his bad attitude anymore.	Soportar, tolerar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
189	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Run out of	We ran out of milk, so we need to go to the store.	Quedarse sin algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
190	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Settle down	After years of traveling, they decided to settle down in the countryside.	Asentarse, calmarse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
115	2025-02-22 14:40:07.998052-03	2025-04-11 19:57:28.292973-04	\N	in lieu of	She gave flowers in lieu of an apology	en lugar de	3	PREPOSICION	PENDIENTE	3	1
191	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Take up	She took up painting as a hobby last year.	Comenzar a hacer algo (hobby, deporte, actividad).	1	VERBO_COMPUESTO	PENDIENTE	0	0
199	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Run across	I ran across my old teacher while walking in the park.	Encontrar por casualidad.	1	VERBO_COMPUESTO	PENDIENTE	0	0
200	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Speak up	Please speak up, I can’t hear you from over here.	Hablar más fuerte, expresarse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
201	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Take over	She will take over the project after John leaves.	Tomar el control, encargarse de algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
202	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Break into	The thief broke into the house late last night.	Entrar a la fuerza.	1	VERBO_COMPUESTO	PENDIENTE	0	0
203	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get by	It’s hard, but we’ll get by with what we have.	Arreglárselas, sobrevivir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
204	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Go over	Let’s go over the plan one more time before the meeting.	Repasar, revisar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
205	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Ask out	He asked her out to dinner last night.	Invitar a alguien a salir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
206	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Catch up	I need to catch up on my emails.	Ponerse al día.	1	VERBO_COMPUESTO	PENDIENTE	0	0
207	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Do over	I didn’t like my painting, so I’m going to do it over.	Hacer de nuevo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
208	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Drop by	I’ll drop by your office tomorrow morning.	Pasar por, visitar brevemente.	1	VERBO_COMPUESTO	PENDIENTE	0	0
209	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Drop off	Can you drop me off at the airport?	Dejar a alguien en algún lugar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
210	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Fill out	Please fill out this form before the appointment.	Rellenar (formularios).	1	VERBO_COMPUESTO	PENDIENTE	0	0
211	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Find out	I need to find out what time the meeting starts.	Descubrir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
212	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get around	We got around the city by subway.	Moverse, desplazarse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
213	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get away	We’re planning to get away next weekend.	Escaparse, irse de vacaciones.	1	VERBO_COMPUESTO	PENDIENTE	0	0
214	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get back	When do you get back from your trip?	Volver.	1	VERBO_COMPUESTO	PENDIENTE	0	0
215	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get off	She got off the bus at the next stop.	Bajar (de un transporte).	1	VERBO_COMPUESTO	PENDIENTE	0	0
216	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get on	I need to get on the train now, or I’ll be late.	Subir (a un transporte).	1	VERBO_COMPUESTO	PENDIENTE	0	0
217	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Give away	She gave away all her old clothes to charity.	Regalar, dar algo sin pedir nada a cambio.	1	VERBO_COMPUESTO	PENDIENTE	0	0
218	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Go out	We’re going out for dinner tonight.	Salir (a divertirse).	1	VERBO_COMPUESTO	PENDIENTE	0	0
219	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Grow up	He grew up in a small town in the countryside.	Crecer, madurar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
220	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Hang out	We used to hang out at the park every weekend.	Pasar el rato, socializar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
221	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Hold up	Sorry I’m late, I got held up at work.	Retrasar, atracar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
222	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Keep on	Keep on trying, you’ll get it eventually.	Continuar haciendo algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
223	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Look down on	She looks down on people who don’t have a university degree.	Mirar a alguien con desdén.	1	VERBO_COMPUESTO	PENDIENTE	0	0
224	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Look for	I’m looking for my keys, have you seen them?	Buscar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
225	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Look out	Look out for the car! It’s coming fast.	Tener cuidado.	1	VERBO_COMPUESTO	PENDIENTE	0	0
226	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Show up	He showed up late to the party.	Aparecer, presentarse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
227	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Shut down	The company shut down last year due to financial problems.	Cerrar (un negocio, sistema), detenerse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
228	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Wake up	I wake up at 7 AM every day.	Despertarse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
229	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Wrap up	Let’s wrap up this meeting, we’re running out of time.	Concluir, finalizar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
230	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Write down	Please write down your name and contact number.	Anotar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
231	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Bring about	The new law will bring about major changes.	Causar, provocar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
232	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Call back	I missed your call, I’ll call you back later.	Devolver la llamada.	1	VERBO_COMPUESTO	PENDIENTE	0	0
234	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Break in	Someone broke in while we were on vacation.	Forzar la entrada.	1	VERBO_COMPUESTO	PENDIENTE	0	0
235	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Bring in	They brought in a new system to improve efficiency.	Introducir, traer.	1	VERBO_COMPUESTO	PENDIENTE	0	0
236	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Bring out	The artist brought out a new painting last week.	Sacar a la luz, resaltar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
237	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Call for	The situation calls for immediate action.	Exigir, requerir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
238	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Call in	We had to call in a technician to fix the issue.	Llamar (a una persona para pedir ayuda).	1	VERBO_COMPUESTO	PENDIENTE	0	0
240	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Come down with	She came down with a cold last week.	Enfermar de algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
241	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Come over	Why don’t you come over and we can hang out?	Visitar, pasar por casa.	1	VERBO_COMPUESTO	PENDIENTE	0	0
242	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Cut back	We need to cut back on our expenses this year.	Reducir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
243	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Cut down	I need to cut down on sugar.	Reducir, recortar (una cantidad).	1	VERBO_COMPUESTO	PENDIENTE	0	0
244	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get ahead	She is working hard to get ahead in her career.	Avanzar, progresar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
245	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get out	They got out of the building just before it collapsed.	Salir, escapar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
246	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Get together	Let’s get together this weekend and catch up.	Reunirse, juntarse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
248	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Give off	The flowers give off a pleasant fragrance.	Emitir, desprender.	1	VERBO_COMPUESTO	PENDIENTE	0	0
249	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Go ahead	You can go ahead and start without me.	Adelante, proceder.	1	VERBO_COMPUESTO	PENDIENTE	0	0
250	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Go down	The price of oil went down last week.	Descender, disminuir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
251	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Go for	I’m going for the red dress, it looks better on me.	Optar por, elegir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
252	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Go out with	He’s going out with his friends tonight.	Salir con (en pareja).	1	VERBO_COMPUESTO	PENDIENTE	0	0
253	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Hang up	She hung up the phone after a short conversation.	Colgar (el teléfono).	1	VERBO_COMPUESTO	PENDIENTE	0	0
255	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Hold out	He held out his hand for a handshake.	Extender, ofrecer.	1	VERBO_COMPUESTO	PENDIENTE	0	0
256	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Keep away	Keep away from the edge of the cliff!	Mantenerse alejado.	1	VERBO_COMPUESTO	PENDIENTE	0	0
257	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Keep up	She’s struggling to keep up with the new project.	Mantener el ritmo, seguir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
258	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Let down	I hope I don’t let you down during the presentation.	Decepcionar, defraudar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
259	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Let in	She let him in after a few minutes of hesitation.	Permitir la entrada.	1	VERBO_COMPUESTO	PENDIENTE	0	0
260	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Look back	I often look back at my childhood memories.	Mirar atrás, reflexionar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
261	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Look into	We need to look into the details before making a decision.	Investigar, indagar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
262	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Look out for	Look out for the cars while crossing the street.	Estar alerta por algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
263	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Make up for	I’ll make up for missing your birthday next year.	Compensar, resarcir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
264	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Make up to	She made up to her friend after the argument.	Compensar a alguien.	1	VERBO_COMPUESTO	PENDIENTE	0	0
265	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Pick up on	He picked up on her discomfort during the meeting.	Notar, percatarse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
267	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Put up	Can you put up the decorations for the party?	Colocar, poner algo en un lugar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
268	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Run away	She ran away from home after the argument.	Huir, escapar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
269	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Run out	We ran out of coffee this morning.	Quedarse sin algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
270	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Set aside	They set aside some money for their vacation.	Apartar, reservar (algo).	1	VERBO_COMPUESTO	PENDIENTE	0	0
271	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Set off	They set off early in the morning to avoid traffic.	Salir, comenzar un viaje.	1	VERBO_COMPUESTO	PENDIENTE	0	0
272	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Shut up	He told me to shut up during the meeting.	Callarse.	1	VERBO_COMPUESTO	PENDIENTE	0	0
273	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Stand out	Her performance really stood out at the competition.	Destacar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
274	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Take in	It took me a while to take in all the information from the meeting.	Aceptar, asimilar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
275	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Take on	She took on a leadership role in the project.	Asumir, aceptar un desafío.	1	VERBO_COMPUESTO	PENDIENTE	0	0
276	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Take out	He took out the trash before leaving.	Sacar, extraer.	1	VERBO_COMPUESTO	PENDIENTE	0	0
277	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Talk over	Let’s talk over the details of the proposal tomorrow.	Hablar de algo, discutir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
278	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Tear up	She tore up the letter after reading it.	Romper en pedazos.	1	VERBO_COMPUESTO	PENDIENTE	0	0
279	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Throw away	Don’t throw away that book, it’s a classic!	Tirar, desechar.	1	VERBO_COMPUESTO	PENDIENTE	0	0
280	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Turn off	Please turn off the lights when you leave the room.	Apagar (un dispositivo).	1	VERBO_COMPUESTO	PENDIENTE	0	0
281	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Turn on	Can you turn on the air conditioning?	Encender (un dispositivo).	1	VERBO_COMPUESTO	PENDIENTE	0	0
282	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Wake up to	He woke up to the reality of the situation.	Darse cuenta de algo.	1	VERBO_COMPUESTO	PENDIENTE	0	0
283	2025-04-08 08:02:51.176598-04	2025-04-08 08:02:51.176598-04	\N	Write up	I’ll write up the report and send it to you tomorrow.	Redactar, escribir.	1	VERBO_COMPUESTO	PENDIENTE	0	0
297	2025-05-01 18:29:25.397756-04	2025-05-01 18:29:25.397756-04	\N	frauds	The police arrested two frauds posing as charity workers.	fraudes, estafadores (puede referirse tanto a personas como a acciones)	1	NOMBRE	PENDIENTE	0	0
298	2025-05-01 18:30:46.764752-04	2025-05-01 18:30:46.764752-04	\N	scoundrels	 Those scoundrels stole from the elderly without remorse.	sinvergüenzas, canallas	1	NOMBRE	PENDIENTE	0	0
300	2025-05-01 18:42:29.802342-04	2025-05-01 18:42:29.802342-04	\N	shrill	The baby's shrill cry woke everyone in the house.	agudo, chillón (refiriéndose a un sonido, generalmente desagradable)	1	NOMBRE	PENDIENTE	0	0
\.


--
-- Name: palabras_id_seq; Type: SEQUENCE SET; Schema: public; Owner: tcero
--

SELECT pg_catalog.setval('public.palabras_id_seq', 309, true);


--
-- PostgreSQL database dump complete
--

