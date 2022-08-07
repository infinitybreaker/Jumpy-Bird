PipePair = class{}



function PipePair:init(y)
	self.x = VIRTUAL_WIDTH + 32
	self.y = y
    self.pipegap = math.random(85,115)
	self.pipes = {
		['upper'] = Pipe('top',self.y - self.pipegap),
		['lower'] = Pipe('bottom',self.y)
	} 
	self.remove = false
    self.scored = false
 
end


function PipePair:update(dt)

    if self.x > -PIPE_WIDTH  then
    	self.x = self.x + PIPE_SCROLL * dt
    	self.pipes['lower'].x = self.x
    	self.pipes['upper'].x = self.x
    else
    	self.remove = true
    end
end


function PipePair:render()
    for k,pipe in pairs(self.pipes) do
     	pipe:render()
    end
end



