--Chado Group Module
--Mara Kim

--Generic groups
CREATE TABLE grp (
    grp_id serial PRIMARY KEY,
    name varchar(255),
    uniquename text NOT NULL,
    type_id integer NOT NULL REFERENCES cvterm
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    is_analysis boolean NOT NULL DEFAULT false,
    is_obsolete boolean NOT NULL DEFAULT false,
    UNIQUE(uniquename, type_id)
);
--Group synonym
CREATE TABLE grp_synonym (
    grp_synonym_id serial PRIMARY KEY,
    is_current boolean NOT NULL DEFAULT true,
    is_internal boolean NOT NULL DEFAULT false,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    pub_id integer NOT NULL REFERENCES pub
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    synonym_id integer NOT NULL REFERENCES synonym
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(grp_id, pub_id, synonym_id)
);
--Group annotation
CREATE TABLE grpprop (
    grpprop_id serial PRIMARY KEY,
    value text,
    rank integer NOT NULL DEFAULT 0,
    type_id integer NOT NULL REFERENCES cvterm
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(rank, type_id, grp_id)
);
--Group annotation provenance
CREATE TABLE grpprop_pub (
    grpprop_pub_id serial PRIMARY KEY,
    pub_id integer NOT NULL REFERENCES pub
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grpprop_id integer NOT NULL REFERENCES grpprop
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(pub_id, grpprop_id)
);
--Group relationships
CREATE TABLE grp_relationship (
    grp_relationship_id serial PRIMARY KEY,
    value text,
    rank integer NOT NULL DEFAULT 0,
    type_id integer NOT NULL REFERENCES cvterm
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    subject_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    object_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(rank, type_id, subject_id, object_id)
);
--Group relationship provenance
CREATE TABLE grp_relationship_pub (
    grp_relationship_pub_id serial PRIMARY KEY,
    pub_id integer NOT NULL REFERENCES pub
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_relationship_id integer NOT NULL REFERENCES grp_relationship
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(pub_id, grp_relationship_id)
);
--Group relationship annotation
CREATE TABLE grp_relationship_prop (
    grpprop_id serial PRIMARY KEY,
    value text,
    rank integer NOT NULL DEFAULT 0,
    type_id integer NOT NULL REFERENCES cvterm
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_relationship_id integer NOT NULL REFERENCES grp_relationship
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(rank, type_id, grp_relationship_id)
);
--Link to analysis
CREATE TABLE analysisgrp (
    analysisgrp_id serial PRIMARY KEY,
    rawscore double precision,
    normscore double precision,
    significance double precision,
    identity double precision,
    analysis_id integer NOT NULL REFERENCES analysis
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(analysis_id, grp_id)
);
--Link to cvterm
CREATE TABLE grp_cvterm (
    grp_cvterm_id serial PRIMARY KEY,
    is_not boolean NOT NULL DEFAULT false,
    cvterm_id integer NOT NULL REFERENCES cvterm
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    pub_id integer NOT NULL REFERENCES pub
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(cvterm_id, grp_id, pub_id)
);
--Link to dbxref
CREATE TABLE grp_dbxref (
    grp_dbxref_id serial PRIMARY KEY,
    is_current boolean NOT NULL DEFAULT true,
    dbxref_id integer NOT NULL REFERENCES dbxref
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(dbxref_id, grp_id)
);
--Link to pub
CREATE TABLE grp_pub (
    grp_pub_id serial PRIMARY KEY,
    pub_id integer NOT NULL REFERENCES pub
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(pub_id, grp_id)
);
--Link to contact
CREATE TABLE grp_contact (
    grp_contact_id serial PRIMARY KEY,
    contact_id integer NOT NULL REFERENCES contact
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(contact_id, grp_id)
);
--Group publication annotation
CREATE TABLE grp_pubprop (
    grp_pubprop_id serial PRIMARY KEY,
    value text,
    rank integer NOT NULL DEFAULT 0,
    type_id integer NOT NULL REFERENCES cvterm
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_pub_id integer NOT NULL REFERENCES grp_pub
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(rank, type_id, grp_pub_id)
);
--Group membership
CREATE TABLE grpmember (
    grpmember_id serial PRIMARY KEY,
    rank integer NOT NULL DEFAULT 0,
    type_id integer NOT NULL REFERENCES cvterm
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    linking_table information_schema.sql_identifier NOT NULL,
    UNIQUE(rank, type_id, grp_id)
);
--Group member provenance
CREATE TABLE grpmember_pub (
    grpmember_pub_id serial PRIMARY KEY,
    pub_id integer NOT NULL REFERENCES pub
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grpmember_id integer NOT NULL REFERENCES grpmember
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(pub_id, grpmember_id)
);
--Link to analysis
CREATE TABLE analysisgrpmember (
    analysisgrpmember_id serial PRIMARY KEY,
    rawscore double precision,
    normscore double precision,
    significance double precision,
    identity double precision,
    analysis_id integer NOT NULL REFERENCES analysis
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grpmember_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(analysis_id, grpmember_id)
);
--Group member annotation
CREATE TABLE grpmemberprop (
    grpmemberprop_id serial PRIMARY KEY,
    value text,
    rank integer NOT NULL DEFAULT 0,
    type_id integer NOT NULL REFERENCES cvterm
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grpmember_id integer NOT NULL REFERENCES grpmember
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(rank, type_id, grpmember_id)
);
--Group member annotation provenance
CREATE TABLE grpmemberprop_pub (
    grpmemberprop_pub_id serial PRIMARY KEY,
    pub_id integer NOT NULL REFERENCES pub
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grpmemberprop_id integer NOT NULL REFERENCES grpmemberprop
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(pub_id, grpmemberprop_id)
);
--Link to cvterm
CREATE TABLE grpmember_cvterm (
    grpmember_cvterm_id serial PRIMARY KEY,
    is_not boolean NOT NULL DEFAULT false,
    cvterm_id integer NOT NULL REFERENCES cvterm
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grpmember_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    pub_id integer NOT NULL REFERENCES pub
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(cvterm_id, grpmember_id, pub_id)
);


---Group linker tables---
--Module specific membership tables
--Supplied by respective modules?

CREATE TABLE organism_grpmember (
    organism_grpmember_id serial PRIMARY KEY,
    grpmember_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    organism_id integer NOT NULL REFERENCES organism
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    linking_table information_schema.sql_identifier
      DEFAULT 'organism' CHECK (linking_table = 'organism'),
    FOREIGN KEY(grpmember_id, linking_table)
      REFERENCES grpmember(grpmember_id, linking_table),
    UNIQUE(grpmember_id)
);

CREATE TABLE feature_grpmember (
    feature_grmpmember_id serial PRIMARY KEY,
    grpmember_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    feature_id integer NOT NULL REFERENCES feature
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    linking_table information_schema.sql_identifier
      DEFAULT 'feature' CHECK (linking_table = 'feature'),
    FOREIGN KEY(grpmember_id, linking_table)
      REFERENCES grpmember(grpmember_id, linking_table),
    UNIQUE(grpmember_id)
);
