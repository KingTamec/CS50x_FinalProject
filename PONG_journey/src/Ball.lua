Ball = Class{}

function Ball:init(x, y, radius, density, acceleration)
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.radius = radius
    self.shape = love.physics.newCircleShape(radius)
    self.fixture = love.physics.newFixture(self.body, self.shape, density)
    self.body:setBullet(true)
    self.fixture:setRestitution(acceleration)
end

function Ball:wallCollision()

    if self.body:isTouching(leftBorder.body) then
        dx, dy = self.body:getLinearVelocity()
        if dy > 0 then 
            self.body:applyForce(100,0)
        else 
            self.body:applyForce(100,0)
        end
    elseif self.body:isTouching(rightBorder.body) then
        dx, dy = self.body:getLinearVelocity()
        if dy > 0 then
            self.body:applyForce(-100,0)
        else
            self.body:applyForce(-100,0)
        end
    end
end

function Ball:inGoal()
    if self.body:getY() < 0 then
        ball:playerScores()
    elseif self.body:getY() > gameHeight then
        ball:cpuScores()
    end
end

function Ball:playerScores()
    tele = false
    love.audio.play(gSounds['player_scores'])
    self.body:setPosition(gameWidth/2, gameHeight/2)
    self.body:setLinearVelocity(0,0)
    if stage == 7 then 
        ballcage.body:setActive(true) 
    end
    playerScore = playerScore + 1
    startOfPlay = true
    if playerScore == WIN_SCORE then
        stageCleared()
    end
end

function stageCleared()
    totalPlayerScore = totalPlayerScore + (playerScore - cpuScore)*lifes
    cpu.fixture:destroy()
    cpu.body:destroy()
    destroyAdditionalCpuParts()
    stage = stage + 1

    if stage == 11 then
        victory()
    else
        cpu = Cpu(gameWidth/2, 20, cpuWidth, cpuHeight, 100000)
        map:loadStage()
        playerScore = 0
        cpuScore = 0
        upgradeMenu = true
        if playerWall == true then
            destroyPlayerWall()
        end
    end
end

function destroyAdditionalCpuParts()
    if stage == 5 or stage == 7 or stage == 9 then
        cpu.fixture1:destroy()
        cpu.fixture2:destroy()
        cpu.body1:destroy()
        cpu.body2:destroy()
    end
    if stage == 7 then
        for i = sphereCount, 1, -1 do
            spheres[i].fixture:destroy()
            spheres[i].body:destroy()
        end
        ballcage.fixture:destroy()
        ballcage.body:destroy()
        topBorder.fixture:destroy()
        topBorder.body:destroy()
        bottomBorder.fixture:destroy()
        bottomBorder.body:destroy()
    end
    if stage == 9 then
        cpu.fixture3:destroy()
        cpu.fixture4:destroy()
        cpu.body3:destroy()
        cpu.body4:destroy()
    end
    if stage == 10 then
        for j = i-1, d, -1 do
            projectiles[j].fixture:destroy()
            projectiles[j].body:destroy()
        end
    end
    if cpuWall == true then
        destroyCpuWall()
    end
end

function destroyCpuWall()
    for i = rows, 1, -1 do
        for j = brickCount, 1, -1 do
            bricks[i][j].fixture:destroy()
        end
    end
    cpuWall = false
end

function victory()
    love.audio.play(gSounds['win'])
    if hardmode == false then
        highscore.add(playername, totalPlayerScore)
    end
    highscore.save()
    ezscores = {}
    for i, score, name in highscore() do
        ezscores[i] = {name, score}
    end
    hardmodeHighscore.set("highscores_hard.txt", 5, "empty", 0)
    highscore.add('Colton', 213)
    highscore.add('David', 195)
    highscore.add('Emma', 157)
    highscore.add('Doug', 113)
    highscore.add('Rodrigo', 97)
    hardmodeHighscore.load()
    if hardmode == true then
        hardmodeHighscore.add(playername, totalPlayerScore)
    end
    hardmodeHighscore.save()
    hardscores = {}
    for i, score, name in hardmodeHighscore() do
        hardscores[i] = {name, score}
    end
    stage = 1
    upgrades = Upgrade()
    playerYborder = 660
    lifes = 5
    playerScore = 0
    cpuScore = 0
    gStateMachine:change('victory')
    if playerWall == true then
        destroyPlayerWall()
    end
end

function destroyPlayerWall()
    for i = pbrickCount, 1, -1 do
        pWall[i].fixture:destroy()
    end
    playerWall = false
end

function Ball:cpuScores()
    tele = false
    love.audio.play(gSounds['cpu_scores'])
    self.body:setPosition(gameWidth/2, gameHeight/2)
    self.body:setLinearVelocity(0,0)
    if stage == 7 then 
        ballcage.body:setActive(true) 
    end
    cpuScore = cpuScore + 1
    startOfPlay = true
    if cpuScore == WIN_SCORE then
        stageFailed()
    end
end

function stageFailed()
    lifes = lifes - 1
    playerScore = 0
    cpuScore = 0
    if playerWall == true then
        destroyPlayerWall()
    end
    cpu.fixture:destroy()
    cpu.body:destroy()
    destroyAdditionalCpuParts()
    if lifes == 0 then
        gameOver()
    end
    
    map:loadStage()
    cpu = Cpu(gameWidth/2, 20, cpuWidth, cpuHeight, 100000)
end

function gameOver()
    stage = 1
    upgrades = Upgrade()
    playerYborder = 660
    lifes = 5
    gStateMachine:change('gameover')
end

function Ball:minSpeed()
        
    if pause ~= true and tele ~= true then -- minspeed
        dx, dy = self.body:getLinearVelocity()
        if gameState == 'play' then
            if dy >= 0 and dy < 50 then
                self.body:setLinearVelocity(dx, 50)
            elseif dy < 0 and dy > -50 then
                self.body:setLinearVelocity(dx, -50)
            end
        end

        dx, dy = self.body:getLinearVelocity()  -- min y angle
        if dx > 200 and dy > 0 then
            self.body:setLinearVelocity(dx-2, dy+1)
        elseif dx > 200 and dy < 0 then
            self.body:setLinearVelocity(dx-2, dy-1)
        elseif dx < -200 and dy > 0 then
            self.body:setLinearVelocity(dx+2, dy+1)
        elseif dx < -200 and dy < 0 then
            self.body:setLinearVelocity(dx+2, dy-1)
        end
    end
end

function Ball:render()
    if stage == 10 then
        if colorTimer < 20 then
            love.graphics.setColor(1,1,1,1)
        else
            love.graphics.setColor(0.2,0.2,0.2,1)
        end
        if colorTimer == 0 then
            colorTimer = 40
        else
            colorTimer = colorTimer - 1
        end
    else
        love.graphics.setColor(0.2, 0.2, 0.2, 1)
    end
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.radius)
end

function round(n)
    return math.floor(n+0.5)
end