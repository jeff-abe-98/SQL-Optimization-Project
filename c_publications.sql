CREATE TABLE public.publications
(
"pubID" UUID NOT NULL DEFAULT gen_random_uuid (),
title text,
year text,
pages text,
CONSTRAINT publications_pkey PRIMARY KEY ("pubID")
)