--Link to contact
CREATE TABLE grp_contact (
    grp_contact_id serial PRIMARY KEY,
    contact_id integer NOT NULL REFERENCES contact
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(pub_id, grp_id)
);

--Alter grpmember to track table type
ALTER TABLE grpmember
  ADD COLUMN linking_table information_schema.sql_identifier
    NOT NULL REFERENCES information_schema.tables(table_name);

--Alter xxx_grpmember tables to enforce single member design
ALTER TABLE organism_grpmember
  DROP CONSTRAINT "organism_grpmember_grpmember_id_organism_id_key",
  ADD COLUMN linking_table information_schema.sql_identifier
    DEFAULT 'organism' CHECK (linking_table = 'organism'),
  ADD FOREIGN KEY(grpmember_id, linking_table)
    REFERENCES grpmember(grpmember_id, linking_table),
  ADD UNIQUE(grpmember_id)

ALTER TABLE feature_grpmember
  DROP CONSTRAINT "feature_grpmember_grpmember_id_feature_id_key",
  ADD COLUMN linking_table information_schema.sql_identifier
    DEFAULT 'feature' CHECK (linking_table = 'feature'),
  ADD FOREIGN KEY(grpmember_id, linking_table)
    REFERENCES grpmember(grpmember_id, linking_table),
  ADD UNIQUE(grpmember_id)
