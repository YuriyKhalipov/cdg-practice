def script2
  puts "Введите количество покемонов: "
  n = gets.to_i
  arr = []
  i = 1
  pokemons = Hash.new

  n.times do |x|
    print "Введите название #{i} покемона: "
    pokemon_name = gets.chomp
    print "Введите цвет #{i} покемона: "
    pokemon_color = gets.chomp
    pokemons = {name: pokemon_name, color: pokemon_color}
    arr.push(pokemons)
    i += 1
  end
  return arr
end

puts(script2)