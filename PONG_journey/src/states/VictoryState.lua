VictoryState = Class{__includes = BaseState}

function VictoryState:update(dt)
    if love.keyboard.wasPressed('return') then
        player.fixture:destroy()
        player.body:destroy()
        player = Player(gameWidth/2, gameHeight-50, playerWidth, playerHeight, 100000)
        cpu = Cpu(gameWidth/2, 20, cpuWidth, cpuHeight, 100000)
        gStateMachine:change('start')
    end
end

function VictoryState:render()
    love.graphics.clear(0.2,0.2,0.2,1)
    love.graphics.setFont(gFonts['double'])
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.printf('YOU WIN', 0, 100, gameWidth, 'center')
    love.graphics.setFont(gFonts['menu'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('congratulations [ESC] to exit [Return] to restart', gameWidth/4, gameHeight/2.2, gameWidth/2+20, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.printf('Highscores', gameWidth/6, 540, gameWidth, 'left')
    love.graphics.printf('(Max: 150)', gameWidth/6+8, 560, gameWidth, 'left')
    
    for i = 1, 5, 1 do
        if hardmode == false and ezscores[i][1] == playername and ezscores[i][2] == totalPlayerScore and score_printed == false then 
            love.graphics.setColor(0.8, 0.2, 0.2, 1)
            love.graphics.rectangle('line', 46, 560 + i * 25, 190, 20)
            score_printed = true
        end
        love.graphics.print(ezscores[i][1], 50, 560 + i * 25)
        love.graphics.printf(ezscores[i][2], -310, 560 + i * 25, gameWidth, 'right')
        love.graphics.setColor(1, 1, 1, 0.8)
        
    end

    love.graphics.printf('Hardmode', -gameWidth/6-10, 540, gameWidth, 'right')
    love.graphics.printf('(Max: 250)', -gameWidth/6-15, 560, gameWidth, 'right')

    for i = 1, 5, 1 do
        if hardmode == true and hardscores[i][1] == playername and hardscores[i][2] == totalPlayerScore and score_printed == false then
            love.graphics.setColor(0.8, 0.2, 0.2, 1)
            love.graphics.rectangle('line', 306, 560 + i * 25, 190, 20)
            score_printed = true
        end
        love.graphics.print(hardscores[i][1], 310, 560 + i * 25)
        love.graphics.printf(hardscores[i][2], -50, 560 + i * 25, gameWidth, 'right')
        love.graphics.setColor(1, 1, 1, 0.8)
    end

    score_printed = false
end