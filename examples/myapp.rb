require '../sqlitepo-gen'

class Objects < SqlitePOGenerator
  project_name "MyApp"
  directory "myapp"
  author "Ian Terrell"
  
  persistent_object :user do |user|
    user.string :username
    user.integer :user_id
    user.belongs_to :group
    user.belongs_to :group, :name => :another_group
  end
  
  persistent_object :group do |group|
    group.string :title
    group.string :description
    group.integer :group_id
  end
end