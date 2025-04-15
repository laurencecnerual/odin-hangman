file = File.open("./google-10000-english-no-swears.txt", "r")

word_candidates = file.readlines().map { |w| w.chomp }.select do |w|
  w.length >= 5 && w.length <= 12
end

secret_word = word_candidates.sample
player_word = "_" * secret_word.length

file.close

remaining_guesses = 8
past_guesses = []

puts "Let's play hangman! Can you guess what letters are in my secret word within #{remaining_guesses} tries?"
puts player_word
puts ""

while true do

  while true do
    puts "Give me a letter"
    player_input = gets.chomp
    puts ""

    if player_input.length == 1 && player_input =~ /\A[a-zA-Z]+\z/
      player_input = player_input.downcase

      if !past_guesses.include?(player_input)
        break
      else
        puts "You've already used that letter. Pick something other than #{past_guesses.join(", ")}"
      end
    else
      puts "You should only give me a single letter of the English alphabet"
    end
  end

  was_successful = false

  secret_word.each_char.with_index do |char, index|
    if player_input == char
      player_word[index] = char
      was_successful = true
    end
  end

  if was_successful
    puts "Good job! That letter is in my secret word!"
  else
    puts "That's too bad. That letter is not in my secret word"
  end

  if player_word == secret_word # player wins
    break
  end

  remaining_guesses -= 1

  if remaining_guesses < 1 # player loses
    break
  end

  past_guesses << player_input
  puts "This is your guess so far: #{player_word}"
  puts ""
  puts "You have #{remaining_guesses} #{remaining_guesses > 1 ? "tries" : "try"} remaining"
end

if remaining_guesses > 0
  puts ""
  puts "Congrats, you win! My secret word was '#{secret_word}'!"
else
  puts ""
  puts "Sorry, you've run out of tries. My secret word was '#{secret_word}'"
end