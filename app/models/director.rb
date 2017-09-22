class Director < ApplicationRecord
  # Direct associations

  belongs_to :director,
             :class_name => "Movie"

  # Indirect associations

  # Validations

end
