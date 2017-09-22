class User < ApplicationRecord
  # Direct associations

  has_many   :boomarks,
             :dependent => :destroy

  # Indirect associations

  has_many   :movies,
             :through => :boomarks,
             :source => :movie

  # Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
