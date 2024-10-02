local baseUrlFormat = 'https://raw.githubusercontent.com/%s/%s/refs/heads/%s/src/'

local userName, repositoryName, branchName = ...
if userName == nil then
  print('usage : retrieveProgram [github userName] [repositoryName] [branchName]')
  print('github userName is required')
  print('if repositoryName is omitted, assume "shirokumaComputerCraft"')
  print('if branchName is omitted, assume "main"')
end

if repositoryName == nil then
  repositoryName = 'shirokumaComputerCraft'
end
if branchName == nil then
  branchName = 'main'
end
local baseUrl = string.format(baseUrlFormat, userName, repositoryName, branchName)

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
  local url = baseUrl..pathForRetrieve
  local inputFile = http.get(url)
  if inputFile ~= nil then
    local outputFile = fs.open(pathForSave, 'w')
    outputFile.write(inputFile.readAll())
    outputFile.flush()
    outputFile.close()
    inputFile.close()
    print('succeed')
  else
    print('retrieve failed. url : ', url)
  end
end
