require_relative 'sql_object'

class School < SQLObject

  has_many :philosophers, foreign_key: :school_id

  finalize!
end
