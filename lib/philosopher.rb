require_relative 'sql_object'

class Philosopher < SQLObject

  belongs_to :school, foreign_key: :school_id
  has_many :quotes, foreign_key: :philosopher_id

  finalize!
end
