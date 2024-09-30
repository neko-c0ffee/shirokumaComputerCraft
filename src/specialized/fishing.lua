local sleepTime = 30

print('fishing start')

while true do
  if turtle.getFuelLevel() <= 0 then
    print('out of fuel')
    break
  end
  turtle.attack()
  sleep(sleepTime)
  local isFishingSuccess, fishingMessage = turtle.dig()
  print('fishing ', isFishingSuccess and 'success' or 'failed : ', fishingMessage)
  if isFishingSuccess then
    local isDropSuccess, dropMessage = turtle.dropUp()
    if not isDropSuccess then
      print('drop failed : '. dropMessage)
      break
    end
  end
end

print('fishing finish')
