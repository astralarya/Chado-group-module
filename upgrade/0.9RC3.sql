--Alter grpmember supporting tables to use proper foreign key
ALTER TABLE analysisgrpmember
  DROP CONSTRAINT "analysisgrpmember_grpmember_id_fkey",
  ADD FOREIGN KEY(grpmember_id)
    REFERENCES grpmember(grpmember_id);

ALTER TABLE grpmember_cvterm
  DROP CONSTRAINT "grpmember_cvterm_grpmember_id_fkey",
  ADD FOREIGN KEY(grpmember_id)
    REFERENCES grpmember(grpmember_id);

--Alter xxx_grpmember linker tables to use proper foreign key
ALTER TABLE organism_grpmember
  DROP CONSTRAINT "organism_grpmember_grpmember_id_fkey",
  ADD FOREIGN KEY(grpmember_id)
    REFERENCES grpmember(grpmember_id);

ALTER TABLE feature_grpmember
  DROP CONSTRAINT "feature_grpmember_grpmember_id_fkey",
  ADD FOREIGN KEY(grpmember_id)
    REFERENCES grpmember(grpmember_id);
