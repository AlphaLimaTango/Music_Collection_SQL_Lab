class Album

  attr_reader :id
  attr_accessor :title, :genre, :artist_id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id']
  end

  def save()
    sql = 'INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id;'
    values = [@title, @genre, @artist_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.delete_all()
    sql = 'DELETE FROM albums;'
    SqlRunner.run(sql)
  end
end
