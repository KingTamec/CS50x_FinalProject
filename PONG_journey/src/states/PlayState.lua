PlayState = Class{__includes = BaseState}

function PlayState:init()
    ball = Ball(gameWidth/2, gameHeight/2, 10, 4, 1)
    player = Player(gameWidth/2, gameHeight-50, playerWidth, playerHeight, 100000)
    cpu = Cpu(gameWidth/2, 20, cpuWidth, cpuHeight, 100000)

    upgrades = Upgrade()

    map = Map()
    map:loadStage()
end

function PlayState:update(dt)
    
    world:update(dt)

    ball:wallCollision()
    ball:minSpeed()

    cpu:control()
    player:control()

    upgrades:activation()

    ball:inGoal()

    playsounds()

    if upgradeMenu == true then
        upgrades:set()
    end
        
   if love.keyboard.wasPressed('return') then
        if startOfPlay == true and upgradeMenu == false then
            if stage == 7 then ballcage.body:setActive(false) end
            ball.body:setLinearVelocity(0, 200*(math.random(2) == 1 and -1 or 1))
            startOfPlay = false
            printNewSkill = false
        end
    end
end

function PlayState:render()
    
    map:render()
        
    upgrades:redline()
    
    ball:render()
    player:render()
    cpu:render()
        
    upgrades:render()

    if upgradeMenu == true then
        upgrades:menu()
    else
        printInfo()
    end
end

function printInfo()
    if startOfPlay == true then
        love.graphics.setFont(gFonts['std'])
        love.graphics.setColor(1, 1, 1, 0.4)
        love.graphics.print(playerScore, gameWidth/2 - 64, gameHeight/2 - 128)
        love.graphics.printf(':', gameWidth/2 - 6, gameHeight/2 - 134, gameWidth, 'left')
        love.graphics.print(cpuScore, gameWidth/2 + 32, gameHeight/2 - 128)

        love.graphics.setFont(gFonts['viper'])
        love.graphics.printf(playername, -5, gameHeight/2-30, gameWidth, 'right')
        love.graphics.printf(totalPlayerScore, -5, gameHeight/2+5, gameWidth, 'right')

        if stage < 10 then
            love.graphics.printf("Stage " ..stage, 0, gameHeight/4, gameWidth, 'center')
        else
            love.graphics.printf("Final Stage!", 0, gameHeight/4, gameWidth, 'center')
        end
        
        for i = lifes, 1,-1 do
            love.graphics.draw(gIcons['full_heart'], i*40 -30, gameHeight/2-40, 0, 0.8, 0.8)
        end
    
        for i = MAX_LIFES - lifes, 1,-1 do
            love.graphics.draw(gIcons['empty_heart'], 210 - i*40, gameHeight/2-40, 0, 0.8, 0.8)
        end

        if printNewSkill == true then
            love.graphics.setFont(gFonts['menu'])
            love.graphics.setColor(1, 1, 1, 0.8)
            if newSkill == 'g' then
                love.graphics.printf('Growth - paddle grown', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setFont(gFonts['small'])
                love.graphics.printf('In addition switch between offensive and defensive form with [space]', gameWidth/4, gameHeight/1.3, gameWidth/2, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(gIcons['grow'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 'f' then
                love.graphics.printf('Forward - you may now move forward', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(gIcons['move_fwd'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 'w' then
                love.graphics.printf('Wall - press [1] to build a wall once per stage', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(gIcons['wall'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 'p' then
                love.graphics.printf('Pause - press [2] to temporary freeze the ball', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setFont(gFonts['small'])
                love.graphics.printf('In addition flight direction is shown but be aware it loses accuracy after wall contact', gameWidth/4, gameHeight/1.2, gameWidth/2, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(gIcons['pause'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 's' then
                love.graphics.printf('Speed - press [3] to gain a temporary speed boost', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(gIcons['speed'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 't' then
                love.graphics.printf('Telekinetics - press [W,A,S,D] to gain temporary kinetic ball control', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(gIcons['tele'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            end
        end
    end
end

function playsounds()
    
    if stage <= 5 then
        if gameState == 'start' or gameState == 'play' then
            love.audio.play(gSounds['music1'])
        end
    else
        love.audio.stop(gSounds['music1'])
    end

    if stage >= 6 then
        if gameState == 'start' or gameState == 'play' then
            love.audio.play(gSounds['music2'])
        end
    else
        love.audio.stop(gSounds['music2'])
    end
    
    if gameState == 'play' then
        if ball.body:isTouching(cpu.body) or ball.body:isTouching(player.body) then
            love.audio.play(gSounds['bat_hit'])
        end

        if ball.body:isTouching(leftBorder.body) or ball.body:isTouching(rightBorder.body) then
            love.audio.play(gSounds['wall_hit'])
        end
    end
end