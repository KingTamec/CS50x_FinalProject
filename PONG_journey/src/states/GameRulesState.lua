GameRulesState = Class{__includes = BaseState}

function GameRulesState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end

function GameRulesState:render()
    love.graphics.clear(0.2,0.2,0.2,1)
    love.graphics.setFont(gFonts['menu'])
    love.graphics.setColor(0.7,0.7,0.7,1)
    love.graphics.printf("There are 10 stages ahead!", 0, 60, gameWidth, 'center')
    love.graphics.printf("3 Goals per stage to clear it (5 in hardmode)", 30, 150, gameWidth-60, 'center')
    love.graphics.printf("You may choose an upgrade after each stage, which will help you alot!", 0, 270, gameWidth, 'center')
    love.graphics.setFont(gFonts['std'])
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf("Good luck!", 0, 400, gameWidth, 'center')
    love.graphics.setColor(0.7,0.7,0.7,1)
    love.graphics.setFont(gFonts['menu'])
    love.graphics.printf("See you on the highscore table after stage 10", 0, 510, gameWidth, 'center')
    love.graphics.printf("Hit [return] to start", 0, 630, gameWidth, 'center')
end