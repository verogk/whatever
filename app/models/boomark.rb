class Boomark < ApplicationRecord
  # Direct associations

  belongs_to :user

  belongs_to :movie

  # Indirect associations

  # Validations

end
