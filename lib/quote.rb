require_relative 'sql_object'

class Quote < SQLObject

  belongs_to :philosopher, foreign_key: :philosopher_id
  has_one_through :school, :philosopher, :school

  finalize!
end
