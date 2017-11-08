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
