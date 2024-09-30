local fileList = fs.list('')
for key, fileName in pairs(fileList) do
  if fileName ~= 'disk' and fileName ~= 'rom' then
    local destination = '/disk/'..fileName
    fs.delete(destination)
    fs.copy(fileName, destination)
  end
end

print('succeed')
