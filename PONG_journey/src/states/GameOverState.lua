GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)
    if love.keyboard.wasPressed('return') then
        player.fixture:destroy()
        player.body:destroy()
        player = Player(gameWidth/2, gameHeight-50, playerWidth, playerHeight, 100000)
        cpu = Cpu(gameWidth/2, 20, cpuWidth, cpuHeight, 100000)
        gStateMachine:change('start')
    end
end

function GameOverState:render()
    love.graphics.clear(0,0,0,1)
    love.graphics.setFont(gFonts['double'])
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.printf('GAME OVER', 0, 100, gameWidth, 'center')
    love.graphics.setFont(gFonts['std'])
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('press [RETURN] to restart or [ESC] to give up', 0, gameHeight/1.6, gameWidth, 'center')
end