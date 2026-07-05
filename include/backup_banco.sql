--
-- PostgreSQL database dump
--

\restrict rmFxz90R8qjWXgDYdmoHdWrfzKoM2Sr8Y6lvWyfdXLSfMRbw0UPcoyzPrfn8Cc0

-- Dumped from database version 18.4 (Debian 18.4-1.pgdg13+1)
-- Dumped by pg_dump version 18.4 (Debian 18.4-1.pgdg13+1)

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
-- Name: aluno_turma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aluno_turma (
    id_aluno_turma integer NOT NULL,
    id_aluno integer NOT NULL,
    id_turma integer NOT NULL,
    conceito character varying(2)
);


ALTER TABLE public.aluno_turma OWNER TO postgres;

--
-- Name: aluno_turma_id_aluno_turma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aluno_turma_id_aluno_turma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aluno_turma_id_aluno_turma_seq OWNER TO postgres;

--
-- Name: aluno_turma_id_aluno_turma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aluno_turma_id_aluno_turma_seq OWNED BY public.aluno_turma.id_aluno_turma;


--
-- Name: alunos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alunos (
    id_aluno integer NOT NULL,
    nome character varying(100) NOT NULL,
    matricula integer NOT NULL
);


ALTER TABLE public.alunos OWNER TO postgres;

--
-- Name: alunos_id_aluno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alunos_id_aluno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alunos_id_aluno_seq OWNER TO postgres;

--
-- Name: alunos_id_aluno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alunos_id_aluno_seq OWNED BY public.alunos.id_aluno;


--
-- Name: conteudos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conteudos (
    id_conteudo integer NOT NULL,
    codigo character varying(20) NOT NULL,
    essencialidade character varying(20) NOT NULL,
    descricao character varying(500) NOT NULL
);


ALTER TABLE public.conteudos OWNER TO postgres;

--
-- Name: conteudos_id_conteudo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conteudos_id_conteudo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conteudos_id_conteudo_seq OWNER TO postgres;

--
-- Name: conteudos_id_conteudo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conteudos_id_conteudo_seq OWNED BY public.conteudos.id_conteudo;


--
-- Name: disciplinas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplinas (
    id_disciplina integer NOT NULL,
    nome character varying(100) NOT NULL,
    codigo character varying(20) NOT NULL,
    area character varying(2)
);


ALTER TABLE public.disciplinas OWNER TO postgres;

--
-- Name: disciplinas_conteudos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplinas_conteudos (
    id_disciplina integer NOT NULL,
    id_conteudo integer NOT NULL
);


ALTER TABLE public.disciplinas_conteudos OWNER TO postgres;

--
-- Name: disciplinas_habilidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplinas_habilidades (
    id_disciplina integer NOT NULL,
    id_habilidade integer NOT NULL
);


ALTER TABLE public.disciplinas_habilidades OWNER TO postgres;

--
-- Name: disciplinas_id_disciplina_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.disciplinas_id_disciplina_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.disciplinas_id_disciplina_seq OWNER TO postgres;

--
-- Name: disciplinas_id_disciplina_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.disciplinas_id_disciplina_seq OWNED BY public.disciplinas.id_disciplina;


--
-- Name: habilidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.habilidades (
    id_habilidade integer NOT NULL,
    codigo character varying(20) NOT NULL,
    essencialidade character varying(20) NOT NULL,
    descricao character varying(500) NOT NULL,
    proficiencia character varying(20) NOT NULL
);


ALTER TABLE public.habilidades OWNER TO postgres;

--
-- Name: habilidades_id_habilidade_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.habilidades_id_habilidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.habilidades_id_habilidade_seq OWNER TO postgres;

--
-- Name: habilidades_id_habilidade_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.habilidades_id_habilidade_seq OWNED BY public.habilidades.id_habilidade;


--
-- Name: notas_conteudos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notas_conteudos (
    id_nota_conteudo integer NOT NULL,
    id_aluno_turma integer NOT NULL,
    id_conteudo integer NOT NULL,
    nota double precision
);


ALTER TABLE public.notas_conteudos OWNER TO postgres;

--
-- Name: notas_conteudos_id_nota_conteudo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notas_conteudos_id_nota_conteudo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notas_conteudos_id_nota_conteudo_seq OWNER TO postgres;

--
-- Name: notas_conteudos_id_nota_conteudo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notas_conteudos_id_nota_conteudo_seq OWNED BY public.notas_conteudos.id_nota_conteudo;


--
-- Name: notas_habilidades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notas_habilidades (
    id_nota_habilidade integer NOT NULL,
    id_aluno_turma integer NOT NULL,
    id_habilidade integer NOT NULL,
    nota double precision
);


ALTER TABLE public.notas_habilidades OWNER TO postgres;

--
-- Name: notas_habilidades_id_nota_habilidade_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notas_habilidades_id_nota_habilidade_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notas_habilidades_id_nota_habilidade_seq OWNER TO postgres;

--
-- Name: notas_habilidades_id_nota_habilidade_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notas_habilidades_id_nota_habilidade_seq OWNED BY public.notas_habilidades.id_nota_habilidade;


--
-- Name: turmas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.turmas (
    id_turma integer NOT NULL,
    id_disciplina integer NOT NULL,
    codigo character varying(20) NOT NULL,
    ano integer NOT NULL,
    semestre integer NOT NULL
);


ALTER TABLE public.turmas OWNER TO postgres;

--
-- Name: turmas_id_turma_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.turmas_id_turma_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.turmas_id_turma_seq OWNER TO postgres;

--
-- Name: turmas_id_turma_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.turmas_id_turma_seq OWNED BY public.turmas.id_turma;


--
-- Name: aluno_turma id_aluno_turma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_turma ALTER COLUMN id_aluno_turma SET DEFAULT nextval('public.aluno_turma_id_aluno_turma_seq'::regclass);


--
-- Name: alunos id_aluno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alunos ALTER COLUMN id_aluno SET DEFAULT nextval('public.alunos_id_aluno_seq'::regclass);


--
-- Name: conteudos id_conteudo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conteudos ALTER COLUMN id_conteudo SET DEFAULT nextval('public.conteudos_id_conteudo_seq'::regclass);


--
-- Name: disciplinas id_disciplina; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas ALTER COLUMN id_disciplina SET DEFAULT nextval('public.disciplinas_id_disciplina_seq'::regclass);


--
-- Name: habilidades id_habilidade; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidades ALTER COLUMN id_habilidade SET DEFAULT nextval('public.habilidades_id_habilidade_seq'::regclass);


--
-- Name: notas_conteudos id_nota_conteudo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_conteudos ALTER COLUMN id_nota_conteudo SET DEFAULT nextval('public.notas_conteudos_id_nota_conteudo_seq'::regclass);


--
-- Name: notas_habilidades id_nota_habilidade; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_habilidades ALTER COLUMN id_nota_habilidade SET DEFAULT nextval('public.notas_habilidades_id_nota_habilidade_seq'::regclass);


--
-- Name: turmas id_turma; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turmas ALTER COLUMN id_turma SET DEFAULT nextval('public.turmas_id_turma_seq'::regclass);


--
-- Data for Name: aluno_turma; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aluno_turma (id_aluno_turma, id_aluno, id_turma, conceito) FROM stdin;
\.


--
-- Data for Name: alunos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alunos (id_aluno, nome, matricula) FROM stdin;
2	Vaeda	976296
3	Marcellene	568619
4	Kaamilah	39519
5	Hastings	637573
6	Dessence	710371
7	Harmoney	74377
8	Renat	370550
9	Joban	772174
10	Malaiah	867789
11	Siomara	862799
12	Kahlaya	18122
13	Varner	173682
14	Maral	173170
15	Pene	264962
16	Hather	818458
17	Myrion	11693
18	Delzora	688917
19	Sharde	309688
20	Wuilian	670795
21	Jayren	384433
22	Jeweldene	62067
23	Makaily	202040
24	Angelyn	511459
25	Isabell	724613
26	Kema	885003
27	Sanija	70433
28	Cordney	447841
29	Strella	610263
30	Breya	498531
31	Leniya	211320
32	Niana	583533
33	Stevion	655095
34	Rodneysha	623967
35	Terranisha	470868
36	Marlenia	53852
37	Chekesha	604163
38	Ariabella	532805
39	Raeli	532939
40	Kyndell	382678
41	Yalana	313168
42	Jabrian	19980
43	Korianne	328169
44	Astella	268199
45	Brenea	355661
46	Aaronjoseph	437651
47	Kerrissa	384511
48	Breyan	570766
49	Latorya	987485
50	Billi	591872
51	Erene	60351
52	Narelle	102455
53	Schnell	733243
54	Jesiree	933655
55	Deema	527458
56	Birdene	167727
57	Aniysa	122448
58	Tonita	776117
59	Dalonda	715246
60	Ivah	992073
61	Omkar	829516
62	Gabrylle	635106
63	Mulani	40730
64	Rory	278712
65	Siyah	875741
66	Jermell	670458
67	Deletta	517632
68	Jacobey	683761
69	Anniemarie	764142
70	Meissa	908133
71	Lawrin	813496
72	Qusay	777835
73	Maicey	760814
74	Marlyne	693047
75	Zillie	735962
76	Brenesha	22865
77	Samrudh	917083
78	Taddeo	158707
79	Zakaria	671115
80	Drennon	477839
81	Sagine	29476
82	Miquel	908868
83	Kadrianna	327715
84	Tyrique	777935
85	Glorious	283217
86	Zoriah	104861
87	Tykiria	112832
88	Barbaraa	397962
89	Lubie	608342
90	Shareeka	479615
91	Antolina	793386
92	Cemya	237746
93	Jamiracle	319181
94	Sumayyah	45412
95	Ezmerelda	532899
96	Claretha	778652
97	Bang	662670
98	Jacenda	757480
99	Aila	743431
100	Maliya	269310
101	Meeya	712349
102	Alegacy	695753
103	Nirmala	295301
104	Jossalyn	777532
105	Jadalin	165706
106	Kyhia	159462
107	Shauntrell	358429
108	Othoniel	504454
109	Lekisa	981244
110	Petter	194956
111	Antown	719791
112	Dianelly	670728
113	Eustolia	381006
114	Nancyjo	158067
115	Briara	130181
116	Eaven	431094
117	Izah	668143
118	Barlow	397550
119	Mazey	477964
120	Yaeno	619932
121	Pavly	434355
122	Sammiyah	524987
123	Tiofila	628289
124	Saquita	718490
125	Graylee	286581
126	Levern	777894
127	Raymeir	49614
128	Nauman	359910
129	Leiana	371170
130	Tryniti	527588
131	Natalee	203396
132	Cyrill	826150
133	Williaa	224429
134	Quionna	959779
135	Ferdie	303249
136	Aleca	343222
137	Kleo	592463
138	Tjaden	27899
139	Euclid	783002
140	Ixtzel	758330
141	Gregry	525935
142	Tychina	213805
143	Neeah	530505
144	Shayde	193679
145	Rendon	513103
146	Jeroline	800120
147	Zymier	314022
148	Marsue	524755
149	Tairon	320145
150	Zeriah	378545
151	Peydon	875645
152	Cheryse	926485
153	Consiglia	973663
154	Jashelle	344941
155	Aleaya	545588
156	Adhithya	929631
157	Arnardo	709465
158	Eleonore	534600
159	Rozan	92229
160	Khanh	704894
161	Romelia	458658
162	Euella	741960
163	Jabulani	371252
164	Shara	597441
165	Saraya	165721
166	Shayal	460761
167	Margarethe	801495
168	Kayesha	540740
169	Larrion	59342
170	Dawone	381851
171	Kennady	562269
172	Jimena	914135
173	Rae	992325
174	Viena	640590
175	Keedah	820248
176	Yolette	756640
177	Cedeno	869985
178	Evey	79044
179	Mae	436241
180	Akyia	822591
181	Zein	192571
182	Alyas	554521
183	Kishonna	856964
184	Laterra	649718
185	Serah	872558
186	Cristen	854081
187	Isaac	696368
188	Marytza	255601
189	Tzion	340806
190	Zsazsa	629939
191	Nisma	693163
192	Symara	916573
193	Debroah	379149
194	Darivs	585018
195	Caeli	520870
196	Aamena	213833
197	Emileah	213340
198	Kasaun	806492
199	Yumeka	773350
200	Jurate	674383
201	Edmay	422766
202	Damayanti	514122
203	Deantwon	399178
204	Torriano	308963
205	Althelia	714495
206	Hulali	912395
207	Dylian	170287
208	Letisha	676435
209	Tehillah	513150
210	Miamour	671290
211	Londonrose	880118
212	Abbygale	965872
213	Navarre	926763
214	Relonda	430620
215	Janaira	518812
216	Kona	788106
217	Deeqa	850817
218	Davd	251624
219	Kimani	164278
220	Rosel	81128
221	Muireann	771127
222	Jemar	875449
223	Demontra	535737
224	Eralyn	590277
225	Menyon	700100
226	Divia	510682
227	Kealia	193640
228	Adriana	192129
229	Inderpreet	728932
230	Natae	366329
231	Prajna	615791
232	Tinina	502066
233	Thaliana	31570
234	Nazhae	38310
235	Efford	123660
236	Sharlyne	923511
237	Rubben	835068
238	Dakera	47759
239	Nazario	199134
240	Aureon	729142
241	Majik	348379
242	Domminic	781927
243	Zaelyn	524978
244	Caleab	882198
245	Adjua	381890
246	Jakkob	966191
247	Dannyelle	237881
248	Jhoselin	824137
249	Decarlos	996713
250	Deonza	256796
251	Francie	951489
252	Leeshawn	74490
253	Duel	386077
254	Torstein	18004
255	Annel	653823
256	Zaryah	270436
257	Vesenia	699941
258	Joey	615707
259	Eldrige	234456
260	Dejahna	13695
261	Jaisha	955947
262	Tyvan	561827
263	Kimblery	919093
264	Nateasha	921438
265	Dawud	991871
266	Jermya	874182
267	Amaia	3488
268	Lindly	91630
269	Makar	202948
270	Timarah	850945
271	Yadon	521607
272	Andrelle	42250
273	Abdirisaq	700667
274	Nelma	301063
275	Laeton	785143
276	Muneerah	495772
277	Isabellia	804074
278	Antonin	880153
279	Devana	536617
280	Amando	364027
281	Braley	752566
282	Jaloni	547544
283	Caylen	472064
284	Loriena	123655
285	Tiauna	118255
286	Raaghav	509701
287	Tahel	507044
288	Maurey	100311
289	Derna	202652
290	Bissan	877543
291	Azon	29108
292	Earlina	178180
293	Shavannah	757597
294	Nivaeh	876434
295	Hosey	13361
296	Kinadee	727177
297	Gloribel	176182
298	Tylan	934406
299	Elic	599740
300	Khiyon	881930
301	Yaniv	639335
302	Shellee	998752
303	Nemo	145813
304	Lismari	909639
305	Anyya	554813
306	Sirron	753582
307	Xou	554271
308	Nanalee	226308
309	Anjelicia	147345
310	Yaneli	791141
311	Virignia	435806
312	Georga	229472
313	Maluhia	387266
314	Xaveon	219869
315	Teaya	46054
316	Emilina	266601
317	Jalei	162219
318	Shantavia	611865
319	Zyyanna	420975
320	Jayanah	692631
321	Amiira	682806
322	Kemeshia	318724
323	Kenari	701813
324	Keylin	281132
325	Pei	984477
326	Creon	5140
327	Jovontae	790763
328	Dulio	254382
329	Virla	474365
330	Lason	146210
331	Crystale	997925
332	Serrena	361561
333	Dede	33322
334	Myrtlee	626344
335	Jeany	635518
336	Esquiel	346521
337	Jakaiya	331231
338	Maketa	523033
339	Oatis	882802
340	Wildan	136425
341	Darnetha	639447
342	Kalie	4444
343	Aliccia	256697
344	Manasvini	649656
345	Kayven	443514
346	Zionna	239272
347	Adrielle	660740
348	Vernen	90746
349	Thecla	198507
350	Kenesia	325861
351	Aloysia	193241
352	Jaival	245764
353	Elbie	576088
354	Huldia	573372
355	Rand	836047
356	Neylin	526002
357	Temikia	777271
358	Tacie	359408
359	Loyalty	210259
360	Mayana	946005
361	Gamaliel	938577
362	Gearl	512827
363	Lenci	350411
364	Reshaunda	852475
365	Allianna	587630
366	Tobye	13988
367	Normalinda	59960
368	Shaunt	156291
369	Derrald	676852
370	Kaitlon	383394
371	Delorise	253078
372	Meerab	404125
373	Stamatis	998871
374	Sudha	168406
375	Keenen	470776
376	Harutun	958456
377	Fedrick	784929
378	Antwanett	717725
379	Luisiana	563017
380	Aricel	115915
381	Jessabella	552280
382	Mourine	972113
383	Maricela	920269
384	Jewan	153143
385	Tayshia	401519
386	Tyera	289669
387	Katylin	609721
388	Lindajo	458627
389	Teshika	445102
390	Uriyah	353311
391	Emylie	838428
392	Reminisce	429571
393	Trishamae	407105
394	Zaydrian	983844
395	Ija	573481
396	Rudolph	77915
397	Keyah	34846
398	Kelaiah	216330
399	Urina	984279
400	Rakiem	715840
401	Corderra	77288
402	Azyon	721408
403	Ewart	712807
404	Rreanna	797834
405	Jesska	269311
406	Keshae	924813
407	Anthonio	117689
408	Kizzy	426914
409	Swannie	797564
410	Phelicity	732402
411	Enari	191022
412	Brieanne	964580
413	Kivin	130088
414	Momie	653008
415	Antawn	385707
416	Brocha	43806
417	Zyhier	913874
418	Tyvon	834762
419	Kaname	105309
420	Diannia	836230
421	Joniesha	12104
422	Nobie	812858
423	Ramira	22784
424	Luiscarlos	445633
425	Ahliana	58633
426	Tymire	104745
427	Slone	245037
428	Ahni	659571
429	Shigeko	640421
430	Avrom	808566
431	Barclay	678604
432	Ronta	315534
433	Aidana	686860
434	Issaiah	391113
435	Jahaven	87403
436	Ewell	732018
437	Naythan	415202
438	Reagann	279627
439	Jimette	678502
440	Claud	862275
441	Alitzel	673121
442	Quenetta	764714
443	Mariss	963172
444	Aubreyana	147963
445	Otie	79927
446	Nyvea	331359
447	Jovannie	224480
448	Aundreya	652730
449	Samantaha	323515
450	Vyaan	563097
451	Melton	585733
452	Montrese	995076
453	Davae	915875
454	Shanelle	523441
455	Gioia	851220
456	Danilynn	120743
457	Marsie	649090
458	Tymeek	79161
459	Tsuyako	578690
460	Dorace	248096
461	Lolitha	355216
462	Crstal	670182
463	Christol	31276
464	Verden	405676
465	Monnette	73498
466	Jaelani	783047
467	Lyndze	809532
468	Johneisha	249067
469	Marther	86414
470	Sandrine	391425
471	Finnbar	526985
472	Lataysha	506175
473	Terianne	869407
474	Tevaris	835525
475	Kewana	793218
476	Nahyan	457928
477	Nyerere	604090
478	Deren	952957
479	Maricio	592749
480	Elridge	848387
481	Haileyann	793515
482	Ascencion	916472
483	Jaquari	843605
484	Coralene	509751
485	Akiana	154507
486	Deverne	325124
487	Jovonnie	388098
488	Tilghman	649841
489	Ilori	351077
490	Hideki	540725
491	Davianna	192662
492	Aureo	897258
493	Yuriah	882148
494	Gleora	367596
495	Aashritha	789390
496	Shantiana	850710
497	Taro	69821
498	Nysaiah	724423
499	Yordan	539847
500	Nermeen	626735
501	Saboor	174976
502	Filiz	867327
503	Allante	351465
504	Jakel	108775
505	Kharmyn	765798
506	Jerrison	224838
507	Yogi	472357
508	Aruba	530135
509	Jermonte	929383
510	Dylynn	331852
511	Willys	253986
512	Woody	130806
513	Kyalee	471138
514	Alijha	848631
515	Annabela	705352
516	Nanetta	40655
517	Mathias	276003
518	Khloie	251384
519	Afif	202242
520	Socheata	549104
521	Tlyer	82888
522	Nussen	884035
523	Caye	963368
524	Aalias	92797
525	Andols	92646
526	Zori	234441
527	Steph	623744
528	Iula	366566
529	Elzia	198975
530	Jungwoo	18607
531	Eirinn	128897
532	Gaylia	611111
533	Milette	596241
534	Nekishia	3903
535	Whiteny	232613
536	Pierrette	597267
537	Elizabelle	37142
538	Dajea	170981
539	Pashion	853567
540	Neff	296085
541	Akhilesh	242313
542	Jamicah	664646
543	Ferra	375535
544	Gevan	213909
545	Jalal	28811
546	Thomasina	238777
547	Sakima	528136
548	Youri	545475
549	Blyss	853250
550	Raygan	519932
551	Rosalynda	749701
552	Zinnia	540921
553	Yariana	442366
554	Lilibeth	212803
555	Reaner	613348
556	Deucalion	592113
557	Paisly	776408
558	Makinley	460557
559	Radiance	132517
560	Martinis	185292
561	Davalyn	798929
562	Tavorian	361249
563	Emuel	831168
564	Kariyana	344932
565	Tollie	464601
566	Ashalina	99226
567	Skyelynn	363123
568	Dorinna	94213
569	Tenyah	300497
570	Alvinia	206140
571	Matt	868153
572	Nastasja	693217
573	Sharonlee	515169
574	Zoilo	374256
575	Inikki	22582
576	Marylen	391513
577	Hyde	676336
578	Antonius	344122
579	Brandan	465213
580	Emmariah	504343
581	Brettney	840134
582	Ceres	177059
583	Gwindolyn	62872
584	Kadeem	856526
585	Brittoni	847708
586	Adlena	989913
587	Amr	557686
588	Undre	387387
589	Campton	758473
590	Nasiah	228702
591	Shiye	412369
592	Deyan	462944
593	Draxie	168855
594	Rakeia	251621
595	Bernadine	325303
596	Charmika	992071
597	Leslian	12001
598	Hailly	997203
599	Maggielean	212973
600	Grettel	140182
601	Jaymiah	63673
602	Vincenta	863695
603	Shaquelle	61739
604	Demitrius	519004
605	Kurstie	887306
606	Willes	776927
607	Riku	503037
608	Emelia	587709
609	Vicktoria	809278
610	Darionte	285063
611	Jkayla	299667
612	Avangeline	984197
613	Shanay	655258
614	Alixandrea	701161
615	Sametta	374873
616	Londen	340899
617	Evyn	882854
618	Tho	293079
619	Troya	736988
620	Fonzo	274988
621	Deverick	247379
622	Maleaya	781758
623	Dayvid	884364
624	Stehanie	130482
625	Preetham	145957
626	Esterlene	400643
627	Mecos	891727
628	Giavannah	239033
629	Dawna	649105
630	Kaya	499778
631	Manreet	757876
632	Domian	783342
633	Nickesha	416590
634	Kerstein	186701
635	Lemarr	422990
636	Mechele	996786
637	Evaine	602607
638	Annibelle	474863
639	Vonita	518913
640	Brodi	586416
641	Mandre	233269
642	Jammey	389670
643	Zhymir	228959
644	Tyshone	578268
645	Fabianna	856410
646	Abdu	734111
647	Amira	723844
648	Alvie	740864
649	Reubena	143263
650	Remini	370013
651	Lavett	665128
652	Fredarius	335396
653	Aarika	93952
654	Nathaneal	247082
655	Alethia	230849
656	Johnice	970546
657	Karolin	587998
658	Zayvian	628332
659	Kohana	492724
660	Jamael	860361
661	Jubril	703795
662	Lucindia	268917
663	Enloe	226777
664	Jasianna	689884
665	Cheralee	996001
666	Laetyn	74865
667	Taaron	950274
668	Karielle	579480
669	Sayonna	65232
670	Zechary	634306
671	Darah	644038
672	Tyshia	955886
673	Latavia	709197
674	Jnae	859969
675	Kenyla	75377
676	Trystin	359646
677	Chua	10913
678	Breanna	255393
679	Anastin	966660
680	Tyiana	589234
681	Avaya	273772
682	Nijai	153363
683	Ramey	766601
684	Tregan	566969
685	Savyon	90044
686	Anaja	986034
687	Sneyder	221220
688	Scheherazade	200448
689	Florece	129734
690	Hillery	33678
691	Lakitha	786065
692	Daeshaun	919036
693	Jacee	194794
694	Cutina	467647
695	Katylyn	325201
696	Fadel	655361
697	Ashai	449039
698	Martay	294077
699	Jamileth	817577
700	Hakeim	96519
701	Gwenette	364750
702	Yaden	122147
703	Leonne	440098
704	Mikhaila	849325
705	Kursti	395630
706	Karia	755111
707	Zianny	401678
708	Jelaina	493318
709	Royse	66525
710	Quillen	1815
711	Charm	201219
712	Ellinore	916773
713	Joannamarie	208242
714	Zorina	400397
715	Nahuel	600221
716	Fate	419203
717	Jwaun	68336
718	Tokio	310384
719	Radric	141412
720	Tauheed	612065
721	Shanterra	854101
722	Lasaro	752376
723	Eustace	427076
724	Corleen	456874
725	Clynton	442114
726	Carliss	441108
727	Montera	668401
728	Lennan	389737
729	Krishina	926781
730	Ricole	166135
731	Markwan	28874
732	Haydyn	160624
733	Amais	107787
734	Taliek	172640
735	Dekker	146678
736	Sharnise	553952
737	Prissila	760708
738	Yoshani	201294
739	Makiah	290482
740	Reyanne	467239
741	Sotera	22356
742	Eveli	414278
743	Heathcliff	491056
744	Jane	385632
745	Tremarion	506487
746	Adalin	291269
747	Rositta	97566
748	Harmonei	444348
749	Kaleina	541170
750	Kassity	281768
751	Shaniqa	23322
752	Baili	249315
753	Emiah	89270
754	Theon	276009
755	Wilcie	75906
756	Lytle	55324
757	Nuran	738208
758	Ericson	429335
759	Anathea	135768
760	Kataliya	164421
761	Evester	472560
762	Keegin	170887
763	Abreia	221974
764	Elpha	509350
765	Kederick	142504
766	Kamarian	269912
767	Kadesh	796083
768	Marquize	55800
769	Vinessa	488057
770	Sadina	71009
771	Shonia	836755
772	Danner	94543
773	Altamae	403639
774	Franchesca	852394
775	Chrishelle	621950
776	Lanxton	104113
777	Zinda	729301
778	Shavna	289307
779	Javonna	769310
780	Daxin	267269
781	Plum	476533
782	Arvi	569437
783	Bayani	582863
784	Maebri	47572
785	Carlean	537827
786	Shekena	398822
787	Kaygen	850669
788	Kayline	663102
789	Laksha	977021
790	Esgar	348747
791	Callissa	586972
792	Justinia	470932
793	Pa	824342
794	Liyana	297401
795	Chiquitia	917881
796	Yarazeth	39073
797	Shelena	796294
798	Carvel	306188
799	Briana	197219
800	Renwick	936567
801	Minyard	395303
802	Zaryn	456021
803	Jaycob	189887
804	Robertanthony	630062
805	Oda	672930
806	Laysha	120339
807	Amid	345134
808	Jecaryous	261320
809	Danton	927797
810	Seth	899773
811	Jt	884634
812	Jamareon	959961
813	Antwaine	19452
814	Idalie	674006
815	Zyhaire	613103
816	Eyian	728997
817	Delmo	61429
818	Bertella	877540
819	Cyprus	914450
820	Antinique	524546
821	Lannetta	66498
822	Sibyl	802686
823	Axa	700799
824	Naleigha	221156
825	Surveen	581993
826	Lajuanna	513095
827	Shahera	226237
828	Mattix	343418
829	Tayzha	268065
830	Madgeline	176713
831	Cashala	635888
832	Latresha	89804
833	Ahriya	432731
834	Robbie	989844
835	Danilla	171124
836	Davada	551116
837	Janautica	857889
838	Safeara	331937
839	Jalexi	261220
840	Chantrel	213384
841	Jessyka	863566
842	Chevette	291372
843	Arunas	938561
844	Crescentia	6695
845	Shatanya	713794
846	Annely	93400
847	Ellorie	57809
848	Deniese	160421
849	Katelind	912749
850	Kymauri	424957
851	Shravani	214716
852	Florenda	527626
853	Yazzmine	853364
854	Marquie	840340
855	Daeshun	494043
856	Kyleighann	845159
857	Dorithy	26055
858	Erisha	978772
859	Rosealina	311460
860	Issaic	989216
861	Makina	171041
862	Hooker	180489
863	Annasha	962795
864	Zariyha	180368
865	Briani	578551
866	Kyonia	214877
867	Nashly	584908
868	Silla	828427
869	Danard	775537
870	Gesina	840997
871	Siddhanth	189647
872	Campbell	754298
873	Lakiyah	756078
874	Philander	997088
875	Lakicha	341547
876	Rosealynn	677326
877	Ryleigh	477193
878	Karla	563595
879	Sayward	678986
880	Araia	399763
881	Arohi	847549
882	Bartel	506792
883	Enner	37836
884	Tomekia	487703
885	Ellaree	632433
886	Arnesia	330266
887	Keyron	888035
888	Germon	817497
889	Jamilee	429043
890	Treba	471497
891	Sebastean	292508
892	Azaelia	891935
893	Jolynne	455517
894	Ahjahnae	141507
895	Arquilla	508729
896	Humbert	673669
897	Aimara	927409
898	Zaylah	28795
899	Aristides	188075
900	Dejonna	818580
901	Adayah	442537
902	Sushant	392587
903	Reitha	854519
904	Othar	503332
905	Havis	468253
906	Doree	332403
907	Yulissa	536349
908	Ersel	414450
909	Jhoselyn	618213
910	Hanalee	835615
911	Firmin	993118
912	Steffy	225797
913	Debooah	204336
914	Londynn	981193
915	Rephael	179128
916	Karisma	344799
917	Urielle	490873
918	Lizaida	557466
919	Daleysha	334366
920	Niclas	124510
921	Sami	627353
922	Kristinejoy	187156
923	Rorik	426906
924	Anglo	618406
925	Soojin	623021
926	Enda	565957
927	Chuck	580942
928	Essam	723446
929	Audianna	572375
930	Prestin	88382
931	Kenniah	921958
932	Timisha	859837
933	Deundra	750210
934	Salomon	50124
935	Devoiry	501468
936	Maissa	35483
937	Weeda	583962
938	Kaylene	858304
939	Jadin	793319
940	Daijaun	256596
941	Roseanna	945803
942	Adron	202022
943	Jabez	874307
944	Devonta	460026
945	Kendrianna	870767
946	Sandreka	877243
947	Neji	872631
948	Myrisa	733479
949	Aires	742488
950	Makye	766256
951	Karey	677167
952	Lukian	276618
953	Gavvin	860890
954	Treylen	932377
955	Tedford	484190
956	Sudhir	374901
957	Jauquan	654105
958	Dawnee	865637
959	Danysha	688598
960	Anir	316781
961	Carlotta	16675
962	Arraya	423650
963	Jerimah	945598
964	Shanyse	140889
965	Tamariah	710550
966	Kelani	550541
967	Lorma	890318
968	Melida	14092
969	Lydya	398557
970	Joscelyne	735727
971	Philliph	602127
972	Lu	402915
973	Dalal	503405
974	Klarrisa	439614
975	Oneida	21382
976	Aprille	764771
977	Marquitta	200450
978	Kaleinani	855608
979	Maxx	119454
980	Antowain	68038
981	Genaro	231752
982	Tionnie	935014
983	Omolola	831969
984	Stven	137227
985	Yedidya	649689
986	Harlin	553766
987	Lilybelle	847781
988	Tishonna	176241
989	Kimley	950041
990	Loronda	493724
991	Marquettia	803353
992	Shary	801160
993	Pringle	374923
994	Hay	375416
995	Gwenevieve	176265
996	Stowe	186903
997	Rexann	448167
998	Naeli	848608
999	Jediael	48362
1000	Luciana	276269
1001	Ticia	830131
1002	Lavalle	238707
1003	Aydrian	809587
1004	Marhta	217902
1005	Ashari	814761
1006	Dupri	618517
1007	Dreven	117144
1008	Artin	337377
1009	Brekon	441697
1010	Annaelise	540748
1011	Mancie	823967
1012	Alrick	329056
1013	Tennelle	755079
1014	Kiai	936593
1015	Ranyah	343312
1016	Dmani	736411
1017	Duuana	590211
1018	Arleht	345883
1019	Shaylia	369670
1020	Derrall	690310
1021	Bengiman	530700
1022	Rumsey	798049
1023	Nunzio	419659
1024	Eleaner	375505
1025	Gizel	531649
1026	Doreene	118991
1027	Othie	865256
1028	Rayonia	201341
1029	Apirl	355466
1030	Albanie	142520
1031	Emmi	182056
1032	Sabina	842622
1033	Joely	284316
1034	Elitha	720034
1035	Rylinn	376251
1036	Satoria	54852
1037	Latashi	919907
1038	Anaiz	918641
1039	Dawneen	694752
1040	Anniesha	843770
1041	Sumeko	942499
1042	Fisher	221142
1043	Rubio	40078
1044	Aliviya	357144
1045	Eureeka	12670
1046	Emmersyn	799335
1047	Mevelyn	298261
1048	Usamah	221355
1049	Tomias	125260
1050	Takara	134572
1051	Rubyann	647220
1052	Qadirah	995332
1053	Reyner	131423
1054	Diahanna	909312
1055	Eniylah	715026
1056	Miricale	408509
1057	Ansleigh	315545
1058	Katlan	244345
1059	Miraya	477483
1060	Jasinto	261735
1061	Michaeljoseph	902829
1062	Farryn	602920
1063	Bryaunna	728927
1064	Verniya	907358
1065	Amberlin	413322
1066	Earin	669021
1067	Naysha	133087
1068	Aniyan	398134
1069	Nakevia	103252
1070	Kasarah	106848
1071	Deleah	771084
1072	Eliyanah	424216
1073	Tyquann	799263
1074	Thompson	480735
1075	Izzybella	819397
1076	Timesha	16811
1077	Judean	699478
1078	Gladimir	848485
1079	Darena	293262
1080	Jermiane	953764
1081	Moline	371099
1082	Danaisha	537745
1083	Kalima	829525
1084	Elkin	293915
1085	Sumire	439471
1086	Jia	497583
1087	Shenyah	419797
1088	Ellamaria	997126
1089	Isaid	536383
1090	Jayion	289607
1091	Deovion	399306
1092	Berel	245712
1093	Ariadny	415529
1094	Shaul	420370
1095	Glenndora	754067
1096	Eshika	738693
1097	Azreal	914103
1098	Yuly	485025
1099	Millani	139547
1100	Lajean	493342
1101	Chardonae	865675
1102	Gaius	479960
1103	Dequita	780841
1104	Brynnlee	501000
1105	Krystof	732224
1106	Jeliah	348041
1107	Suprena	782658
1108	Zariyana	301270
1109	Preetam	723271
1110	Yubal	627009
1111	Jade	931405
1112	Jhan	440209
1113	Izhane	917831
1114	Quanita	377412
1115	Jabrielle	483848
1116	Tailen	606881
1117	Genner	360077
1118	Nyleah	267766
1119	Kenija	422289
1120	Chabeli	106954
1121	Jetzael	95400
1122	Ronshay	359487
1123	Kirah	194684
1124	Nachele	945905
1125	Latica	319781
1126	Cariann	451481
1127	Paycie	228850
1128	Ricky	925420
1129	Samara	564901
1130	Ambika	473773
1131	Tishia	483849
1132	Takirra	211256
1133	Enriqueta	648263
1134	Graeden	848696
1135	Zahmier	461994
1136	Nathael	732749
1137	Meer	802127
1138	Domita	243021
1139	Ayati	629831
1140	Raejean	154699
1141	Lonna	497646
1142	Truston	225707
1143	Ranique	624069
1144	Heinrich	947222
1145	Celyne	243114
1146	Sophea	19132
1147	Candes	457368
1148	Makil	604614
1149	Kieana	295015
1150	Felicite	754987
1151	Lauryn	137269
1152	Delali	951295
1153	Chanon	807315
1154	Oneita	3317
1155	Josh	537538
1156	Kamiryn	877291
1157	Kenron	825596
1158	Dreana	252909
1159	Wilhemenia	716247
1160	Lain	701095
1161	Bernadina	989217
1162	Kestra	866694
1163	Anaelise	517903
1164	Antoneshia	954691
1165	Jersie	328521
1166	Chiyoka	250157
1167	Aetna	898491
1168	Kuol	14074
1169	Hallema	103166
1170	Birkley	915408
1171	Jarick	615115
1172	Devion	620633
1173	Deandrick	367576
1174	Deb	751056
1175	Mikesha	927379
1176	Krysteen	945011
1177	Shila	670303
1178	Roddie	297517
1179	Madlin	888451
1180	Jazyra	979362
1181	Delphene	354609
1182	Hakob	452260
1183	Josselyn	456976
1184	Jabarrie	719241
1185	Tarone	721963
1186	Tallyn	154342
1187	Quindarius	298431
1188	Damielle	103882
1189	Nadin	500528
1190	Keyawna	788623
1191	Tydre	318391
1192	Quandell	458299
1193	Salmah	475785
1194	Melike	904134
1195	Blaydin	364335
1196	Vishruth	385982
1197	Daycia	655114
1198	Janzen	383536
1199	Klee	224981
1200	Valta	259748
1201	Melique	102752
1202	Dakin	911498
1203	Colie	940337
1204	Teuna	416052
1205	Jasmen	350024
1206	Tanaeja	641332
1207	Makyrah	31490
1208	Shizuo	381029
1209	Daquavious	437877
1210	Tangelia	892145
1211	Chelley	268628
1212	Keats	661754
1213	Astin	169149
1214	Alyanah	291863
1215	Ardala	614481
1216	Shiquan	267619
1217	Margie	251462
1218	Hanz	518817
1219	Shariah	319972
1220	Shaban	78480
1221	Sadir	35576
1222	Syeria	414055
1223	Arryon	730243
1224	Eshana	358744
1225	Shambhavi	379620
1226	Aren	86146
1227	Zaydenn	721049
1228	Zeryk	68826
1229	Kourosh	50369
1230	Quanya	295209
1231	Benina	761915
1232	Wendall	1607
1233	Agee	789537
1234	Adilenne	749428
1235	Yanisse	723185
1236	Yoneko	853398
1237	Doloris	22021
1238	Jaylaa	801497
1239	Lailanie	272229
1240	Justyna	952701
1241	Jacody	134003
1242	Daimarion	873974
1243	Palani	501999
1244	Johnston	919334
1245	Tavery	987147
1246	Prayer	315720
1247	Oliviana	842730
1248	Warith	534186
1249	Maxola	241131
1250	Shadiamond	548053
1251	Kimberlea	768786
\.


--
-- Data for Name: conteudos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conteudos (id_conteudo, codigo, essencialidade, descricao) FROM stdin;
1161	AL-001	Essencial 1	Noção de algoritmo, dado, variável, instrução e programa.
1162	AL-002	Essencial 1	Construções básicas: tipos de dados atribuição, leitura e escrita.
1163	AL-003	Essencial 1	Estruturas de controle: sequência, seleção e iteração.
1164	AL-004	Essencial 1	Tipos estruturados básicos: vetores, matrizes registros e strings
1165	AL-005	Essencial 1	Subprogramas: funções, procedimentos, ponteiros e recursão
1166	AL-006	Essencial 1	Arquivos
1167	AL-007	Essencial 1	Tipos Abstratos de Dados
1168	AL-008	Essencial 1	Listas, Pilhas, Filas e Deques
1169	AL-009	Essencial 1	Árvores: Binárias, Binárias de Pesquisa, Balanceadas, B, B+
1170	AL-010	Essencial 1	Estruturas de arquivos?
1171	AL-011	Essencial 1	Tabela Hash
1172	AL-012	Essencial 1	Algoritmos de Ordenação (inserção, seleção, trocas, intercalação)
1173	AL-013	Essencial 1	Strings: Árvores Digitais, Arquivo invertido, compressão de texto
1174	AL-014	Essencial 1	Grafos: Formas de representação
1175	AL-015	Essencial 1	Grafos: Percursos, Árvore Geradora, Caminho Mínimo, Coloração de Vértices
1176	AL-016	Essencial 1	Definição de problemas, algoritmos e pensamento computacional
1177	AL-017	Essencial 1	Principais técnicas de resolução de problemas: generalização, decomposição (de processos e dados, tanto em partes quanto em camadas de abstração) e transformação
1178	AL-018	Essencial 1	Introdução às principais formas de organizar a informação (registros, listas, árvores, grafos)
1179	AL-019	Essencial 1	Princípios da sistematização da construção de soluções computacionais (documentação, colaboração, análise crítica)
1180	AL-020	Essencial 1	Resolução de problemas usando recursão e meta-programação
1181	AL-021	Essencial 1	Introdução a métodos sistemáticos e técnicas de abstração, formulação, codificação, avaliação, e reuso
1182	AL-022	Eletiva	Modelos de Recuperação de Informação (booleano, vetorial e probabilístico)
1183	AL-023	Eletiva	Métricas de Avaliação de Recuperação de informação
1184	AL-024	Eletiva	Recuperação de informação na Web (crawling, algoritmos de ranking)
1185	AL-025	Eletiva	Funções de similaridade de strings (distância de edição, Jaccard, cosseno)
1186	AL-026	Eletiva	Algoritmos Geométricos e Estruturas de Dados Espaciais/Multidimensionais
1187	AL-027	Essencial 1	Lógica Proposicional
1188	AL-028	Essencial 1	Lógica de Predicados
1189	AL-029	Essencial 1	Lógica: Correção, Completude, Decidibilidade
1190	AL-030	Essencial 1	Deduções Lógicas, Padrões de Prova, Provas por Indução
1191	AL-031	Essencial 1	Estudo Sistemático de Técnicas de Prova
1192	AL-032	Essencial 1	Introdução a análise de correção de algoritmos/programas
1193	AR-001	Essencial 2	História da computação e das arquiteturas de computadores
1194	AR-002	Essencial 1	Notação posicional e conversão de bases
1195	AR-003	Essencial 1	Sistemas de numeração (números sem sinal, sinal-magnitude, complemento de B)
1196	AR-004	Essencial 1	Ponto fixo e ponto flutuante
1197	AR-005	Essencial 1	Lógica combinacional (portas lógicas, operadores aritméticos, multiplexadores, decodificadores)
1198	AR-006	Essencial 1	Lógica sequencial (flip-flops, registradores, contadores)
1199	AR-007	Essencial 1	Máquinas de estados finitas (Mealy, Moore, projeto e implementação)
1200	AR-008	Essencial 1	Caminho de dados e bloco de controle
1201	AR-009	Essencial 1	Expressões lógicas e minimização de lógica Booleana (lógica de dois níveis e multi-nível)
1202	AR-010	Essencial 1	Arquitetura de von Neumann (componentes básicos, ciclo de busca-decodificação-execução)
1203	AR-011	Essencial 1	Arquiteturas de conjunto de instruções (instruções, formatos de instruções, modos de endereçamento)
1204	AR-012	Essencial 1	Programação em linguagem de montagem
1205	AR-013	Essencial 1	Mecanismos de chamada de sub-rotinas e de interrupção
1206	AR-014	Essencial 1	Métricas e propriedades de memórias (vazão, latência, custo, consumo de energia, volatilidade, durabilidade)
1207	AR-015	Essencial 1	Tecnologias de memórias (SRAM, DRAM, Flash, memórias magnéticas)
1208	AR-016	Essencial 1	Princípios de localidade (espacial, temporal)
1209	AR-017	Essencial 1	Memórias cache (objetivos, funcionamento, organização, implementação, avaliação, otimizações, coerência)
1210	AR-018	Essencial 1	Memória virtual (objetivos, funcionamento, organização, implementação, avaliação)
1211	AR-019	Essencial 1	Entrada e saída (dispositivos, entrada e saída programada, por interrupção, mapeamento em memória, barramentos, acesso direto à memória)
1212	AR-020	Essencial 1	Organizações de processadores (monociclo, multiciclo, pipeline, superescalaridade, taxonomia de Flynn, exemplos)
1213	AR-021	Essencial 2	Avaliação de desempenho de arquiteturas e organizações (conjuntos de programas de benchmark, ferramentas de simulação arquiteturais e de organização)
1214	AR-022	Essencial 2	Técnicas e arquiteturas avançadas (e.g., clock e power gating, DVFS, execução fora de ordem e especulativa, predição de desvios, etc.)
1215	AR-023	Essencial 2	Arquiteturas multicore, específicas e/ou heterogeneas (DSPs, GPUs, MPSoCs, aceleradores de propósito específico em ASIC ou FPGA, arquiteturas de warehouses)
1216	AR-024	Eletiva	Novos paradigmas de computação (computação quântica, computação em memória, lógicas não-binárias, arquiteturas não-von Neumann)
1217	AR-025	Eletiva	Automação de Projeto de Sistemas Digitais (problemas, algoritmos e ferramentas de síntese e análise; síntese física, lógica e de alto nível; simulação e verificação formal)
1218	AR-026	Essencial 2	Otimização de requisitos no projeto de hardware (energia, potência, desempenho, área etc)
1219	CG-001	Essencial 1	Aplicações de Computação Gráfica
1220	CG-002	Essencial 1	Transformações Geométricas (Lineares, Afins, Projetivas), Sistemas de Coordenadas, Coordenadas Homogêneas, Transf. Hierárquicas
1221	CG-003	Essencial 1	Pipeline Gráfico
1222	CG-004	Essencial 1	Modelagem e Processamento Geométrico
1223	CG-005	Essencial 1	Uso de APIs Gráficas, Programas de GPUs
1224	CG-006	Essencial 1	Mapeamento de Texturas
1225	CG-007	Essencial 1	Modelos de Iluminação e Modelos de Shading
1226	CG-008	Essencial 1	Ray Tracing, Monte Carlo Path Tracing, Transporte de Luz, Equação de Rendering, Iluminação Global
1227	CG-009	Essencial 1	Animação, Testes de Intersecção Geométrica (Aumento na Carga Horária)
1228	CG-010	Essencial 1	Uso eficiente do hardware (CPU e GPU) em aplicações gráficas interativas e de tempo real (Novo)
1229	CG-011	Essencial 2	Amostragem e Filtragem, Antialiasing (Atualmente Eletivo)
1230	CG-012	Essencial 2	Algoritmos de Sombras (Atualmente Eletivo)
1231	CG-013	Essencial 2	Machine Learning em Computação Gráfica (Novo)
1232	CG-014	Eletiva	Real-Time Rendering Techniques
1233	CG-015	Eletiva	Interpolação Perspectivamente Correta
1234	CG-016	Eletiva	Quaternions e Sequências de Rotação
1235	CG-017	Eletiva	Rendering Avançado
1236	CG-018	Eletiva	Modelagem e Processamento Geométrico: Tópicos Avançados
1237	CG-019	Eletiva	Composição de Imagens (eg, Alpha Blending, Premultiplied Alpha, Gamma Correction, Linear vs Non-Linear Space)
1238	CG-020	Eletiva	Differentiable Rendering, Inverse Rendering, Neural Radiance Fields
1239	CG-021	Eletiva	Computer Aided Manufacturing, Fabrication (eg, 3D Printing, CNC)
1240	CG-022	Eletiva	Abstração de dados e tarefas no contexto de visualização de informações
1241	CG-023	Eletiva	Percepção visual e aspectos cognitivos da visualização (e.g.,princípios de Gestalt, conceitos de atenção e pré-atenção)
1242	CG-024	Eletiva	Codificação visual, codificação e arranjos espaciais
1243	CG-025	Eletiva	Visualização de dados quantitativos e categóricos
1244	CG-026	Eletiva	Visualização de dados hierárquicos
1245	CG-027	Eletiva	Visualização de dados grafos (incluindo grafos multivariados)
1246	CG-028	Eletiva	Visualização de dados espaciais
1247	CG-029	Eletiva	Visualização de dados multidimensionais
1248	CG-030	Eletiva	Modelos de interação com representações visuais de informações
1249	CG-031	Essencial 1	Percepção Visual e Modalidades de Imagens
1250	CG-032	Essencial 1	Transformações Pontuais sobre Imagens
1251	CG-033	Essencial 1	Equalização de Histograma e Outras Transformações Não Lineares
1252	CG-034	Essencial 1	Transformada da Fourier
1253	CG-035	Essencial 1	Filtragem de Imagens nos Domínios Espaço e Frequência, Convolução
1254	CG-036	Essencial 1	Teorema da Amostragem e Teorema da Convolução
1255	CG-037	Essencial 1	Restauração de Imagens
1256	CG-038	Essencial 1	Segmentação de Imagens
1257	CG-039	Essencial 1	Compressão de Imagens e Vídeos, Algoritmo JPEG
1258	CG-040	Essencial 1	Espaços de Cores, HDR, Tone Mapping
1259	CG-041	Essencial 1	Questões Éticas e Sociais envolvendo Imagens
1260	CG-042	Essencial 1	Deep Learning para Processamento de Imagens: Introdução, Redes Convolucionais
1261	CG-043	Essencial 2	Transformações Geométricas de Imagens
1262	CG-044	Essencial 2	Aquisição de Imagens, Anatomia de Câmeras Digitais
1263	CG-045	Eletiva	Deep Learning para Processamento de Imagens: Uso Avançado (eg, Modelos Generativos de Imagens)
1264	CG-046	Eletiva	Outras Transformadas de Imagens
1265	CG-047	Eletiva	Composição de Imagens: Algoritmos Avançados
1266	CG-048	Eletiva	Representação Multi-escala: Pirâmides Gaussiana e Laplaciana
1267	CG-049	Eletiva	Filtragem com Preservação de Arestas
1268	CG-050	Eletiva	Light Fields e Câmeras Plenópticas
1269	CG-051	Eletiva	Fotografia Codificada
1270	CG-052	Essencial 1	Modelos de câmera; Parâmetros instrísecos e extrínsecos; Calibração
1271	CG-053	Essencial 1	Estereoscopia, Multi-view Stereo e Structure from Motion
1272	CG-054	Essencial 1	Fluxo Ótico e Rastreamento de Objetos
1273	CG-055	Essencial 1	Classificação de imagens
1274	CG-056	Essencial 1	Detecção de objetos
1275	CG-057	Essencial 1	Deep Learning para Visão Computacional
1276	CG-058	Essencial 2	Detecção e codificação de pontos-chave (keypoints)
1277	CG-059	Eletiva	Representação e análise de formas
1278	CG-060	Eletiva	Representação e análise de texturas
1279	CG-061	Eletiva	Segmentação de Imagens: Algoritmos Avançados (eg, Graph Cuts, Watershed)
1280	CG-062	Eletiva	Processamento de Nuvens de Pontos
1281	CG-063	Essencial 1	Conceito de metaverso: histórico, expectativas, tecnologias envolvidas, exemplos, modelo de negócio, implicações éticas
1282	CG-064	Essencial 1	Realidade virtual e realidade aumentada, conceito de presença e imersão, motion sickness
1283	CG-065	Eletiva	Dispositivos para realidade virtual e aumentada
1284	CG-066	Essencial 2	Construção de mundos virtuais usando recursos gráficos de alto nível com Web3D, engines gráficas, etc.
1285	CG-067	Essencial 2	Interação 3D
1286	CG-068	Eletiva	Interação em háptica
1287	CG-069	Eletiva	Simuladores imersivos e jogos sérios
1288	CG-070	Eletiva	Immersive analytics (uso de realidade virtual e aumentada como suporte à visualização de informações)
1289	CG-071	Eletiva	Aplicações na medicina, treinamento, entretenimento, etc.
1290	CG-072	Essencial 1	Design de interação, conceitos básicos, metas de acessibilidade, usabilidade, UX, cognição, percepção, memória, aprendizado
1291	CG-073	Essencial 1	Estilos de interação, metáfora, paradigma
1292	CG-074	Essencial 2	Interação com dispositivos móveis
1293	CG-075	Essencial 1	Design de interação: visão geral do processo e metodologias de pesquisa em UX (UX Research)
1294	CG-076	Essencial 1	Análise contextual: modelo do usuários (personas), cenários de uso (jornadas), modelo de tarefas
1295	CG-077	Essencial 1	Projeto e prototipação de interfaces (protótipos de baixa fidelidade, alta fidelidade, protótipos funcionais, prototipação no code e em hardware)
1296	CG-078	Essencial 1	Avaliação de interfaces (técnicas sem usuário)
1364	IA-004	Essencial 2	General Game Playing
1297	CG-079	Essencial 1	Avaliação de interfaces (técnicas com usuários: formativas e somativas, implicações éticas e cuidados)
1298	CG-080	Essencial 1	Análise de resultados (qualitativos e quantitativos)
1299	CG-081	Eletiva	Interfaces conversacionais (chatbots e interfaces de voz)
1300	CG-082	Essencial 2	UX Analytics
1301	CG-083	Essencial 2	Interfaces baseadas em dashboards interativos
1302	CO-001	Essencial 1	Linguagens regulares, autômatos finitos e expressões regulares
1303	CO-002	Essencial 1	Linguagens livres de contexto, autômatos com pilha e gramáticas livres de contexto
1304	CO-003	Essencial 1	Hierarquia de Chomsky
1305	CO-004	Essencial 1	Máquinas de Turing e suas variantes (não determinismo, múltiplas fitas, etc.)
1306	CO-005	Essencial 2	Máquinas de Registradores
1307	CO-006	Essencial 1	Cálculo Lambda
1308	CO-007	Essencial 1	Tese de Church-Turing
1309	CO-008	Essencial 1	Indecidibilidade de problemas e redutibilidade
1310	CO-009	Essencial 1	Classes de complexidade de problemas (P, NP, PSPACE...)
1311	CO-010	Essencial 1	Projeto de algoritmos: análise assintótica
1312	CO-011	Essencial 1	Projeto de algoritmos: recorrências
1313	CO-012	Essencial 1	Projeto de algoritmos: divisão e conquista
1314	CO-013	Essencial 1	Projeto de algoritmos: algoritmos gulosos
1315	CO-014	Essencial 1	Projeto de algoritmos: programação dinâmica
1316	CO-015	Essencial 1	Grafos: conceitos e principais problemas associados e algoritmos conhecidos
1317	CO-016	Essencial 1	Projeto de algoritmos: aproximação
1318	CO-017	Essencial 2	Projeto de algoritmos: fluxos e emparelhamentos
1319	CO-018	Essencial 2	Projeto de algoritmos: randomização
1320	CO-019	Essencial 1	Projeto de algoritmos: busca exaustiva
1321	CO-020	Essencial 1	Projeto de algoritmos: busca local
1322	CO-021	Essencial 1	Projeto de algoritmos: programação linear e inteira
1323	CS-001	Essencial 1	Impactos ambientais da Computação e respectivos métodos de avaliação - p.ex. consumo de energia, pegada de carbono, lixo eletrônico.
1324	CS-002	Essencial 1	Proteção da privacidade e dos dados pessoais em soluções e serviços computacionais - "privacy by design", normas legais
1325	CS-003	Essencial 1	Impactos de soluções e serviços computacionais sobre direitos humanos, como liberdade de expressão
1326	CS-004	Essencial 1	Implicações éticas da Computação e respectivos métodos de avaliação - p.ex. impactos da IA e vieses algorítmicos discriminatórios
1327	CS-005	Essencial 1	Normas e códigos de conduta profissional
1328	CS-006	Essencial 1	Processos de transformação digital, futuro do emprego e das oportunidades de trabalho
1329	CS-007	Essencial 1	Introdução aos instrumentos de direitos humanos
1330	CS-008	Essencial 2	Inclusão digital
1331	CS-009	Essencial 2	Questões legislativas e regulatórias e políticas públicas relacionadas ao desenvolvimento e ao uso de soluções computacionais
1332	CS-010	Eletiva	Introdução a teorias éticas
1333	CS-011	Essencial 1	Questões de licenças de software e creative commons, uso legal de software de código aberto, copyleft, direitos autorais, atribuição
1334	EM-001	Essencial 1	Conceitos de inovação e empreendedorismo
1335	EM-002	Essencial 1	Modelos de negócios inovadores
1336	EM-003	Essencial 1	Metodologias para criação de soluções inovadoras, p.ex. design thinking
1337	EM-004	Essencial 1	Metodologias para elaboração de modelos de negócios inovadores
1338	EM-005	Essencial 1	Metodologias para implementação de soluções como modelos de negócios inovadores, p.ex. lean startup
1339	EM-006	Essencial 1	Ferramentas para elaboração de modelos de negócios inovadores
1340	EM-007	Essencial 1	Técnicas para análise de mercado, p.ex. pesquisas qualitativas e quantitativas, análise SWOT
1341	EM-008	Essencial 1	Planejamento financeiro de empreendimentos inovadores
1342	EM-009	Essencial 1	Técnicas de apresentação e divulgação de empreendimentos inovadores
1343	EM-010	Essencial 2	Ecossistema de inovação e empreendedorismo – startups, investidores, ambientes de inovação, etc
1344	EM-011	Essencial 1	ESG e negócios de impacto socioambiental
1345	EM-012	Essencial 2	Gestão da inovação - propriedade intelectual, marcas e patentes, registro de software, inovação aberta
1346	EM-013	Eletiva	Mecanismos de captação de fontes de capital
1347	EM-014	Essencial 2	Formalização de negócios
1348	EM-015	Essencial 1	Ética e responsabilidade em negócios
1349	ES-001	Essencial 1	Trabalho em Grupo (teamwork)
1350	ES-002	Essencial 1	Ferramentas e Ambientes de ES (IDEs, Modelagem, Teste, Versao, Configuração, Dependência, Depuração, Refatoração,etc)
1351	ES-003	Essencial 1	Requisitos (Engenharia de Requisitos, Gestão de Requisitos)
1352	ES-004	Essencial 1	Projeto de Software (Princípios, Arquitetura de Software, Padrões Arquiteturais, Modularidade, Design patterns : GoF e outros)
1353	ES-005	Essencial 1	Construção de Software (Convenções e Boas Práticas, Estilos de Codificação, Smells e qualidade de código, Teste de Unidade, TDD, Documentação, Uso de patterns, bibliotecas e frameworks)
1354	ES-006	Essencial 1	Teste, verificação e validação de software (Diferentes dimensões de teste, Casos de teste, Revisao de código, planejamento e execução de testes,
1355	ES-007	Essencial 2	Refatoração e Evolução de Código (Principais refatorações, versionamento semântico)
1356	ES-008	Eletiva	Confiabilidade de Software (fundamentos, requisitos de confiabilidade em diferentes tipos de software, métodos e modelos de tolerância a falhas em software)
1357	ES-009	Eletiva	Métodos Formais (Especificação formal, Enfoques formais para modelagem e análise,)
1358	ES-010	Eletiva	BPM, web, mobile?
1359	ES-011	Essencial 1	Práticas Ágeis
1360	ES-012	Essencial 1	Verificação de software
1361	IA-001	Essencial 1	Busca em espaço de estados (busca não-informada, busca informada)
1362	IA-002	Essencial 2	Busca com Memória Limitada e Busca Bidirecional (IDA*, PEA*, MM)
1363	IA-003	Essencial 1	Busca com Adversário e Jogos
1365	IA-005	Essencial 1	Modelagem de problemas de decisão (MDPs, FONDPs, PONDPs, POMDPs)
1366	IA-006	Essencial 1	Problemas de Satisfação de Restrições
1367	IA-007	Essencial 1	Busca Local
1368	IA-008	Essencial 2	Computação Evolutiva
1369	IA-009	Essencial 1	Raciocínio probabilístico (redes bayesianas, inferência, amostragem, independência)
1370	IA-010	Essencial 2	Resolvedores SAT
1371	IA-011	Eletiva	Answer Set Programming
1372	IA-012	Essencial 2	Planejamento Automatizado
1373	IA-013	Essencial 1	Aspectos Éticos em IA (Vieses, usos maliciosos, impactos sociais, econômicos e ambientais)
1374	IA-014	Essencial 1	Transparência e Explicabilidade em sistemas de IA
1375	IA-015	Essencial 1	Introdução à Filosofia em IA (IA forte vs IA fraca)
1376	IA-016	Eletiva	Conceitos de Filosofia em IA (Inteligência, Consciência, Limites)
1377	IA-017	Essencial 2	IA distribuída e Sistemas Multiagente
1378	IA-018	Essencial 1	Métodos de aprendizado supervisionado (e.g. árvores de decisão, KNN, NB, SVM,...)
1379	IA-019	Essencial 1	Neurônio artificial - Regressão Linear e Regressão Logística
1380	IA-020	Essencial 1	Redes Neurais - Perceptron Multicamada e algoritmo backpropagation
1381	IA-021	Essencial 1	Processamento de imagens com redes neurais (e.g. Redes Convolucionais)
1382	IA-022	Essencial 1	Processamento de sequências com redes neurais (e.g. RNNs e Transformers)
1383	IA-023	Eletiva	Processamento de Grafos com redes neurais (Graph Neural Networks)
1384	IA-024	Essencial 2	Modelos pré-treinados
1385	IA-025	Essencial 2	Modelos generativos
1386	IA-026	Essencial 2	Aprendizado ensemble (variações de bagging, boosting, stacking)
1387	IA-027	Essencial 1	Avaliação de modelos - métricas, holdout, validação cruzada
1388	IA-028	Essencial 2	Comparação de modelos com análises estatísticas (intervalo de confiança, testes estatísticos)
1389	IA-029	Essencial 1	Over vs. Underfitting (Bias vs. Variance)
1390	IA-030	Eletiva	Aprendizado semi-supervisionado
1391	IA-031	Essencial 1	Fundamentos de aprendizado por reforço tabular e Q-learning
1392	IA-032	Essencial 1	Fundamentos de aprendizado por reforço profundo
1393	IA-033	Eletiva	Aprendizado on- vs. off-policy
1394	IA-034	Eletiva	Métodos de Monte Carlo
1395	IA-035	Eletiva	Aprendizado baseado em modelos
1396	IA-036	Eletiva	Métodos baseados em Gradiente de Política
1397	IA-037	Eletiva	Métodos de ator-crítico
1398	IA-038	Essencial 1	Métodos de agrupamento (particional, hierárquico, por densidade) e métricas de avaliação
1399	IA-039	Essencial 1	Redução de dimensionalidade
1400	IA-040	Eletiva	Aprendizado auto-supervisionado (self-supervised learning)
1401	IA-041	Essencial 1	Pré-processamento de dados (normalização, imputação, transformação..)
1402	IA-042	Essencial 1	Aspectos Práticos (Frameworks, Inicialização, Regularização, Algoritmos de Otimização,  hiperparametros, tuning ...)
1403	IA-043	Essencial 2	Implantação, monitoramento e manutenção de sistemas de ML
1404	IA-044	Essencial 1	PLN: formas de representação de texto (one-hot encoding, embeddings fixas e contextuais)
1405	IA-045	Essencial 1	PLN: Algoritmos fundamentais (pré-processamento, part-of-speech tagging, reconhecimento de entidades nomeadas)
1406	IA-046	Essencial 1	PLN: Aplicações (classificação, sumarização, tradução, modelagem de tópicos, perguntas e respostas, agentes conversacionais)
1407	IA-047	Essencial 1	PLN: Geração de texto
1408	IA-048	Essencial 1	CD: Modelos de ciclo de vida de projetos (e.g. CRISP-DM)
1409	IA-049	Essencial 2	CD: Frameworks para tratamento de grandes volumes de dados
1410	IA-050	Essencial 2	CD: Desenvolvimento de projetos práticos
1411	IA-051	Essencial 2	CD: Engenharia de Dados
1412	IA-052	Essencial 1	Conceitos gerais de engenharia de conhecimento e sistemas baseados em conhecimento
1413	IA-053	Eletiva	Conceitos gerais de representação de conhecimento e raciocínio
1414	IA-054	Eletiva	Conceitos gerais de ontologias e modelagem conceitual
1415	IA-055	Eletiva	Análise ontológica
1416	IA-056	Eletiva	Linguagens de representação de conhecimento
1417	IA-057	Eletiva	Engenharia de ontologias
1418	IA-058	Eletiva	Aquisição de conhecimento
1419	LP-001	Essencial 1	Léxica: Análise Léxica (ERs, Construção de Thompson, Alg. de Subconjuntos, AFD)
1420	LP-002	Essencial 1	GLCs, como escrever GLC, Transformações gramaticais, primeiro/sequência
1421	LP-003	Essencial 1	Análise Sintática Ascendente LR(0), SLR(1), LR(1), LALR(1), autômatos, conflitos
1422	LP-004	Essencial 1	Análise Sintática Descendente LL(1), Construção da Tabela LL(1), Erros
1423	LP-005	Essencial 1	AST, Tradução Dirigida pela Sintaxe, Ordem de Avaliação, Esquemas L e S-Atribuídos
1424	LP-006	Essencial 1	Tradução: escopo, declaração, endereçamento de variáveis, aritmética e lógica
1425	LP-007	Essencial 1	Tradução: comandos de controle de fluxo, chamada de função, passagem de pars.
1426	LP-008	Essencial 2	Tradução: arranjos, switch-case, classes, etc
1427	LP-009	Essencial 1	Geração de código de máquina, alocação de registradores (coloração de grafo)
1428	LP-010	Essencial 1	Otimização (local, global), grafos de fluxo de controle, blocos básicos
1429	LP-011	Essencial 1	Paradigmas e modelos de programação e suas características, propriedades e mecanismos computacionais (funcional, OO, lógico, imperativo, declarativo)
1430	LP-012	Essencial 1	Definição e gerência de escopo; declarações e definições, vinculações (propriedades)
1431	LP-013	Essencial 1	Sistemas de tipos simples, construtores de tipos, polimorfismo paramétrico, tipagem implícita,tiagem explícita
1432	LP-014	Essencial 1	Verificação de tipos e inferência de tipos
1433	LP-015	Essencial 2	Sistemas de Tratamento de exceções
1434	LP-016	Essencial 2	Gerenciamento do Heap (garbage collectors)
1435	LP-017	Essencial 1	Expressões e Operadores (tipos, efeitos colaterais), comandos de controle de fluxo
1436	LP-018	Essencial 1	Definição e controle de execução de subrotinas, controle de escopo/pilha, alocação de variáveis e parâmetros
1437	LP-019	Essencial 1	Passagem de parâmetros (semântica de operação, modos de operação).
1438	LP-020	Essencial 1	Estilos de semântica operacional: small step, big step com ambientes
1439	LP-021	Essencial 1	Indução estrutural, prova por indução estrutural de propriedades de linguagens
1440	LP-022	Essencial 1	Hierarquia de Chomsky
1441	LP-023	Essencial 2	Ferramentas do ecossistema de LPs: geradores de parsers, geradores de documentação, testes unitários, controle de versoes
1442	MA-001	Essencial 1	Conjuntos, operações, diagramas de venn. Relações e tipos de relações (ordem parcial, equivalência). Funções totais e parciais.
1443	MA-002	Essencial 1	Técnicas de prova: direta, contraexemplo, contradição, indução (forte e fraca) nos números naturais, indução estrutural em listas e árvores.
1444	MA-003	Essencial 1	Lógica I: Lógica proposicional e lógica de predicados: sintaxe, semântica, sistemas dedutivos.
1445	MA-004	Essencial 1	Análise combinatória: princípios de contagem, contagem de arranjos, permutações e combinações, princípio dos escaninhos.
1446	MA-005	Essencial 1	Recorrências: definição, classificação e técnicas de resolução (resolução de recorrências lineares, resolução via funções geradoras ordinárias e exponenciais)
1447	MA-006	Essencial 1	Grafos: definição, variações (grafos direcionados, com pesos nas arestas), classificação (euleriano, hamiltoniano, árvore), e principais problemas associados (distância, árvore geradora mínima, coloração, etc.)
1448	MA-007	Essencial 1	Probabilidade I: Conceito e teoremas fundamentais. Variáveis aleatórias. Distribuições de probabilidade discretas e contínuas.
1449	MA-008	Essencial 1	Estatística descritiva. Noções de amostragem. Inferência estatística: Teoria da estimação e Testes de hipóteses. Regressão linear simples. Correlação.
1450	MA-009	Essencial 1	Cálculo I: Limites. Cálculo diferencial de uma variável real. Cálculo integral de uma variável real.
1451	MA-010	Essencial 1	Cálculo II: Geometria analítica espacial. Derivadas parciais. Integrais múltiplas. Séries.
1452	MA-011	Essencial 1	Álgebra Linear: Sistema de equações lineares. Matrizes. Fatoração LU. Vetores. Espaços vetoriais. Ortogonalidade. Valores próprios. Aplicações.
1453	MA-012	Essencial 1	Cálculo Numérico: erros; ajustamento de equações; interpolação, derivação e integração; solução de equações lineares e não lineares;\nsolução de sistemas de equações lineares e não lineares; noções de otimização; solução de equações diferenciais e\nequações diferenciais parciais; noções do método Monte Carlo em suas diferentes aplicações.
1454	MA-013	Essencial 1	Equações diferenciais ordinárias e lineares. Resolução simbólica de equações diferenciais simples.
1455	MA-014	Essencial 1	Séries de Fourier, Transformada de Fourier e Transformada rápida de Fourier, com ênfase nas respectivas variantes discretas.
1456	MA-015	Essencial 1	Teoria dos Números: divisibilidade, primalidade, Teorema de Fermat, Teorema Chinês dos Resto, fatoração de inteiros, funções de hash, aritmética modular.
1457	MA-016	Eletiva	Probabilidade II: Geração de números pseudoaleatórios. Processos estocásticos.
1458	MA-017	Essencial 2	Lógica II: Lógica de Hoare.  Lógica temporal. Correção de programas. Verificação de Modelos
1459	MA-018	Eletiva	Geometria computacional: principais conceitos. algoritmos e fórmulas como, por exemplo, a distãncia de ponto a plano, cálculo de invólucros convexos, etc.
1460	MA-019	Eletiva	Teoria da Informação: entropia, taxa de amostragem, capacidade de canal. Codificação com perdas e sem perdas. Códigos de correção de erros.
1461	PE-001	Eletiva	Overview de Robôs Móveis Inteligentes (arquiteturas robóticas, sensores e atuadores)
1462	PE-002	Eletiva	Linguagens e frameworks específicos para robótica (ROS)
1463	PE-003	Eletiva	Introdução a navegação autônoma (noções de cinematica e controle)
1464	PE-004	Essencial 2	Planejamento de caminhos
1465	PE-005	Eletiva	Mapeamento de ambientes
1466	PE-006	Eletiva	Exploração de ambientes
1467	PE-007	Eletiva	Localização
1468	PE-008	Eletiva	Noções de SLAM e mais problemas avançados de robótica móvel
1469	PE-009	Eletiva	Introdução aos jogos por computador (plataformas históricas e atuais)
1470	PE-010	Eletiva	Impactos éticos, sociais e legais dos jogos
1471	PE-011	Eletiva	Game engines (ferramentas para desenvolvimento de jogos)
1472	PE-012	Eletiva	Técnicas de animação, simulação e rendering real-time
1473	PE-013	Eletiva	Game design
1474	PE-014	Eletiva	Tópicos avançados no desenvolvimento de jogos
1475	PE-015	Essencial 1	Linguagens de programação para web (e.g., JavaScript, HTML5, CSS)
1476	PE-016	Essencial 1	Arquiteturas (front-end, backend), Componentes WEB, APIs
1477	PE-017	Essencial 2	Frameworks para aplicações web (e.g. Yii, Rails, Django, Flask, Laravel, Spring, Angular, React)
1478	PE-018	Essencial 1	Analisando requisitos e modelando aplicações web
1479	PE-019	Essencial 1	Padrões web (e.g. DOM, JSON, AJAX) e padrões arquiteturais (MVC, MVVP, MVC)
1480	PE-020	Eletiva	Software as a Service (SaaS)
1481	PE-021	Essencial 1	Considerações de Segurança e Privacidade
1482	PE-022	Essencial 1	Plataformas, características de hardware, exemplos de uso, distribuição de aplicativos (modelo de negócio)
1483	PE-023	Essencial 1	Prototipação e desenvolvimento de aplicativos usando ferramentos no-code, ambientes cross-platform, linguagens de programação e frameworks para plataformas móveis
1484	PE-024	Essencial 1	Compartilhamento de informações entre aplicativos e entre dispositivos
1485	PE-025	Essencial 1	Regras e recomendações para o projeto de interfaces com o usuário
1486	PE-026	Eletiva	Uso de recursos avançados e sensores (georeferenciamento, sensores inerciais, mapas, realidade aumentada, health data)
1487	PE-027	Eletiva	Uso criativo (avançado) de dispositivos móveis
1488	RC-001	Essencial 1	Importância de redes em sistemas atuais e desafios associados.
1489	RC-002	Essencial 1	Organização da Internet (ex: usuários, provedores de serviço Internet, sistemas autônomos, provedores de conteúdo, redes de distribuição de conteúdo).
1490	RC-003	Essencial 1	Técnicas de comutação (ex: orientada a circuitos e a pacotes).
1491	RC-004	Essencial 1	Camadas e seus papeis (aplicação, transporte, rede, enlace, física).
1492	RC-005	Essencial 1	Princípios de organização de redes em camadas (ex: encapsulamento).
1493	RC-006	Essencial 1	Dispositivos de rede (ex: roteadores, switches, hubs, pontos de acesso e estações finais).
1494	RC-007	Essencial 1	Conceitos de enfileiramento de pacotes (e relação com atrasos, congestionamento, níveis de serviço, etc.)
1495	RC-008	Essencial 1	Esquemas de nomes e endereçamento (ex: DNS, endereços IP, URLs).
1496	RC-009	Essencial 1	Diversidade de requisitos de aplicações em rede (ex: atraso, vazão e tolerância a perdas).
1497	RC-010	Essencial 1	Explicação de pelo menos um protocolo de camada de aplicação (ex: HTTP, SMTP e IMAP).
1498	RC-011	Essencial 1	Entrega não confiável de dados (ex: UDP).
1499	RC-012	Essencial 1	Princípios de entrega de dados confiável (ex: sem perdas, sem duplicação e em ordem).
1500	RC-013	Essencial 1	Controle de erros (ex: retransmissão e correção de erros).
1501	RC-014	Essencial 1	Controle de fluxo (ex: stop and wait, baseado em janela).
1502	RC-015	Essencial 2	Controle de congestionamento (ex: implícito e via notificação explícita de congestionamento).
1503	RC-016	Essencial 2	TCP e aspectos de desempenho (ex: Tahoe, Reno, Vegas, Cubic, Quic, BBR).
1504	RC-017	Essencial 1	Paradigmas e hierarquias de roteamento (ex: intra/inter domínio - OSPF/BGP, centralizado e descentralizado, source routing, circuitos virtuais, QoS).
1505	RC-018	Essencial 1	Métodos de encaminhamento (ex: tabelas de encaminhamento e algoritmos de matching).
1506	RC-019	Essencial 2	Separação dos planos de controle e de dados (SDN, planos de dados programáveis, etc.).
1507	RC-020	Essencial 1	IP e aspectos de escalabilidade (ex: NAT, CIDR, diferentes versões do IP).
1508	RC-021	Essencial 2	IPv6 e mecanismos de transição
1509	RC-022	Essencial 2	Introdução à modulação, largura de banda e meios de comunicação.
1510	RC-023	Essencial 2	Codificação e enquadramento (framing).
1511	RC-024	Essencial 1	Controle de acesso ao meio (ex: acesso randômico e escalonado).
1512	RC-025	Essencial 1	Ethernet.
1513	RC-026	Essencial 1	Comutação (switching).
1514	RC-027	Essencial 2	Topologias de redes (ex: redes de data center).
1515	RC-028	Essencial 2	Princípios de comunicação celular (ex: 4G, 5G e 6G).
1516	RC-029	Essencial 1	Princípios de redes locais sem fio (ex: IEEE 802.11).
1517	RC-030	Eletiva	Comunicação device-to-device.
1518	RC-031	Eletiva	Redes sem fio multisaltos (ex: ad-hoc, oportunísticas, tolerantes a atrasos).
1519	RC-032	Essencial 2	Middleboxes (ex: filtragem, inspeção profunda de pacotes, balanceamento de carga, NAT).
1520	RC-033	Essencial 2	Redes de distribuição de conteúdo (CDNs).
1521	RC-034	Eletiva	Redes quânticas (ex: introdução ao domínio, segurança, Internet quântica).
1522	RC-035	Essencial 2	Monitoração de redes (ex: SNMP, fluxos, telemetria, observabilidade).
1523	RC-036	Essencial 2	FCAPS (terminologia).
1524	RC-037	Eletiva	Green networking ou carbon-aware networking.
1525	RC-038	Essencial 2	Multimídia (streaming, ao vivo, video/audioconferência - codificação, bufferização, DASH, etc.).
1526	RC-039	Eletiva	Aplicações emergentes (ex: VR/AR/holographic-type communications, sistemas ciberfísicos)
1527	RC-040	Eletiva	Redes ópticas (ex: funcionamento básico, NG-SDH/SONET, DWDM, OTN, PON)
1528	RC-041	Eletiva	Redes de sensores sem fio, Indústria 4.0, Cidades inteligentes, Smart*.
1529	RC-042	Eletiva	Teoria da Informação (ex: entropia, entropia condicional, mutual information, Teorema de Shannon).
1530	RC-043	Eletiva	Comunicação sem fio (ex: antenas, faixas de frequência, WPANs, WLANs, WMANs, WRANs, WWANs).
1531	SE-001	Essencial 1	Conceitos e propriedades em segurança
1532	SE-002	Essencial 1	Risco, vulnerabilidades, ameaças e vetores de ataque
1533	SE-003	Essencial 1	Princípios de segurança
1534	SE-004	Essencial 1	Princípios de privacidade
1535	SE-005	Essencial 1	Tensões entre segurança e outros objetivos de design
1536	SE-006	Essencial 1	Questões legais e ética
1537	SE-007	Essencial 1	Autenticação e autorização, controle de acesso
1538	SE-008	Essencial 1	Segurança de ponta a ponta
1539	SE-009	Essencial 1	Defesa em profundidade
1540	SE-010	Essencial 1	Segurança por design
1541	SE-011	Eletiva	Segurança utilizável
1542	SE-012	Essencial 1	Validação de entrada e sanitização de dados
1543	SE-013	Essencial 1	Escolha da linguagem de programação e linguagens de tipo seguro
1544	SE-014	Essencial 1	Condições de corrida
1545	SE-015	Essencial 1	Tratamento correto de exceções e comportamentos inesperados
1546	SE-016	Essencial 2	Controle de fluxo de informações
1547	SE-017	Essencial 1	Gerando aleatoriedade corretamente para fins de segurança
1548	SE-018	Essencial 1	Análise estática e análise dinâmica
1549	SE-019	Essencial 1	Verificação de programas
1550	SE-020	Essencial 1	Suporte de segurança no sistema operacional
1551	SE-021	Essencial 1	Suporte de segurança em hardware
1552	SE-022	Essencial 1	Objetivos, capacidades e motivações do invasor
1553	SE-023	Essencial 1	Malware
1554	SE-024	Essencial 1	Negação de Serviço
1555	SE-025	Essencial 1	Engenharia social
1556	SE-026	Essencial 1	Ataques à privacidade e ao anonimato
1557	SE-027	Essencial 1	Canais secretos e estegonografia
1558	SE-028	Essencial 1	Ameaças específicas de rede e tipos de ataque
1559	SE-029	Essencial 1	Criptografia para segurança de dados e rede
1560	SE-030	Essencial 1	Arquiteturas para redes seguras
1561	SE-031	Essencial 1	Mecanismos de defesa de redes e contramedidas
1562	SE-032	Essencial 2	Segurança para redes celulares sem fio
1563	SE-033	Essencial 2	Segurança de redes sem fio
1564	SE-034	Essencial 2	Resistência à censura
1565	SE-035	Essencial 2	Gerenciamento de segurança de rede
1566	SE-036	Essencial 1	Tipos de cifras juntamente com métodos de ataque típicos
1567	SE-037	Essencial 1	Suporte de infraestrutura de chave pública para assinatura digital e criptografia e seus desafios.
1568	SE-038	Essencial 1	Preliminares Matemáticas para Criptografia
1569	SE-039	Essencial 1	Primitivas criptográficas
1570	SE-040	Essencial 1	Cifras de bloco e de fluxo
1571	SE-041	Essencial 1	Funções de hash
1572	SE-042	Essencial 1	Códigos de autenticação de mensagem
1573	SE-043	Essencial 1	Criptografia de chave simétrica
1574	SE-044	Eletiva	Modos de operação para segurança semântica e criptografia autenticada
1575	SE-045	Essencial 1	Integridade da mensagem (por exemplo, CMAC, HMAC)
1576	SE-046	Essencial 1	Criptografia de chave pública
1577	SE-047	Essencial 1	Assinaturas digitais
1578	SE-048	Essencial 1	Infraestrutura de chave pública (PKI) e certificados
1579	SE-049	Essencial 1	Protocolos criptográficos
1580	SE-050	Essencial 1	Criptografia quântica e pós-quântica
1581	SE-051	Eletiva	Modelo de segurança da web
1582	SE-052	Eletiva	Gerenciamento de sessão
1583	SE-053	Eletiva	Vulnerabilidades e defesas de aplicativos
1584	SE-054	Eletiva	Segurança do lado do cliente
1585	SE-055	Eletiva	Rastreamento de usuário
1586	SE-056	Eletiva	Integridade do código e assinatura de código
1587	SE-057	Eletiva	Segurança em Internet das Coisas
1588	SE-058	Eletiva	Caminho confiável
1589	SE-059	Eletiva	Políticas de segurança
1590	SE-060	Essencial 2	Princípios básicos e metodologias para forense digital
1591	SE-061	Eletiva	Métodos e padrões de Evidências Digitais e Preservação de Dados
1592	SE-062	Eletiva	Detecção, análise e investigação de ataques
1593	SE-063	Eletiva	Anti-forense
1594	SE-064	Essencial 1	Construindo segurança no ciclo de vida de desenvolvimento de software
1595	SE-065	Essencial 1	Princípios e padrões de design seguro
1596	SE-066	Essencial 1	Especificações e requisitos de software seguro
1597	SE-067	Essencial 1	Práticas seguras de desenvolvimento de software
1598	SE-068	Essencial 1	Garantia de qualidade de software e medições de benchmarking
1599	SO-001	Essencial 1	Função e finalidade dos sistemas operacionais
1600	SO-002	Essencial 1	Princípios do Sistema Operacional
1601	SO-003	Essencial 1	Concorrência - Básico
1602	SO-004	Essencial 2	Concorrência - Avançado
1603	SO-005	Essencial 1	Escalonamento - Básico
1604	SO-006	Eletiva	Escalonamento - Avançado
1605	SO-007	Essencial 1	Modelo de processo
1606	SO-008	Essencial 1	Gerenciamento de memória - Básico
1607	SO-009	Essencial 2	Gerenciamento de memória - Avançado
1608	SO-010	Essencial 2	Proteção e Segurança - Básico
1609	SO-011	Eletiva	Proteção e Segurança - Avançado
1610	SO-012	Essencial 1	Gerenciamento de dispositivos - Básico
1611	SO-013	Eletiva	Gerenciamento de dispositivos - Avançado
1612	SO-014	Essencial 1	API de sistemas de arquivos e implementação
1613	SO-015	Essencial 2	Sistemas de arquivos avançados
1614	SO-016	Eletiva	Sistemas de arquivos mais avançados
1615	SO-017	Essencial 2	Virtualização - Básico
1616	SO-018	Eletiva	Virtualização - Avançado
1617	SO-019	Eletiva	Sistemas em tempo real e embarcados
1618	SO-020	Essencial 1	Tolerância à Falhas
1619	SO-021	Essencial 2	Princípios de Programação paralela e distribuída
1620	SO-022	Essencial 2	Programação Paralela em arquiteturas multicore
1621	SO-023	Essencial 2	Programação Paralela para arquiteturas heterogêneas
1622	SO-024	Eletiva	Programação Paralela em ambientes de memória distribuída
1623	SO-025	Essencial 2	Tópicos em Cloud Computing (Edge/Fog???)
1624	GD-001	Essencial 1	Estruturas e Organizações de Arquivos de Dados e de Índice
1625	GD-002	Eletiva	Bancos de Dados NoSQL e NewSQL
1626	GD-003	Eletiva	Teorema CAP e BASE (integridade)
1627	GD-004	Eletiva	Bancos de Dados Chave-Valor e Tabulares
1628	GD-005	Eletiva	Bancos de dados orientados a Documentos
1629	GD-006	Eletiva	Bancos de Dados orientados a Grafos
1630	GD-007	Eletiva	Bancos de Dados de Memória Principal
1631	GD-008	Eletiva	Sintonia em Sistemas Gerenciadores de Bancos de Dados
1632	GD-009	Eletiva	Modelos de Recuperação de Informação (booleano, vetorial e probabilístico)
1633	GD-010	Eletiva	Métricas de Avaliação de Recuperação de informação
1634	GD-011	Eletiva	Recuperação de informação na Web (crawling, algoritmos de ranking)
1635	GD-012	Eletiva	Funções de similaridade de strings (distância de edição, Jaccard, cosseno)
1636	GD-013	Eletiva	Técnicas de Melhoria de Qualidade
1637	GD-014	Eletiva	Metodologia Experimental de Recuperação da Informação
1638	GD-015	Essencial 1	SGBD: visao geral
1639	GD-016	Essencial 1	Modelo de dados: conceitual, lógico
1640	GD-017	Essencial 2	Projeto de Base de Dados Conceitual
1641	GD-018	Essencial 1	Projeto de Base de Dados Lógico
1642	GD-019	Essencial 2	Mapeamento entre Esquemas de Banco de Dados
1643	GD-020	Essencial 1	Modelo Relacional: conceitos
1644	GD-021	Essencial 1	Linguagem de Definição/Manipulacao de Dados
1645	GD-022	Essencial 1	Normalizacao
1646	GD-023	Essencial 1	Algebra Relacional
1647	GD-024	Essencial 1	Consultas em SQL: Básicas, Avançadas
1648	GD-025	Essencial 1	Visao
1649	GD-026	Essencial 1	Procedimento Armazenado, Gatilho
1650	GD-027	Essencial 1	Transacao: conceitos, propriedades, niveis de isolamento
1651	GD-028	Essencial 2	Transacao: recuperaçao e concorrencia, log, operacoes undo/redu
1652	GD-029	Essencial 2	Transacao: concorrencia, niveis de bloqueio, estrategias
1653	GD-030	Essencial 2	SGBD: Recuperaçao, controle de falhas, backup
1654	GD-031	Essencial 1	Autorizacao
1655	GD-032	Essencial 2	Plano de Consultas e otimizaçao
\.


--
-- Data for Name: disciplinas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disciplinas (id_disciplina, nome, codigo, area) FROM stdin;
6	INTRODUÇÃO À CIÊNCIA DA COMPUTAÇÃO	INF01087	AL
107	COMPILADORES	INF01147	NI
108	PROJETO E ANÁLISE DE ALGORITMOS III	INF05030	AL
9	PROCESSAMENTO DE LINGUAGEM NATURAL	INF01100	IA
1	CIÊNCIA DE DADOS N	INF01090	IA
2	COMPUTAÇÃO DE ALTO DESEMPENHO	INF01091	NI
3	COMPUTAÇÃO GRÁFICA II	INF01009	CG
4	DESENVOLVIMENTO DE APLICAÇÕES WEB	INF01099	PE
5	GERÊNCIA E ADMINISTRAÇÃO DE PROJETOS	INF01016	NI
7	NOVAS ABORDAGENS DE BANCO DE DADOS	INF01095	NI
8	PROCESSAMENTO DE IMAGENS II	INF01089	CG
10	PROJETO DE BANCO DE DADOS	INF01006	NI
11	RECUPERAÇÃO DE INFORMAÇÃO	INF01096	NI
12	SEGURANÇA DE REDES DE COMPUTADORES E SISTEMAS DISTRIBUÍDOS	INF01097	RC
13	TECNOLOGIAS COMPUTACIONAIS - EAD	INF01074	NI
14	TENDÊNCIAS EM ENGENHARIA DE SOFTWARE	INF01217	ES
15	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XVIII	INF01060	NI
16	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XXXIV	INF01219	NI
17	ALGORITMOS E PROGRAMAÇÃO	INF01211	AL
18	ARQUITETURA E DESEMPENHO DE BANCO DE DADOS	INF01023	AR
19	ARQUITETURA E ORGANIZAÇÃO DE COMPUTADORES II	INF01112	AR
20	BANCOS DE DADOS	INF01145	NI
21	CAD PARA SISTEMAS DIGITAIS	INF01205	NI
22	CIRCUITOS DIGITAIS	INF01058	AR
23	CLASSIFICAÇÃO E PESQUISA DE DADOS	INF01124	NI
24	COMPUTAÇÃO BÁSICA FORTRAN	INF01101	NI
25	COMPUTAÇÃO EVOLUTIVA	INF01037	NI
26	COMPUTADOR E SISTEMAS DE INFORMAÇÃO	INF01119	NI
27	COMPUTADOR E SOCIEDADE	INF01140	CS
28	CONCEPÇÃO DE CIRCUITOS INTEGRADOS II	INF01194	AR
29	DESAFIOS DE PROGRAMAÇÃO	INF01056	NI
30	DESENVOLVIMENTO DE SOFTWARE	INF01120	NI
31	EMPREENDIMENTO EM INFORMÁTICA	INF01032	NI
32	ESPECIFICAÇÃO FORMAL N	INF01001	NI
33	ESTRUTURAS DE DADOS I	INF01126	AL
34	FUNDAMENTOS DE TOLERÂNCIA A FALHAS	INF01209	SO
35	GERÊNCIA E APLICAÇÕES EM REDES	INF01015	NI
36	HISTÓRIA DA COMPUTAÇÃO	INF01039	NI
37	INTELIGÊNCIA ARTIFICIAL	INF01048	IA
38	INTRODUÇÃO À ARQUITETURA DE COMPUTADORES	INF01107	AR
39	INTRODUÇÃO À INFORMÁTICA	INF01210	NI
40	INTRODUÇÃO À PESQUISA EM INFORMÁTICA	INF01049	NI
41	METODOLOGIA DE PROGRAMAÇÃO	INF01212	NI
42	MODELOS DE LINGUAGEM DE PROGRAMAÇÃO	INF01121	NI
43	PROGRAMAÇÃO ORIENTADA A OBJETO	INF01057	NI
44	PROJETO DE CIRCUITOS DIGITAIS	INF01086	AR
45	PROJETO DE HIPERDOCUMENTOS	INF01021	NI
46	SIMULAÇÃO	INF01116	NI
47	SISTEMAS DE BANCO DE DADOS DISTRIBUÍDOS	INF01014	NI
48	SISTEMAS DIGITAIS PARA COMPUTADORES A	INF01175	NI
49	SISTEMAS ESPECIALISTAS N	INF01038	NI
50	SISTEMAS OPERACIONAIS DISTRIBUÍDOS E DE REDES	INF01018	SO
51	TESTE DE SOFTWARE	INF01214	NI
52	TÓPICOS ESPECIAIS EM COMPUTAÇÃO I	INF01179	NI
53	TÓPICOS ESPECIAIS EM COMPUTAÇÃO II	INF01182	NI
54	TÓPICOS ESPECIAIS EM COMPUTAÇÃO III	INF01188	NI
55	TÓPICOS ESPECIAIS EM COMPUTAÇÃO IV	INF01198	NI
56	TÓPICOS ESPECIAIS EM COMPUTAÇÃO VII	INF01054	NI
57	TÓPICOS ESPECIAIS EM COMPUTAÇÃO VIII	INF01055	NI
58	TÓPICOS ESPECIAIS EM COMPUTAÇÃO X	INF01065	NI
59	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XI	INF01064	NI
60	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XII	INF01063	NI
61	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XVI	INF01062	NI
62	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XVII	INF01061	NI
63	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XXII	INF01066	NI
64	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XXIII	INF01067	NI
65	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XXIX	INF01069	NI
66	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XXX	INF01070	NI
67	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XXXI	INF01071	NI
68	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XXXII	INF01072	NI
70	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XXXV	INF01220	NI
71	TÓPICOS ESPECIAIS EM ENGENHARIA DE COMPUTAÇÃO IV	INF01053	NI
75	ALGORÍTMOS E PROGRAMAÇÃO - CIC	INF01202	NI
76	CÁLCULO E GEOMETRIA ANALÍTICA I - A	MAT01353	NI
80	CÁLCULO E GEOMETRIA ANALÍTICA II - A	MAT01354	NI
84	TESTE E VERIFICAÇÃO DE SOFTWARE	INF01088	NI
87	ÁLGEBRA LINEAR I - A	MAT01355	NI
89	INTERAÇÃO HUMANO-COMPUTADOR E EXPERIÊNCIA DO USUÁRIO	INF01043	NI
93	CÁLCULO NUMÉRICO A	MAT01032	NI
95	PROJETO EM CIÊNCIA E INOVAÇÃO	INF99003	NI
97	APRENDIZADO DE MÁQUINA	INF01017	NI
104	OTIMIZAÇÃO COMBINATÓRIA	INF05010	NI
106	PROJETO INTEGRADOR EM COMPUTAÇÃO	INF99004	NI
77	LÓGICA PARA COMPUTAÇÃO	INF05508	AL
92	TEORIA DA COMPUTAÇÃO II - Computabilidade e Complexidade	INF05501	NI
79	ARQUITETURA DE COMPUTADORES	INF01075	AR
81	ESTRUTURAS DE DADOS	INF01203	AL
82	MATEMÁTICA DISCRETA B	MAT01375	MA
83	PROBABILIDADE E ESTATÍSTICA	MAT02219	MA
85	PROJETO E ANÁLISE DE ALGORITMOS I	INF05027	AL
90	ORGANIZAÇÃO DE COMPUTADORES	INF01113	AR
91	PROJETO E ANÁLISE DE ALGORITMOS II	INF05028	AL
94	COMPUTAÇÃO GRÁFICA E VISUALIZAÇÃO I	INF01047	CG
98	LINGUAGENS DE PROGRAMAÇÃO I	INF05029	LP
99	PROCESSAMENTO DE IMAGENS E VISÃO COMPUTACIONAL I	INF01046	CG
100	PROGRAMAÇÃO PARALELA	INF01008	SO
102	CIBERSEGURANÇA	INF01045	SE
103	LINGUAGENS DE PROGRAMAÇÃO II	INF01083	LP
105	SISTEMAS DISTRIBUÍDOS E TOLERANTES A FALHAS	INF01085	SO
78	PENSAMENTO COMPUTACIONAL	INF05008	AL
86	\tTEORIA DA COMPUTAÇÃO I - Linguagens Formais e Autômatos	INF05005	NI
88	ENGENHARIA DE SOFTWARE	INF01127	ES
96	SISTEMAS OPERACIONAIS	INF01142	SO
101	REDES DE COMPUTADORES	INF01084	RC
69	TÓPICOS ESPECIAIS EM COMPUTAÇÃO XXXIII	INF01218	AA
\.


--
-- Data for Name: disciplinas_conteudos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disciplinas_conteudos (id_disciplina, id_conteudo) FROM stdin;
17	1161
17	1162
17	1163
17	1164
17	1165
17	1166
17	1176
6	1179
76	1450
77	1444
77	1458
82	1442
82	1443
82	1445
82	1456
79	1195
79	1196
79	1202
79	1203
79	1204
79	1205
81	1167
81	1168
81	1169
81	1171
81	1172
81	1173
83	1448
83	1449
80	1451
44	1197
44	1198
44	1199
44	1200
44	1201
85	1311
85	1312
85	1313
85	1314
85	1316
30	1349
30	1350
30	1352
30	1353
30	1354
30	1355
20	1638
20	1639
20	1641
20	1643
20	1644
20	1645
20	1646
20	1647
20	1648
20	1649
20	1650
20	1652
20	1654
20	1655
91	1315
91	1316
91	1317
91	1318
91	1319
90	1206
90	1207
90	1208
90	1209
90	1210
90	1211
90	1212
90	1213
87	1452
89	1281
89	1282
89	1290
89	1291
89	1293
89	1294
89	1295
89	1296
89	1297
89	1298
37	1361
37	1363
37	1364
37	1365
37	1366
37	1367
37	1368
37	1369
37	1373
37	1375
37	1379
37	1380
37	1391
37	1392
95	1179
94	1219
94	1220
94	1221
94	1222
94	1223
94	1224
94	1225
94	1226
94	1227
94	1228
94	1249
94	1270
97	1378
97	1386
97	1387
97	1389
97	1398
97	1399
97	1401
97	1402
99	1249
99	1250
99	1251
99	1252
99	1253
99	1254
99	1255
99	1256
99	1257
99	1258
99	1270
99	1271
99	1272
99	1273
99	1274
99	1275
99	1259
100	1602
100	1619
100	1620
100	1621
102	1531
102	1532
102	1533
102	1534
102	1535
102	1536
102	1537
102	1538
102	1539
102	1540
102	1552
102	1553
102	1554
102	1555
102	1556
102	1557
102	1566
102	1567
102	1570
102	1572
102	1573
102	1575
102	1576
102	1577
102	1578
102	1579
102	1580
105	1618
105	1619
105	1622
105	1623
9	1404
9	1405
9	1406
9	1407
51	1358
28	1217
28	1218
48	1199
48	1200
48	1218
92	1307
92	1308
92	1309
92	1310
88	1349
88	1351
88	1352
88	1353
88	1354
88	1359
88	1360
96	1208
96	1209
96	1210
96	1599
96	1600
96	1601
96	1603
96	1604
96	1605
96	1606
96	1607
96	1610
96	1612
96	1613
96	1615
96	1616
101	1488
101	1489
101	1490
101	1491
101	1492
101	1493
101	1494
101	1495
101	1496
101	1497
101	1498
101	1499
101	1500
101	1501
101	1502
101	1503
101	1504
101	1505
101	1506
101	1507
101	1508
101	1510
101	1511
101	1512
101	1513
101	1514
101	1516
78	1179
78	1180
78	1178
78	1176
78	1177
86	1304
86	1303
86	1302
86	1305
108	1321
108	1320
108	1322
\.


--
-- Data for Name: disciplinas_habilidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disciplinas_habilidades (id_disciplina, id_habilidade) FROM stdin;
17	26
17	27
17	29
82	158
82	159
82	163
82	169
79	37
79	38
79	40
79	41
44	38
44	39
44	40
30	90
30	91
30	92
30	93
30	94
30	95
30	96
30	97
30	98
30	99
20	211
20	212
20	213
20	214
20	215
90	42
90	43
90	44
90	45
90	46
37	101
37	102
37	103
37	104
37	105
37	106
37	107
37	113
37	118
37	120
94	50
94	51
94	55
94	58
102	201
9	126
9	127
9	128
9	129
28	39
48	39
48	42
88	90
88	91
88	92
88	96
88	97
88	99
101	193
101	194
101	195
101	196
78	26
78	27
78	28
78	31
\.


--
-- Data for Name: habilidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.habilidades (id_habilidade, codigo, essencialidade, descricao, proficiencia) FROM stdin;
26	AL-H-001	Essencial 1	Analisar problemas e elaborar programas que os solucionem, utilizando para isto uma linguagem de programção.	Criar
27	AL-H-002	Essencial 1	Escolher as estruturas de dados adequadas para modelar diferentes situações e justificar suas escolhas	Avaliar
28	AL-H-003	Essencial 1	Construir soluções computacionais utilizando conceitos de subprogramação, recursão, meta-programação e manipulação de arquivos	Criar
29	AL-H-004	Essencial 1	Avaliar e selecionar uma estratégia adequada para a resolução de um problema	Avaliar
30	AL-H-005	Essencial 1	Construir soluções computacionais eficientes para a organização e busca de dados	Criar
31	AL-H-006	Essencial 1	Resolver problemas usando o pensamento computacional, aplicando as principais técnicas de construção de soluções computacionais e analisando criticamente as soluções	Avaliar
32	AL-H-007	Essencial 1	Compreender os princípios da análise de problemas e algoritmos	Compreender
33	AL-H-008	Eletiva	Compreender os princípios da organização e busca por dados textuais e do funcionamento de motores de busca.	Aplicar
34	AL-H-009	Eletiva	Selecionar algoritmos e estruturas de dados adequadas para a resolução de problemas que envolvem dados espaciais e/ou multidimensionais	Criar
35	AL-H-010	Essencial 1	Analisar algoritmos/programas justificando sua correção (ou seja, sendo capaz de argumentar porque um programa resolve de fato o problema dado)	Avaliar
36	AR-H-001	Essencial 2	Conhecer a história da computação e os principais marcos históricos da evolução das arquiteturas de computadores.	Lembrar
37	AR-H-002	Essencial 1	Escolher sistemas de representação de dados adequados para aplicações com diferentes necessidades.	Avaliar
38	AR-H-003	Essencial 1	Analisar o funcionamento e utilizar os componentes básicos para composição de arquiteturas computacionais.	Analisar
39	AR-H-004	Essencial 1	Aplicar técnicas de desenvolvimento e otimização de circuitos digitais.	Aplicar
40	AR-H-005	Essencial 1	Avaliar o funcionamento de arquiteturas de von Neumann e seus principais componentes.	Avaliar
41	AR-H-006	Essencial 1	Criar programas utilizando arquiteturas de conjuntos de instruções para resolver diferentes problemas.	Criar
42	AR-H-007	Essencial 1	Analisar a eficiência de diferentes arquiteturas para classes de problemas e níveis de paralelismo distintos.	Avaliar
43	AR-H-008	Essencial 1	Compreender as diferentes tecnologias de implementação de memórias e suas principais métricas de qualidade.	Compreender
44	AR-H-009	Essencial 1	Avaliar o funcionamento de hierarquias de memória para diferentes aplicações.	Avaliar
45	AR-H-010	Essencial 1	Compreender o funcionamento e utilizar sistemas de entrada e saída e seus principais mecanismos de implementação.	Aplicar
46	AR-H-011	Essencial 1	Avaliar requisitos não-funcionais (e.g., desempenho, potência e consumo de energia) de sistemas computacionais.	Avaliar
47	AR-H-012	Essencial 2	Utilizar técnicas e arquiteturas avançadas para desenvolvimento de sistemas computacionais.	Aplicar
48	AR-H-013	Eletiva	Compreender novos paradigmas relacionados a arquitetura, organização e circuitos.	Aplicar
49	AR-H-014	Eletiva	Utilizar algoritmos adequados para resolver problemas de automação de projeto de sistemas digitais.	Aplicar
50	CG-H-001	Essencial 1	Criar aplicações gráficas interativas que possibilitem a visualização de ambientes virtuais tridimensionais, aproximando ambientes reais em diferentes níveis de realismo, utilizando de maneira eficiente os recursos computacionais existentes em hardware e software.	Criar
51	CG-H-002	Essencial 1	Compreender os diferentes métodos existentes para geração de imagens por computador, assim como as principais estruturas de dados e modelos matemáticos para representação geométrica, sabendo a melhor situação onde estes devem ser aplicados.	Aplicar
52	CG-H-003	Essencial 2	Utilizar técnicas de computação gráfica para gerar imagens por computador com alto nível de qualidade e realismo, tanto de maneira "offline" quanto em tempo real.	Aplicar
53	CG-H-004	Eletiva	Desenvolver novos algoritmos que avançem o estado da arte na geração de imagens por computador	Criar
54	CG-H-005	Eletiva	Entender o funcionamento e algoritmos básicos de ferramentas que realizam a fabricação física a partir de modelos geométricos virtuais	Compreender
55	CG-H-006	Essencial 1	Compreender e identificar as potenciais vantagens do uso de técnicas de visualização de informações como forma de comunicação e suporte à exploração de grandes conjuntos de dados	Compreender
56	CG-H-007	Eletiva	Desenvolver, implementar e avaliar aplicações envolvendo técnicas interativas de visualização de informações, utilizando recursos de alto nível disponíveis na forma de bibliotecas ou ferramentas 	Criar
57	CG-H-008	Essencial 1	Desenvolver, implementar e avaliar aplicações que manipulam a representação digital de dados visuais, como imagens e vídeos, utilizando com plena capacidade os princípios matemáticos associados	Avaliar
58	CG-H-009	Essencial 1	Compreender a relação entre representações digitais e os fenômenos visuais que ali estão codificados	Compreender
59	CG-H-010	Essencial 1	Desenvolver, implementar e avaliar soluções capazes de extrair informações relevantes a partir de dados visuais	Avaliar
60	CG-H-011	Essencial 1	Aplicar métodos e recursos de computação gráfica e interação para construção de ambientes imersivos usando recursos de alto nível (engines e APIs)	Aplicar
61	CG-H-012	Essencial 2	Compreender e identificar as potenciais vantagens no uso de Realidade Virtual e Realidade Aumentada como espaço de comunicação	Compreender
62	CG-H-013	Essencial 1	Conduzir um processo de concepção e projeto de interfaces centrado no usuário e em suas necessidades	Aplicar
63	CG-H-014	Essencial 1	Ser capaz de escolher e aplicar a técnica de avaliação de interfaces adequada a cada situação	Aplicar
64	CG-H-015	Eletiva	Criar novos artefatos de interação a partir da tecnologia disponível e tendo em vista as necessidades dos usuários	Criar
65	CO-H-001	Essencial 1	Compreender diversos modelos de computação, seus princípios de funcionamento e as respectivas linguagens reconhecidas e/ou funções computadas, assim como a Hierarquia de Chomsky.	Compreender
66	CO-H-002	Essencial 1	Utilizar autômatos finitos e expressões regulares para modelar sistemas computacionais, e gramáticas para descrever linguagens formais, compreendendo a relação entre formalismos geradores e reconhecedores das respectivas linguagens.	Aplicar
67	CO-H-003	Essencial 2	Implementar algoritmos usando modelos de computação Turing-completos.	Criar
68	CO-H-004	Essencial 1	Comparar modelos de computação através de transformações que preservem a semântica, compreendendo a Tese de Church-Turing e sua importância para a área da Computação.	Avaliar
69	CO-H-005	Essencial 1	Reconhecer a existência de funções e linguagens não computáveis e de problemas indecidíveis, identificando  exemplos famosos como o problema da parada.	Lembrar
70	CO-H-006	Essencial 1	Demonstrar que um dado problema de interesse é indecidível através da construção de reduções entre problemas.	Criar
71	CO-H-007	Essencial 1	Demonstrar que um dado problema de interesse pertence a uma classe de complexidade (P, NP, PSPACE)	Criar
72	CO-H-008	Essencial 1	Demonstrar a complexidade assintótica de um dado problema de interesse, usando notação e os respectivos tipos de complexidade (pior caso, melhor caso e caso médio)	Criar
73	CO-H-009	Essencial 1	Avaliar o uso de algoritmos conhecidos para solucionar um dado problema de interesse	Avaliar
74	CO-H-010	Essencial 1	Criar algoritmo para solução de um dado problema de interesse usando padrões conhecidos de solução	Criar
75	CS-H-001	Essencial 1	Avaliar o impacto e a sustentabilidade ambiental de soluções e serviços computacionais	Avaliar
76	CS-H-002	Essencial 1	Avaliar o impacto de soluções e serviços computacionais sobre direitos humanos, como privacidade, proteção aos dados pessoais, liberdade de expressão, acessibilidade, etc.	Avaliar
77	CS-H-003	Essencial 1	Avaliar as implicações éticas de soluções e serviços computacionais	Avaliar
78	CS-H-004	Essencial 1	Compreender as responsabilidades profissionais relacionadas às diferentes áreas de atuação do egresso	Compreender
79	CS-H-005	Essencial 2	Compreender os processos de transformação digital da sociedade e suas implicações sociais e econômicas	Compreender
80	CS-H-006	Essencial 1	Compreender os processos regulatórios e legislativos e as políticas públicas que se aplicam a soluções e serviços computacionais e compreender suas implicações sociais e econômicas	Compreender
81	CS-H-007	Essencial 1	Compreender questões de propriedade intelectual relativas ao desenvolvimento de software	Compreender
82	EM-H-001	Essencial 1	Compreender os conceitos de inovação, empreendedorismo e modelos de negócios 	Compreender
83	EM-H-002	Essencial 1	Criar e elaborar modelos de negócios inovadores	Criar
84	EM-H-003	Essencial 1	Aplicar metodologias, técnicas e ferramentas no desenvolvimento de modelos de negócios inovadores, incluindo análise de mercado e planejamento financeiro.	Aplicar
85	EM-H-004	Essencial 1	Aplicar metodologias para desenvolvimento de soluções como modelos de negócios inovadores	Aplicar
86	EM-H-005	Essencial 2	Conhecer os principais atores do ecossistema de empreendedorismo e inovação	Compreender
87	EM-H-006	Essencial 2	Conhecer os fundamentos da gestão da inovação	Compreender
88	EM-H-007	Essencial 2	Conhecer principais conceitos relacionados a ESG, negócios de impacto e responsabilidade e ética em negócios inovadores	Compreender
89	EM-H-008	Essencial 2	Conhecer os principais mecanismos de captação de fontes de capital e os principais modelos de formalização de negócios	Compreender
90	ES-H-001	Essencial 1	Descrever os requisitos (funcionais e não funcionais) de um software.	Aplicar
91	ES-H-002	Essencial 1	Entender Processos de software e os diferentes Papéis e responsabilidades em uma equipe de software	Compreender
92	ES-H-003	Essencial 1	Aplicar os princípios de design do sistema, selecionando adequadamente entre os principais estilos de arquitetura de software (2 camadas, 3 camadas, cliente servidor, MVC, etc)	Aplicar
93	ES-H-004	Essencial 1	Identificar Code smells e outros indicadores de qualidade de código (débito técnico, métricas, etc) ; Realizar Revisão de Código	Analisar
94	ES-H-005	Essencial 1	Identificar e construir configuraçoes de módulos (que atendam princípios de modularidade) que atendem os requisitos	Criar
95	ES-H-006	Essencial 1	Utilizar facilidades de ambientes de ES - versionamento, depuração, refatoração, busca, dependências,  etc	Aplicar
96	ES-H-007	Essencial 1	Aplicar boas práticas de codificação e documentação	Aplicar
97	ES-H-008	Essencial 1	Planejar e executar testes de de software e analisar os resultados	Analisar
98	ES-H-009	Essencial 1	Analisar criticamente um sistema de software sob vários aspectos (correção, usabilidade, eficiência, ...)	Avaliar
99	ES-H-010	Essencial 1	Criar e manter modelos (por exemplo usando UML) e artefatos para desenvolvimento e evolução de software	Criar
100	ES-H-011	Eletiva	Aplicar técnicas formais para garantir a correção do software	Analisar
101	IA-H-001	Essencial 1	Avaliar a solução mais adequada para um problema de tomada de decisão (i.e. controle), identificando suas características e verificando a aplicabilidade de algoritmos de aprendizado por reforço ou planejamento em conjunto com heurísticas apropriadas, de acordo com os recursos computacionais disponíveis.	Avaliar
102	IA-H-002	Essencial 2	Modelar um problema de satisfação de restrições para uso de um solver ou método aproximado.	Aplicar
103	IA-H-003	Essencial 1	Identificar impactos positivos e negativos da implantação de um sistema de IA.	Analisar
104	IA-H-004	Essencial 1	Compreender as vantagens, desvantagens e limites computacionais de diferentes algoritmos, solvers ou técnicas de inteligência artificial. 	Compreender
105	IA-H-005	Essencial 2	Representar domínios probabilísticos, identificando as variáveis e suas dependências.	Aplicar
106	IA-H-006	Essencial 2	Identificar as características de um ambiente competitivo (e.g. jogo) e aplicar o raciocínio de otimização min-max, identificando a aplicabilidade, limitações e ajustes necessários dos algoritmos de busca com adversário	Lembrar
107	IA-H-007	Essencial 1	Identificar as possibilidades e limites das abordagens estatísticas e simbólicas de IA, bem como maneiras de uso integrado de ambas	Compreender
108	IA-H-008	Essencial 1	Compreender os diversos paradigmas, classes de métodos e métodos de aprendizado de máquina.	Compreender
109	IA-H-009	Essencial 1	Identificar se a tarefa é preditiva ou descritiva, de acordo com os requisitos do problema e os dados disponíveis	Analisar
110	IA-H-010	Essencial 1	Propor uma solução adequada em termos de eficácia e eficiência para um problema de aprendizado de máquina de acordo com a descrição e requisitos do problema, os dados e recursos computacionais disponíveis.	Aplicar
111	IA-H-011	Essencial 1	Avaliar de forma correta e robusta diferentes algoritmos de aprendizado de máquina, utilizando métricas de desempenho e estratégias de avaliação apropriadas para o tipo de tarefa em questão.	Avaliar
112	IA-H-012	Essencial 1	Preparar um conjunto de dados para uso por algoritmos de aprendizado de máquina, tratando a dimensionalidade, escala de valores, entradas ausentes e atributos menos relevantes para a tarefa em questão, de acordo com os requisitos dos algoritmos utilizados.	Aplicar
113	IA-H-013	Essencial 1	Modelar um problema de controle como Processo de Decisão de Markov para uso de um algoritmo de aprendizado por reforço.	Criar
114	IA-H-014	Essencial 2	Identificar a técnica mais apropriada de aprendizado por reforço de acordo com a dimensionalidade das percepções e ações.	Analisar
115	IA-H-015	Eletiva	Discernir aprendizado on- e off-policy em termos da política final aprendida e da recompensa adquirida ao longo do treinamento.	Compreender
116	IA-H-016	Eletiva	Discernir o aprendizado baseado em Monte Carlo do baseado em diferenças temporais e dos métodos ator-crítico quanto à coleta de experiências e à atualização da política	Compreender
117	IA-H-017	Eletiva	Avaliar as vantagens e desvantagens de métodos de aprendizado baseado em modelos, com relação ao aproveitamento de experiências coletadas e possível integração com métodos de planejamento	Avaliar
118	IA-H-018	Essencial 1	Compreender a otimização baseada em gradiente como elemento essencial das técnicas de aprendizado profundo.	Compreender
119	IA-H-019	Essencial 1	Prototipar uma solução de aprendizado supervisionado para um problema de predição	Criar
120	IA-H-020	Essencial 1	Identificar e mitigar under- e overfitting em aprendizado supervisionado	Avaliar
121	IA-H-021	Essencial 1	Entender as possibilidades e limitações de cada classe de algoritmos com relação à tarefa (regressão/classificação), à natureza dos dados a serem processados (dados estruturados, imagens, textos e grafos) e a sua independência (dados independentes vs dados sequenciais).	Analisar
122	IA-H-022	Essencial 2	Obter modelos pré-treinados e ajustá-los para aplicação em problemas de predição	Aplicar
123	IA-H-023	Essencial 2	Identificar a necessidade de realizar combinação de modelos preditivos, avaliando as vantagens e desvantagens das diferentes abordagens de ensemble	Analisar
124	IA-H-024	Essencial 1	Definir métricas de similaridade e o método de agrupamento mais apropriados de acordo com os dados e recursos computacionais disponíveis	Analisar
125	IA-H-025	Essencial 1	Identificar a necessidade de redução de dimensionalidade nos dados e avaliar a técnica apropriada para o problema	Analisar
126	IA-H-026	Essencial 1	Compreender as formas de representação de dados em linguagem natural, avaliando sua capacidade de representação, eficiência e eficácia	Avaliar
127	IA-H-027	Essencial 1	Identificar o algoritmo mais apropriado para as diferentes tarefas de PLN, considerando os dados e recursos computacionais disponíveis	Analisar
128	IA-H-028	Essencial 1	Prototipar uma solução para uma tarefa de PLN, de forma a estruturar a preparação dos dados, o uso do algoritmo e a aferição de métricas de desempenho	Criar
129	IA-H-029	Essencial 2	Desenvolver aplicações que tratem da compreensão e geração de linguagem	Criar
130	IA-H-030	Essencial 1	Compreender todas as etapas de um processo de descoberta de conhecimento a partir de dados (e.g,. etapas do CRISP-DM)	Avaliar
131	IA-H-031	Essencial 2	Conhecer os problemas, técnicas e ferramentas inerentes às atividades de engenharia de dados, incluindo grandes voumes de dados e paralelismo	Analisar
132	IA-H-032	Essencial 2	Saber aplicar técnicas de modelagem (e.g. estatística, IA, visualização analítica, etc) para encontrar padrões em dados	Avaliar
133	IA-H-033	Essencial 2	Saber inserir projetos de ciência de dados em problemas de negócio de relevância às empresas e organizações para geração de soluções de impacto (economico, teconológico, social, etc)	Criar
134	IA-H-034	Essencial 1	Compreender as atividades envolvidas em um processo de engenharia de conhecimento e os contextos de uso desta abordagem	Compreender
135	IA-H-035	Essencial 2	Compreender as teorias de modelagem conceitual (metafísica, ontologias, e outras) para determinar as melhores estratégias e abordagens para criar modelos de conhecimento e informações	Compreender
136	IA-H-036	Essencial 2	Formular modelos de representação de conhecimento computacionalmente eficientes para diferentes aplicações	Aplicar
137	IA-H-037	Eletiva	Criar modelos de conhecimento para construir soluções	Criar
138	IA-H-038	Eletiva	Avaliar a abordagem adequada de representação de conhecimento em diferentes contextos	Avaliar
139	IA-H-039	Eletiva	Criar soluções baseadas em conhecimento explícito para resolução de problemas, aplicando modelos de conhecimento adequados e raciocínio	Criar
140	IA-H-040	Eletiva	Aplicar análise ontológica para esclarecimento conceitual e elaboração de modelos de conhecimento bem fundamentados e adequados para representar o conhecimento do domínio	Aplicar
141	IA-H-041	Eletiva	Avaliar as técnicas mais adequadas para adquirir conhecimento de diferentes fontes	Avaliar
142	IA-H-042	Eletiva	Analisar o conhecimento de domínio, realizando as distinções adequadas	Analisar
143	IA-H-043	Essencial 1	Avaliar a aplicabilidade de abordagens de IA baseadas em conhecimento explícito em diferentes contextos	Analisar
144	LP-H-001	Essencial 2	CONCEPÇÃO  de  linguagens formais desde sua sintaxe, semântica e aspectos pragmáticos de sua adequação como ferramenta para solução de problemas (LPs) ou para descrição de dados	Criar
145	LP-H-002	Essencial 1	SINTAXE - Uso autômatos finitos e expressões regulares e gramáticas para descrever linguagens formais, compreendendo a relação entre formalismos geradores e reconhecedores das respectivas linguagens e identificar o uso para as mais variadas linguagens (não somente para  linguagens de programaçao) 	Criar
146	LP-H-003	Essencial 1	SINTAXE - Habilidade para poder exprimir padrões por intermédio de expressões regulares de maneira a procurar padrões em grande volumes de dados.	Criar
147	LP-H-004	Essencial 1	PRAGMÁTICA: Implementação de  analisadores léxicos e sintáticos  a partir de ERs, autômatos e gramáticas	Criar
148	LP-H-005	Essencial 1	SEMÂNTICA - habilidade para definir de forma indutiva a semântica estática (sistema de tipos) e semântica dinâmica (comportamento operacional) de uma linguagem	Avaliar
149	LP-H-006	Essencial 1	SEMÂNTICA - provar propriedades de linguagens de programação a partir da especificação da semântica estática e dinâmica	Aplicar
150	LP-H-007	Essencial 1	SEMÂNTICA: reconhecer sistemas de tipos de LPs  como elementos disciplinadores da programação e organizadores de LPs do ponto de vista de Engenharia de Software	Avaliar
151	LP-H-008	Essencial 1	PRAGMÁTICA: Implementação de  analisadores semânticos a partir de especificação de semântica estática	Criar
152	LP-H-009	Essencial 1	PRAGMÁTICA - Habilidade de poder criar elementos e ações que permitam traduzir uma linguagem de programação no nível de usuário para um nível de abstração computacional mais baixo (geração de código)	Criar
153	LP-H-010	Essencial 1	PRAGMÁTICA - Habilidade para projetar processadores de linguagens (LPs, ou de descrição de dados) identificando suas principais etapas e as diferentes representaçoes pelas quais passa um programa . Tipicamente, no caso de LPs, etapas de front-end (análise léxica, sintática e semântica) e etapas back end (avaliação, no caso de interpretadores e geração de código, no caso de compiladores)	Criar
154	LP-H-011	Essencial 1	PRAGMÁTICA -  Habilidade de identificar caracteristicas e propriedades de LPs existentes tais como: propósito geral x DSL x script; alto nível x baixo nível; estaticamente x dinamicamente tipadas; funcional, lógica, OO, imperativa; núcleo x acúcar sintático, e escolher a mais adequada para uso na solução de problemas	Avaliar
155	LP-H-012	Essencial 1	PRAGMÁTICA - dada uma linguagem, identificar os recursos oferecidos por ela e selecionar os mais adequados para modelar estruturas de dados e representar algoritmos. Analisar esses  recursos  em termos de desempenho, eficácia, e da contribuição para a obtenção de programas robustos.	Avaliar
156	LP-H-013	Essencial 2	PRAGMÁTICA: habilidade para usar ferramentas e recursos do ecossitema de Linguagens para geração de parsers,  geração de documentação, para testes unitátios, "builders", e ferramentas para controle de versões	Aplicar
157	MA-H-001	Essencial 1	Compreender os conceitos relacionados ao cálculo diferencial e integral  (em uma ou mais variáveis reais) sabendo aplicar os mesmos na resolução de problemas como minimização de funções, cálculo de áreas de formas geométricas complexas, entre outros.	Analisar
158	MA-H-002	Essencial 1	Conhecer as principais definições, resultados e notações associadas a conjuntos, relações e funções, em particular para a descrição de objetos matemáticos como linguagens formais e estruturas algébricas.	Aplicar
159	MA-H-003	Essencial 1	Saber construir e reconhecer demonstrações matemáticas válidas, conhecendo as principais estruturas de prova -- em particular provas por indução estrutural.	Criar
160	MA-H-004	Essencial 1	Conhecer os conceitos fundamentais de álgebra linear, os principais resultados formais e as mais importantes aplicações em computação como em computação gráfica e inteligência artificial	Aplicar
161	MA-H-005	Essencial 1	Saber aplicar lógica formal para a modelagem de raciocínios e verificação de validade de argumentos.	Aplicar
162	MA-H-006	Essencial 1	Ser capaz de especificar formalmente o comportamento de um dado algoritmo ou programa, assim como de provar a correção deste em relação a esta especificação.	Criar
163	MA-H-007	Essencial 1	Calcular de forma correta o número de possibilidades de um dado cenário ou de uma coleção de objetos.	Aplicar
164	MA-H-008	Essencial 1	Ser capaz de resolver simbolicamente equações de recorrência, podendo estas estarem associadas à contagem de objetos ou à contagem de passos de execução de algoritmos recursivos. 	Aplicar
165	MA-H-009	Essencial 1	Compreender os conceitos relacionados a equaçõs diferenciais, sabendo identificar o que estas modelam, quais os principais tipos (ordinárias, lineares, etc.) e ser capaz de resolver simbolicamente equações simples. 	Aplicar
166	MA-H-010	Essencial 1	Compreender a noção de erro em operações de ponto flutuante, sabendo estimar o seu impacto em algoritmos numéricos.	Analisar
167	MA-H-011	Essencial 1	Conhecer e saber aplicar métodos de resolução numérica de problemas como busca de raízes de equações, diferenciação e integração de funções, e resolução de equações diferenciais. 	Aplicar
168	MA-H-012	Essencial 1	Conhecer o papel das séries de potências, sendo capaz de determinar parâmetros como intervalo de convergência, e o seu uso na aproximação de funções ou resolução de recorrências (funções geradoras).	Aplicar
169	MA-H-013	Essencial 1	Conhecer os principais resultados de teoria dos números, como aritmética modular, divisibilidade, fatoração, primalidade, e suas respectivas aplicações em criptografia e segurança.	Aplicar
170	MA-H-014	Essencial 1	Ser capaz de estimar corretamente a probabilidade de ocorrência de eventos.	Criar
171	MA-H-015	Essencial 1	Ser capaz de sumarizar grandes quantidades de dados por meio de estatísticas adequadas, e ser capaz de testar a validade estatística de hipóteses.	Avaliar
172	MA-H-016	Essencial 1	Saber modelar por meio de grafos diversos problemas que envolvam a conectividade de estruturas.	Criar
173	MA-H-017	Essencial 1	Conhecer os principais teoremas, problemas e algoritmos associados a grafos, sabendo aplicá-los na construção de soluções computacionais.	Aplicar
174	PE-H-001	Eletiva	Compreender principais capacidades e limitações de sistemas de robôs móveis inteligentes atuais (e.g. veículos autônomos, robôs terrestres), dados os sensores disponíveis nos sistemas sendo considerados e o processamento computacional que pode ser feito com os dados obtidos.	Compreender
175	PE-H-002	Eletiva	Desenvolver uma aplicação em uma plataforma robótica padrão, por exemplo usando ROS (Robot Operating System) conectado a um robô móvel físico ou simulado.	Aplicar
176	PE-H-003	Eletiva	Entender os principais problemas de percepção de sistemas robóticos, como mapeamento e localização, e saber aplicar soluções tradicionais de estimativa de estado para tais problemas (e.g. soluções probabilisticas baseadas em filtragem Bayesiana) considerando as incertezas inerentes aos problemas	Aplicar
177	PE-H-004	Eletiva	Aplicar diferentes técnicas de navegação autônoma de robôs móveis dependendo das características do ambiente, dos sensores e dos atuadores do sistema.	Aplicar
178	PE-H-005	Eletiva	Compreender os impactos éticos, sociais e legais dos jogos como ferramentas de entretenimento, treinamento e educação	Compreender
179	PE-H-006	Eletiva	Compreender a lógica de desenvolvimento usando game engines, úteis também para o desenvolvimento de simuladores e sistemas de realidade virtual e aumentada	Compreender
180	PE-H-007	Eletiva	Desenvolver aplicações usando game engines	Aplicar
181	PE-H-008	Eletiva	Explorar técnicas de computação gráfica (rendering e animação) real-time em ambiente de produção de sistemas interativos	Analisar
182	PE-H-009	Eletiva	Propor soluções inovadoras baseadas no uso de computação gráfica 3D em tempo real	Criar
183	PE-H-010	Essencial 1	Desenvolver e implementar uma aplicação web	Aplicar
184	PE-H-011	Essencial 1	Descrever requisitos, restrições e oportunidades de plataformas web	Analisar
185	PE-H-012	Essencial 2	Comparar e contrastar programação web e programação de propósito geral	Avaliar
186	PE-H-013	Eletiva	Descrever diferenças entre Software-como-serviço e software tradicional	Avaliar
187	PE-H-014	Essencial 2	Discutir como padrões web impactam desenvolvimento de software	Analisar
188	PE-H-015	Essencial 2	Analisar aplicações web existentes em relação a padrões	Analisar
189	PE-H-016	Essencial 1	Compreender a lógica de desenvolvimento e de uso de aplicações mobile	Compreender
190	PE-H-017	Essencial 1	Desenvolver protótipos funcionais usando ferramentas no-code e implementar aplicações mobile simples usando plataformas cross-platform	Aplicar
191	PE-H-018	Essencial 2	Compreender as potencialidades e recursos avançados disponíveis nos dispositivos móveis atuais	Compreender
192	PE-H-019	Eletiva	Propor soluções inovadoras baseadas no uso de dispositivos móveis	Criar
193	RC-H-001	Essencial 1	Compreender a organização e o funcionamento da Internet, incluindo suas principais terminologias, componentes, protocolos, mecanismos e interações.	Compreender
194	RC-H-002	Essencial 1	Listar e descrever mecanismos-chave para comunicação confiável, classificando demandas de diferentes aplicações em rede, incluindo controle de fluxo e de congestionamento, roteamento e escalabilidade na Internet. 	Compreender
195	RC-H-003	Essencial 1	Caracterizar métricas e indicadores chaves de desempenho em redes, como atraso, perda, jitter e vazão, bem como reconhecer fontes e causas de interferência nesses indicadores.	Analisar
196	RC-H-004	Essencial 1	Compreender fundamentos de funcionamento de tecnologias de redes, cabeadas e sem fio, de diferentes alcances.	Compreender
197	RC-H-005	Essencial 2	Reconhecer, caracterizar e identificar o benefício de tecnologias e mecanismos emergentes em redes de comunicação.	Avaliar
198	RC-H-006	Eletiva	Aplicar princípios de gerenciamento para assegurar o funcionamento adequado de infraestrutura, serviços e aplicações.	Aplicar
199	RC-H-007	Eletiva	Compreender aspectos de interoperabilidade e integração para sistemas de Internet das Coisas e seus desdobramentos em segmentos diversos de aplicação.	Compreender
200	RC-H-008	Eletiva	Projetar sistemas interconectados em rede envolvendo dispositivos móveis e fixos integrados ao ambiente, seja para aquisição de dados ou para atuação nesse ambiente.	Aplicar
201	SE-H-001	Essencial 1	Desenvolver um sistema que incorpore vários princípios de segurança e avaliar sua resiliência a ataques	Analisar
202	SO-H-001	Essencial 1	Compreender os objetivos e funções dos sistemas operacionais, principais mecanismos e tecnicas utilizados na construção desses sistemas e suas relações de conveniência, eficiência e capacidade de evolução.	Compreender
203	SO-H-002	Essencial 1	Compreender como o design de software para de sistemas operacionais afeta a robustez e a capacidade de manutenção de um sistema operacional	Compreender
204	SO-H-003	Essencial 1	Compreender a dinâmica de chamadas do sistema, a separação entre modo kernel e modo de usuário e seus efeitos sobre a segurança e o desempenho, as vantagens e desvantagens de usar o processamento de interrupção para habilitar a multiprogramação	Compreender
205	SO-H-004	Essencial 2	Comparar e contrastar os algoritmos comuns usados para escalonamento (preemptivo e não preemptivo) de tarefas em sistemas operacionais, como prioridade, comparação de desempenho e esquemas de compartilhamento justo	Analisar
206	SO-H-005	Essencial 2	Analisar possíveis ameaças aos sistemas operacionais e os recursos de segurança projetados para protegê-los	Analisar
207	SO-H-006	Essencial 2	Aplicar técnicas de isolamento, proteção nas funções do sistema operacional (por exemplo, escalonamento de processos e operações em disco, semáforos etc.)	Aplicar
208	SO-H-007	Essencial 2	Compreender como o sistema operacional pode facilitar a tolerância a falhas, confiabilidade e disponibilidade, a variedade de métodos para implementar a tolerância a falhas e as compensações de desempenho e flexibilidade que afetam o uso de tolerância a falhas	Compreender
209	SO-H-008	Eletiva	Identificar uma condição de corrida em um determinado programa e como a introdução de paralelismo em um programa sequencial melhoraria a taxa de transferência e/ou reduziria a latência e como isso pode afetar a eficiência energética	Analisar
210	SO-H-009	Eletiva	Escrever programas distribuídos que apliquem técnicas de filtro/mapeamento/redução, serviços que criem threads para atender a solicitações de diversos clientes em paralelo	Criar
211	GD-H-001	Eletiva	Avaliar os modelos e tecnologias de Bancos de Dados para tratar dados não relacionais, semi-estruturados e com estrutura complexa, além de tratar de grandes volumes de dados.	Avaliar
212	GD-H-002	Eletiva	Aplicar as implementações de bancos de dados para o armazenamento de dados sanitizados para processamento de ciência de dados	Aplicar
213	GD-H-003	Eletiva	Avaliar os conceitos e técnicas relacionados à arquitetura e ao desempenho de sistemas de gerência de banco de dados com vistas à redução do tempo de resposta e a aumento do throughput de transações de banco de dados.	Avaliar
214	GD-H-004	Eletiva	Conhecer os conceitos e técnicas relacionados a manutenção da integridade de dados e estratégias de implementação para determinar a eficiência dos sistemas gerenciadores de bancos de dados.	Avaliar
215	GD-H-005	Eletiva	Aplicar e investigar os conceitos de desempenho de bancos de dados em sistemas comerciais	Aplicar
216	GD-H-006	Eletiva	Avaliar os princípios da organização e busca por dados não estruturados (principalmente textuais)	Avaliar
217	GD-H-007	Eletiva	Aplicar a metodologia da avaliação experimental em recuperação de Informação	Aplicar
218	GD-H-008	Essencial 1	Compreender todas as etapas de um processo de descoberta de conhecimento a partir de dados (e.g,. etapas do CRISP-DM)	Avaliar
219	GD-H-009	Essencial 2	Conhecer os problemas, técnicas e ferramentas inerentes às atividades de engenharia de dados, DATA OPS, incluindo dados não relacionais, semi-estruturados e de estrutura complexa. Lidar com grandes voumes de dados e paralelismo	Analisar
220	GD-H-010	Essencial 2	Saber aplicar técnicas de modelagem (e.g. estatística, IA, visualização analítica, etc) para encontrar padrões em dados	Avaliar
221	GD-H-011	Essencial 2	Saber inserir projetos de ciência de dados em problemas de negócio de relevância às empresas e organizações para geração de soluções de impacto (economico, teconológico, social, etc)	Criar
\.


--
-- Data for Name: notas_conteudos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notas_conteudos (id_nota_conteudo, id_aluno_turma, id_conteudo, nota) FROM stdin;
\.


--
-- Data for Name: notas_habilidades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notas_habilidades (id_nota_habilidade, id_aluno_turma, id_habilidade, nota) FROM stdin;
\.


--
-- Data for Name: turmas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.turmas (id_turma, id_disciplina, codigo, ano, semestre) FROM stdin;
\.


--
-- Name: aluno_turma_id_aluno_turma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aluno_turma_id_aluno_turma_seq', 10, true);


--
-- Name: alunos_id_aluno_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alunos_id_aluno_seq', 1251, true);


--
-- Name: conteudos_id_conteudo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conteudos_id_conteudo_seq', 1655, true);


--
-- Name: disciplinas_id_disciplina_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.disciplinas_id_disciplina_seq', 108, true);


--
-- Name: habilidades_id_habilidade_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.habilidades_id_habilidade_seq', 221, true);


--
-- Name: notas_conteudos_id_nota_conteudo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notas_conteudos_id_nota_conteudo_seq', 4, true);


--
-- Name: notas_habilidades_id_nota_habilidade_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notas_habilidades_id_nota_habilidade_seq', 1, false);


--
-- Name: turmas_id_turma_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.turmas_id_turma_seq', 10, true);


--
-- Name: aluno_turma aluno_turma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_turma
    ADD CONSTRAINT aluno_turma_pkey PRIMARY KEY (id_aluno_turma);


--
-- Name: alunos alunos_matricula_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alunos
    ADD CONSTRAINT alunos_matricula_key UNIQUE (matricula);


--
-- Name: alunos alunos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alunos
    ADD CONSTRAINT alunos_pkey PRIMARY KEY (id_aluno);


--
-- Name: conteudos conteudos_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conteudos
    ADD CONSTRAINT conteudos_codigo_key UNIQUE (codigo);


--
-- Name: conteudos conteudos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conteudos
    ADD CONSTRAINT conteudos_pkey PRIMARY KEY (id_conteudo);


--
-- Name: disciplinas disciplinas_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT disciplinas_codigo_key UNIQUE (codigo);


--
-- Name: disciplinas_conteudos disciplinas_conteudos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas_conteudos
    ADD CONSTRAINT disciplinas_conteudos_pkey PRIMARY KEY (id_disciplina, id_conteudo);


--
-- Name: disciplinas_habilidades disciplinas_habilidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas_habilidades
    ADD CONSTRAINT disciplinas_habilidades_pkey PRIMARY KEY (id_disciplina, id_habilidade);


--
-- Name: disciplinas disciplinas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT disciplinas_pkey PRIMARY KEY (id_disciplina);


--
-- Name: habilidades habilidades_codigo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidades
    ADD CONSTRAINT habilidades_codigo_key UNIQUE (codigo);


--
-- Name: habilidades habilidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.habilidades
    ADD CONSTRAINT habilidades_pkey PRIMARY KEY (id_habilidade);


--
-- Name: notas_conteudos notas_conteudos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_conteudos
    ADD CONSTRAINT notas_conteudos_pkey PRIMARY KEY (id_nota_conteudo);


--
-- Name: notas_habilidades notas_habilidades_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_habilidades
    ADD CONSTRAINT notas_habilidades_pkey PRIMARY KEY (id_nota_habilidade);


--
-- Name: turmas turmas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turmas
    ADD CONSTRAINT turmas_pkey PRIMARY KEY (id_turma);


--
-- Name: aluno_turma unique_aluno_turma; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_turma
    ADD CONSTRAINT unique_aluno_turma UNIQUE (id_turma, id_aluno);


--
-- Name: turmas unique_codigo_periodo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turmas
    ADD CONSTRAINT unique_codigo_periodo UNIQUE (codigo, ano, semestre);


--
-- Name: notas_conteudos unique_nota_conteudo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_conteudos
    ADD CONSTRAINT unique_nota_conteudo UNIQUE (id_aluno_turma, id_conteudo);


--
-- Name: notas_habilidades unique_nota_habilidade; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_habilidades
    ADD CONSTRAINT unique_nota_habilidade UNIQUE (id_aluno_turma, id_habilidade);


--
-- Name: aluno_turma aluno_turma_id_aluno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_turma
    ADD CONSTRAINT aluno_turma_id_aluno_fkey FOREIGN KEY (id_aluno) REFERENCES public.alunos(id_aluno);


--
-- Name: aluno_turma aluno_turma_id_turma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aluno_turma
    ADD CONSTRAINT aluno_turma_id_turma_fkey FOREIGN KEY (id_turma) REFERENCES public.turmas(id_turma);


--
-- Name: disciplinas_conteudos disciplinas_conteudos_id_conteudo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas_conteudos
    ADD CONSTRAINT disciplinas_conteudos_id_conteudo_fkey FOREIGN KEY (id_conteudo) REFERENCES public.conteudos(id_conteudo);


--
-- Name: disciplinas_conteudos disciplinas_conteudos_id_disciplina_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas_conteudos
    ADD CONSTRAINT disciplinas_conteudos_id_disciplina_fkey FOREIGN KEY (id_disciplina) REFERENCES public.disciplinas(id_disciplina);


--
-- Name: disciplinas_habilidades disciplinas_habilidades_id_disciplina_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas_habilidades
    ADD CONSTRAINT disciplinas_habilidades_id_disciplina_fkey FOREIGN KEY (id_disciplina) REFERENCES public.disciplinas(id_disciplina);


--
-- Name: disciplinas_habilidades disciplinas_habilidades_id_habilidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas_habilidades
    ADD CONSTRAINT disciplinas_habilidades_id_habilidade_fkey FOREIGN KEY (id_habilidade) REFERENCES public.habilidades(id_habilidade);


--
-- Name: notas_conteudos notas_conteudos_id_aluno_turma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_conteudos
    ADD CONSTRAINT notas_conteudos_id_aluno_turma_fkey FOREIGN KEY (id_aluno_turma) REFERENCES public.aluno_turma(id_aluno_turma);


--
-- Name: notas_conteudos notas_conteudos_id_conteudo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_conteudos
    ADD CONSTRAINT notas_conteudos_id_conteudo_fkey FOREIGN KEY (id_conteudo) REFERENCES public.conteudos(id_conteudo);


--
-- Name: notas_habilidades notas_habilidades_id_aluno_turma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_habilidades
    ADD CONSTRAINT notas_habilidades_id_aluno_turma_fkey FOREIGN KEY (id_aluno_turma) REFERENCES public.aluno_turma(id_aluno_turma);


--
-- Name: notas_habilidades notas_habilidades_id_habilidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notas_habilidades
    ADD CONSTRAINT notas_habilidades_id_habilidade_fkey FOREIGN KEY (id_habilidade) REFERENCES public.habilidades(id_habilidade);


--
-- Name: turmas turmas_id_disciplina_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turmas
    ADD CONSTRAINT turmas_id_disciplina_fkey FOREIGN KEY (id_disciplina) REFERENCES public.disciplinas(id_disciplina);


--
-- PostgreSQL database dump complete
--

\unrestrict rmFxz90R8qjWXgDYdmoHdWrfzKoM2Sr8Y6lvWyfdXLSfMRbw0UPcoyzPrfn8Cc0

