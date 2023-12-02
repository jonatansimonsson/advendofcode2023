mutable struct Game
    id::Int
    maxGreen::Int
    maxRed::Int
    maxBlue::Int
end

filePath = "advendofcode2023/day02/input.txt"

file = open(filePath, "r")
games = Game[]

try
    content = read(file, String)
    lines = [rstrip(line) for line in split(content, '\n')]
    
    for line in lines
        if occursin("Game", line)
            
            gameId = parse(Int, match(r"Game (\d+):", line).captures[1])
            line = replace(line, r"Game \d+: " => "")

            sets = split(line, ';')

            maxGreen = 0
            maxRed = 0
            maxBlue = 0

            for set in sets
                count = Dict("green" => 0, "red" => 0, "blue" => 0)
                colors = split(set, ',')

                for c in colors
                    parts = split(strip(c), ' ')
                    if length(parts) > 1 
                        count[parts[2]] += parse(Int, parts[1])
                    end
                end   
                maxGreen = max(maxGreen, get(count, "green", 0))
                maxRed = max(maxRed, get(count, "red", 0))
                maxBlue = max(maxBlue, get(count, "blue", 0))

            end
            game = Game(gameId, maxGreen, maxRed, maxBlue)
            push!(games, game)
        end
    end

    sumIds = 0
    sumPowers = 0

    for g in games
        power = g.maxBlue * g.maxGreen * g.maxRed 
        sumPowers += power
        if g.maxRed <= 12 && g.maxGreen <= 13 && g.maxBlue <= 14
            sumIds += g.id
        end
    end
    println("Part 1: ", sumIds)
    println("Part 2: ", sumPowers)

finally
    close(file)
end
