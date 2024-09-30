local sleepTime = 30

print('start')
print('to exit, press and hold ctrl + t key')

while true do
  local isSuccess = turtle.attack()
  if isSuccess then
    local isDropSuccess = turtle.dropUp()
    if not isDropSuccess then
      print('drop failed')
      break
    end
  end
  sleep(sleepTime)
end
