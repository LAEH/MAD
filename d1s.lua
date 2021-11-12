local MAD = require 'MAD'
local d0 = "/Users/laeh_15/BRUT/Brut.Videos/assets/deduped/by_256"
   -- local command = 'cd "'..d0..'"&& find . -empty -type d -delete'
   -- os.execute(command)
local ext = '.jpg'
-- local d1s = dir.getdirectories(d0)
-- for i, d1 in ipairs(d1s) do
-- 	print(d1)
-- end

--[[🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁]]

local run = true

if run then
	local ofile = d0..'-counts-d1s.txt'
	local f = io.open(ofile, 'w')
	local d1s = dir.getdirectories(d0)
	local tosort = {}
	for i, d1 in ipairs(d1s) do
		print(d1)
		local files = MAD.idir.jpgs(d1,'reparse')
		if #files > 0 then
			local name = path.basename(stringx.replace(d1, d0, ''))
			table.insert(tosort, {
				name = name,
				count = #files
			})
		end
	end


	f:write(d0, "\n")
	f:write("🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁", "\n")
	f:write("BYCOUNT", "\n")
	f:write("🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁", "\n")
	f:write("_", "\n")

	table.sort(tosort, function(a,b) return a["count"] < b["count"]  end)
	for i, folder in ipairs(tosort) do
		local name = stringx.ljust(folder.name, 60)
		local count = stringx.ljust(tostring(MAD.number2comas(folder.count)), 20)
		f:write(name..' = '..count, "\n")
	end
	f:write("_", "\n")


	f:write("🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁", "\n")
	f:write("BYNAME", "\n")
	f:write("🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁🏁", "\n")
	f:write("_", "\n")

	table.sort(tosort, function(a,b) return a["name"] < b["name"]  end)
	for i, folder in ipairs(tosort) do
		local name = stringx.ljust(folder.name, 60)
		local count = stringx.ljust(tostring(MAD.number2comas(folder.count)), 20)
		f:write(name..' = '..count, "\n")
	end

	f:write("_", "\n")
	f:close()

	os.execute('open "'..ofile..'"')
end

