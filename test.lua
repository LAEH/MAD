local MAD = require 'MAD'

function hex2rgb(hex, alpha)
	local r, g, b = hex:match("(%w%w)(%w%w)(%w%w)")
	r = (tonumber(r, 16) or 0) / 255
	g = (tonumber(g, 16) or 0) / 255
	b = (tonumber(b, 16) or 0) / 255
	return r, g, b, alpha or 1
end
function x2r(hex, alpha)
	local r, g, b = hex:match("(%w%w)(%w%w)(%w%w)")
	r = torch.round( ( ( tonumber(r, 16 ) or 0 ) / 255 ) * 100 )
	g = torch.round( ( ( tonumber(g, 16 ) or 0 ) / 255 ) * 100 )
	b = torch.round( ( ( tonumber(b, 16 ) or 0 ) / 255 ) * 100 )
	return r, g, b, alpha or 1
end


-- local map = torch.ByteTensor(3,size,size)

-- map[1] = torch.uniform(0,255)
-- map[2] = torch.uniform(0,255)
-- map[3] = torch.uniform(0,255)
local colorsHEX = {
	"#2a2e39",
	"#167ffb",
	"#414863",
	"#6c758f",
	"#52596c",
	"#4f5770",
	"#495063",
	"#363d4d",
	"#343844",
	"#b1c0d6",
	"#b1c0d7",
	"#d6e4fb",
	"#44546a",
	"#34445c",
	"#222e3f",
	"#a1e22d",
	"#ed5555",
	"#363c4c",
	"#3b4254",
	"#454e67",
	"#505872",
	"#167ffb",
	"#2a2e39",
	"#e9edf0",
	"#15212b",
	"#000a14",
	"#23262c",
	"#192124",
	"#222c31",
	"#0c36c0",
	"#21252c",
	"#242a32",
	"#081946",
	"#fecb2f",
	"#2d54fb",
	"#fc3e22",
	"#2f3439",
	"#3b4147",
	"#515860",
	"#737c86",
	"#fa0e4d",
	"#ffe10e",
	"#0b2ef5",
	"#2d2e34",
	"#167ffb",
	"#5cfdac",
	"#fd3769",
	"#290c69",
	"#167ffb",
	"#134bc9",
	"#082666",
	"#3e95fc",
	"#383d42",
	"#b8bfca",
	"#35485d",
	"#383d43",
	"#327fd9",
	"#1d82a9",
	"#848893",
	"#8d9299",
	"#60c9f8",
	"#fecb2f",
	"#167ffb",
	"#fc3159",
	"#53d86a",
	"#fd9526",
	"#fc3c39",
	"#8e8f93",
	"#29bb9c",
	"#229f85",
	"#39ca74",
	"#30ad63",
	"#3999d8",
	"#2e81b7",
	"#35485d",
	"#253443",
	"#f0c330",
	"#f19b2c",
	"#e47e30",
	"#d15419",
	"#e54d42",
	"#be3a30",
	"#ecf0f1",
	"#bdc3c7",
	"#7e8c8c",
	"#697475",
	"#2b6d9e",
	"#d74e48",
	"#f62a85",
	"#2083e1",
	"#3c5c92",
	"#535a6b",
	"#fb6f71",
	"#fec683",
	"#37d7b3",
	"#9dedfa",
	"#a3fce1",
	"#a9ffc3",
	"#b0ffac",
	"#efffb0",
	"#fffab0",
	"#ffefb0",
	"#ffe6b0",
	"#ffe0b0",
	"#000617",
	"#111199",
	"#222440",
	"#141424",
	"#0e0f25",
	"#0f1b3a",
	"#000619",
	"#182a5b",
	"#000617",
	"#000000",
	"#ffffff",
	"#f2f2f2",
	"#f91a4f",
	"#ffb71b",
	"#ffe41b",
}


-- for i, color in ipairs(colorsHEX) do
-- 	print(x2r(color))
-- end




--    function formula(n,id)
--       local n = n or 1e6
--       local id = id or torch.round(torch.uniform(1,n))
--       id = id - 1
--       assert(id >= 0 and id < n, 'id must be in [1,n]')
--       local vocab = 26
--       local charS = 97
--       local charE = charS + vocab - 1
--       local elts = 1
--       local chars = 0
--       while true do
--          elts = elts * vocab
--          chars = chars + 1
--          if elts >= n then
--             break
--          end
--       end
--       local cs = {}
--       while true do
--          chars = chars - 1
--          local basis = vocab ^ chars
--          local c = math.floor(id / basis)
--          table.insert(cs, c)
--          id = id - c*basis
--          if chars == 0 then
--             break
--          end
--       end
--       local ccs = {}
--       for i,c in ipairs(cs) do
--          ccs[i] = string.char(charS + c)
--       end
--       return table.concat(ccs,'')
--    end
--    function uid_make(n)
--       local n = n or error("Missing uids number")
--       print('Generating uids')
--       local p = torch.randperm(n)
--       local tbl = {}
--       for i=1, n do
--          xlua.progress(i, n)
--          local uid = formula(n,p[i])
--          table.insert(tbl, 'heaven_'..uid)
--          -- collectgarbage('step')
--       end
--       return tbl
--    end

function formula(n,id)
   local n = n or 1e6
   local id = id or torch.round(torch.uniform(1,n))
   id = id - 1
   assert(id >= 0 and id < n, 'id must be in [1,n]')
   local vocab = 26
   local charS = 97
   local charE = charS + vocab - 1
   local elts = 1
   local chars = 0
   while true do
      elts = elts * vocab
      chars = chars + 1
      if elts >= n then
         break
      end
   end
   local cs = {}
   while true do
      chars = chars - 1
      local basis = vocab ^ chars
      local c = math.floor(id / basis)
      table.insert(cs, c)
      id = id - c*basis
      if chars == 0 then
         break
      end
   end
   local ccs = {}
   for i,c in ipairs(cs) do
      ccs[i] = string.char(charS + c)
   end
   return table.concat(ccs,'')
end
function uid_make(n)
   local n = n or error("Missing uids number")
   print('Generating uids')
   local p = torch.randperm(n)
   local tbl = {}
   for i=1, n do
      xlua.progress(i, n)
      local uid = formula(n,p[i])
      table.insert(tbl, ''..uid)
      -- collectgarbage('step')
   end
   return tbl
end

local fs = {}
fs['art0_uids_1,000,000'] = path.join('data', 'uids', 'art0_1,000,000.th')
MAD.parent(fs['art0_uids_1,000,000'])
if not path.exists(fs['art0_uids_1,000,000']) then
	local uids = uid_make(1000000)
	torch.save(fs['art0_uids_1,000,000'], uids)
end

-- function MADuid.get(opt)
--    opt = opt or {}

--    local n = opt.n or error('How many you idiots ?')
--    local f = opt.f or error('From which list file ?')
--    local ext = path.extension(f)
--    local fname  = stringx.replace( f, ext, '')

--    local ds = {}
--    ds.backups  = stringx.replace( f, ext, '')..'_backup'
--    ds.backup = path.join( ds.backups, MAD.date()..'-'..MADuid.simple(1) )

--    local fs = {}
--    fs.backup_total = path.join( ds.backup, 'total'..ext)
--    fs.backup_sample = path.join( ds.backup, 'sample'..ext)
--    fs.backup_left = path.join( ds.backup, 'left'..ext)

--    print('loading uids from', col.green(f))

--    local uids = torch.load(f)
--    print('available',#uids)

--    local sample = {}
--    for i=1, n do
--       table.insert(sample, uids[i])
--    end

--    local left = {}
--    for i=n+1, #uids do
--       table.insert(left, uids[i])
--    end

--    print('n',n)
--    print('total',#uids)
--    print('sample',#sample)
--    print('left',#left)

--    MAD.file.copy( f, fs.backup_total)
--    torch.save( fs.backup_sample, sample )
--    torch.save( fs.backup_left, left )
--    MAD.file.copy( fs.backup_left, f )

--    print( 'fs.backup_total', fs.backup_total)
--    print( 'fs.backup_sample', fs.backup_sample)
--    print( 'fs.backup_left', fs.backup_left)

--    return sample
-- end
