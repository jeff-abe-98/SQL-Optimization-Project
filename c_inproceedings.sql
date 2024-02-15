CREATE TABLE public.inproceedings
(
"inproceedingsID" UUID NOT NULL DEFAULT gen_random_uuid (),
title text COLLATE pg_catalog."default",

author text COLLATE pg_catalog."default",

year text,

pages text,
booktitle text COLLATE pg_catalog."default",

CONSTRAINT inproceedings_pkey PRIMARY KEY ("inproceedingsID")
)