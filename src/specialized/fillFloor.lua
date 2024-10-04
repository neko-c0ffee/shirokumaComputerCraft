dofile(shell.resolveProgram('funcMove'))

local selectedItemDetail = turtle.getItemDetail(turtle.getSelectedSlot())
assert(selectedItemDetail, 'block for fill is not selected')
local blockForFill = selectedItemDetail.name

local rightOrLeft = ...

if rightOrLeft == nil then
	print('Enter right or left')
	rightOrLeft = read()
	print()

	print(rightOrLeft)
	print('block for fill : ', blockForFill)
	print('OK? (y|n)')
	local okInput = read()

	if okInput ~= 'y' then
		return
	end
end

local function placeBlock()
	if turtle.getItemCount(turtle.getSelectedSlot()) <= 0 then
		local isExists = false
		for i = 1, 16, 1 do
			local itemDetail = turtle.getItemDetail(i)
			if itemDetail ~= nil and itemDetail.name == blockForFill then
				turtle.select(i)
				isExists = true
				break
			end
		end
		if not isExists then
			print('block for fill is not exists')
			return false
		end
	end
	turtle.placeDown()
	return true
end

local function isEnoughFuel()
	-- 10 is buffer
	if turtle.getFuelLevel() > 10 then
		return true
	end
	print('fuel is not enough')
	return false
end

local function fillLine(isForward)
	local isPlaceSuccess = placeBlock()
	if not isPlaceSuccess then
		return false
	end

	local moveDirection = isForward and 1 or -1
	while move(moveDirection, 0, 0, false) do
		isPlaceSuccess = placeBlock()
		if not isPlaceSuccess then
			return false
		end

		if not isEnoughFuel() then
			return false
		end
	end

	return true
end

local isForward = true
local isSuccess = true
local moveDirection = rightOrLeft == 'right' and 1 or -1
isSuccess = fillLine(isForward)
isForward = not isForward
if isSuccess then
	while move(0, 0, moveDirection) do
		isSuccess = fillLine(isForward)
		isForward = not isForward
		if not isSuccess then
			break
		end
	end
end

print('fill down ', isSuccess and 'succeed' or 'failed')

turtle.select(1)
