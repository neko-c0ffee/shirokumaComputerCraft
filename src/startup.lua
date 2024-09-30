local sPath = shell.path()
sPath = sPath..':/common'
if turtle then
  sPath = sPath..':/common/turtle'
end

shell.setPath(sPath)
