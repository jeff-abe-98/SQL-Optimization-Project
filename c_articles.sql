CREATE TABLE public.articles
(
"articleID" integer NOT NULL DEFAULT
nextval('"articles_articleID_seq"'::regclass),
pages text,
volume text,
journal text,
"number" text,
"pubID" integer,
CONSTRAINT articles_pkey PRIMARY KEY ("articleID"),
CONSTRAINT "pubID" FOREIGN KEY ("pubID")
REFERENCES public.publications ("pubID") MATCH SIMPLE
)