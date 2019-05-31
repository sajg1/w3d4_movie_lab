require_relative('../db/sql_runner')

class Movie

  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
  end

#CREATE
  def save()
    sql = "INSERT INTO movies
    (
      title, genre
    )
    VALUES
    (
      $1, $2
    ) RETURNING * "
    values = [@title, @genre]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  #UPDATE

  def update()
    sql = "UPDATE movies SET
    (
      title, genre
    )
    =
    (
      $1, $2
    ) WHERE id = $3"
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  #READ

  def self.all()
    sql= "SELECT * FROM movies"
    movies = SqlRunner.run(sql)
    result = movies.map {|movie| Movie.new(movie)}
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end
end
