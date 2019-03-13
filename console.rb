require_relative('models/artist.rb')
require_relative('models/album.rb')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({
  'name' => 'Prince'
  })


artist1.save


album1 = Album.new({
  'title' => 'Sign of the Times',
  'genre' => 'Funk Rock',
  'artist_id' => artist1.id
  })

album1.save
