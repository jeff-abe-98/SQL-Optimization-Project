CREATE TABLE public.articles
(
"articleID" UUID NOT NULL DEFAULT gen_random_uuid (),
title text,
author text,
year text,
journal text,

pages text,
CONSTRAINT articles_pkey PRIMARY KEY ("articleID")
)