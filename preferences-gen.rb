require "#{File.dirname(__FILE__)}/base-gen"

class Preferences
  attr_accessor :name, :fields, :bulk_setters
  
  def initialize
    @fields = []
    @types = {}
    @bulk_setters = []
  end
  
  def string(field_name)
    @fields << { :type => ObjC.type_for(:string), :name => field_name.to_s.camelize(:lower), :symbol_type => :string }
    @types[field_name] = ObjC.type_for(:string)
  end
  
  def bulk_setter_for(*args)
    @bulk_setters << args.map { |x| {:type => @types[x], :name => x.to_s.camelize(:lower)} }
  end

  def type_for_key(type)
    "#{type}ForKey"
  end
  
  def setter_for_key(type)
    if type.ends_with? "*"
      "setObject"
    else
      "set#{type}".rtrim
    end
  end
  
  def is_set?(field)
    case field[:symbol_type]
    when :string:
       %~(([Preferences #{field[:name]}] == nil) || ([[Preferences #{field[:name]}] isEqualToString:@""]))~
    end
  end
  
  def bulk_setter_name_for(setters)
    "set" + setters.map{|setter| "#{setter[:name].capitalize}:(#{setter[:type]})#{setter[:name]}"}.join(" and")
  end
end

class PreferencesGenerator < BaseGenerator  
  def self.preferences
    object = Preferences.new
    yield(object)
    generate_files(object)
  end

  def self.generate_files(object)
    template_files = `ls #{File.dirname(__FILE__)}/preferences-templates`.split(/\n/)
    template_files.each do |template_file|
      file = File.new "#{File.dirname(__FILE__)}/preferences-templates/#{template_file}", 'r'
      template = ERB.new file.read, nil, "-"
      file.close
      
      file = File.new File.join(@directory, template_file), 'w'
      file << template.result(binding)
      file.close
    end
  end
end