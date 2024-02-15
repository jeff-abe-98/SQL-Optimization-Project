CREATE TABLE public.authors
(
"authorID" UUID NOT NULL DEFAULT gen_random_uuid (),
"authorName" text COLLATE pg_catalog."default",
CONSTRAINT authors_pkey PRIMARY KEY ("authorID")
)