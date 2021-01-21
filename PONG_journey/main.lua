-- Final Project of Thomas feuerstein for CS50x 

Class  = require 'class'
push = require 'push'
utf8 = require("utf8")
highscore = require 'sick' -- downloaded from https://gist.github.com/Kyrremann/b29397159e939cff2896ed53f1e7c10f
hardmodeHighscore = require 'sick' 

require 'Map'
require 'Ball'
require 'Cpu'
require 'Player'
require 'Upgrade'
require 'GameSetup'

windowWidth, windowHeight = love.window.getDesktopDimensions()
gameWidth, gameHeight = 540, 720

hardmode = false
playerColor = {255,159,40}
colorIndex = 1
colorBuilder = false
playername = ""
colorTimer = 0

playerYborder = 660

playerWidth = 80
playerHeight = 20

cpuWidth = 100
cpuHeight = 20

CPU_STD_SPEED = 100
PLAYER_SPEED = 200

lifes = 5
MAX_LIFES = 5

function love.load()
   
    stage = 1
    -- Score related variables
    winScore = 3
    playerScore = 0
    cpuScore = 0
    totalPlayerScore = 118
    score_printed = false

    -- Ugrade related variables
    speed_cooldown = 0
    pause_cooldown = 0
    tele_cooldown = 0
    playerWall = false
    cpuWall = false
    pause = false
    tele = false

    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = true})
    love.window.setTitle('PONG THE JOURNEY')

    smallFont = love.graphics.newFont('fonts/capture.ttf', 16)
    menuFont = love.graphics.newFont('fonts/capture.ttf', 32)
    stdFont = love.graphics.newFont('fonts/capture.ttf', 64)
    doubleFont = love.graphics.newFont('fonts/capture.ttf', 128)
    viperFont = love.graphics.newFont('fonts/viper.ttf', 24)
    viperLargeFont = love.graphics.newFont('fonts/viper.ttf', 48)

    highscore.set("highscores.txt", 5, "empty", 0)
    highscore.add('Hermione', 136)
    highscore.add('Alice', 121)
    highscore.add('Charlie', 87)
    highscore.add('Bob', 62)
    highscore.add('Scratch', 45)
    highscore.load()

    cpuColors = {
        {0,1,0}, {0,0,1}, {1,0,0}, 
        {1,0,0.6}, {0,0,0}, {0.41,0.51,0.06},
        {0.49,0.38,0.04}, {0.48,0.48,0.48}, {0.89,0.56,0.18},
        {1,1,1}
    }
    bgColors = {
        {0.4,0.4,0.4}, {0.3,0.3,0.3}, {0.5,0.5,0.5},
        {0.1,0.1,0.1}, {0.7,0.7,0.7}, {0.4,0.4,0.4}, 
        {0.5,0.5,0.5}, {0.3,0.3,0.3}, {0.5,0.5,0.5},
        {0.1,0.1,0.1}
    }
    icons = {
        ['full_heart'] = love.graphics.newImage('icons/full_heart.png'),
        ['empty_heart'] = love.graphics.newImage('icons/empty_heart.png'),
        ['grow'] = love.graphics.newImage('icons/Grow_Bat.png'),
        ['move_fwd'] = love.graphics.newImage('icons/Move_forward.png'),
        ['pause'] = love.graphics.newImage('icons/pause.png'),
        ['speed'] = love.graphics.newImage('icons/speed.png'),
        ['tele'] = love.graphics.newImage('icons/tele.png'),
        ['wall'] = love.graphics.newImage('icons/wall.png')
    }
    sounds = {
        ['bat_hit'] = love.audio.newSource('sounds/bat_hit.wav', 'static'),
        ['player_scores'] = love.audio.newSource('sounds/scores.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['win'] = love.audio.newSource('sounds/Winning-sound-effect.mp3', 'static'),
        ['cpu_scores'] = love.audio.newSource('sounds/cpu_scores.wav', 'static'),
        ['speed'] = love.audio.newSource('sounds/speed.wav', 'static'),
        ['morph'] = love.audio.newSource('sounds/morph.wav', 'static'),
        ['pause'] = love.audio.newSource('sounds/pause.wav', 'static'),
        ['tele'] = love.audio.newSource('sounds/tele.wav', 'static'),
        ['wall'] = love.audio.newSource('sounds/wall.wav', 'static'),
        ['music1'] = love.audio.newSource('sounds/speck_-_Head_Full_Of_Mash.mp3', 'static'),
        --Head Full Of Mash by Speck (c) copyright 2020 Licensed under a Creative Commons Attribution Noncommercial  
        --(3.0) license. http://dig.ccmixter.org/files/speck/62667 Ft: Reiswerk, Apoxode, Jihfa, Stefan Kartenberg
        ['music2'] = love.audio.newSource('sounds/Karstenholymoly_-_Stardust_(Ziggy_is_coming)_1.mp3', 'static')
        --Stardust (Ziggy is coming) by Kraftamt (c) copyright 2020 Licensed under a Creative Commons Attribution Noncommercial  
        --(3.0) license. http://dig.ccmixter.org/files/Karstenholymoly/62493 Ft: Platinum Butterfly
    }
    sounds['player_scores']:setVolume(0.5)
    sounds['win']:setVolume(0.5)
    sounds['music1']:setVolume(0) -- should be 0.15
    sounds['music2']:setVolume(0) -- should be 0.15
    love.audio.setVolume(1) ------------------------------------SWITCH ON AGAIN-------------------------------------------------------------------

    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, false)

    ball = Ball(gameWidth/2, gameHeight/2, 10, 4, 1)
    
    player = Player(gameWidth/2, gameHeight-50, playerWidth, playerHeight, 100000)

    cpu = Cpu(gameWidth/2, 20, cpuWidth, cpuHeight, 100000)

    upgrades = Upgrade(0, 0, 0, 0, 0, 0)

    map = Map()

    math.randomseed(os.time())

    gameState = 'gamemenu'
end

function love.update(dt)
    if gameState == 'gamemenu' then
        function love.keypressed(key)
            if key == 'escape' then
                love.event.quit()
            elseif key == 'h' then
                hardmode = (hardmode == false and true or false)
                if hardmode == true then
                    CPU_STD_SPEED = 150
                    CPU_SPEED = 150
                    winScore = 5
                else
                    CPU_STD_SPEED = 100
                    CPU_SPEED = 100
                    winScore = 3
                end
            
            elseif key == 'return' then
                gameState = 'getname'
            end
        end
    elseif gameState == 'getname' then
        typename()

    elseif gameState == 'colorchoice' then
        function love.keypressed(key)
            if key == 'escape' then
                love.event.quit()
            end
            if colorBuilder == true then
                if key == 'down' then
                    colorIndex = math.min(3, colorIndex + 1)
                elseif key == 'up' then
                    colorIndex = math.max(1, colorIndex - 1)
                elseif key == 'return' then
                    map:loadStage()
                    gameState = 'gamerules'
                end
            end
        end
    
    elseif gameState == 'gamerules' then
        function love.keypressed(key)
            if key == 'escape' then
                love.event.quit()
            elseif key == 'return' then
                map:loadStage()
                gameState = 'start'
            end
        end

    elseif gameState == 'gameover' or gameState == 'won' then
        function love.keypressed(key)
            if key == 'escape' then
                love.event.quit()
            elseif key == 'return' then
                player.fixture:destroy()
                player.body:destroy()
                player = Player(gameWidth/2, gameHeight-50, playerWidth, playerHeight, 100000)
                cpu = Cpu(gameWidth/2, 20, cpuWidth, cpuHeight, 100000)
                gameState = 'gamemenu'
            end
        end
    else
    
        world:update(dt)

        ball:wallCollision()

        ball:minSpeed()

        cpu:control()

        player:control()

        upgrades:activation()

        ball:inGoal()

        playsounds()

        if gameState == 'upgrades' then
            upgrades:set()
        end
            
        function love.keypressed(key)
            if key == 'escape' then
                love.event.quit()
            elseif key == 'return' then
                if gameState == 'start' then
                    if stage == 7 then ballcage.body:setActive(false) end
                    ball.body:setLinearVelocity(0, 200*(math.random(2) == 1 and -1 or 1))
                    gameState = 'play'
                    printNewSkill = false
                end
            end
        end
    end
end

function love.draw()
  push:start()
    if gameState == 'gamemenu' then
        gamemenu()

    elseif gameState == 'getname' then
        printname()
    
    elseif gameState == 'colorchoice' then
        colorchoice()

    elseif gameState == 'gamerules' then
        gamerules()

    elseif gameState == 'gameover' then
        gameover()
    
    elseif gameState == 'won' then
        gameWon()

    else
        map:render()
        
        upgrades:redline()
        
        ball:render()
        
        player:render()

        cpu:render()
            
        upgrades:render()

        printInfo()

        if gameState == 'upgrades' then
            upgrades:menu()
        end

    end
  push:finish()
end

function printInfo()
    if gameState == 'start' then
        love.graphics.setFont(stdFont)
        love.graphics.setColor(1, 1, 1, 0.4)
        love.graphics.print(playerScore, gameWidth/2 - 64, gameHeight/2 - 128)
        love.graphics.printf(':', gameWidth/2 - 6, gameHeight/2 - 134, gameWidth, 'left')
        love.graphics.print(cpuScore, gameWidth/2 + 32, gameHeight/2 - 128)

        love.graphics.setFont(viperFont)
        love.graphics.printf(playername, -5, gameHeight/2-30, gameWidth, 'right')
        love.graphics.printf(totalPlayerScore, -5, gameHeight/2+5, gameWidth, 'right')

        if stage < 10 then
            love.graphics.printf("Stage " ..stage, 0, gameHeight/4, gameWidth, 'center')
        else
            love.graphics.printf("Final Stage!", 0, gameHeight/4, gameWidth, 'center')
        end
        
        for i = lifes, 1,-1 do
            love.graphics.draw(icons['full_heart'], i*40 -30, gameHeight/2-40, 0, 0.8, 0.8)
        end
    
        for i = MAX_LIFES - lifes, 1,-1 do
            love.graphics.draw(icons['empty_heart'], 210 - i*40, gameHeight/2-40, 0, 0.8, 0.8)
        end

        if printNewSkill == true then
            love.graphics.setFont(menuFont)
            love.graphics.setColor(1, 1, 1, 0.8)
            if newSkill == 'g' then
                love.graphics.printf('Growth - paddle grown', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setFont(smallFont)
                love.graphics.printf('In addition switch between offensive and defensive form with [space]', gameWidth/4, gameHeight/1.3, gameWidth/2, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(icons['grow'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 'f' then
                love.graphics.printf('Forward - you may now move forward', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(icons['move_fwd'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 'w' then
                love.graphics.printf('Wall - press [1] to build a wall once per stage', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(icons['wall'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 'p' then
                love.graphics.printf('Pause - press [2] to temporary freeze the ball', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setFont(smallFont)
                love.graphics.printf('In addition flight direction is shown but be aware it loses accuracy after wall contact', gameWidth/4, gameHeight/1.2, gameWidth/2, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(icons['pause'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 's' then
                love.graphics.printf('Speed - press [3] to gain a temporary speed boost', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(icons['speed'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            elseif newSkill == 't' then
                love.graphics.printf('Telekinetics - press [W,A,S,D] to gain temporary kinetic ball control', 0, gameHeight/1.4, gameWidth, 'center')
                love.graphics.setColor(1, 1, 1, 1)
                love.graphics.draw(icons['tele'], gameWidth/2-50, gameHeight/1.8, 0, 2.5, 2.5)
            end
        end
    end    
end

function gameover()
    love.graphics.clear(0,0,0,1)
    love.graphics.setFont(doubleFont)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.printf('GAME OVER', 0, 100, gameWidth, 'center')
    love.graphics.setFont(stdFont)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('press [RETURN] to restart or [ESC] to give up', 0, gameHeight/1.6, gameWidth, 'center')
end

function gameWon()
    love.graphics.clear(0.2,0.2,0.2,1)
    love.graphics.setFont(doubleFont)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.printf('YOU WIN', 0, 100, gameWidth, 'center')
    love.graphics.setFont(menuFont)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('congratulations [ESC] to exit [Return] to restart', gameWidth/4, gameHeight/2.2, gameWidth/2+20, 'center')
    love.graphics.setFont(smallFont)
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

function playsounds()
    
    if stage <= 5 then
        if gameState == 'start' or gameState == 'play' then
            love.audio.play(sounds['music1'])
        end
    else
        love.audio.stop(sounds['music1'])
    end

    if stage >= 6 then
        if gameState == 'start' or gameState == 'play' then
            love.audio.play(sounds['music2'])
        end
    else
        love.audio.stop(sounds['music2'])
    end
    
    if gameState == 'play' then
        if ball.body:isTouching(cpu.body) or ball.body:isTouching(player.body) then
            love.audio.play(sounds['bat_hit'])
        end

        if ball.body:isTouching(leftBorder.body) or ball.body:isTouching(rightBorder.body) then
            love.audio.play(sounds['wall_hit'])
        end
    end
end
