Class  = require 'lib/class'
push = require 'lib/push'
utf8 = require("utf8")
highscore = require 'lib/sick' 
hardmodeHighscore = require 'lib/sick' 

require 'src/Ball'
require 'src/constants'
require 'src/Cpu'
require 'src/Map'
require 'src/Player'
require 'src/StateMachine'
require 'src/Upgrade'

require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/TypeNameState'
require 'src/states/ColorChoiceState'
require 'src/states/GameRulesState'
require 'src/states/PlayState'
require 'src/states/GameOverState'
require 'src/states/VictoryState'

gFonts = {
    ['small'] = love.graphics.newFont('fonts/capture.ttf', 16),
    ['menu'] = love.graphics.newFont('fonts/capture.ttf', 32),
    ['std'] = love.graphics.newFont('fonts/capture.ttf', 64),
    ['double'] = love.graphics.newFont('fonts/capture.ttf', 128),
    ['viper'] = love.graphics.newFont('fonts/viper.ttf', 24),
    ['viperLarge'] = love.graphics.newFont('fonts/viper.ttf', 48)
}

gIcons = {
    ['full_heart'] = love.graphics.newImage('icons/full_heart.png'),
    ['empty_heart'] = love.graphics.newImage('icons/empty_heart.png'),
    ['grow'] = love.graphics.newImage('icons/Grow_Bat.png'),
    ['move_fwd'] = love.graphics.newImage('icons/Move_forward.png'),
    ['pause'] = love.graphics.newImage('icons/pause.png'),
    ['speed'] = love.graphics.newImage('icons/speed.png'),
    ['tele'] = love.graphics.newImage('icons/tele.png'),
    ['wall'] = love.graphics.newImage('icons/wall.png')
}

gSounds = {
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
    ['music2'] = love.audio.newSource('sounds/Karstenholymoly_-_Stardust_(Ziggy_is_coming)_1.mp3', 'static')
}

highscore.set("highscores.txt", 5, "empty", 0)
highscore.add('Hermione', 136)
highscore.add('Alice', 121)
highscore.add('Charlie', 87)
highscore.add('Bob', 62)
highscore.add('Scratch', 45)
highscore.load()

gSounds['player_scores']:setVolume(0.5)
gSounds['win']:setVolume(0.5)
gSounds['music1']:setVolume(0.15)
gSounds['music2']:setVolume(0.15)
love.audio.setVolume(1)