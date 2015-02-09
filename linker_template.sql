CREATE TABLE FOO_grpmember (
    FOO_grmpmember_id serial PRIMARY KEY,
    grpmember_id integer NOT NULL REFERENCES grp
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    FOO_id integer NOT NULL REFERENCES feature
      ON UPDATE CASCADE ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED,
    linking_table information_schema.sql_identifier
      DEFAULT 'FOO' CHECK (linking_table = 'FOO'),
    FOREIGN KEY(grpmember_id, linking_table)
      REFERENCES grpmember(grpmember_id, linking_table),
    UNIQUE(grpmember_id)
);
