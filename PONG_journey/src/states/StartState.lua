StartState = Class{__includes = BaseState}

function StartState:update(dt)
    
    if love.keyboard.wasPressed('h') then
        hardmode = (hardmode == false and true or false)
        if hardmode == true then
            CPU_STD_SPEED = 150
            CPU_SPEED = 150
            WIN_SCORE = 5
        else
            CPU_STD_SPEED = 100
            CPU_SPEED = 100
            WIN_SCORE = 3
        end
    elseif love.keyboard.wasPressed('return') then
        gStateMachine:change('typename')
    end
end

function StartState:render()
    love.graphics.clear(0.2,0.2,0.2,1)
    love.graphics.setColor(0,0,0,1)
    love.graphics.setFont(gFonts['std'])
    love.graphics.printf("Welcome to PONG the Journey!", 0, gameHeight/30, gameWidth, 'center')
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(gFonts['menu'])
    love.graphics.printf("Press [return] to start new game!", gameWidth/4, gameHeight/2.6, gameWidth/2, 'center')
    love.graphics.setColor(1,1,1,0.6)
    love.graphics.printf("You may leave any time by hitting [Esc]", gameWidth/4, gameHeight/1.68, gameWidth/2, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("But be aware progress will be lost!", 0, gameHeight/1.32, gameWidth, 'center')
    love.graphics.printf("Gamemode: ", -35, gameHeight/1.15, gameWidth, 'center')
    if hardmode == true then
        love.graphics.setColor(1,0,0,1)
        love.graphics.printf("Hard", 38, gameHeight/1.15, gameWidth, 'center')
    else
        love.graphics.setColor(0,1,0,1)
        love.graphics.printf("Normal", 45, gameHeight/1.15, gameWidth, 'center')
    end
    love.graphics.setColor(1,1,1,0.6)
    love.graphics.printf("press [H] to switch", 0, gameHeight/1.1, gameWidth, 'center')
end
    