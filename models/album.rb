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

  def delete()
    sql = 'DELETE FROM albums WHERE id = ($1);'
    values = [@id]
    SqlRunner.run(sql, values)
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
    return Artist.new(artist_hash)
    # album_artist = artist_hash.map { |artist| Artist.new(artist)  }
    # return album_artist // alternative way, mapping
  end

  def self.find_by_album_id(id)
    sql = 'SELECT * FROM albums WHERE id = ($1);'
    values = [id]
    album_found = SqlRunner.run(sql, values).first
    return Album.new(album_found)
  end

  # def update(new_title)
  #   sql = 'UPDATE albums SET title = $1 WHERE id = $2;'
  #   values = [new_title, @id]
  #   SqlRunner.run(sql, values)
  # end -- for changing one item

  def update
    sql = 'UPDATE albums SET (title, genre) = ($1, $2) WHERE id = $3;'
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end #updating multiple keys

  movie3.update({'title' => 'smokeback mountain', 'genre' => food documentary})


end
