
StateMachine  = class{}


function StateMachine:init(states)
	self.begin = {
	    enter = function(p) end,
		exit = function() end,
		render = function() end,
		update = function() end,
	}

	self.states = states or {}
	self.current = self.begin

end


function StateMachine:change(stateName,enterParams)
	assert(self.states[stateName])
	self.current:exit()

	self.current = self.states[stateName]()
	print(self.current)
    self.current:enter(enterParams)
end


function StateMachine:render()
	self.current:render()
end


function StateMachine:update(dt)
	self.current:date(dt)
end