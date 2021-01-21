function gamemenu()
    love.graphics.clear(0.2,0.2,0.2,1)
    love.graphics.setColor(0,0,0,1)
    love.graphics.setFont(stdFont)
    love.graphics.printf("Welcome to PONG the Journey!", 0, gameHeight/30, gameWidth, 'center')
    love.graphics.setColor(1,1,1,1)
    love.graphics.setFont(menuFont)
    love.graphics.printf("Press [return] to start new game!", gameWidth/4, gameHeight/2.6, gameWidth/2, 'center')
    love.graphics.setColor(1,1,1,0.6)
    love.graphics.printf("You may leave any time by hitting [Esc]", gameWidth/4, gameHeight/1.68, gameWidth/2, 'center')
    love.graphics.setFont(smallFont)
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

function typename()
    love.keyboard.setKeyRepeat(true)
    if string.len(playername) < 9 then
        love.keyboard.setTextInput(true)
        function love.textinput(t)
            playername = playername .. t
        end
    else
        love.keyboard.setTextInput(false)
    end
     
    function love.keypressed(key)
        if key == "backspace" then
        
            local byteoffset = utf8.offset(playername, -1)
     
            if byteoffset then
                playername = string.sub(playername, 1, byteoffset - 1)
            end
        elseif key == 'escape' then
            love.event.quit()

        elseif key == 'return' then
            gameState = 'colorchoice'
            love.keyboard.setKeyRepeat(false)
            love.keyboard.setTextInput(false)
        end
    end
end

function printname()
    love.graphics.clear(0.2,0.2,0.2,1)
    love.graphics.setFont(stdFont)
    love.graphics.setColor(0.8,0.8,0.8,1)
    love.graphics.printf("What is your name?", 0, gameHeight/5, gameWidth, 'center')
    love.graphics.setFont(menuFont)
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf("type it & confirm with [return]", gameWidth/6, gameHeight/2, gameWidth/1.5, 'center')
    love.graphics.setFont(viperLargeFont)
    love.graphics.printf(playername, 0, gameHeight/1.4, gameWidth, 'center')
end

function colorchoice()
    
    love.graphics.clear(0.2,0.2,0.2,1)
    
    love.graphics.setFont(menuFont)
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

    if love.keyboard.isDown('r') then
        playerColor = {234,119,101}
        map:loadStage()
        gameState = 'gamerules'
    elseif love.keyboard.isDown('g') then
        playerColor = {154,230,217,1}
        map:loadStage()
        gameState = 'gamerules'
    elseif love.keyboard.isDown('b') then
        playerColor = {85,110,204,1}
        map:loadStage()
        gameState = 'gamerules'
    
    elseif love.keyboard.isDown('o') then
        colorBuilder = true
    end

    if colorBuilder == true then
        love.keyboard.setKeyRepeat(false)

        love.graphics.setFont(menuFont)
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

        if love.keyboard.isDown('right') then
            playerColor[colorIndex] = math.min(255, playerColor[colorIndex] + 1)
        elseif love.keyboard.isDown('left') then
            playerColor[colorIndex] = math.max(0, playerColor[colorIndex] - 1)
        end

        love.graphics.setFont(smallFont)
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf("These are the background colors:", 0, 670, gameWidth, 'center')
        for i = 1, 10, 1 do
            love.graphics.setColor(bgColors[i][1],bgColors[i][2],bgColors[i][3], 1)    
            love.graphics.rectangle('fill', 95+30*i, 695, 20, 20, 2, 2, 4)
        end
    end
end

function gamerules()
    love.graphics.clear(0.2,0.2,0.2,1)
    
    love.graphics.setFont(menuFont)
    love.graphics.setColor(0.7,0.7,0.7,1)
    love.graphics.printf("There are 10 stages ahead!", 0, 60, gameWidth, 'center')
    love.graphics.printf("3 Goals per stage to clear it (5 in hardmode)", 30, 150, gameWidth-60, 'center')
    love.graphics.printf("You may choose an upgrade after each stage, which will help you alot!", 0, 270, gameWidth, 'center')
    love.graphics.setFont(stdFont)
    love.graphics.setColor(1,1,1,1)
    love.graphics.printf("Good luck!", 0, 400, gameWidth, 'center')
    love.graphics.setColor(0.7,0.7,0.7,1)
    love.graphics.setFont(menuFont)
    love.graphics.printf("See you on the highscore table after stage 10", 0, 510, gameWidth, 'center')
    love.graphics.printf("Hit [return] to start", 0, 630, gameWidth, 'center')
end