class AdminUser < ApplicationRecord
  role_based_authorizable
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable,
           :recoverable, :rememberable, :validatable

 def role_names_str
    roles = ''
    self.roles.each_with_index do | role, i |
      roles += role.name
      roles += ", " unless i == self.roles.length-1
    end
    return roles
  end
  
  def role_ids
    roles = []
    self.roles.each do | role |
      roles << role.id
    end
    return roles
  end
end
