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

  def self.all()
    sql = 'SELECT * FROM albums;'
    all_albums = SqlRunner.run(sql)
    return all_albums.map { |album| Album.new(album)  }
  end

  def self.find_album_by_artist(artist_id)
    sql = 'SELECT * FROM albums WHERE artist_id = ($1);'
    values = [artist_id]
    albums_found = SqlRunner.run(sql, values)
    return albums_found.map { |album| Album.new(album)  }
  end

  def show_artist()
    sql = 'SELECT * FROM artists WHERE id = ($1);'
    values = [@artist_id]
    artist_hash = SqlRunner.run(sql, values).first
    # album_artist = artist_hash.map { |artist| Artist.new(artist)  }
    return Artist.new(artist_hash)
  end
end
