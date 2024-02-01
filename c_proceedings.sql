CREATE TABLE public.proceedings
(
"proceedingsID" integer NOT NULL DEFAULT
nextval('"proceedings_proceedingID_seq"'::regclass),
pages text,
crossref text,
booktitle text,
publisher text,
"pubID" integer,
CONSTRAINT proceedings_pkey PRIMARY KEY ("proceedingsID"),
CONSTRAINT "pubID" FOREIGN KEY ("pubID")
REFERENCES public.publications ("pubID") MATCH SIMPLE
)