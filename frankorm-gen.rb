require "#{File.dirname(__FILE__)}/base-gen"

class FrankObject < BaseGeneratorObject
  attr_accessor :name, :fields, :class_references, :enums
  
  def initialize(name)
    super()
    @name = name.to_s.camelize
    @fields = []
    @class_references = []
    @enums = []
  end
  
  [:string, :number].each do |field_type|
    define_method field_type do |field_name|
      @fields << { :type => ObjC.type_for(field_type), :name => field_name.to_s.camelize(:lower) }
    end
  end
  
  def enum(field_name, options={})
    raise "Needs values!" unless options.has_key? :values
    name = options[:name] ? options[:name].to_s.camelize : "#{@name}#{field_name.to_s.camelize}"
    @fields << { :type => "#{name} ", :name => field_name.to_s.camelize(:lower) }
    @enums << { name => options[:values].uniq.map{|x|x.to_s.camelize} }
  end
  
  def belongs_to(object, options={})
    @class_references << object.to_s.camelize unless @class_references.include?(object.to_s.camelize)
    name = options[:name] || object
    @fields << { :type => "#{object.to_s.camelize} *", :name => name.to_s.camelize(:lower) }
  end
  
  def field_names
    @fields.map { |field| field[:name] }
  end
  
  def table_name
    self.name.underscore.pluralize
  end
  
  def self.fmdb_column_value(type, name)
    case type
    when "NSNumber *"
      %{[NSNumber numberWithInt:[rs intForColumn:@"#{name}"]]}
    when "NSString *"
      %{[rs stringForColumn:@"#{name}"]}
    end
  end
end

class FrankORMGenerator < BaseGenerator  
  def self.frank_object(object_name)
    object = FrankObject.new object_name
    yield(object)
    generate_files(object)
    
    # @objects ||= []
    # @objects << object
  end

  def self.generate_files(object)
    template_files = `ls #{File.dirname(__FILE__)}/frankorm-templates`.split(/\n/)
    template_files.each do |template_file|
      file = File.new "#{File.dirname(__FILE__)}/frankorm-templates/#{template_file}", 'r'
      template = ERB.new file.read, nil, "-"
      file.close
      
      suffix = template_file.split('.').pop
      file = File.new File.join(@directory, "#{object.name}.#{suffix}"), 'w'
      file << template.result(binding)
      file.close
    end
  end
  
  # def self.generate_schema
  #   file = File.new "#{File.dirname(__FILE__)}/frankorm-templates/schema.sql", 'r'
  #   template = ERB.new file.read, nil, "-"
  #   file.close
  #   
  #   puts "hi!"
  #   puts @objects
  #   file = File.new File.join(@directory, "schema.sql"), 'w'
  #   file << template.result(binding)
  #   file.close
  # end
end