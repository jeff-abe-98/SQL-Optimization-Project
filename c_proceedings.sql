CREATE TABLE public.proceedings
(
"proceedingsID" UUID NOT NULL DEFAULT gen_random_uuid (),
title text,

editor text,
year text,
booktitle text,

series text,
publisher text,
CONSTRAINT proceedings_pkey PRIMARY KEY ("proceedingsID")
)