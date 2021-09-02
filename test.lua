local MAD = require 'MAD'

local function countD1s()
	local d0 = "/Users/laeh_15/Pictures/red100k/assets/versions"
	local d1s = dir.getdirectories(d0)
	for i, d1 in ipairs(d1s) do
		local vname = path.basename(d1)
		local files = MAD.idir.jpgs(d1)
		MAD.P2(vname, #files)	
	end
end


-- MAD.pixels.img.centerRatioCrop(img, ratio)
-- MAD.pixels.ifile.paddedbox(file, box)

-- local map = torch.FloatTensor(3,ih,iw)

-- local idir = "/Users/laeh_15/LAimages/laeh_pro/2TB/laeh/laeh.images/images.laeh/LA•images/Trees/XX Curation and Mosaics/Red Pornstars/XX.Mosaics.Pornstars/0.04/128*128"

local function mosaic()
	local idir = "/Users/laeh_15/LAimages/laeh_pro/2TB/laeh/laeh.images/images.laeh/LA•images/Trees/XX Curation and Mosaics/Red Pornstars/XX.Mosaics.Pornstars/3"

	local files = MAD.idir.jpgs(idir)
	print(files)
	MAD.img.show(MAD.mosaics.files2map({
		files = files,
		mr = 1.6,
		iw = 128,
		ih = 128,
		quiet = false,
	}))
end

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


for i, color in ipairs(colorsHEX) do
	print(x2r(color))
end



MAD.mosaics.files2map({
	files = files,
	mr = 1,
	iw = 64,
	ih = 64,
})