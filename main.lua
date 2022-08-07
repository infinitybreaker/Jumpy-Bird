

push = require 'push'
-- require the classic OOP class library
class = require 'class'
--require the Bird file containing Bird class
require 'Bird'
--require the Pipe file containing PIpe class
require 'Pipe'

require 'PipePair'

require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CoundownState'
-- PHYSICAL SCREEN DIMENSIONS(setting original width and height of the window )
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
--VIRTUAL RESOLTUION DIMENSIONS
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288
-- local keyword as the file object is gonna be available within this file only

-- objects for drawbles i.e background mountains and ground respectively
local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

-- starting X-axis position of drawables(background and ground) images respectively
local backgroundScroll = 0
local groundScroll = 0

-- speed of scroll of drawables (pixel shifted per sec)
local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

PAUSE = love.graphics.newImage('pause.png')
local scrolling = true
--object of class Bird defined and init is called by default

-- first function to be called during execution
function love.load()
    -- texture filtering for drawables 
    love.graphics.setDefaultFilter('nearest','nearest')
    dispfont = love.graphics.newFont('font.ttf',8)
    mediumfont = love.graphics.newFont('flappy.ttf',14)
    titlefont = love.graphics.newFont('flappy.ttf',28)
    hugefont = love.graphics.newFont('flappy.ttf',54)
    -- random seeding funtion to seed y start pos of esach pipe object
    math.randomseed(os.time())
    -- cosmetic addition (Adding name to window)
    love.window.setTitle('JUMPY BIRD')


    -- setting up virtual display
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
    	fullscreen = false,
    	resizable = true,
    	vsync = true
    })
    -- table containing keys pressed last frame
    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    sounds = {
        --['explode'] = love.audio.newSource('explosion.wav',static),
        ['jump'] = love.audio.newSource('jump.wav','static'),
        ['hurt'] = love.audio.newSource('hurt.wav','static'),
        ['score'] = love.audio.newSource('score.wav','static'),
        ['music'] = love.audio.newSource('marios_way.mp3','static'),
        ['explode'] = love.audio.newSource('explosion.wav', 'static'),
    }
    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['countdown'] = function() return CountdownState() end
    }

    gStateMachine:change('title')
    
    sounds['music']:setLooping(true)
    sounds['music']:play()
end
-- factor to reset backgroundScroll to 0,0 
local BACKGROUND_LOOPING_POINT = 413
-- factor to reset groundScroll to 0,0 
local GROUND_LOOPING_POINT = 514
-- function to allow resizing of physical window and adjusting the canvas accly.
function love.resize(width,height)
	-- push:resize dynamically rescale the canvas to fit to the screen
	push:resize(width,height)
end
-- function  called each frame
function love.update(dt)
    --dt = delta-time
    if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('P') then
        scrolling = not scrolling == true and sounds['music']:play() or sounds['music']:pause()
    end
    if scrolling then 
        --[[updation of starting X-axis pos of background drawable and 
        ground drawable respectively ]]
        -- loop back to zero each time  loop point is encountered   
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
        % BACKGROUND_LOOPING_POINT   
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt)
        % GROUND_LOOPING_POINT


        gStateMachine:update(dt)   
      
        
    end
    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
  
end



-- callback function called if any key is initially pressed
function love.keypressed(key)
    --[[ the key value pair (keysPressed table) is updated each time key 
        key is pressed initially]]
    love.keyboard.keysPressed[key] = true
    -- if esc is pressed the execution ends
	if key == 'escape' then
        -- function to quit executable
		love.event.quit()
	end
end

function love.mousepressed(x,y,button)
    love.mouse.keysPressed[button] = true
end

-- function to check if a specific key was pressed in last frame
function love.keyboard.wasPressed(key) 
    --[[returns true if key was present in table i.e 
       if the key was pressed during last frame otherwise false]]
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(button)
    return love.mouse.keysPressed[button] 
end

--  function used to render changes to canvas
--  called each frame after update (dt)
function love.draw()
    -- start rendering at virtual resolution
    push:start()
    --[[ to render any drawable taking-in drawable object and
     start pos i.e x,y ]]

    love.graphics.draw(background,-backgroundScroll,0)
    --iterate through each key value pair or each pipe object 
    gStateMachine:render()
    -- ground is rendered on the top of background
    love.graphics.draw(ground,-groundScroll,VIRTUAL_HEIGHT-16)
    if not scrolling  then
        love.graphics.draw(PAUSE,200,94)
    end

    displayFPS()
    -- end rendering at virtual resolution
    push:finish()

end


function displayFPS()
    love.graphics.setFont(dispfont)
    love.graphics.print('FPS = ' .. love.timer.getFPS(),10,40)


end
