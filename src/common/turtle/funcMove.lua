-- to load: dofile(shell.resolveProgram('funcMove'))
-- usage: move([forward-distance], [up-distance], [right-distance], [isReturnWhenError (true|false)])

local function moveStraight(direction, distance)
	if distance == 0 then
		return true, 0
	end

	if direction == 'right' then
		turtle.turnRight()
	end

	local resultDistance = distance
	local absDistance = math.abs(distance);
	local isSuccess
	local errMessage
	for i = 1, absDistance, 1 do
		if direction == 'forward' or direction == 'right' then
			if distance > 0 then
				isSuccess, errMessage = turtle.forward()
			else
				isSuccess, errMessage = turtle.back()
			end
		elseif direction == 'up' then
			if distance > 0 then
				isSuccess, errMessage = turtle.up()
			else
				isSuccess, errMessage = turtle.down()
			end
		end

		if not isSuccess then
			print('move failed : ', errMessage)
			resultDistance = i - 1
			if distance < 0 then
				resultDistance = -resultDistance
			end
			break
		end
	end

	if direction == 'right' then
		turtle.turnLeft()
	end

	return isSuccess, resultDistance
end

function move(forwardDistance, upDistance, rightDistance, isReturnWhenError)
	local isSuccess
	local resultDistance
	isSuccess, resultDistance = moveStraight('forward', forwardDistance)
	if not isSuccess then
		if isReturnWhenError then
			moveStraight('forward', -resultDistance)
		end
		return false
	end
	isSuccess, resultDistance = moveStraight('up', upDistance)
	if not isSuccess then
		if isReturnWhenError then
			moveStraight('up', -resultDistance)
			moveStraight('forward', -forwardDistance)
		end
		return false
	end
	isSuccess, resultDistance = moveStraight('right', rightDistance)
	if not isSuccess then
		if isReturnWhenError then
			moveStraight('right', -resultDistance)
			moveStraight('up', -upDistance)
			moveStraight('forward', -forwardDistance)
		end
		return false
	end

	return true
end
