local filesForCopy = {'common', 'startup'}

for key, fileName in pairs(filesForCopy) do
  fs.delete(fileName)
  fs.copy('/disk/'..fileName, fileName)
end

print('succeed')
