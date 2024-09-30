local modemSide = 'left'

rednet.open(modemSide)

while true do
  local senderId, message, distance = rednet.receive()

  local func = loadstring(message)
  local isSuccess, err = pcall(func)

  if isSuccess then
    print('#', senderId, ' : ', message)
  else
    print('(error)#', senderId, ' : ', message, ' : ', err)
  end
end
