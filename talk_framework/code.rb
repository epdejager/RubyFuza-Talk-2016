############################
# Ancestors chain
############################

class MySuperClass
  def my_method
    puts :my_method
  end
end

class MyClass < MySuperClass
end

MyClass.ancestors

############################
# Eigenclasses
############################

my_obj = MyClass.new

e = class << my_obj
  self
end

e.instance_methods.first
e.superclass

###

e = my_obj.singleton_class

###

class << my_obj
  def my_obj_method
    puts :my_obj_method
  end
end

my_obj.singleton_methods

############################
# Eigenclasses of Classes
############################

class_e = class << MyClass
  self
end

class_e.superclass

superclass_e = class << MySuperClass
  self
end

############################
# Lets mix evals - SELF
############################

MyClass.instance_eval do
  self
end

m = MyClass.new
m.class_eval do
  self
end

############################
# Lets mix evals - METHODS
############################
MyClass.instance_eval do
  def hi
    puts :hi
  end
end

MyClass.singleton_methods

MyClass.instance_eval do
  def self.bye
    puts :bye
  end
end

MyClass.singleton_methods

###

m.class_eval do
  def fred
    puts :fred_is_that_you?
  end
end

m.fred
MyClass.new.fred

m.singleton_methods

###

m.class_eval do
  def self.bob
    puts :bob?
  end
end

m_e = class << m
  self
end
m_e.bob

m_e.singleton_methods

############################
############################

############################
# No surprises
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
# Class and Instance Eval no Surprises
######################

# instance method
MyClass.class_eval do
  def bye
    puts :bye
  end
end

# class method
MyClass.class_eval do
  def self.later
    puts :later
  end
end


m = MyClass.new

# singleton method
m.instance_eval do
  def hello
    puts :hello
  end
end

# singleton method
m.instance_eval do
  def self.hi
    puts :hi
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

######################
# Include in Eigenclass
######################

class MyClass
  blah blah blah
  ...
  class << self
    blah blah
    blah blah
    ...
    include MyModule
    ...
    blah
  end
  blah
end
