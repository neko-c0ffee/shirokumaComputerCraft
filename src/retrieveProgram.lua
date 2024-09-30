local baseUrl = 'https://raw.githubusercontent.com/neko-c0ffee/shirokumaComputerCraft/refs/heads/main/src/'

print('Enter the name of the program you want to retrieve')
local pathForRetrieve = read()
print('Enter the destination path')
local pathForSave = read()
print()

print('retrieve : ', pathForRetrieve)
print('save : ', pathForSave)
print('OK? (y|n)')
local okInput = read()
print()

if okInput == 'y' then
  local inputFile = http.get(baseUrl..pathForRetrieve)
  if inputFile ~= nil then
    local outputFile = fs.open(pathForSave, 'w')
    outputFile.write(inputFile.readAll())
    outputFile.flush()
    outputFile.close()
    inputFile.close()
    print('succeed')
  else
    print('retrieve failed')
  end
end
