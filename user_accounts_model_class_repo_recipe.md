# user_accounts Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Tables

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `user_accounts`*

```
# EXAMPLE

Table: user_accounts

email_address | username 
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{user_accounts}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (email_address, username) VALUES ('a_user@gmail.com', 'user A');
INSERT INTO user_accounts (email_address, username) VALUES ('b_userB@yahoo.com', 'user B');
INSERT INTO user_accounts (email_address, username) VALUES ('c_userC@hotmail.com', 'user C');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 social_network < seeds_{user_accounts}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: user_accounts

# Model class
# (in lib/user_account.rb)
class UserAccount
end

# Repository class
# (in lib/user_account_repository.rb)
class UserAccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: user_accounts

# Model class
# (in lib/user_accounts.rb)

class UserAccount

  # Replace the attributes by your own columns.
  attr_accessor :email_address, :username

end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# user_account = UserAccount.new
# user_account.email_address = 'a_user@gmail.com'
# user_account.email_address 
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: user_accounts

# Repository class
# (in lib/user_account_repository.rb)

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query: 
    # SELECT id, email_address, username FROM user_accounts;

    # Returns an array of UserAccount objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email_address, username FROM user_accounts WHERE id = $1;

    # Returns a single UserAccount object.
  end

  # Add more methods below for each operation you'd like to implement.
  
  # Creates a new record by its ID
  # One argument: a new model object UserAccount
  def create(user_account)
    # Executes the SQL query:
    # INSERT INTO user_accounts (email_address, username)  VALUES ($1, $2);

    # Does not return anything (returns nil)
  end

  # def update(user_account)
  # end

  # Deletes a record by its ID
  # One argument: the id (number)
  def delete(id)
     # Executes the SQL query:
     # DELETE FROM user_accounts (email_address, username)  WHERE id = $1);

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
# Get all user_accounts

repo = UserAccountRepository.new

user_accounts = repo.all # => an array of hashes

user_accounts.length # =>  3

user_accounts[0].id # =>  '1'
user_accounts[0].email_address # =>  'a_user@gmail.com'
user_accounts[0].username # => 'user A'


user_accounts[1].id # =>  '2'
user_accounts[1].email_address # =>  'b_user@gmail.com'
user_accounts[1].username # =>  'user B'




# 2
# Get a single user_account

repo = UserAccountRepository.new

user_account = repo.find(3) 

user_account.id # =>  3
user_account.email_address # =>  'c_userC@hotmail.com'
user_account.username # =>  'user C'

# 3
# Create a new user_account

repo = UserAccountRepository.new

user_account = UserAccount.new
user_account.email_address = 'd_user@microsoft.com'
user_account.username = 'user D'

repo.create(user_account) # => nil

repo.all.length # => 4
repo.all.last.email_address # => 'd_user@microsoft.com'
repo.all.last.username  # => 'user D'

# 4
# Delete an user account by id

repo = UserAccountRepository.new
repo.delete(1) # => nil
repo.all.length # => 2


# Add more examples for each method
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_account_repository_spec.rb


```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->