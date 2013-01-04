class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :group_name

  # Test for group membership
  def super?
    group_name == 'super'
  end

  # Test for group membership
  def admin?
    super? or group_name == 'admin'
  end

  # Test for group membership
  def operator?
    admin? or group_name == 'operator'
  end
end
