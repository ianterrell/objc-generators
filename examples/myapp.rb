require '../sqlitepo-gen'
require '../preferences-gen'

class Objects < SqlitePOGenerator
  project_name "MyApp"
  directory "myapp"
  author "Ian Terrell"
  
  persistent_object :user do |user|
    user.string :username
    user.integer :user_id
    user.enum :state, :values => [:fired, :fired, :super_fired]
    user.belongs_to :group
    user.belongs_to :group, :name => :another_group
  end
  
  persistent_object :group do |group|
    group.string :title
    group.string :description
    group.integer :group_id
    group.method "+(NSString *)helloWorld" do <<-OBJC
      return @"Hello World!";
      OBJC
    end
  end
end  

class MyPreferences < PreferencesGenerator
  project_name "MyApp"
  directory "myapp"
  author "Ian Terrell"
  
  preferences do |p|
    p.string :username
    p.string :password
    p.bulk_setter_for :username, :password
    p.method "+(NSString *)helloWorld" do <<-OBJC
      return @"Hello World!";
      OBJC
    end
  end
end