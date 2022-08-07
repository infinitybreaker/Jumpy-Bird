-- inheritence of BaseState class members into PlayState class


PlayState = class{__includes = BaseState}

function PlayState:enter() end
function PlayState:exit() end

function PlayState:init()
    self.bird = Bird()
--[[ table simulating a linked list or dynamic array to create and destroy 
  pipe objects]]
    self.pipepairs = {}
    self.playerscore = 0
--[[time counter to spawn a new pipe object (after every 2 secs in reference 
   to this code) ]]
    self.spawnTimer = 0 
    self.lastY = math.random(113) + 125
    self.duration = 1
end


function PlayState:date(dt)

    
--  reset keysPressed table at the end of each updation
        -- after each update function timecounter increases by delta time 
    self.spawnTimer = self.spawnTimer + dt
        -- condition if spawntimer becomes greater than 2
    if self.spawnTimer > self.duration then
        --[[ lower and upper bounded height magnitude with the deviation of
        20 pixels(at max) from the preceding magnitude]]
        local y = math.min(VIRTUAL_HEIGHT - 50,
            math.max(self.lastY + math.random(-20,20),125))
        -- preceding spawn height magnitude set to latter 
        self.lastY = y
        -- a new pipe pair is inserted
        table.insert(self.pipepairs,PipePair(y))
        self.spawnTimer = 0
        self.duration = (math.random(3,4)+ math.random())/2
    end


        -- updation of bird pos each frame
    self.bird:update(dt)  
    for k, pair in pairs(self.pipepairs) do
        if pair.remove then
            table.remove(self.pipepairs, k)
        end
    end
    for k ,pair in pairs(self.pipepairs) do
        if not pair.scored then
            if self.bird.x > pair.x + PIPE_WIDTH then
                self.playerscore = self.playerscore + 1
                sounds['score']:play()
                pair.scored = true
            end
        end
    end

    -- iterate through each pipe object spawned 
    for k,pair in pairs(self.pipepairs) do
        -- update each pipe object on each frame execution
        pair:update(dt) 
        for l,pipe in pairs(pair.pipes) do
            if self.bird:collide(pipe) then
                sounds['explode']:play()
                sounds['hurt']:play()
                gStateMachine:change('score',{score = self.playerscore})
            end
        end
    end
    if self.bird.y >= VIRTUAL_HEIGHT - 15 then
        sounds['explode']:play()
        sounds['hurt']:play()
    	gStateMachine:change('score',{score = self.playerscore})
    
    end

end


function PlayState:render()

	-- rendering of bird each frame based on input 
    self.bird:render()
	for k,pair in pairs(self.pipepairs) do
        -- render each pipe instance to canvas
        pair:render()
    end
    love.graphics.setFont(titlefont)
    love.graphics.print('SCORE = ' .. self.playerscore,0,0)

end

