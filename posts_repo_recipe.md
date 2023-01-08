# posts/user_accounts Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Tables

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `posts`*

```
# EXAMPLE

Table: posts

Columns:
title | content | views | user_account_id

```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{posts}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 1', 'content 1', '100', '1');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 2', 'content 2', '200', '3');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 3', 'content 3', '300', '2');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 4', 'content 4', '300', '3');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 5', 'content 5', '100', '2');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 6', 'content 6', '200', '1');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('title 7', 'content 7', '400', '1');

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network < seeds_{posts}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)
class Post
end

# Repository class
# (in lib/post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: posts

# Model class
# (in lib/post.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :title, :content, :views, :user_account_id 

end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# post = Post.new
# post.title = 'title 1'
# post.title 
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: posts

# Repository class
# (in lib/post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query: 
    # SELECT id, title, content, views, user_account_id FROM posts;

    # Returns an array of Post objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT title, content, views, user_account_id FROM posts WHERE id = $1;

    # Returns a single Post object.
  end

  # Add more methods below for each operation you'd like to implement.
  
  # Creates a new record by its ID
  # One argument: a new model object Post
  def create(post)
    # Executes the SQL query:
    # INSERT INTO posts (title, content, views, user_account_id)  VALUES ($1, $2, $3, $4);

    # Does not return anything (returns nil)
  end

  # def update(post)
  # end

  # Deletes a record by its ID
  # One argument: the id (number)
  def delete(id)
     # Executes the SQL query:
     # DELETE FROM posts (title, content, views, user_account_id)  WHERE id = $1);

     # Does not return anything (returns nil)
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all # => an array of hashes

posts.length # =>  7

posts[0].id # =>  '1'
posts[0].title # =>  'title 1'
posts[0].content # =>  'content 1'
posts[0].views # =>  '100'
posts[0].user_account_id #=> '1'

posts[1].id # =>  '2'
posts[1].title # =>  'title 2'
posts[1].content # =>  'content 2'
posts[1].views # =>  '200'
posts[1].user_account_id #=> '3'



# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1) 

post.id # =>  1
post.title # =>  'title 1'
post.views # =>  '100'
post.content  # =>  'content 1'
post.user_account_id  # =>  '1'

# 3
# Create a new post

repo = PostRepository.new

post = Post.new
post.title = 'title 8'
post.content = 'content 8'
post.views = '350'
post.user_account_id = '2'

repo.create(post) # => nil

repo.all.length # => 8
repo.all.last.title # => 'title 8'
repo.all.last.content  # => 'content 8'
repo.all.last.views  # => '350'
repo.all.last.user_account_id # => '2'

# 4
# Delete a post by id

repo = PostRepository.new
repo.delete(1) # => nil
repo.all.length # => 6


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/post_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_posts.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'posts' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->