dofile(shell.resolveProgram('funcMove'))

print('Enter up or down')
local upOrDown = read()
print('Enter height')
local height = tonumber(read())
print('Enter right or left')
local rightOrLeft = read()
print('Enter width')
local width = tonumber(read())
print()

print(upOrDown, ' ', height, ' , ', rightOrLeft, ' ', width)
print('OK? (y|n)')
local okInput = read()

if okInput ~= 'y' then
	return
end

local currUpPosition = 0
local currRightPosition = 0

local function isEnoughFuel()
	-- 10 is buffer
	if turtle.getFuelLevel() > math.abs(currUpPosition) + math.abs(currRightPosition) + 10 then
		return true
	end
	print('fuel is not enough')
	return false
end

local function fillLine(lineWidth)
	if lineWidth == 0 then
		return false
	end

	turtle.place()

	local absDistance = math.abs(lineWidth) - 1;
	if absDistance == 0 then
		return true
	end

	local moveDirection = lineWidth > 0 and 1 or -1
	for i = 1, absDistance, 1 do
		local isMoveSuccess = move(0, 0, moveDirection)
		if not isMoveSuccess then
			return false
		end
		currRightPosition = currRightPosition + moveDirection
		turtle.place()

		if not isEnoughFuel() then
			return false
		end
	end
	return true
end

local isRight = rightOrLeft == 'right'
local isSuccess = true
for i = 1, height, 1 do
	isSuccess = fillLine(isRight and width or -width)
	if not isSuccess then
		break
	end

	if i ~= height then
		local moveDirection = upOrDown == 'up' and 1 or -1
		isSuccess = move(0, moveDirection, 0)
		if not isSuccess then
			break
		end
		currUpPosition = currUpPosition + moveDirection

		if not isEnoughFuel() then
			isSuccess = false
			break
		end
	end
end

print('fill wall is ', isSuccess and 'succeed' or 'failed')

local isReturnSuccess = move(0, -currUpPosition, -currRightPosition)
print('return to initial position is ', isReturnSuccess and 'succeed' or 'failed')
