-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public.activation_codes
(
    id integer NOT NULL,
    "activation_code " character varying(20) NOT NULL,
    is_activated boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidate_activation_codes_by_mail
(
    id integer NOT NULL,
    candidate_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.candidates
(
    user_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    identity_number character varying(11) NOT NULL,
    birth_year integer NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE public.employer_activation_by_mail
(
    id integer NOT NULL,
    employer_id integer NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employer_activation_by_system_personnel
(
    id integer NOT NULL,
    system_personel_id integer NOT NULL,
    employer_id integer NOT NULL,
    is_confirmed boolean NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.employers
(
    user_id integer NOT NULL,
    company_name character varying(80) NOT NULL,
    web_address character varying(80) NOT NULL,
    phone_number character varying(14) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE public.job_titles
(
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE public.system_personnels
(
    user_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE public.users
(
    id integer NOT NULL,
    e_mail character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    PRIMARY KEY (id)
);

ALTER TABLE public.activation_codes
    ADD FOREIGN KEY (id)
    REFERENCES public.candidate_activation_codes_by_mail (id)
    NOT VALID;


ALTER TABLE public.activation_codes
    ADD FOREIGN KEY (id)
    REFERENCES public.employer_activation_by_mail (id)
    NOT VALID;


ALTER TABLE public.candidates
    ADD FOREIGN KEY (user_id)
    REFERENCES public.candidate_activation_codes_by_mail (candidate_id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (user_id)
    REFERENCES public.employer_activation_by_mail (employer_id)
    NOT VALID;


ALTER TABLE public.employers
    ADD FOREIGN KEY (user_id)
    REFERENCES public.employer_activation_by_system_personnel (employer_id)
    NOT VALID;


ALTER TABLE public.system_personnels
    ADD FOREIGN KEY (user_id)
    REFERENCES public.employer_activation_by_system_personnel (system_personel_id)
    NOT VALID;


ALTER TABLE public.users
    ADD FOREIGN KEY (id)
    REFERENCES public.candidates (user_id)
    NOT VALID;


ALTER TABLE public.users
    ADD FOREIGN KEY (id)
    REFERENCES public.employers (user_id)
    NOT VALID;


ALTER TABLE public.users
    ADD FOREIGN KEY (id)
    REFERENCES public.system_personnels (user_id)
    NOT VALID;

END;