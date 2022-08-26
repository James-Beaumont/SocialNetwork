-- Create the table without the foreign key first.
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  username text,
  email_address text
);

-- Then the table with the foreign key first.
CREATE TABLE timeline_posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
-- The foreign key name is always {other_table_singular}_id
  username_id int
);