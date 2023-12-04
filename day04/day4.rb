filePath = 'input.txt'

File.open(filePath, 'r') do |file|
  pointA = 0
  pointB = 0
  numberOfCards = Array.new(6, 1)
  file.each_with_index do |line, index|
    parts = line.split('|')
    winningNumbers = parts[0].strip.sub(/Card \d+: /, '').split(' ')
    myNumbers = parts[1].strip.split(' ')

    print myNumbers
    print "\n"
    print winningNumbers
    print "\n"
    print(winningNumbers - myNumbers)
    print "\n"

    matching_numbers = (winningNumbers.length - (winningNumbers - myNumbers).length)
    print "#{index} \n"

    (0...matching_numbers).each do |i|
      numberOfCards[index + i] += 1 * numberOfCards[i]
    end

    pointA += (2**(winningNumbers.length - (winningNumbers - myNumbers).length)) / 2
    pointB += (2**(winningNumbers.length - (winningNumbers - myNumbers).length)) / 2
  end
  print "Part 1: #{pointA} \n"
  print "Part 2: #{pointB} \n"

  print numberOfCards
  print numberOfCards.sum
end
