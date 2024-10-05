dofile(shell.resolveProgram('funcMove'))

local selectedItemDetail1 = turtle.getItemDetail(1)
local selectedItemDetail2 = turtle.getItemDetail(2)
assert(selectedItemDetail1 and selectedItemDetail2, 'block for fill is not selected')
local blockForFill1 = selectedItemDetail1.name
local blockForFill2 = selectedItemDetail2.name

local rightOrLeft = ...

if rightOrLeft == nil then
	print('Enter right or left')
	rightOrLeft = read()
	print()

	print(rightOrLeft)
	print('block for fill : ', blockForFill1, ', ', blockForFill2)
	print('OK? (y|n)')
	local okInput = read()

	if okInput ~= 'y' then
		return
	end
end

local function placeBlock(blockNo)
	local blockForFill = blockNo == 1 and blockForFill1 or blockForFill2

	local itemDetail = turtle.getItemDetail(turtle.getSelectedSlot())
	if itemDetail == nil or itemDetail.name ~= blockForFill then
		local isExists = false
		for i = 1, 16, 1 do
			itemDetail = turtle.getItemDetail(i)
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
	if not placeBlock(1) then
		return false
	end
	if not move(0, 1, 0) then
		return false
	end
	if not placeBlock(2) then
		return false
	end

	local moveDirection = isForward and 1 or -1
	while move(moveDirection, -1, 0, true) do
		if not placeBlock(1) then
			return false
		end
		if not move(0, 1, 0) then
			return false
		end
		if not placeBlock(2) then
			return false
		end

		if not isEnoughFuel() then
			return false
		end
	end

	return true
end

local isForward = true
local moveDirection = rightOrLeft == 'right' and 1 or -1
local isSuccess = fillLine(isForward)
isForward = not isForward
if isSuccess then
	while move(0, 0, moveDirection) and move(0, -1, 0) do
		isSuccess = fillLine(isForward)
		isForward = not isForward
		if not isSuccess then
			break
		end
	end
end

print('fill down ', isSuccess and 'succeed' or 'failed')

turtle.select(1)
