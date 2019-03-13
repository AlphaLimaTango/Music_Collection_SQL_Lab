require_relative('../db/sql_runner.rb')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = 'INSERT INTO artists (name) VALUES ($1) RETURNING id;'
    values = [@name]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def delete()
    sql = 'DELETE FROM artists WHERE id = ($1);'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = 'SELECT * FROM artists;'
    all_artists = SqlRunner.run(sql)
    return all_artists.map { |artist| Artist.new(artist)  }
  end

  def self.delete_all()
    sql = 'DELETE FROM artists;'
    SqlRunner.run(sql)
  end

  def self.find_by_artist_id(id)
    sql = 'SELECT * FROM artists WHERE id = ($1)'
    values = [id]
    artist_found = SqlRunner.run(sql, values).first
    return Artist.new(artist_found)
  end

  def update(new_artist)
    sql = 'UPDATE artists SET name = $1 WHERE id = $2;'
    values = [new_artist, @id]
    SqlRunner.run(sql, values)
  end
end
