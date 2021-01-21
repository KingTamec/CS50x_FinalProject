Cpu = Class{}

reactiontime = 0

function Cpu:init(x, y, width, height, density)
        self.width = width    
        self.startX = X
        self.startY = y

    if stage == 1 then --Normal CPU
        self.body = love.physics.newBody(world, x, y, "dynamic")
        self.shape = love.physics.newRectangleShape(0, 0, width, height)
        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.body:setFixedRotation(true)
        CPU_SPEED = CPU_STD_SPEED

    elseif stage == 2 then -- Slightly bigger CPU
        self.body = love.physics.newBody(world, x, y, "dynamic")
        self.shape = love.physics.newRectangleShape(0, 0, width + 100, height)
        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.body:setFixedRotation(true)
        CPU_SPEED = CPU_STD_SPEED
    
    elseif stage == 3 then -- Fast Normal random shot CPU
        self.body = love.physics.newBody(world, x, y, "dynamic")
        self.shape = love.physics.newRectangleShape(0, 0, width, height)
        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.body:setFixedRotation(true)
        CPU_SPEED = CPU_STD_SPEED*2
        
    elseif stage == 4 then --CPU with 2 row wall
        self.startY = y+60
        self.body = love.physics.newBody(world, x, y+60, "dynamic")
        self.shape = love.physics.newPolygonShape(-100,-20, 100,-20, 80,20, -80,20)
        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.body:setFixedRotation(true)
        CPU_SPEED = CPU_STD_SPEED*1.5
    
    elseif stage == 5 then --Tripple Paddle CPU
        self.body = love.physics.newBody(world, x, y, "dynamic")
        self.body1 = love.physics.newBody(world, x-80, y+100, "dynamic")
        self.body2 = love.physics.newBody(world, x+80, y+100, "dynamic")
        
        self.shape = love.physics.newRectangleShape(0, 0, width, height)
        self.shape1 = love.physics.newRectangleShape(0, 0, width/2, height)
        self.shape2 = love.physics.newRectangleShape(0, 0, width/2, height)
        
        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.fixture1 = love.physics.newFixture(self.body1, self.shape1, density)
        self.fixture2 = love.physics.newFixture(self.body2, self.shape2, density)

        self.body:setFixedRotation(true)
        self.body1:setFixedRotation(true)
        self.body2:setFixedRotation(true)
        CPU_SPEED = CPU_STD_SPEED*1.5    
    
    elseif stage == 6 then -- flat triangle CPU
        self.body = love.physics.newBody(world, x, y, "dynamic")
        self.shape = love.physics.newPolygonShape(-100,-15, 100,-15, 0,15)
        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.body:setFixedRotation(true)
        CPU_SPEED = CPU_STD_SPEED*2.5

    elseif stage == 7 then -- Hantel CPU
        self.startY = y+10
        radius = 30
        self.body = love.physics.newBody(world, x, y+10, "dynamic")
        self.body1 = love.physics.newBody(world, x-80, y+10, "dynamic")
        self.body2 = love.physics.newBody(world, x+80, y+10, "dynamic")
        self.joint1 = love.physics.newWeldJoint(self.body, self.body1, x-40, y, false)
        self.joint2 = love.physics.newWeldJoint(self.body, self.body2, x+40, y, false)

        self.shape = love.physics.newRectangleShape(0, 0, width+20, height)
        self.shape1 = love.physics.newCircleShape(radius)
        self.shape2 = love.physics.newCircleShape(radius)

        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.fixture1 = love.physics.newFixture(self.body1, self.shape1, 1)
        self.fixture2 = love.physics.newFixture(self.body2, self.shape2, 1)

        self.body:setFixedRotation(true)
        self.body1:setFixedRotation(true)
        self.body2:setFixedRotation(true)

        CPU_SPEED = CPU_STD_SPEED*2

    elseif stage == 8 then --CPU with 4 row wall
        self.startY = y+90
        self.body = love.physics.newBody(world, x, y+90, "dynamic")
        self.shape = love.physics.newRectangleShape(0, 0, width, height)
        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.body:setFixedRotation(true)
        CPU_SPEED = CPU_STD_SPEED*1.5

    elseif stage == 9 then -- Triangle Corner CPU
        leftCounter = 0
        rightCounter = 0
        triangle_width = 80
        triangle_height = 160
        l = 40
        self.body = love.physics.newBody(world, x, y-20, "dynamic")
        self.body1 = love.physics.newBody(world, x-280, y-20, "static")
        self.body2 = love.physics.newBody(world, x+280, y-20, "static")
        self.body3 = love.physics.newBody(world, x-140, 200, "dynamic")
        self.body4 = love.physics.newBody(world, x+140, 200, "dynamic")

        self.shape = love.physics.newPolygonShape(-60,15, -50,0, 50,0, 60,15, 0,30)
        self.shape1 = love.physics.newPolygonShape(0,0, 0,triangle_height, triangle_width,0)
        self.shape2 = love.physics.newPolygonShape(0,0, 0,triangle_height, -triangle_width,0)
        self.shape3 = love.physics.newPolygonShape(0,-l, -l/2,0, l/2,0, 0,l)
        self.shape4 = love.physics.newPolygonShape(0,-l, -l/2,0, l/2,0, 0,l)

        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.fixture1 = love.physics.newFixture(self.body1, self.shape1, density)
        self.fixture2 = love.physics.newFixture(self.body2, self.shape2, density)
        self.fixture3 = love.physics.newFixture(self.body3, self.shape3, density)
        self.fixture4 = love.physics.newFixture(self.body4, self.shape4, density)

        self.body:setFixedRotation(true)
        self.body1:setFixedRotation(true)
        self.body2:setFixedRotation(true)
        CPU_SPEED = CPU_STD_SPEED*2
        self.body3:setLinearVelocity(-CPU_SPEED/4, 0)
        self.body4:setLinearVelocity(CPU_SPEED/4, 0)
        

    elseif stage == 10 then -- projectile CPU
        self.body = love.physics.newBody(world, x, y, "dynamic")
        self.shape = love.physics.newRectangleShape(0, 0, width, height)
        self.fixture = love.physics.newFixture(self.body, self.shape, density)
        self.body:setFixedRotation(true)
        CPU_SPEED = CPU_STD_SPEED*2

        projectiles = {}
        projectilesWidth = 20
        projectilesHeight = 80
        i = 1
        d = 1
        projectileTimer = 0
    end
end

function Cpu:control()
    
    if self.body:isDestroyed() == false and stage ~= 9 then
        
        dx, dy = self.body:getLinearVelocity()
        if ball.body:getY() > self.body:getY() then
            if ball.body:getX() < self.body:getX() then
                self.body:setLinearVelocity(-CPU_SPEED, dy)
            else
                self.body:setLinearVelocity(CPU_SPEED, dy)
            end
        else
            if ball.body:getX() > self.body:getX() then
                self.body:setLinearVelocity(-CPU_SPEED/3, dy)
            else
                self.body:setLinearVelocity(CPU_SPEED/3, dy)
            end
        end
        
        dx, dy = self.body:getLinearVelocity()
        if love.physics.getDistance(ball.fixture, self.fixture) < 50 and math.abs(ball.body:getX()-self.body:getX()) < self.width/2 then
            self.body:setLinearVelocity(dx, CPU_SPEED/2)
        elseif self.body:getY() > self.startY then
            self.body:setLinearVelocity(dx, -CPU_SPEED/4)
        else
            self.body:setLinearVelocity(dx, 0)
        end
    end

    if stage == 3 then
        if self.body:isTouching(ball.body) then
            dx, dy = ball.body:getLinearVelocity()
            ball.body:setLinearVelocity(math.random(-200,200), dy)
        end
    end

    if stage == 5 then -- tripple paddle cpu
        --left paddle
        if ball.body:isTouching(self.body1) or ball.body:isTouching(self.body2) then
            love.audio.play(sounds['bat_hit'])
        end

        if ball.body:getY() > self.body1:getY() then
            if self.body1:getX() > (gameWidth/2-40) then
                self.body1:setLinearVelocity(0, 0)
                self.body1:setX((gameWidth/2-40)-1)
            end
            if ball.body:getX() < self.body1:getX() then
                self.body1:setLinearVelocity(-CPU_SPEED*1.5, 0)
            else
                self.body1:setLinearVelocity(CPU_SPEED*1.5, 0)
            end
        else
            if ball.body:getX() > self.body1:getX() then
                self.body1:setLinearVelocity(-CPU_SPEED*1.5, 0)
            else
                self.body1:setLinearVelocity(CPU_SPEED*1.5, 0)
            end
        end
        --right paddle
        if ball.body:getY() > self.body2:getY() then
            if self.body2:getX() < (gameWidth/2+40) then
                self.body2:setLinearVelocity(0, 0)
                self.body2:setX((gameWidth/2+40)+1)
            end
            if ball.body:getX() < self.body2:getX() then
                self.body2:setLinearVelocity(-CPU_SPEED*1.5, 0)
            else
                self.body2:setLinearVelocity(CPU_SPEED*1.5, 0)
            end
        else
            if ball.body:getX() > self.body2:getX() then
                self.body2:setLinearVelocity(-CPU_SPEED*1.5, 0)
            else
                self.body2:setLinearVelocity(CPU_SPEED*1.5, 0)
            end
        end

        if pause == true then
            self.body1:setLinearVelocity(0, 0)
            self.body2:setLinearVelocity(0, 0)
        end
    end

    if stage == 7 then -- Bubble cpu
        if timer == 0 then
            for i = sphereCount, 1, -1 do
                x = spheres[i].shape:getRadius()/5
                spheres[i].body:applyForce(math.random(-x*5,x*5),math.random(-x*5,x*5))
            end
            timer = 10
        else
            timer = timer - 1
        end
    end

    if stage == 9 then  -- Triangle Corner cpu
        
        if ball.body:isTouching(self.body1) or ball.body:isTouching(self.body2) or ball.body:isTouching(self.body3) or ball.body:isTouching(self.body4) then
            love.audio.play(sounds['bat_hit'])
        end

        if ball.body:getX() < self.body:getX() then
            self.body:setLinearVelocity(-CPU_SPEED, 0)
        else
            self.body:setLinearVelocity(CPU_SPEED, 0)
        end
        if self.body:getX() < (triangle_width+50) then
            self.body:setLinearVelocity(0, 0)
            x = self.body:getX()
            self.body:setX(x +1)
        elseif self.body:getX() > (gameWidth-triangle_width-50) then
            self.body:setLinearVelocity(0, 0)
            x = self.body:getX()
            self.body:setX(x -1)
        end

        if self.body1:isTouching(ball.body) then
            dx, dy = ball.body:getLinearVelocity()
            ball.body:setLinearVelocity((math.abs(dx)+math.abs(dy))/3,0)
            leftCounter = 100
        end
        if leftCounter > 0 then
            dx, dy = ball.body:getLinearVelocity()
            ball.body:setLinearVelocity(dx - 2, dy + 3)
            leftCounter = leftCounter - 1
        end

        if self.body2:isTouching(ball.body) then
            dx, dy = ball.body:getLinearVelocity()
            ball.body:setLinearVelocity(-(math.abs(dx)+math.abs(dy))/3,0)
            rightCounter = 100
        end
        if rightCounter > 0 then
            dx, dy = ball.body:getLinearVelocity()
            ball.body:setLinearVelocity(dx + 2, dy + 3)
            rightCounter = rightCounter - 1
        end

        if self.body3:getX() > gameWidth/2 - (l+5) then
            self.body3:setLinearVelocity(-CPU_SPEED/4, 0)
        elseif self.body3:getX() < l+5 then
            self.body3:setLinearVelocity(CPU_SPEED/4, 0)
        end    

        if self.body4:getX() < gameWidth/2 + l+5 then
            self.body4:setLinearVelocity(CPU_SPEED/4, 0)
        elseif self.body4:getX() > gameWidth - (l+5) then
            self.body4:setLinearVelocity(-CPU_SPEED/4, 0)
        end    
        
        self.body3:setAngularVelocity(1)
        self.body4:setAngularVelocity(-1)

        if pause == true then
            self.body:setLinearVelocity(0, 0)
            self.body3:setAngularVelocity(0)
            self.body4:setAngularVelocity(0)
        end
    end

    if stage == 10 then -- Projectiles CPU
        
        if projectileTimer == 0 then
            projectile = {}
            projectile.body = love.physics.newBody(world, love.math.random(0,1)*gameWidth/2 + love.math.random(20, gameWidth/2-20), 40, "dynamic")
            projectile.shape = love.physics.newPolygonShape(0,0, -projectilesWidth/2,projectilesHeight, projectilesWidth/2,projectilesHeight)
            projectile.fixture = love.physics.newFixture(projectile.body, projectile.shape, 10000000000)
            projectiles[i] = projectile
            projectiles[i].body:setLinearVelocity(0, CPU_SPEED)

            projectileTimer = 75
            i = i + 1
        end
        projectileTimer = projectileTimer - 1

        for j = i-1, d, -1 do
            if projectiles[j].body:getY() >= gameHeight - projectilesHeight - 40 then
                projectiles[j].fixture:destroy()
                projectiles[j].body:destroy()
                d = d + 1
            end
        end
    end
end

function Cpu:render()
    
    if stage < 11 then
        love.graphics.setColor(cpuColors[stage][1], cpuColors[stage][2], cpuColors[stage][3], 1)
    end
 
    if stage == 1 then
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
    
    elseif stage == 2 then
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

    elseif stage == 3 then
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

    elseif stage == 4 then
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

    elseif stage == 5 then -- tripple paddle cpu
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.polygon("fill", self.body1:getWorldPoints(self.shape1:getPoints()))
        love.graphics.polygon("fill", self.body2:getWorldPoints(self.shape2:getPoints()))

    elseif stage == 6 then
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

    elseif stage == 7 then -- bubble CPU
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.circle("fill", self.body1:getX(), self.body1:getY(), radius)
        love.graphics.circle("fill", self.body2:getX(), self.body2:getY(), radius)

    elseif stage == 8 then
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))

    elseif stage == 9 then
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
        love.graphics.polygon("fill", self.body1:getWorldPoints(self.shape1:getPoints()))
        love.graphics.polygon("fill", self.body2:getWorldPoints(self.shape2:getPoints()))
        love.graphics.polygon("fill", self.body3:getWorldPoints(self.shape3:getPoints()))
        love.graphics.polygon("fill", self.body4:getWorldPoints(self.shape4:getPoints()))


    elseif stage == 10 then
        love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
        
        love.graphics.setColor(cpuColors[stage][1]*0.8, cpuColors[stage][2]*0.8, cpuColors[stage][3]*0.8, 1)
        for j = i-1, d, -1 do
            love.graphics.polygon("fill", projectiles[j].body:getWorldPoints(projectiles[j].shape:getPoints()))
        end
            
    end

end

