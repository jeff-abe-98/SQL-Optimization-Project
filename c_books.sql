CREATE TABLE public.books
(
"bookID" integer NOT NULL DEFAULT
nextval('"books_bookID_seq"'::regclass),
publisher text COLLATE pg_catalog."default",
isbn text,
"pubID" integer,
CONSTRAINT books_pkey PRIMARY KEY ("bookID"),
CONSTRAINT "pubID" FOREIGN KEY ("pubID")
REFERENCES public.publications ("pubID") MATCH SIMPLE
)