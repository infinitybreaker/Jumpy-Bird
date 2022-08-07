CountdownState = class{__includes = BaseState}
 
function CountdownState:exit() 


end
COUNT_DOWN = 0.75
function CountdownState:enter() end
function CountdownState:init() 
	self.timer = 0
	self.counter = 3
	--self.bird = Bird()
	--self.pipepairs = {}
end
 
function CountdownState:date(dt) 
    self.timer = self.timer + dt
    if self.timer >= COUNT_DOWN then
    	self.timer= self.timer % COUNT_DOWN
    	self.counter = self.counter - 1
    end

    if self.counter == 0  then
        gStateMachine:change('play')
    end


end
function CountdownState:render() 
	love.graphics.setFont(hugefont)
	love.graphics.printf(self.counter,0,VIRTUAL_HEIGHT/2 - 27,(VIRTUAL_WIDTH/1.5),'center')

end

