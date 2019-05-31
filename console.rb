require_relative('models/movie')
require_relative('models/star')
require_relative('models/casting')
require('pry-byebug')

movie1 = Movie.new({'title' => 'Jaws', 'genre' => 'horror'})

movie1.save()

star1 = Star.new({'first_name' => 'George', 'last_name' => 'Clooney'})

star1.save()

casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => '2000'})

casting1.save()



binding.pry
nil
