require 'erb'
require 'fileutils'
require 'rubygems'
require 'activesupport'

class BaseGenerator
  def initialize
    @directory = "."
  end
  
  def self.directory(directory)
    @directory = directory
    FileUtils.mkdir @directory unless File.directory? @directory
  end
  
  def self.author(author)
    @author = author
  end
  
  def self.project_name(project_name)
    @project_name = project_name
  end
end

class BaseGeneratorObject
  attr_reader :methods
  def initialize
    @methods = []
  end
  def method(signature)
    code = yield
    @methods << {:signature => signature, :code => code}
  end
end

class ObjC
  def self.type_for(type)
    case type
    when :integer
      "NSInteger "
    when :string
      "NSString *"
    end
  end
end