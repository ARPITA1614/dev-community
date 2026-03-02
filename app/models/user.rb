class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

 has_many :work_experiences, dependent: :destroy
 has_many :connections, dependent: :destroy

  PROFILE_TITLE=[
    "senior Ruby on Rails Developer",
    "Full Stack Ruby on Rails Developer",
    "Senior Full Stack Ruby on Rails Developer",
    "Junior Full Stack Ruby on Rails Developer",
    "Senior Java Developer",
    "Senior Front End Developer"
].freeze

 def name
    "#{first_name} #{last_name}".strip
 end

 def address
    "#{city}, #{state}, #{country}, #{pincode}"
 end

def self.ransackable_attributes(auth_object = nil)
    ["country", "city" ]
end

def self.ransackable_associations(auth_object = nil)
    []
end

def check_if_already_connected?(current_user, user)
    # self != user && !my_connection(user).present?
    current_user != user && !current_user.connections.pluck(:connected_user_id).include?(user.id)
    # !current_user.connections => current user k saare connections load krega 
    # chcek with connected user id if connected user id is present user already connected then dont show link to connect
end

def mutually_connected_ids(user)
    self.connected_user_ids.intersection(user.connected_user_ids)
end
end
