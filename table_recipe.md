# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.
```

```
Nouns:

username, email address, info, timeline, title, content, views
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| users information     | id, username, email address
| timeline              | title, content, views

1. Name of the first table (always plural): `users information` 

    Column names: `id`, `username`, `email address`

2. Name of the second table (always plural): `timeline posts` 

    Column names: `id`, `post title`, `content`, `views`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```


Table: User information
id: SERIAL
username: text
email address: text

Table: Timeline posts
id: SERIAL
title: text
content: text
view: int
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
# EXAMPLE

1. Can one username have many timeline posts? YES
2. Can one timeline post have many usernames? NO

-> Therefore,
-> An username HAS MANY posts
-> An posts BELONGS TO an username

-> Therefore, the foreign key is on the posts table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: albums_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE usernames (
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
  username_id int,
  constraint fk_usernames foreign key(username_id)
    references usernames(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 social_network < socialnetwork.sql
```