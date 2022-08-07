-- class Bird is created
Bird = class{}

-- GRAVITY CONST local to this file
local GRAVITY = 18

-- constructor for class bird used to initialise its data members
function Bird:init()
	-- loads bird image from disk and object is assigned 
	self.image = love.graphics.newImage('bird.png')
	--[[ getWidth and getHeight called through self.image object 
	     and width and height are returned respectively]]
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
    -- [[bird rendered at middle of canvas in the genesis ]]
    self.x = VIRTUAL_WIDTH/2 - self.width/2
	self.y = VIRTUAL_HEIGHT/2 - self.height/2
    -- delta change in y preinitialised to zero
	self.dy = 0
	print (self.width)
	print(self.height)
end



function Bird:collide(pipe)


	if (self.x + 3) + (self.width - 6) >= pipe.x and (self.x + 3) <= (pipe.x + pipe.width) then
        if pipe.orientation == 'bottom' then
            if (self.y + 3) + (self.height - 6) >= pipe.y then --and (self.y + 3) <= pipe.y + pipe.height 
                return true
            end
        else
            if (self.y + 3) <= pipe.y then --and (self.y + 3) + (self.height - 6) >= pipe.y - pipe.height 
                return true   
                end     
        end
    end
    return false
end



-- update bird logic 
function Bird:update(dt)
	--[[ during each frame the delta change in y (dy) is increased at 
	     constant rate of 0.25000005 per frame simulating GRAVITY ]]

    self.dy = self.dy + GRAVITY * dt
    --[[if space was pressed in last frame then delta change in y is
    	negated i.e object moves up by 5 pixels ]]
    if love.keyboard.keysPressed['space'] or love.mouse.keysPressed[1] then
        sounds['jump']:play()
        self.dy= -5
    end
    -- updating of y axis pos wrt delta change in y each frame
    self.y = self.y + self.dy
end

-- function to render bird logic each frame
function Bird:render()
	love.graphics.draw(self.image,self.x,self.y)
end
