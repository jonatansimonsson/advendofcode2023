filePath = 'input.txt'

File.open(filePath, 'r') do |file|
  pointA = 0
  pointB = 0
  numberOfCards = Array.new(211, 1)
  file.each_with_index do |line, index|
    parts = line.split('|')
    winningNumbers = parts[0].strip.sub(/Card \d+: /, '').split(' ')
    myNumbers = parts[1].strip.split(' ')

    matchingNumbers = (winningNumbers.length - (winningNumbers - myNumbers).length)


    (0...matchingNumbers).each do |i|
      numberOfCards[index + 1 + i] += 1 * numberOfCards[index]
    end

    pointA += (2**(winningNumbers.length - (winningNumbers - myNumbers).length)) / 2
    pointB = numberOfCards.sum
  end
  print "Part 1: #{pointA} \n"
  print "Part 2: #{pointB} \n"
end
