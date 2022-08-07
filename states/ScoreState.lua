
ScoreState = class{__includes = Basestate}
GOLD_MEDAL = love.graphics.newImage('gold.png')
SILVER_MEDAL = love.graphics.newImage('silver.png')
BRONZE_MEDAL = love.graphics.newImage('bronze.png')

function ScoreState:exit() end

function ScoreState:enter(params)
    self.playerscore = params.score
    print(self.y)
end


function ScoreState:date(dt)
    self.y = 'hello' 
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    	gStateMachine:change('countdown')
    end
end



function ScoreState:render()
	print(self.y)
	love.graphics.setFont(titlefont)
	if self.playerscore >100 then
		love.graphics.draw(GOLD_MEDAL,VIRTUAL_WIDTH/2 - 50,30,0,0.2)
    elseif self.playerscore >50 then
		love.graphics.draw(SILVER_MEDAL,VIRTUAL_WIDTH/2 - 35,50,0,0.2)
    elseif self.playerscore >=10 then
		love.graphics.draw(BRONZE_MEDAL,VIRTUAL_WIDTH/2 - 35,50,0,0.2)		
    end
    
	love.graphics.printf('GAME OVER!',0,160,VIRTUAL_WIDTH,'center')
	love.graphics.printf('SCORE = ' .. self.playerscore,0,185,VIRTUAL_WIDTH,'center')
	love.graphics.setFont(mediumfont)
	love.graphics.printf('Press enter to continue',0,220,VIRTUAL_WIDTH,'center')


end
