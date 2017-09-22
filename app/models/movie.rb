class Movie < ApplicationRecord
  # Direct associations

  has_many   :boomarks,
             :dependent => :destroy

  has_many   :castings,
             :dependent => :destroy

  has_many   :directors,
             :foreign_key => "director_id",
             :dependent => :destroy

  # Indirect associations

  # Validations

end
