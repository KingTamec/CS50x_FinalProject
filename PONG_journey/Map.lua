Map = Class{}

function Map:init()
    leftBorder = {}
    leftBorder.body = love.physics.newBody(world, 0, gameHeight/2, "static")
    leftBorder.shape = love.physics.newRectangleShape(1, 770)
    leftBorder.fixture = love.physics.newFixture(leftBorder.body, leftBorder.shape)
    
    rightBorder = {}
    rightBorder.body = love.physics.newBody(world, gameWidth, gameHeight/2, "static")
    rightBorder.shape = love.physics.newRectangleShape(1, 770)
    rightBorder.fixture = love.physics.newFixture(rightBorder.body, rightBorder.shape)

end

function Map:loadStage()
    if stage == 4 or stage == 8 then
        bricks = {}
        brickWidth = 20
        brickHeight = 20
        brickCount = 24
        rows = (stage == 4 and 2 or 4)

        for i = rows, 1, -1 do
            bricks[i] = {}
            for j = brickCount, 1, -1 do
                brick = {}
                brick.body = love.physics.newBody(world, 10 + (j-1)*brickWidth + 2*j + (i % 2)*brickWidth/2, (i-1)*brickHeight + brickHeight, "dynamic")
                brick.shape = love.physics.newRectangleShape(brickWidth, brickHeight)
                brick.fixture = love.physics.newFixture(brick.body, brick.shape, 100)
                bricks[i][j] = brick
            end
        end
        cpuWall = true
    end

    if stage == 7 then
        ballcage = {}
        ballcage.body = love.physics.newBody(world, gameWidth/2, gameHeight/2, "static")
        ballcage.shape = love.physics.newCircleShape(30)
        ballcage.fixture = love.physics.newFixture(ballcage.body, ballcage.shape)

        topBorder = {}
        topBorder.body = love.physics.newBody(world, gameWidth/2, -50, "static")
        topBorder.shape = love.physics.newRectangleShape(540, 1)
        topBorder.fixture = love.physics.newFixture(topBorder.body, topBorder.shape)
        
        bottomBorder = {}
        bottomBorder.body = love.physics.newBody(world, gameWidth/2, gameHeight + 50, "static")
        bottomBorder.shape = love.physics.newRectangleShape(540, 1)
        bottomBorder.fixture = love.physics.newFixture(bottomBorder.body, bottomBorder.shape)

        spheres = {}
        sphereCount = 120
        timer = 0

        for i = sphereCount, 1, -1 do
            sphere = {}
            sphere.body = love.physics.newBody(world, math.random(100, gameWidth-100), math.random(150, gameHeight-150), 'dynamic')
            x = math.random(1,3)
            sphere.shape = love.physics.newCircleShape(x*5)
            sphere.fixture = love.physics.newFixture(sphere.body, sphere.shape, x*0.01)
            spheres[i] = sphere
        end
    end

end

function Map:render()
    love.graphics.clear(bgColors[stage][1],bgColors[stage][2],bgColors[stage][3], 1)

    love.graphics.setColor(1,1,1,0.4)
    love.graphics.setLineWidth(4)
    love.graphics.line(0,gameHeight/2, gameWidth/2-32,gameHeight/2)
    love.graphics.line(gameWidth/2+32,gameHeight/2, gameWidth,gameHeight/2)
    love.graphics.circle("line", gameWidth/2, gameHeight/2, 30)

    love.graphics.setColor(cpuColors[stage][1]*0.8, cpuColors[stage][2]*0.8, cpuColors[stage][3]*0.8, 1)

    if stage == 4 or stage == 8 and cpuWall == true then
              
        for i = rows, 1, -1 do
            for j = brickCount, 1, -1 do
                love.graphics.polygon("fill", bricks[i][j].body:getWorldPoints(bricks[i][j].shape:getPoints()))
            end
        end
    end

    if stage == 7 then
        if colorTimer < 100 then
            love.graphics.setColor(cpuColors[stage][1], cpuColors[stage][2], cpuColors[stage][3], 1)
        else
            love.graphics.setColor(0.2,0.2,0.2,1)
        end
        if colorTimer == 0 then
            colorTimer = 400
        else
            colorTimer = colorTimer - 1
        end
        for i = sphereCount, 1, -1 do
            love.graphics.circle("fill", spheres[i].body:getX(), spheres[i].body:getY(), spheres[i].shape:getRadius())
        end
    end
end