Player = Class{}

function Player:init(x, y, width, height, density)
    
    self.density = density
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.shape = love.physics.newRectangleShape(0, 0, width, height)
    self.fixture = love.physics.newFixture(self.body, self.shape, density)
    self.body:setFixedRotation(true)
    
end

function Player:control()
    
    dx, dy = self.body:getLinearVelocity()
    if love.keyboard.isDown("right") then
        self.body:setLinearVelocity(PLAYER_SPEED, dy)
    elseif love.keyboard.isDown("left") then
        self.body:setLinearVelocity(-PLAYER_SPEED, dy)
    else
        self.body:setLinearVelocity(0, dy)
    end
    dx, dy = self.body:getLinearVelocity()
    if self.body:getY() < playerYborder then
        self.body:setLinearVelocity(dx, 0)
        self.body:setY(playerYborder + 1)
    elseif self.body:getY() > (gameHeight-(playerWall == true and 26 or 0) -10) then
        self.body:setLinearVelocity(dx, 0)
        self.body:setY(gameHeight-(playerWall == true and 26 or 0) - 11)
    elseif love.keyboard.isDown("up") then
        self.body:setLinearVelocity(dx, -PLAYER_SPEED/2)
    elseif love.keyboard.isDown("down") then
        self.body:setLinearVelocity(dx, PLAYER_SPEED/2)
    else
        self.body:setLinearVelocity(dx, 0)
    end
end

function Player:render()
    love.graphics.setColor(playerColor[1]/255, playerColor[2]/255, playerColor[3]/255, 1)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end