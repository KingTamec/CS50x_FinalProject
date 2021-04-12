TypeNameState = Class{__includes = BaseState}

function TypeNameState:update(dt)
    love.keyboard.setKeyRepeat(true)
    if string.len(playername) < 9 then
        love.keyboard.setTextInput(true)
        function love.textinput(t)
            playername = playername .. t
        end
    else
        love.keyboard.setTextInput(false)
    end  
    
    if love.keyboard.wasPressed('backspace') then
        local byteoffset = utf8.offset(playername, -1)
    
        if byteoffset then
            playername = string.sub(playername, 1, byteoffset - 1)
        end
   
    elseif love.keyboard.wasPressed('return') then
        love.keyboard.setKeyRepeat(false)
        love.keyboard.setTextInput(false)
        gStateMachine:change('colorchoice')
    end
end

function TypeNameState:render()
    love.graphics.clear(0.2,0.2,0.2,1)
    love.graphics.setFont(gFonts['std'])
    love.graphics.setColor(0.8,0.8,0.8,1)
    love.graphics.printf("What is your name?", 0, gameHeight/5, gameWidth, 'center')
    love.graphics.setFont(gFonts['menu'])
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf("type it & confirm with [return]", gameWidth/6, gameHeight/2, gameWidth/1.5, 'center')
    love.graphics.setFont(gFonts['viperLarge'])
    love.graphics.printf(playername, 0, gameHeight/1.4, gameWidth, 'center')
end