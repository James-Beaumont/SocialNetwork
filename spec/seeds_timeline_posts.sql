-- TRUNCATE TABLE timeline_posts RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE accounts, timeline_posts RESTART IDENTITY;
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO accounts (username, email_address) VALUES ('Jamesbeaumont26', 'jamesbeaumont26@gmail.com');
INSERT INTO accounts (username, email_address) VALUES ('LeoHetsch', 'leohetsch@hotmail.co.uk');
INSERT INTO accounts (username, email_address) VALUES ('WillO`Connell', 'WillOConnell@gmail.com');
INSERT INTO accounts (username, email_address) VALUES ('RoiDriscoll123', 'RoiDriscoll@hotmail.co.uk');

INSERT INTO timeline_posts (title, content, views, username_id) VALUES ('First post', 'This is my first post ever', 15, 2);
INSERT INTO timeline_posts (title, content, views, username_id) VALUES ('James` First post', 'This is my first post ever', 25, 1);

