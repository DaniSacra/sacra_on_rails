# Sacra Framework

A lightweight Ruby framework inspired by Rails, built for learning Object-Oriented Programming and Metaprogramming concepts.

## 🎯 Purpose

This project was developed as a learning exercise to understand the core concepts behind Ruby on Rails, focusing on:

- **Object-Oriented Programming** principles
- **Metaprogramming** techniques in Ruby
- **Active Record** pattern implementation
- **Testing framework** creation
- **Ruby internals** and advanced features

## 🚀 Features

### Base Model
- **Active Record-like** ORM functionality
- **Dynamic attribute** creation and access
- **Validation** system for required fields
- **Callbacks** support (before_save, after_save, etc.)
- **Class methods** like `all`, `count`, `find_by`
- **Instance methods** like `save`, `new_record?`

### Testing Framework
- **Custom test case** implementation
- **Assertion methods** (assert, assert_equal, assert_nil, etc.)
- **Test reporting** with success/failure tracking
- **Rails-like** test syntax and structure

## 📁 Project Structure

```
sacra_framework/
├── lib/
│   └── sacra_on_rails/
│       ├── base_model.rb      # Core ORM functionality
│       ├── test_case.rb       # Testing framework
│       └── test_helper.rb     # Test utilities
├── specs/
│   └── user_spec.rb          # Example test suite
├── user.rb                   # Example model
├── run_tests.rb              # Test runner
└── README.md
```

## 🔧 Usage

### Creating a Model

```ruby
require_relative 'lib/sacra_on_rails'

class User < SacraOnRails::BaseModel
  # Define required attributes
  validates :name, :email, :password, presence: true
  
  # Add callbacks
  before_save :reverse_password
  
  private
  
  def reverse_password
    self.password = password.reverse if password
  end
end
```

### Using the Model

```ruby
# Create a new user
user = User.new(name: "John Doe", email: "john@example.com", password: "secret123")

# Save to "database"
user.save

# Query methods
User.count                    # => 1
User.all                      # => [#<User:0x...>]
User.find_by(name: "John Doe") # => #<User:0x...>
```

### Writing Tests

```ruby
require_relative '../lib/sacra_on_rails'
require_relative '../user'

class UserSpec < SacraOnRails::TestCase
  def self.run
    test "Validates required attributes" do
      user = User.new(email: "test@email.com", password: "123456")
      assert !user.save, "User without name should not be saved"
    end
    
    test "Saves with all required attributes" do
      user = User.new(name: "John", email: "john@email.com", password: "123456")
      assert user.save, "User with all attributes should be saved"
    end
  end
end
```

## 🧪 Running Tests

```bash
ruby run_tests.rb
```

## 🎓 Learning Objectives

This framework demonstrates:

1. **Metaprogramming**: Dynamic method creation, `method_missing`, `define_method`
2. **Class Variables**: Storing data at class level (`@@records`)
3. **Callbacks**: Implementing before/after hooks
4. **Validation**: Building a simple validation system
5. **Testing**: Creating a custom testing framework
6. **Ruby Internals**: Understanding how Rails-like frameworks work

## 🔍 Key Implementation Details

### Dynamic Attributes
```ruby
def method_missing(method_name, *args, &block)
  if method_name.to_s.end_with?('=')
    attribute_name = method_name.to_s.chomp('=')
    instance_variable_set("@#{attribute_name}", args.first)
  else
    instance_variable_get("@#{method_name}")
  end
end
```

### Validation System
```ruby
def self.validates(*attributes, presence: false)
  @validations ||= {}
  attributes.each do |attr|
    @validations[attr] = { presence: presence }
  end
end
```

### Callback System
```ruby
def self.before_save(method_name)
  @before_save_callbacks ||= []
  @before_save_callbacks << method_name
end
```

## 🚧 Limitations

This is a learning project and has several limitations compared to Rails:

- No database persistence (uses in-memory storage)
- Limited validation types
- Basic callback system
- No associations or migrations
- Simple testing framework

## 📚 Educational Value

Perfect for developers who want to understand:

- How Rails' Active Record works under the hood
- Ruby metaprogramming techniques
- Object-oriented design patterns
- Building domain-specific languages (DSL)
- Testing framework architecture

## 🤝 Contributing

This is a learning project, but suggestions and improvements are welcome!

## 📄 License

This project is for educational purposes only.