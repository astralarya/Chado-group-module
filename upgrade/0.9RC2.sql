--Link to contact
CREATE TABLE grp_contact (
    grp_contact_id serial PRIMARY KEY,
    contact_id integer NOT NULL REFERENCES contact
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(pub_id, grp_id)
);
