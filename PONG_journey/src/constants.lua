windowWidth, windowHeight = love.window.getDesktopDimensions()
gameWidth, gameHeight = 540, 720

CPU_STD_SPEED = 100
PLAYER_SPEED = 200
MAX_LIFES = 5
WIN_SCORE = 3

hardmode = false
colorIndex = 1
colorBuilder = false
upgradeMenu = false
startOfPlay = true
playername = ""
colorTimer = 0
stage = 1

playerColor = {255,159,40}
playerYborder = 660
playerWidth = 80
playerHeight = 20
playerScore = 0
totalPlayerScore = 0
score_printed = false
lifes = 5

speed_cooldown = 0
pause_cooldown = 0
tele_cooldown = 0
playerWall = false
pause = false
tele = false

cpuWidth = 100
cpuHeight = 20
cpuScore = 0
cpuWall = false

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