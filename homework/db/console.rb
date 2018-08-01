require("pry")
require_relative("../models/artist")
require_relative("../models/album")

Album.delete_all()
Artist.delete_all()

state_champs = Artist.new(
  {
    'name' => 'State Champs'
  }
)

neck_deep = Artist.new(
  {
    'name' => 'Neck Deep'
  }
)

state_champs.save()
neck_deep.save()

album1 = Album.new(
  {
    'title' => 'Living Proof',
    'genre' => 'Rock',
    'artist_id' => state_champs.id
  }
)

album2 = Album.new(
  {
    'title' => 'Around the World and Back',
    'genre' => 'Rock',
    'artist_id' => state_champs.id
  }
)

album3 = Album.new(
  {
    'title' => 'The Peace and the Panic',
    'genre' => 'Rock',
    'artist_id' => neck_deep.id
  }
)

album1.save()
album2.save()
album3.save()


binding.pry
nil
