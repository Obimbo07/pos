class Worker < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_and_belongs_to_many :services
  has_and_belongs_to_many :booking_histories
  has_many :worker_commissions
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "current_sign_in_at", "current_sign_in_ip", "email", "encrypted_password", "id", "id_value", "last_sign_in_at", "last_sign_in_ip", "name", "phone", "remember_created_at", "reset_password_sent_at", "reset_password_token", "services", "sign_in_count", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["booking_histories", "services", "worker_commissions"]
  end
end
