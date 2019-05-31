require_relative("../db/sql_runner")


class Star

  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @id = options["id"].to_i if options["id"]
  end

#CREATE
  def save
    sql = "INSERT INTO stars (
      first_name,
      last_name
      )
      VALUES ($1, $2)
      RETURNING * "
      values = [@first_name, @last_name]
      result = SqlRunner.run(sql, values).first
      @id = result["id"].to_i
  end

#UPDATE
  def update()
    sql = "UPDATE stars SET
    (
      first_name, last_name
    )
    =
    (
      $1, $2
    ) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

#READ
  def self.all()
    sql = "SELECT * FROM stars"
    stars = SqlRunner.run(sql)
    result = stars.map {|star| Star.new(star)}
    return result

  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

end
