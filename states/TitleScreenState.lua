
-- inheritance of BaseState members into TitleScreenState class
TitleScreenState = class{__include = BaseState}

function TitleScreenState:enter() end
function TitleScreenState:exit() end

function TitleScreenState:render()
	love.graphics.setFont(hugefont)
	love.graphics.printf('JUMPY BIRD!',0,100,VIRTUAL_WIDTH,'center')
	love.graphics.setFont(mediumfont)
	love.graphics.printf('enter to play',0,160,VIRTUAL_WIDTH,'center')
end


function TitleScreenState:date(dt)
	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
		gStateMachine:change('countdown')
	end
end
