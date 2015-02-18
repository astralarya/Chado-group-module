--Link to contact
CREATE TABLE grp_contact (
    grp_contact_id serial PRIMARY KEY,
    contact_id integer NOT NULL REFERENCES contact
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    grp_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    UNIQUE(contact_id, grp_id)
);

--Alter grpmember to track table type
ALTER TABLE grpmember
  ADD COLUMN linking_table information_schema.sql_identifier NOT NULL,
  ADD UNIQUE(grpmember_id, linking_table);


--Alter xxx_grpmember tables to enforce single member design
--Alter xxx_grpmember linker tables to use proper foreign key
ALTER TABLE organism_grpmember
  DROP CONSTRAINT "organism_grpmember_grpmember_id_organism_id_key",
  ADD COLUMN linking_table information_schema.sql_identifier
    DEFAULT 'organism' CHECK (linking_table = 'organism'),
  ADD FOREIGN KEY(grpmember_id, linking_table)
    REFERENCES grpmember(grpmember_id, linking_table),
  ADD UNIQUE(grpmember_id),
  DROP CONSTRAINT "organism_grpmember_grpmember_id_fkey",
  ADD FOREIGN KEY(grpmember_id)
    REFERENCES grpmember(grpmember_id);

ALTER TABLE feature_grpmember
  DROP CONSTRAINT "feature_grpmember_grpmember_id_feature_id_key",
  ADD COLUMN linking_table information_schema.sql_identifier
    DEFAULT 'feature' CHECK (linking_table = 'feature'),
  ADD FOREIGN KEY(grpmember_id, linking_table)
    REFERENCES grpmember(grpmember_id, linking_table),
  ADD UNIQUE(grpmember_id),
  DROP CONSTRAINT "feature_grpmember_grpmember_id_fkey",
  ADD FOREIGN KEY(grpmember_id)
    REFERENCES grpmember(grpmember_id);

--Alter grpmember supporting tables to use proper foreign key
ALTER TABLE analysisgrpmember
  DROP CONSTRAINT "analysisgrpmember_grpmember_id_fkey",
  ADD FOREIGN KEY(grpmember_id)
    REFERENCES grpmember(grpmember_id);

ALTER TABLE grpmember_cvterm
  DROP CONSTRAINT "grpmember_cvterm_grpmember_id_fkey",
  ADD FOREIGN KEY(grpmember_id)
    REFERENCES grpmember(grpmember_id);

