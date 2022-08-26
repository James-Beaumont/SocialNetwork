# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

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



## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE usernames RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO usernames (username, email_address) VALUES ('Jamesbeaumont26', 'jamesbeaumont26@gmail.com');
INSERT INTO usernames (username, email_address) VALUES ('LeoHetsch', 'leohetsch@hotmail.co.uk');
INSERT INTO usernames (username, email_address) VALUES ('WillO`Connell', 'WillOConnell@gmail.com');
INSERT INTO usernames (username, email_address) VALUES ('RoiDriscoll123', 'RoiDriscoll@hotmail.co.uk');

TRUNCATE TABLE timeline_posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO timeline_posts (title, content, views, username_id) VALUES ('First post', 'This is my first post ever', 15, 2);
INSERT INTO timeline_posts (title, content, views) VALUES ('James` First post', 'This is my first post ever', 25, 0);
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network < seeds_usernames.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: usernames

# Model class
# (in lib/username.rb)
class Username
end

# Repository class
# (in lib/username_repository.rb)
class UsernameRepository
end

# Model class
# (in lib/timelinePost.rb)
class TimelinePost
end

# Repository class
# (in lib/timelinePost_repository.rb)
class TimelinePostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: usernames

# Model class
# (in lib/username.rb)

class Username

  # Replace the attributes by your own columns.
  attr_accessor :id, :username, :email_address
end

class TimelinePost

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# username = username.new
# username.name = 'Jo'
# username.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: usernames

# Repository class
# (in lib/username_repository.rb)

class UsernameRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, username, email_address FROM usernames;

    # Returns an array of username objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, username, email_address FROM usernames WHERE id = $1;

    # Returns a single username object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(username, email_address)
    
    
    # INSERT INTO usernames (username, email_address) VALUES ($1, $2);


  end

  def delete(id)
    DELETE FROM usernames WHERE id = $1;
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all usernames

repo = usernameRepository.new

usernames = repo.all

usernames.length # =>  2

usernames[0].id # =>  1
usernames[0].username # =>  'Jamesbeaumont26'
usernames[0].email_address # =>  'jamesbeaumont26@gmail.com'

usernames[1].id # =>  2
usernames[1].username # =>  'LeoHetsch'
usernames[1].email_address # =>  'LeoHetsch@hotmail.co.uk'

# 2
# Get a single username

repo = usernameRepository.new

username = repo.find(1)

username.id # =>  1
username.username # =>  'Jamesbeaumont26'
username.email_address # =>  'jamesbeaumont26@gmail.com'

# 3
# Create new username

repo = usernameRepository.new

username = Username.new
username.username = 'James Beaumont the second'
username.email_address = 'jamesbeaumonthesecond@hotmail.com'

repo.create(username)

all_usernames = repo.all

all_usernames # => 'all users including james beaumont the second'
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/username_repository_spec.rb

def reset_usernames_table
  seed_sql = File.read('spec/seeds_usernames.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'usernames' })
  connection.exec(seed_sql)
end

describe usernameRepository do
  before(:each) do 
    reset_usernames_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour


<!-- END GENERATED SECTION DO NOT EDIT -->