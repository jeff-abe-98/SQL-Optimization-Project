CREATE TABLE public.books
(
"bookID" UUID NOT NULL DEFAULT gen_random_uuid (),
title text  COLLATE pg_catalog."default",

author text COLLATE pg_catalog."default",

publisher text COLLATE pg_catalog."default",
isbn text,

year text,

pages text,
CONSTRAINT books_pkey PRIMARY KEY ("bookID")
)