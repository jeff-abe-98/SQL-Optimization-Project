CREATE TABLE public.publications
(
"pubID" integer NOT NULL DEFAULT
nextval('"publications_pibID_seq"'::regclass),
"pubKey" text,
title text,
year text,
month text,
ee text,
url text,
CONSTRAINT publications_pkey PRIMARY KEY ("pubID")
)