require_relative('../db/sql_runner')
require_relative('movie')
require_relative('star')

class Casting

  attr_reader :id, :movie_id, :star_id
  attr_accessor :fee

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id']
    @star_id = options['star_id']
    @fee = options['fee'].to_i
  end

  def save()
    sql = "INSERT INTO castings
    (
      movie_id, star_id, fee
      )
    VALUES
    (
      $1, $2, $3
      ) RETURNING * "
      values = [@movie_id, @star_id, @fee]
      result = SqlRunner.run(sql, values).first
      @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE castings SET fee = $1 WHERE id = $2"
    values = [@fee, @id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM castings"
    result = SqlRunner.run(sql)
    castings = result.map{|casting| Casting.new(casting)}
    return castings
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    SqlRunner.run(sql)
  end







end
