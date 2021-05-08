-- Table: public.products

-- DROP TABLE public.products;

CREATE TABLE public.products
(
    product_id integer NOT NULL,
    product_name text COLLATE pg_catalog."default" NOT NULL,
    slogan text COLLATE pg_catalog."default",
    product_description text COLLATE pg_catalog."default" NOT NULL,
    category text COLLATE pg_catalog."default" NOT NULL,
    default_price integer NOT NULL,
    CONSTRAINT products_pkey PRIMARY KEY (product_id)
)

TABLESPACE pg_default;

ALTER TABLE public.products
    OWNER to tamir;

-- Table: public.features

-- DROP TABLE public.features;

CREATE TABLE public.features
(
    feature_id integer NOT NULL,
    feature_name text COLLATE pg_catalog."default" NOT NULL,
    feature_value text COLLATE pg_catalog."default",
    product_id integer,
    CONSTRAINT features_pkey PRIMARY KEY (feature_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES public.products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.features
    OWNER to tamir;

-- Table: public.styles

-- DROP TABLE public.styles;

CREATE TABLE public.styles
(
    style_id integer NOT NULL,
    style_name text NOT NULL,
    original_price integer NOT NULL,
    sale_price text NULL,
    isdefault boolean NULL,
    product_id integer,
    CONSTRAINT styles_pkey PRIMARY KEY (style_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES public.products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.styles
    OWNER to tamir;

-- Table: public.related

-- DROP TABLE public.related;

CREATE TABLE public.related
(
    related_id integer NOT NULL,
    related_product_id integer,
    product_id integer,
    CONSTRAINT related_pkey PRIMARY KEY (related_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES public.products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.related
    OWNER to tamir;

-- Table: public.SKUs

-- DROP TABLE public."SKUs";

CREATE TABLE public."skus"
(
    sku_id integer NOT NULL,
    quantity integer,
    item_size text COLLATE pg_catalog."default",
    style_id integer,
    CONSTRAINT "skus_pkey" PRIMARY KEY (sku_id),
    CONSTRAINT fk_style FOREIGN KEY (style_id)
        REFERENCES public.styles (style_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."skus"
    OWNER to tamir;

-- Table: public.photos

-- DROP TABLE public.photos;

CREATE TABLE public.photos
(
    photo_id integer NOT NULL,
    url text COLLATE pg_catalog."default",
    thumbnail text COLLATE pg_catalog."default",
    style_id integer,
    CONSTRAINT photos_pkey PRIMARY KEY (photo_id),
    CONSTRAINT fk_style FOREIGN KEY (style_id)
        REFERENCES public.styles (style_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.photos
    OWNER to tamir;