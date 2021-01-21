Upgrade = Class{}

function Upgrade:init(grow, move_fwd, wall, pause, speed, tele)
    self.grow = grow
    self.move_fwd = move_fwd
    self.pause = pause
    self.wall = wall
    self.speed = speed
    self.tele = tele
end

function Upgrade:set()
    printNewSkill = true
    if self.grow ~= 2 then
        if love.keyboard.isDown('g') then
            love.audio.play(sounds['morph'])
            self.grow = self.grow + 1
            player.fixture:destroy()
            player.body:setPosition(gameWidth/2, gameHeight-20)
            l = (playerWidth/2)+((playerWidth/3)*self.grow)
            h = playerHeight/2
            if self.grow == 1 then
                player.shape = love.physics.newPolygonShape(-l*0.8,h, -l*0.8/2,-h, l*0.8/2,-h, l*0.8,h)
            else
                player.shape = love.physics.newPolygonShape(-l*0.8,h, -l*0.8/2,-h, 0,-2*h, l*0.8/2,-h, l*0.8,h)
            end
            player.fixture = love.physics.newFixture(player.body, player.shape, player.density)
            player.body:setFixedRotation(true)
            flat = false
            morph_cooldown = 0
            gameState = 'start'
            newSkill = 'g'
        end       
    end

    if self.move_fwd ~= 2 then
        if love.keyboard.isDown('f') then
            self.move_fwd = self.move_fwd + 1
            playerYborder = playerYborder - 120
            gameState = 'start'
            newSkill = 'f'
        end
    end

    if self.pause ~= 2 then
        if love.keyboard.isDown('p') then
            love.audio.play(sounds['pause'])
            self.pause = self.pause + 1
            gameState = 'start'
            newSkill = 'p'
        end
    end

    if self.wall ~= 1 then
        if love.keyboard.isDown('w') then
            love.audio.play(sounds['wall'])
            self.wall = self.wall + 1
            playerWall = false
            gameState = 'start'
            newSkill = 'w'
        end
    end

    if stage > 4 then    
        if self.speed ~= 1 then
            if love.keyboard.isDown('s') then
                love.audio.play(sounds['speed'])
                self.speed = self.speed + 1
                gameState = 'start'
                newSkill = 's'
            end
        end

        if self.tele ~= 1 then
            if love.keyboard.isDown('t') then
                love.audio.play(sounds['tele'])
                self.tele = self.tele + 1
                gameState = 'start'
                newSkill = 't'
            end
        end
    end
end

function Upgrade:menu()
    
    love.graphics.setFont(menuFont)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Choose an upgrade', 0, gameHeight/4-40, gameWidth, 'center')
    
    -- First row
    if upgrades.grow ~= 2 then
        love.graphics.draw(icons['grow'], 40, 200, 0, 2, 2)
        love.graphics.printf('[G]', 60, 300, gameWidth, 'left')
    end

    if upgrades.move_fwd ~= 2 then
        love.graphics.draw(icons['move_fwd'], 160, 200, 0, 2, 2)
        love.graphics.printf('[F]', 180, 300, gameWidth, 'left')
    end

    if upgrades.pause ~= 2 then
        love.graphics.draw(icons['pause'], 290, 200, 0, 2, 2)
        love.graphics.printf('[P]', 310, 300, gameWidth, 'left')
    end

    if upgrades.wall ~= 1 then
        love.graphics.draw(icons['wall'], 410, 200, 0, 2, 2)
        love.graphics.printf('[W]', 424, 300, gameWidth, 'left')
    end

    -- Second row
    if stage > 4 then
        if upgrades.speed ~= 1 then
            love.graphics.draw(icons['speed'], 160, 400, 0, 2, 2)
            love.graphics.printf('[S]', 180, 500, gameWidth, 'left')
        end

        if upgrades.tele ~= 1 then
            love.graphics.draw(icons['tele'], 290, 400, 0, 2, 2)
            love.graphics.printf('[T]', 310, 500, gameWidth, 'left')
        end
    end
end

function Upgrade:activation()

    if self.grow > 0 and gameState == 'play' then
 
        if love.physics.getDistance(player.fixture, ball.fixture) > 50 then
        
            if love.keyboard.isDown('space') and morph_cooldown == 0 then
                love.audio.play(sounds['morph'])
                if  flat == false then
                    player.fixture:destroy()
                    player.shape = love.physics.newRectangleShape(0, 0, 2*l, 2*h)
                    player.fixture = love.physics.newFixture(player.body, player.shape, player.density)
                    flat = true
                elseif self.grow == 1 then
                    player.fixture:destroy()
                    player.shape = love.physics.newPolygonShape(-l*0.8,h, -l*0.8/2,-h, l*0.8/2,-h, l*0.8,h)
                    player.fixture = love.physics.newFixture(player.body, player.shape, player.density)
                    flat = false
                else
                    player.fixture:destroy()
                    player.shape = love.physics.newPolygonShape(-l*0.8,h, -l*0.8/2,-h, 0,-2*h, l*0.8/2,-h, l*0.8,h)
                    player.fixture = love.physics.newFixture(player.body, player.shape, player.density)
                    flat = false
                end
                morph_cooldown = 50
            end
        end
        if morph_cooldown > 0 then 
            morph_cooldown = morph_cooldown - 1
        end
    end
    
    if self.wall > 0 then
        
        if playerWall == false and gameState == 'play' then

            if love.keyboard.isDown('1') then
                love.audio.play(sounds['wall'])
                pWall = {}
                pbrickWidth = 20
                pbrickHeight = 20
                pbrickCount = 24
                
                if player.body:getY()+playerHeight/2 > gameHeight-pbrickHeight then 
                    player.body:setY(player.body:getY()-(player.body:getY()+playerHeight/2 - gameHeight-pbrickHeight)) -- geht besser
                end
            
                for i = pbrickCount, 1, -1 do
                    pbrick = {}
                    pbrick.body = love.physics.newBody(world, 10 + (i-1)*1.135*pbrickWidth, gameHeight-(pbrickHeight/2), "dynamic")
                    pbrick.shape = love.physics.newRectangleShape(pbrickWidth, pbrickHeight)
                    pbrick.fixture = love.physics.newFixture(pbrick.body, pbrick.shape, 100)
                    pWall[i] = pbrick
                end

                playerWall = true
            end
        end
    end
    
    if self.pause > 0 and gameState == 'play' then
        if pause_cooldown == 0 and love.keyboard.isDown('2') then
            love.audio.play(sounds['pause'])
            pause = true
            dxp, dyp = ball.body:getLinearVelocity()
            xp, yp = ball.body:getPosition()
            ball.body:setActive(false)
            dummy = {}
            dummy.body = love.physics.newBody(world, xp, yp, 'static')
            dummy.shape = love.physics.newCircleShape(ball.radius)
            dummy.fixture = love.physics.newFixture(dummy.body, dummy.shape, 1)
            pause_cooldown = 800/self.pause
        end
        
        if pause_cooldown == (800/self.pause)-100*self.pause then
            dummy.fixture:destroy()
            dummy.body:destroy()
            ball.body:setActive(true)
            pause = false
        end
        if pause_cooldown > 0 then
            pause_cooldown = pause_cooldown - 1
        end
    end
    
    if self.speed > 0 and gameState == 'play' then
        if speed_cooldown == 0 and love.keyboard.isDown('3') then
            love.audio.play(sounds['speed'])
            PLAYER_SPEED = PLAYER_SPEED*2
            speed_cooldown = 600
        end
        if speed_cooldown == 400 then
            PLAYER_SPEED = PLAYER_SPEED/2
        end
        if speed_cooldown > 0 then
            speed_cooldown = speed_cooldown - 1
        end
    end

    if self.tele > 0 and gameState == 'play' then
        
        if tele_cooldown == 0 then
            if love.keyboard.isDown('w') or love.keyboard.isDown('a') or love.keyboard.isDown('s') or love.keyboard.isDown('d') and stage ~= 10 then
                love.audio.play(sounds['tele'])
                tele_cooldown = 1500
                dx, dy = ball.body:getLinearVelocity()
                ball.body:setLinearVelocity(dx*0.5,dy*0.5)
                tele = true
            end
        end

        if tele == true then
            if tele_cooldown > 1200 then
                if stage ~= 10 then
                    v = 1
                else
                    v = 3
                end
                if love.keyboard.isDown('w') then
                    ball.body:applyLinearImpulse(0,-v)
                end
                if love.keyboard.isDown('a') then
                    ball.body:applyLinearImpulse(-v,0)
                end
                if love.keyboard.isDown('s') then
                    ball.body:applyLinearImpulse(0,v)
                end
                if love.keyboard.isDown('d') then
                    ball.body:applyLinearImpulse(v,0)
                end
            else
                tele = false
            end
        end

        if tele_cooldown > 0 then
            tele_cooldown = tele_cooldown - 1
        end    
    end
    
end

function Upgrade:render()
    if playerWall == true then
        love.graphics.setColor((playerColor[1]/255)*0.8, (playerColor[2]/255)*0.8, (playerColor[3]/255)*0.8, 1)
        for i = pbrickCount, 1, -1 do
            love.graphics.polygon("fill", pWall[i].body:getWorldPoints(pWall[i].shape:getPoints()))
        end
    end

    if self.speed > 0 then
        if speed_cooldown == 0 then
            love.graphics.setColor(0, 1, 0, 0.6)
        else
            love.graphics.setColor(1, 0, 0, 0.6)
        end
        love.graphics.setFont(stdFont)
        love.graphics.printf('S', -5, gameHeight - 80, gameWidth, 'right')
    end

    if self.pause > 0 then
        if pause_cooldown == 0 then
            love.graphics.setColor(0, 1, 0, 0.6)
        else
            love.graphics.setColor(1, 0, 0, 0.6)
        end
        love.graphics.setFont(stdFont)
        love.graphics.printf('P', -5, gameHeight - 130, gameWidth, 'right')
    end

    if self.tele > 0 then
        if tele_cooldown == 0 then
            love.graphics.setColor(0, 1, 0, 0.6)
        else
            love.graphics.setColor(1, 0, 0, 0.6)
        end
        if tele == true then love.graphics.setColor(1, 0.65, 0.12, 0.6) end
        love.graphics.setFont(stdFont)
        love.graphics.printf('T', -5, gameHeight - 180, gameWidth, 'right')
    end
end

function Upgrade:redline()
    if pause == true then
        love.graphics.setColor(1,0,0,1)
        love.graphics.setLineWidth(0.5)
        love.graphics.setLineStyle('smooth')
        love.graphics.line(xp,yp, xp+dxp*10,yp+dyp*10)

        if dxp > 0 then
            yp2 = yp + (gameWidth-xp)*dyp/dxp
            love.graphics.line(gameWidth,yp2, gameWidth-dxp*10,yp2+dyp*10)
        
        elseif dxp < 0 then
            yp2 = yp - xp*dyp/dxp
            love.graphics.line(0,yp2, -dxp*10,yp2+dyp*10)
            
        end      
    end
end