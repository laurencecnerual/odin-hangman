file = File.open("./google-10000-english-no-swears.txt", "r")

word_candidates = file.readlines().map { |w| w.chomp }.select do |w|
  w.length >= 5 && w.length <= 12
end

secret_word = word_candidates.sample

file.close