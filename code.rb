class MySuperClass
  def my_method
    puts :my_method
  end
end

class MyClass < MySuperClass
end

my_obj = MyClass.new

e = class << my_obj
  self
end

e.instance_methods
e.superclass

class_e = class << MyClass
  self
end
class_e.superclass
superclass_e = class << MySuperClass
  self
end

############################
# Trying to use class_evala
############################

# attempt 1
module MyModule
  def my_method
    puts :in_my_method
  end
end

class << self
  ...

  self.class_eval do
    include MyModule
  end
end

# attempt 2
module MyModule
  def my_method
    puts :in_my_method
  end
end

class << self
  ...

  self.instance_eval do
    include MyModule
  end
end

# attempt 3
module MyModule
  def my_method
    puts :in_my_method
  end
end

class << self
  ...

  self.instance_eval do
    extend MyModule
  end
end

# attempt 4
module MyModule
  def self.my_method
    puts :in_my_method
  end
end

class << self
  ...

  self.class_eval do
    extend MyModule
  end
end


############################
# Lets test self
############################

MyClass.class_eval do
  self
end
MyClass.instance_eval do
  self
end


m = MyClass.new
m.class_eval do
  self
end
m.instance_eval do
  self
end

# instance_eval on an obj and self
m.instance_eval do
  def self.hi
    puts :hi
  end
end
m.instance_eval do
  def hello
    puts :hello
  end
end

m.singleton_methods
[:hi, :hello]

# class_eval and self
MyClass.class_eval do
  def bye
    puts :bye
  end
end
MyClass.class_eval do
  def self.later
    puts :later
  end
end

# Now lets mess it up
m.class_eval do
  def fred
    puts :fred_is_that_you?
  end
end
m.fred
my_obj.fred

### add an instance mehtod to the class? good show
### so same as instance_eval then

m.class_eval do
  def self.bob
    puts :bob?
  end
end
m.bob

e = class << m
  self
end
e.bob

######################
# Class methods = Singleton methods
######################
def MyClass.my_method
  puts :my_method
end

class MyClass
  def self.my_method
    puts :my_method
  end
end

class MyClass
  class << self
    def my_method
      puts :my_method
    end
  end
end

######################
# include and extend
######################
module MyModule
  def self.my_module_method
    puts :my_module_method
  end

  def my_method
    puts :my_method
  end
end

class MyClass
  include MyModule # instance methods => instance methods
  extend MyModule # instance methods => class methods
end
