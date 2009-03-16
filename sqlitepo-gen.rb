# ----------------------------------------------------------------------
# Original Version: (c) 2009 Ian Terrell (ian.terrell@gmail.com)
# ----------------------------------------------------------------------
# This code may be used without restriction in any software, commercial,
# free, or otherwise. There are no attribution requirements, and no
# requirement that you distribute your changes, although bugfixes and 
# enhancements are welcome.
# 
# If you do choose to re-distribute the source code, you must retain the
# copyright notice and this license information. I also request that you
# place comments in to identify your changes.
# ----------------------------------------------------------------------

require 'erb'
require 'fileutils'
require 'rubygems'
require 'activesupport'

class SqlitePO
  attr_accessor :name, :fields
  
  def initialize(name)
    @name = name.to_s.camelize
    @fields = []
  end
  
  [:string, :integer].each do |field_type|
    define_method field_type do |field_name|
      @fields << {:type => self.class.objc_type(field_type), :name => field_name.to_s.camelize(:lower) }
    end
  end
  
  def field_names
    @fields.map { |field| field[:name] }
  end
    
  def self.objc_type(type)
    case type
    when :integer
      "NSInteger "
    when :string
      "NSString *"
    end
  end
end

class SqlitePOGenerator
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
  
  def self.persistent_object(object_name)
    object = SqlitePO.new object_name
    yield(object)
    generate_files(object)
  end

  def self.generate_files(object)
    template_files = `ls #{File.dirname(__FILE__)}/sqlitepo-templates`.split(/\n/)
    template_files.each do |template_file|
      file = File.new "#{File.dirname(__FILE__)}/sqlitepo-templates/#{template_file}", 'r'
      template = ERB.new file.read, nil, "-"
      file.close
      
      suffix = template_file.split('.').pop
      file = File.new File.join(@directory, "#{object.name}.#{suffix}"), 'w'
      file << template.result(binding)
      file.close
    end
  end
end