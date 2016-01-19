class MySuperClass
  def my_method
    puts :my_method
  end
end

class MyClass < MySuperClass
end

MyClass.ancestors


my_obj = MyClass.new

e = class << my_obj
  self
end

e.instance_methods.first
e.superclass

class << my_obj
  def my_obj_method
    puts :my_obj_method
  end
end
my_obj.singleton_methods


class_e = class << MyClass
  self
end

class_e.superclass

superclass_e = class << MySuperClass
  self
end

############################
# Class and Instance no surprises
############################

MyClass.class_eval do
  self
end

m = MyClass.new
m.instance_eval do
  self
end

MyClass.class_eval do
  def bye
    puts :bye
  end
end

m.bye
MyClass.new.bye


m.instance_eval do
  def hello
    puts :hello
  end
end

m.singleton_methods

MyClass.class_eval do
  def self.later
    puts :later
  end
end

MyClass.singleton_methods

m.instance_eval do
  def self.hi
    puts :hi
  end
end

m.singleton_methods
[:hi, :hello]

############################
# Now lets mix - SELF
############################

MyClass.instance_eval do
  self
end

m.class_eval do
  self
end


############################
# Now lets mix - METHODS
############################
MyClass.instance_eval do
  def sup
    puts :sup
  end
end

MyClass.singleton_methods

MyClass.instance_eval do
  def self.yo
    puts :yo
  end
end

MyClass.singleton_methods



m.class_eval do
  def fred
    puts :fred_is_that_you?
  end
end

m.fred
MyClass.new.fred

### add an instance method to the class? good show
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
# Extend
######################

module MyModule
  def my_method
    puts :in_my_method
  end
end

obj = Object.new
obj.extend MyModule
obj.my_method

#########################################
# Slides Code
#########################################
######################
# Initial Confustion
######################

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

