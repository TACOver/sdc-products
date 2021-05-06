-- Table: public.products

-- DROP TABLE public.products;

CREATE TABLE public.products
(
    product_id integer NOT NULL,
    product_name text COLLATE pg_catalog."default" NOT NULL,
    slogan text COLLATE pg_catalog."default",
    description text COLLATE pg_catalog."default" NOT NULL,
    category text COLLATE pg_catalog."default" NOT NULL,
    default_price integer NOT NULL,
    CONSTRAINT products_pkey PRIMARY KEY (product_id)
)

TABLESPACE pg_default;

ALTER TABLE public.products
    OWNER to postgres;

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
    OWNER to postgres;

-- Table: public.styles

-- DROP TABLE public.styles;

CREATE TABLE public.styles
(
    style_id integer NOT NULL,
    style_name text COLLATE pg_catalog."default" NOT NULL,
    original_price integer NOT NULL,
    sale_price integer,
    "isdefault?" boolean,
    product_id integer,
    CONSTRAINT styles_pkey PRIMARY KEY (style_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id)
        REFERENCES public.products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.styles
    OWNER to postgres;

-- Table: public.related

-- DROP TABLE public.related;

CREATE TABLE public.related
(
    related_id integer NOT NULL,
    related_product_id integer,
    current_product_id integer,
    CONSTRAINT related_pkey PRIMARY KEY (related_id),
    CONSTRAINT fk_product FOREIGN KEY (current_product_id)
        REFERENCES public.products (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public.related
    OWNER to postgres;

-- Table: public.SKUs

-- DROP TABLE public."SKUs";

CREATE TABLE public."SKUs"
(
    sku_id integer NOT NULL,
    quantity integer,
    item_size text COLLATE pg_catalog."default",
    style_id integer,
    CONSTRAINT "SKUs_pkey" PRIMARY KEY (sku_id),
    CONSTRAINT fk_style FOREIGN KEY (style_id)
        REFERENCES public.styles (style_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE public."SKUs"
    OWNER to postgres;

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
    OWNER to postgres;