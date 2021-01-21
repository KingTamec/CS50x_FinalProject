highscore = require 'sick'

function love.load()
    highscore.set("highscores", 3, "NA", 0)

    highscore.add('player', 5)
    highscore.save()
end

function love.draw()
    for i, score, name in highscore() do
        love.graphics.print(name, 400, i * 40)
        love.graphics.print(score, 500, i * 40)
    end
end