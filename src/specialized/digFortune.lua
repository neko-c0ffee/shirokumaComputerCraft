local fortuneSide = 'left'

local isSuccess, message = peripheral.call(fortuneSide, 'dig')
if isSuccess then
  print('succeed')
else
  print('failed : ', message)
end
