# wORMhole

wORMhole is a fun, philosophy-based quiz game featuring a custom object-relational mapping (ORM).
The game is written in Ruby and uses the SQLite3 gem to store quotes, philosophers, and 'schools' of thought in a database.

## ORM

The underlying tech behind wORMhole is its object-relational mapping, allowing entries in the database to be manipulated as Ruby objects.    

Similar to Rails' ActiveRecord ORM, each database table in wORMhole is modeled as a Ruby class that inherits from `SQLObject`.
Each instance of `SQLObject` represents a (potential) entry in the database. Using core concepts from meta-programming, the `SQLObject`
class dynamically generates getter and setter methods for columns in the database:

```ruby
self.columns.each do |col|
  define_method("#{col}") { self.attributes[col] }
  define_method("#{col}=") { |col_name| self.attributes[col] = col_name }
end
```

The `associatable` module, which is mixed into `SQLObject`, dynamically creates instance methods to capture the relationships between tables in the database:

```ruby
def has_one_through(name, through_name, source_name)
  through_options = self.assoc_options[through_name]

  define_method(name) do
    source_options = through_options.model_class.assoc_options[source_name]

    source_foreign_key_val = through_options.model_class
    .where(through_options.primary_key => self.send(through_options.foreign_key))
    .first
    .send(source_name)
    .send(source_options.primary_key)

    source_options.model_class.where(source_options.primary_key => source_foreign_key_val).first
  end
end
```

## Gameplay

Gameplay is simple! Simply run `bundle install` in the root directory, then navigate to the `lib` folder and run `ruby wormhole.rb`.

Happy playing!

## Using wORMhole in your own project

If you just want to use wORMhole's ORM in your own project, follow the instructions below. Note that the exact file structure may differ depending on your project.
1. Clone this repository into your project's root directory
2. Ensure that the `sqlite3` and `activesupport` gems are in your original project's gemfile
  * Remove the gemfile and gemfile.lock from the wORMhole repo
  * Run bundle install in your root directory
3. Create a new directory (e.g. `orm`) in the `wormhole/` directory
  * Move the `wORMhole/lib/modules` directory into this new directory
  * Also move `wORMhole/lib/sql_object.rb`, `wORMhole/lib/db_connection.rb`, and `wORMhole/philosophers.sql` into this new directory
4. In `wORMhole/lib` there should now only be several `.rb` files. Replace `philosopher.rb`, `quote.rb`, and `school.rb` with your own model files
  * Add any necessary associations (use Rails syntax, e.g. `belongs_to`)
  * IMPORTANT: Remember to `require_relative 'sql_object'` at the top of your model files and to call `finalize!` at the end of your model class definitions. This will allow `sql_object.rb` to dynamically generate all the necessary column and association methods
5. Replace `wormhole.rb` with your own app file (e.g. `app.rb`)
  * Note: This step may be more complicated depending on the file structure of your app
6. In the `orm` directory, edit the `philosophers.sql` file to create the seeds for your own database (I assume they will not be philosophers!)
  * You will probably want to change the name of this file as well to reflect your own database
7. At the top of `orm/db_connection.rb`, change the the file constants (e.g. `PHILOSOPHERS_SQL_FILE`) to reflect your own file structure
  * You will also want to change the file path
  * Make sure to update all references to these variables within thise file too!


That should do it! If you have are having any difficulties, you can check out [Benjamin Berman's](https://github.com/bdberm) [Track's Repo](https://github.com/bdberm/tracks), which contains a demo called "Dogs" that utilizes an MVC framework that Ben built, as well as wORMhole's ORM.   
