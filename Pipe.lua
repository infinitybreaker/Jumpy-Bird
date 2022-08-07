Pipe = class{}

local PIPE_IMAGE = love.graphics.newImage('pipe.png')

PIPE_SCROLL = -60

PIPE_HEIGHT = 288
PIPE_WIDTH = 70

function Pipe:init(orientation,y) 

	self.x = VIRTUAL_WIDTH 

	self.y = y

	self.width = PIPE_IMAGE:getWidth()

	self.height = PIPE_HEIGHT

	self.orientation = orientation

end
function Pipe:update(dt)
	

end


function Pipe:render()
	love.graphics.draw(PIPE_IMAGE,self.x,
		self.y,
		0, --rotation
		1, --scale
		self.orientation == 'top' and -1 or 1)
end