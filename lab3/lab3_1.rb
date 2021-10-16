def script1
  print "Введите слово: "
  word = gets.chomp
  
  if word[-2..-1] == 'cs'
    "Число 2 в степени #{word.length} = #{2 ** word.length}"
  else 
    "Слово #{word} задом наперёд: #{word.reverse}"
  end	
end

puts(script1)
