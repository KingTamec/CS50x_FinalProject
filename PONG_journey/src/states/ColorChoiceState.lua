ColorChoiceState = Class{__includes = BaseState}

function ColorChoiceState:update(dt)   
    if colorBuilder == true then
        if love.keyboard.wasPressed('down') then
            colorIndex = math.min(3, colorIndex + 1)
        elseif love.keyboard.wasPressed('up') then
            colorIndex = math.max(1, colorIndex - 1)
        elseif love.keyboard.wasPressed('return') then
            gStateMachine:change('gamerules')
        end
    end

    if love.keyboard.isDown('r') then
        playerColor = {234,119,101}
        gStateMachine:change('gamerules')
    elseif love.keyboard.isDown('g') then
        playerColor = {154,230,217,1}
        gStateMachine:change('gamerules')
    elseif love.keyboard.isDown('b') then
        playerColor = {85,110,204,1}
        gStateMachine:change('gamerules')
    
    elseif love.keyboard.wasPressed('o') then
        colorBuilder = true
    end

    if love.keyboard.isDown('right') then
        playerColor[colorIndex] = math.min(255, playerColor[colorIndex] + 1)
    elseif love.keyboard.isDown('left') then
        playerColor[colorIndex] = math.max(0, playerColor[colorIndex] - 1)
    end
end

function ColorChoiceState:render()
    love.graphics.clear(0.2,0.2,0.2,1)
    
    love.graphics.setFont(gFonts['menu'])
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf("Choose a color!", 0, 30, gameWidth, 'center')
    
    love.graphics.printf('[R]', 135,  80, gameWidth, 'left')
    love.graphics.printf('[G]', 250,  80, gameWidth, 'left')
    love.graphics.printf('[B]', 365,  80, gameWidth, 'left')

    love.graphics.setColor(0.917,0.466,0.396,1)
    love.graphics.rectangle('fill', 132, 125, 50, 50, 10, 10, 20)
    love.graphics.setColor(0.604,0.902,0.851,1)
    love.graphics.rectangle('fill', 247, 125, 50, 50, 10, 10, 20)
    love.graphics.setColor(0.333,0.431,0.8,1)
    love.graphics.rectangle('fill', 362, 125, 50, 50, 10, 10, 20)

    love.graphics.setColor(1,1,1,1)
    love.graphics.printf("Can't deside? press [o]", 0, 200, gameWidth, 'center')

    if colorBuilder == true then
        love.keyboard.setKeyRepeat(false)

        love.graphics.setFont(gFonts['menu'])
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf("Use the arrow keys to create your own color and hit [return] when you are satisfied!", 
                                gameWidth/6, 260, gameWidth/1.5, 'center')

        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle('line', 100, 480, gameWidth-200, 20)
        love.graphics.rectangle('line', 100, 520, gameWidth-200, 20)
        love.graphics.rectangle('line', 100, 560, gameWidth-200, 20)
        love.graphics.setColor(1,0,0,1)
        love.graphics.rectangle('fill', 102, 482, playerColor[1]*((gameWidth-204)/255), 16)
        love.graphics.setColor(0,1,0,1)
        love.graphics.rectangle('fill', 102, 522, playerColor[2]*((gameWidth-204)/255), 16)
        love.graphics.setColor(0,0,1,1)
        love.graphics.rectangle('fill', 102, 562, playerColor[3]*((gameWidth-204)/255), 16)

        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle('line', gameWidth/2-20, 600, 50, 50, 10, 10, 20)
        love.graphics.setColor(playerColor[1]/255,playerColor[2]/255,playerColor[3]/255,1)
        love.graphics.rectangle('fill', gameWidth/2-18, 602, 46, 46, 8, 8, 20)

        love.graphics.setFont(gFonts['small'])
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf("These are the background colors:", 0, 670, gameWidth, 'center')
        for i = 1, 10, 1 do
            love.graphics.setColor(bgColors[i][1],bgColors[i][2],bgColors[i][3], 1)    
            love.graphics.rectangle('fill', 95+30*i, 695, 20, 20, 2, 2, 4)
        end
    end
end