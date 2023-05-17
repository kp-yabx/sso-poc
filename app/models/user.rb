class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum create_type: %w(manual saml)

  attr_accessor :skip_password_validation

  protected

  def password_required?
    return false if skip_password_validation
    super
  end
end
