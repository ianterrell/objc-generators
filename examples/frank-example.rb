require '../frankorm-gen'

class Objects < FrankORMGenerator
  project_name "FrankApp"
  directory "frankapp"
  author "Ian Terrell"
  
  frank_object :user do |user|
    user.string :username
    user.string :password
    user.number :awesomeness_code
  end
end  
