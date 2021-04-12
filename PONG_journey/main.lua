-- Final Project of Thomas feuerstein for CS50x 

require 'src/Dependencies'

function love.load()

    math.randomseed(os.time())

    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, {fullscreen = true})
    love.window.setTitle('PONG THE JOURNEY')
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, false)

    gStateMachine = StateMachine {
        ['start'] = function() return StartState() end,
        ['typename'] = function() return TypeNameState() end,
        ['colorchoice'] = function() return ColorChoiceState() end,
        ['gamerules'] = function() return GameRulesState() end,
        ['play'] = function() return PlayState() end,
        ['gameover'] = function() return GameOverState() end,
        ['victory'] = function() return VictoryState() end
    }

    gStateMachine:change('start')

    love.keyboard.keysPressed = {}
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
  push:start()
  gStateMachine:render()
  push:finish()
end