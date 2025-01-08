class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create do
    Stripe::Customer.create({email: email, name: self.full_name})
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
