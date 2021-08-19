local col = require 'async.repl'.colorize
local image = require 'image'
local home = os.getenv('HOME')

--[[
    luarocks install https://raw.githubusercontent.com/LAEH/MAD/master/mad-scm-1.rockspec
]]


local MAD = {}

MAD.trash = path.join(home, 'tmp_trash') dir.makepath(MAD.trash)

MAD.black = col.black
MAD.Black = col.Black
MAD.blue = col.blue
MAD.Blue = col.Blue
MAD.cyan = col.cyan
MAD.Cyan = col.Cyan
MAD.green = col.green
MAD.Green = col.Green
MAD.magenta = col.magenta
MAD.Magenta = col.Magenta
MAD.red = col.red
MAD.Red = col.Red
MAD.white = col.white
MAD.White = col.White
MAD.yellow = col.yellow
MAD.Yellow = col.Yellow


function MAD.rdmMinMax()
    local a = torch.uniform(0, 1)
    local b = torch.uniform(0, 1)
    return {
        min = math.min(a,b),
        max = math.max(a,b),
    }
end
function MAD.rdmidx(min, max)
    local a = torch.round(torch.uniform(min, max))
    return {
        min = math.min(a,b),
        max = math.max(a,b),
    }
end
function MAD.file2id(file)
    return stringx.replace(path.basename(file), path.extension(file), '')
end
function MAD.d1s(d0)
    return dir.getdirectories(d0)
end
function MAD.parent(file)
    dir.makepath(path.dirname(file))
end
function MAD.load(f)
    print('loading:', col.green(f))

    local data
    local ext = path.extension(f)

    if ext == '.th' then
        data = torch.load(f)
    end
    if ext == '.csv' then
        data = MAD.csv.load(f)
    end
    if ext == '.json' then
        data = MAD.json.load(f)
    end
    print(col.green('loaded:'), col.Green(f))
    return data
end
function MAD.home()
    return os.getenv('HOME')
end
function MAD.timestamp()
    local date = os.date("%x")
    local date_string = stringx.replace(date, '/', '-')
    month2prettymonth = {
        ['01'] = "Janvier",
        ['02'] = "Fevrier",
        ['03'] = "Mars",
        ['04'] = "Avril",
        ['05'] = "Mai",
        ['06'] = "Juin",
        ['07'] = "Juillet",
        ['08'] = "Aout",
        ['09'] = "Septembre",
        ['10'] = "Octobre",
        ['11'] = "Novembre",
        ['12'] = "Decembre",
    }
    local month = string.sub(date_string,0, 2)
    local prettyMonth = month2prettymonth[month]
    date_string = prettyMonth..string.sub(date_string,3)
    local time = os.date("*t")
    local time_string = ("%02dh%02dm%02ds"):format(time.hour, time.min, time.sec)
    local time_string = ("%02dh%02dm"):format(time.hour, time.min)
    local time_stamp = string.upper(date_string..'_'..time_string)
    local time_stamp = col.yellow(date_string)..' '..col.Yellow(time_string)
    return time_stamp
end
function MAD.date()
    local date = os.date("%x")
    local date_string = stringx.replace(date, '/', '-')
    month2prettymonth = {
        ['01'] = "Janvier",
        ['02'] = "Fevrier",
        ['03'] = "Mars",
        ['04'] = "Avril",
        ['05'] = "Mai",
        ['06'] = "Juin",
        ['07'] = "Juillet",
        ['08'] = "Aout",
        ['09'] = "Septembre",
        ['10'] = "Octobre",
        ['11'] = "Novembre",
        ['12'] = "Decembre",
    }
    local month = string.sub(date_string,0, 2)
    local prettyMonth = month2prettymonth[month]
    date_string = prettyMonth..string.sub(date_string,3)
    return date_string
end
function MAD.uid(l)
    l = l or 1
    local tbl = {}
    for i=1, l do
        table.insert(tbl,string.lower(os.tmpname():gsub('/tmp/lua_', '')))
    end
    return table.concat(tbl)
end
function MAD.number2comas(n)
   local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
   return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end
function MAD.FormatNumber(Number,opt)
    opt = opt or {}
    local c = a or opt.character or '0'
    local w = a or opt.width or 3
    local o = string.format('%'..c..w..'d', Number)
    return o
end
function MAD.FormatNumberTest()
    print(MAD.FormatNumber(809810974697,{
        character = '0',
        width = 16
    }))
end
function MAD.PrettyNumber(n)
   local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
   local str = left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
   return str
end
function MAD.PrettyNumberTest()
    print(MAD.PrettyNumber(809810974697))
end
function MAD.P2(one, two, opt)
    local one, two = tostring(one), tostring(two)
    opt = opt or {}
    local w1 = opt.w1 or 60
    local w2 = opt.w2 or 20
    local h1 = opt.h1 or 'green'
    local h2 = opt.h2 or 'Green'
    local s1 = col[h1]( stringx.rjust( one, w1 ) )
    local s2 = col[h2]( stringx.ljust( two, w2 ) )
    print('    '..s1..' '..s2)
end
function MAD.range(min,max,step)
    local step = step or 1
    local min = min or 1
    local nsteps = max/step
    local range = {}
    for i=min,nsteps do
        range[i]=i*step
    end
    return range
end
function MAD.totar(idir)
   local ofile = idir..'.tar.gz'
   os.execute('tar -czvf '..ofile..' '..idir)
end

MAD.number = {}
MAD.number.pad = MAD.FormatNumber

MAD.print = {}

function MAD.print.P2(one, two, opt)
    local one, two = tostring(one), tostring(two)
    opt = opt or {}
    local w1 = opt.w1 or 16
    local w2 = opt.w2 or 12
    local h1 = opt.h1 or 'Green'
    local h2 = opt.h2 or 'Yellow'
    local s1 = col[h1]( stringx.rjust( one, w1 ) )
    local s2 = col[h2]( stringx.ljust( two, w2 ) )
    print('    '..s1..' '..s2)
end
function MAD.print.P2TEST()
    Print2('PrettyNumber', PrettyNumber(139788), {
        w1 = 16,
        w2 = 12,
        h1 = 'magenta',
        h2 = 'Magenta',
    })
end
function MAD.print.colors()
    print( col['red']('red'), col['Red']('Red') )
    print( col['blue']('blue'), col['Blue']('Blue') )
    print( col['cyan']('cyan'), col['Cyan']('Cyan') )
    print( col['black']('black'), col['Black']('Black') )
    print( col['green']('green'), col['Green']('Green') )
    print( col['white']('white'), col['White']('White') )
    print( col['yellow']('yellow'), col['Yellow']('Yellow') )
    print( col['magenta']('magenta'), col['Magenta']('Magenta') )
end
function MAD.print.d1s(d0)
    local d1s = dir.getdirectories(d0)
    for i, d1 in ipairs(d1s) do
        print(d1) 
    end
end
function MAD.print.two(one, two)
   one = stringx.ljust(tostring(one)..' : ', 40)
   two = stringx.ljust(tostring(two), 40)
   print( col.White(one), col.Blue(two) )
end
function MAD.print.fun(function_name)
   local str_function = col.Yellow(stringx.rjust('function',40))
   local str_name = col.Blue(stringx.ljust(function_name, 48))
   print(str_function..' '..str_name)
end
function MAD.print.title(str)
    local str = string.upper(str)
    local length = string.len(str)
    local line = {}
    for i=1, length do
        table.insert(line, '=')
    end
    line_str = table.concat(line)

    print('')
    print(col.Red(str))
    print(col.red(line_str))
    print('')
end
function MAD.print.fonction(str, color1, color2)
    local color1 = color1 or 'Red'
    local color2 = color2 or 'red'
    local length = string.len(str)
    local line = {}
    for i=1, length do
        table.insert(line, '=')
    end
    line_str = table.concat(line)

    print('')
    print(col[color1](str))
    print(col[color2](line_str))
    print('')
end

MAD.list = {}

function MAD.list.createRange(min,max,step)
    local step = step or 1
    local min = min or 1
    local nsteps = max/step
    local range = {}
    for i=min,nsteps do
        range[i]=i*step
    end
    return range
end
function MAD.list.grid(ncol, nrow)
    local samples = {}
    for i = 1, ncol do
        for j = 1, nrow do
            local gridPositions = {
            ['a'] = {
                ['x'] = i,
                ['y'] = j,
            },
            ['b'] = {
                ['x'] = i+1,
                ['y'] = j+1,
            }
            }
            table.insert(samples,gridPositions)
        end
    end
    return samples
end
function MAD.list.permute(list)
    for i = 1, #list do
        -- xlua.progress(i, #list)
        local  j = torch.random(i,#list)
        list[i], list[j] = list[j], list[i]
    end
    return list
end
function MAD.list.sampleOne(list)
    return list[torch.random(1, #list)]
end
function MAD.list.sample(list, n)
    local olist = {}
    local list = MAD.list.permute(list)
    for i=1, n do
        table.insert(olist, list[i])
    end
    return olist
end
function MAD.list.nbin(list, nbin)
    local n = #list
    local count = 0
    local s = math.floor(n/nbin)
    local binned = {}
    for i=1, nbin do
        binned[i] = {}
        local oj = (s*(i-1))
        for j=oj, oj+s do
            count = count + 1
            table.insert(binned[i], list[count])
        end
    end
    return binned
end
function MAD.list.flip(list)
    local flipped = {}
    local total = #list
    for i, elt in ipairs(list) do
        flipped[i] = list[total - i + 1]
    end
    return flipped
end
function MAD.list.factorial(n)
   if n == 0 then
        return 1
    else
        return n * fun.factorial(n - 1)
    end
end
function MAD.list.countpairs(pairsTable)
    local c = 0
    for k, v in pairs(pairsTable) do
        c = c + 1
    end
    return c
end
function MAD.list.bin(list, nbin)
    local n = #list
    local count = 0
    local s = math.floor(n/nbin)
    local rest = n - (s * nbin)
    local binned = {}
    for i=1, nbin do
        binned[i] = {}
        local oj = (s*(i-1))
        for j=oj, oj+s do
            count = count + 1
            table.insert(binned[i], list[count])
        end
    end
    return binned
end
function MAD.list.binSize(list, binSize)
    local nbin = math.floor(#list/binSize)
    local idx = 0
    local binned = {}
    for i=1, nbin do
        binned[i] = {}
        for j=1, binSize do
            idx = idx + 1
            table.insert(binned[i], list[idx])
        end
    end
    return binned
end

MAD.tbl = {
    length = function(tbl)
        local c = 0
        for k, v in pairs (tbl) do
            c = c + 1
        end
        return c
    end,
    bin = function (tbl, nbin)
        local N = MAD.tbl.length(tbl)
        local sbin = torch.round(N/nbin)

        local binSizes = {}
        local sum = 0
        for i=1, nbin - 1 do
            binSizes[i] = sbin
            sum = sum + binSizes[i]
        end
        binSizes[nbin] = N - sum

        local sum = 0
        for _, binSize in ipairs(binSizes) do
            sum = sum + binSize
        end

        local cumul = 0
        local binsMinMax = {}
        for b, binSize in ipairs(binSizes) do
            cumul = cumul + binSizes[b]
            binsMinMax[b] = {
                min = cumul - binSizes[b] + 1,
                max = cumul
            }
            if b == nbin then binsMinMax[b].max = N end
        end

        local tbl_binned = {}
        for i=1, #binsMinMax do
            tbl_binned[i] = {}
        end
        local c = 0
        for k, v in pairs(tbl)do
            c = c + 1
            for i=1, #binsMinMax do
                if c >= binsMinMax[i].min and c < binsMinMax[i].max then
                    tbl_binned[i][k] = v
                end
            end
        end
        return tbl_binned
    end,
}

MAD.csv = {
    load = function(fcsv)
       local csvigo = require('csvigo')
       return csvigo.load{path=fcsv}
    end,
    save = function(fcsv, tbl)
       local csvigo = require('csvigo')
       csvigo.save{data=tbl, path=fcsv}
    end
}

MAD.file = {
   copy = function(ifile, ofile)
      if not path.exists(ofile) then
         MAD.parent(ofile)
         local command = 'cp -r "'..ifile..'" "'..ofile..'"'
         os.execute(command)
      end
   end,
   move = function(ifile, ofile)
      MAD.parent(ofile)
      local command = 'mv "'..ifile..'" "'..ofile..'"'
      os.execute(command)
   end,
   trash = function(file)
      local home = os.getenv('HOME')
      local trash = path.join(home, '_trash')
      local name = path.basename(file)
      local ofile = path.join(trash, MAD.uid(1)..'-'..name)
      MAD.parent(ofile)
      local command = 'mv "'..file..'" "'..ofile..'"'
      os.execute(command)
   end,
   name = function (ifile)
      local basename = path.basename(ifile)
      local ext = path.extension(basename)
      local name = stringx.replace(basename, ext, "")
      return name
   end,
   size = function(f)
      local command = 'stat -f "%z" "' ..f..'"'
      local s = tonumber( sys.execute(command) )
      s = torch.round(s/10000)/100
      return s
   end,
}


function MAD.file.isImage(file)
   local function isImage(binary)
      local c = string.char
      local numbers = {
         [c(0xff)..c(0xd8)..c(0xff)] = 'JPEG',
         [c(0x89)..c(0x50)..c(0x4e)..c(0x47)] = 'PNG',
      }
      local families = {
         JPEG = 'image',
         PNG = 'image',
      }
      local type = numbers[binary:sub(1,1)] or numbers[binary:sub(1,3)] or numbers[binary:sub(1,4)]or numbers[binary:sub(1,3)..'_'..binary:sub(5,8)]
      local family = families[type]
      return type,family
   end
   local f = io.open(file)
   if f then
      local magic = f:read(8)
      f:close()
      if not magic or #magic < 8 then
         return
      end
         return isImage(magic)
   end
end
function MAD.file.unzip(ifile, odir)
   local cmd = 'unzip "'..ifile..'" -d "'..odir..'"'
   os.execute(cmd)
end
function MAD.file.writekeyword(file, towrite)
    local command = 'exiftool -keywords+='..towrite..' "'..file..'"'
    os.execute(command)
end
function MAD.file.keywords(ifile)
   local p = io.popen('identify -verbose "' .. ifile .. '" | grep Keyword')
     -- print(p)
     local s = p:read('*all')
     -- print(s)
     p:close()
     local keywords = stringx.split(s,'\n')
     local parsed = {}
     for i,keyword in ipairs(keywords) do
        local _,_,keyword = keyword:find('%:.(.*)$')
        if keyword then
           table.insert(parsed, keyword)
       end
   end
   return parsed
end

MAD.files = {}

function MAD.files.copy_flat(files, odir)

    for i, file in ipairs(files) do
        xlua.progress(i,#files)
        local ofile = path.join(odir, path.basename(file))
        if not path.exists(ofile) then
            MAD.file.copy(file, ofile)
        end
    end
end
function MAD.files.bin(files, nbin)
    local n = #files
    local count = 0
    local s = math.floor(n/nbin)
    local rest = n - (s * nbin)
    local binned = {}
    for i=1, nbin do
        binned[i] = {}
        local oj = (s*(i-1))
        for j=oj, oj+s do
            count = count + 1
            table.insert(binned[i], files[count])
        end
    end
    return binned
end

MAD.idir = {}

function MAD.idir.getfiles(idir)
   print('')
   print(col.green(idir))
   print('')
   local count = 0
   local files = {}
   for file in dir.dirtree(idir) do
      if path.isfile(file) then
         table.insert(files, file)
      end
      io.write(' files found = '..count, '\r') io.flush()
   end
   return files
end
function MAD.idir.jpgs(idir, reparse)
    local fjpgs = idir..'_jpgs.th'
    local fids = idir..'_ids.th'
    local function run()
        local n = 0
        local files = {}
        local ids = {}
        for file in dir.dirtree(idir) do
            if path.isfile(file) and path.extension(file) == '.jpg' then
                table.insert(files,file)
                table.insert(ids,path.basename(file))
                n = n + 1
            end
            local n_str  = tostring(n)
            n_str = MAD.number2comas(n)
            n_str = stringx.rjust(n_str, 12)
            if not quiet then
                io.write('n jpgs = ',col.Cyan(n_str), '\r') io.flush()
            end
        end
        torch.save(fjpgs, files)
        torch.save(fids, ids)
    end
    if not path.exists(fjpgs) or reparse == 'reparse' then
        run()
    end
    return torch.load(fjpgs)
end
function MAD.idir.jpgsleafs(idir, quiet)
    MAD.print.title("MAD.idir.jpgsleafs")
    local dirs = {}
    local leafs = {}
    local n = 0
    for file in dir.dirtree(idir) do
        if path.extension(file) == '.jpg'then
            local p = paths.dirname(file)
            if not dirs[p] then
                dirs[p] = 1
                n = n + 1
                local ns = string.format('% 9d',n)
                if not quiet then
                    io.write('images direcories found',col.Cyan(ns), '\r') io.flush()
                end
            end
        end
    end
    local n = 0
    for idir, stuff in pairs(dirs) do
        n=n +1
        table.insert(leafs, idir)
    end
    return leafs
end
function MAD.idir.d1s(d0)
   -- MAD.print.function_name('MAD.idir.d1(d0)')
   return dir.getdirectories(d0)
end
function MAD.idir.d2s(d0)
   local d1s = dir.getdirectories(d0)
   local d2s = {}
   for i, d1 in ipairs(d1s) do
        local d2s = dir.getdirectories(d0)
        for j, d2 in ipairs(d2s) do
            table.insert(d2s, d2)
        end
    end
    return d2s
end
function MAD.idir.ext2files(idir)
    opt = opt or {}
    local supportedExtensions =  {
        images = {
            ['.jpg'] = true,
            ['.jpeg'] = true,
            ['.png'] = true,
        },
        videos = {
            ['.gif'] = true,
            ['.mp4'] = true,
            ['.mv4'] = true,
        },
    }
    MAD.print.title('ext2files')
    local files = {}
    for file in dir.dirtree(idir) do
        if path.isfile(file) then
            table.insert(files, file)
        end
    end

    local n = {
        files = #files,
        ifiles = 0
    }
    local nfiles = #files
    local ext2files = {}
    for i, file in ipairs(files) do
        xlua.progress(i, #files)
        local ext = path.extension(file)
        ext2files[ext] = ext2files[ext] or {}
        table.insert(ext2files[ext], file)
    end
    for ext, files in pairs(ext2files) do
        local name = col.red( stringx.rjust( ext , 16) )
        local count = col.White( stringx.ljust( MAD.number2comas(#files) , 7) )
        print(name..' '..count)
    end
    local totalImages = 0
    for ext, files in pairs(ext2files) do
        if supportedExtensions.images[string.lower(ext)] then
            n.ifiles = n.ifiles + #files
        end
    end
    print(n)
    for ext, files in pairs(ext2files) do
        print( col.Magenta(ext),col.Green(#files) )
    end
    return ext2files
end
function MAD.idir.copyflat(idir, odir)
   MAD.files.copy_flat(MAD.idir.jpgs(idir), odir)
end
function MAD.idir.removeEmpty(idir)
   MAD.print.fun("MAD.idir.removeEmpty()")
   local cd = 'cd "'..idir..'"; '
   local command = 'cd "'..idir..'"&& find . -empty -type d -delete'
   os.execute(command)
end
function MAD.idir.removeNotJpg(idir)
   local odir = "/Users/laeh/_TMP_trash"
   local ext2files = MAD.idir.ext2files(idir)
   for ext, files in pairs(ext2files) do
      MAD.print.two(ext, '#files')
      if ext ~= '.jpg' then
         for i, file in ipairs(files) do
            xlua.progress(i, #files)
            local ofile = path.join('/Users/laeh_pro/tmp_trash', path.basename(file))
            MAD.parent(ofile)
            MAD.file.move(file, ofile)
         end
      end
   end
end
function MAD.idir.alphaOFF(idir)
   local cmd1 = 'cd "'..idir..'" && find . -name "*.jpeg" -exec convert "{}" -alpha off "{}" \\;'
   print(cmd1) os.execute(cmd1)

   local cmd2 = 'cd "'..idir..'" && find . -name "*.jpg" -exec convert "{}" -alpha off "{}" \\;'
   print(cmd2) os.execute(cmd2)

   local cmd3 = 'cd "'..idir..'" && find . -name "*.png" -exec convert "{}" -alpha off "{}" \\;'
   print(cmd3) os.execute(cmd3)

   os.execute('cd "'..idir..'"&& find . -empty -type d -delete')
-- end
function MAD.idir.d1scounts(d0)
    local counts = {}
    local total = 0
    local d1s = dir.getdirectories(d0)
    for i, d1 in ipairs(d1s) do
        local res = MAD.idir.getfiles(d1)
        local files = res.files
        local n = #files
        total = total + n
        local str = stringx.rjust(path.basename(d1), 40)..' = '..tostring(n)
        table.insert(counts, str)
            -- print(col.magenta(d1))
            -- flatten(d1)
    end
    print(counts)
    print("total", total)
end
function MAD.idir.countByExtension(idir, exts)
   local ext2count = {}
   for e, ext in ipairs( exts ) do
      local cmd = 'find "'..idir..'"'..' -name "*'..ext..'" -type f | wc -l'
      local n = sys.execute(cmd)
      ext2count[ext] = n
      print( n, col.Magenta(ext),col.Green(idir) )
   end
   return ext2count
end

MAD.json = {}

function MAD.json.save(ofile, tbl)
    local lunajson = require 'lunajson'
    local f = io.open( ofile, "w" )
    if io.type( f ) == "file" then
        f:write( lunajson.encode( tbl) .. "\n" )
        f:close()
        print( col.Red('JSON saved @')..col.green(ofile))
    else
        print( "ERROR: Unable to open: " .. ofile )
    end
end
function MAD.json.load(path)
    local lunajson = require 'lunajson'
    return lunajson.decode(io.open(path):read('*all') )
end

MAD.img = {}
function MAD.img.save(ofile, img)
    image.save(ofile, img)
end
function MAD.img.load(ifile, kind)
    local img
    img = image.load(ifile)
    -- if kind = 'Float'
    return img
end
function MAD.img.show(img)
    local odir = path.join(os.getenv('HOME'),'_show')
    local ofile = path.join(odir, MAD.uid(1)..'.jpg')
    MAD.parent(ofile)
    image.save(ofile, img)
    os.execute('open "'..ofile..'"')
    MAD.print.two('image saved @:', ofile)
end
MAD.show = MAD.img.show

function MAD.trueFalse(t,f)
    local t = t or 1
    local f = f or 1
    local pool = {}
    for i=1,t do
        table.insert(pool,true)
    end
    for i=1,f do
        table.insert(pool,false)
    end
    local res = fun.permute(pool)[1]
    return res
end
function MAD.bernoulli(prob)
    return torch.bernoulli(prob) == 1
end


function MAD.zeropad(input, n)
    return string.format('%0'..n..'d',input)
end
function MAD.apply_model(opt)
    opt = opt or {}
    local idir = opt.idir or ds.scaled
    local model = opt.model or error('!!missing model')
    local ofile = opt.ofile or error('!!missing ofile')
    local fscript = "/Users/laeh_pro/Documents/MAD/score"
    local command = '"'..fscript..'" -r "'.. model ..'" "'..idir..'" > "' ..ofile..'"'
    local start = os.time()

    print( "MAD.apply_model(opt)" )
    print( 'model',col.Cyan(model) )
    print( 'idir',col.Green(idir) )
    print( 'ofile',col.green(ofile) )
    os.execute(command)
    print(command)

    local finish = os.time()
    local data = MAD.load(ofile)
    local files = data.File
    local n = #files
    local seconds = (finish-start)
    local minutes = seconds/60
    local speed = n/seconds

    print(speed..' img/sec')
end
function MAD.flatten_d1s(d0)
    -- local d0 = "/Volumes/8tb/école.images/images.8C/NA (Nature, Elements, Photographie)/trees/MIX"
    local tmpdir = d0..'tmp'
    MAD.file.move(d0, tmpdir)
    local d1s = dir.getdirectories(tmpdir)
    for _, d1 in ipairs(d1s) do
        local basename = path.basename(d1)
        local odir = path.join( d0, basename )
        local files = MAD.idir.jpgs(d1, {reparse=true})
        for i, file in ipairs(files) do
            local id = path.basename(file)
            local ofile = path.join(odir, id)
            MAD.parent(ofile)
            MAD.file.copy(file,ofile)
        end
    end
    local odir = path.join("/Users/laeh_pro/tmp_trash", MAD.uid(1))
    MAD.file.move(tmpdir, odir)
end
function MAD.flatten(idir)
    local tmpdir = idir..'tmp'
    MAD.file.move(idir, tmpdir)
    local files = MAD.idir.jpgs(tmpdir, {reparse=true})
    for i, file in ipairs(files) do
        local id = path.basename(file)
        local ofile = path.join(idir,id)
        MAD.parent(ofile)
        MAD.file.copy(file, ofile)
    end
    local odir = path.join("/Users/laeh_pro/tmp_trash", MAD.uid(1))
    MAD.file.move(tmpdir, odir)
end
function MAD.save(ofile, content)
    MAD.parent(ofile)
    local ext = path.extension(ofile)
    if ext == '.th' then
        torch.save(ofile, content)
    end
    if ext == '.jpg' then
         image.save(ofile, content)
    end
    if ext == '.csv' then
        local csvigo = require('csvigo')
        csvigo.save{data=content, path=ofile}
    end
end

function MAD.sortUp(list, dim)
    table.sort(list, function(a,b) return a[dim] < b[dim]  end)
    return list
end
function MAD.sortDown(list, dim)
    table.sort(list, function(a,b) return a[dim] > b[dim]  end)
    return list
end


MAD.pixels = {}

MAD.pixels.create = {}

function MAD.pixels.create.uniform(opt)
   opt = opt or {}
   local size = opt.size or 256
   local map = torch.ByteTensor(3,size,size)

   map[1] = torch.uniform(0,255)
   map[2] = torch.uniform(0,255)
   map[3] = torch.uniform(0,255)
   return map
end
function MAD.pixels.create.rdmgrad(opt)
   local function R() return torch.random(0,255)/255 end
   local function G() return torch.random(0,255)/255 end
   local function B() return torch.random(0,255)/255 end
   opt = opt or {}
   local w = opt.w or 512
   local h = opt.h or 512

   local colors = {
      {R(),G(),B()},
      {R(),G(),B()},
      {R(),G(),B()},
      {R(),G(),B()},
   }
   local tl = opt.tl or colors[1]
   local tr = opt.tr or colors[2]
   local br = opt.br or colors[3]
   local bl = opt.bl or colors[4]

   local img = torch.FloatTensor({{tl,tr},{br,bl}})
   img = img:transpose(1,3)
   img = img:transpose(2,3)
   img = image.scale(img,w,h)
   return img
end

MAD.pixels.ifile = {}
function MAD.pixels.ifile.paddedbox(file, box)
   local img = image.load(file)
   local iw = (#img)[3]
   local ih = (#img)[2]
   local ir = iw / ih
   local s = (#box)[3]

   local w,h,t,b,l,r

   if ir > 1 then
      w = s
      h = math.floor(s/ir)
      t = math.ceil((s-h)/2)
      b = t + h -1
      l = 1
      r = s
   elseif ir < 1 then
      w = math.floor(s*ir)
      h = s
      t = 1
      l = math.ceil((s-w)/2)
      b = s
      r = l + w - 1
   elseif ir == 1 then
      w = s
      h = s
      t = 1
      b = s
      l = 1
      r = s
   end
   img = image.scale(img, w, h)
   box[{ {},{t,b},{l,r} }] = img
   return box
end
function MAD.pixels.ifile.isok(file)
   local function isSupported(binary)
      local c = string.char
      local numbers = {
         [c(0xff)..c(0xd8)..c(0xff)] = 'JPEG',
         [c(0x89)..c(0x50)..c(0x4e)..c(0x47)] = 'PNG',
      }
      local families = {
         JPEG = 'image',
         PNG = 'image',
      }
      local type = numbers[binary:sub(1,1)] or numbers[binary:sub(1,3)] or numbers[binary:sub(1,4)]or numbers[binary:sub(1,3)..'_'..binary:sub(5,8)]
      local family = families[type]
      return type,family
   end

   local f = io.open(file)
   if f then
      local magic = f:read(8)
      f:close()
      if not magic or #magic < 8 then
      return
      end
      return isSupported(magic)
   end
end
function MAD.pixels.ifile.hsvx(ifile)
   local command = './hsvx colors "'..ifile..'" 1'
   local hue = sys.execute(command)
   local scores = stringx.split(hue)
   local tbl = {}
   tbl.h = torch.round( tonumber( scores[1]) *100 )
   tbl.s = torch.round( tonumber( scores[2]) *100 )
   tbl.v = torch.round( tonumber( scores[3]) *100 )
   tbl.x = torch.round( tonumber( scores[4]) *100 )
   return tbl
end
function MAD.pixels.ifile.detect_whitePixel(ifile)
   local isStuff
   local img = image.load(ifile, 3, 'float' )
   local top = img[{ {},{1,1},{1,1} }]
   local sum = top[1]+top[2]+top[3]
   local moyenne = sum/3
   if moyenne[1][1] == 1 then
      isStuff = true
   else
      isStuff = false
   end
   return isStuff
end
function MAD.pixels.ifile.ifile2bitmap(ifile, opt)
   opt = opt or {}
   local gridSize = opt.gridSize or 4
   local nRGB = opt.nRGB or 4
   local img = image.load(ifile, 3, 'float' )
   img = image.scale(img,gridSize,gridSize)
   local  div = torch.round(100/nRGB)
   img = torch.round(img*100/div)
   return img
end
function MAD.pixels.ifile.png2jpg(ifile)
   local ofile = stringx.replace(ifile, '.png', '.jpg')
   local command1 = 'convert "'..ifile..'" "'..ofile..'"'
   local command2 = 'rm -f  "'..ifile..'"'
   os.execute(command1)
   os.execute(command2)
end
function MAD.pixels.ifile.rgb2rgba(ifile, ofile, alpha)
   local command = 'convert "'..file..'"  -alpha set -background none -channel A -evaluate multiply '..alpha..' +channel "'..ofile..'"'
end
function MAD.pixels.ifile.bw2rgb(ifile)
   local command1 = 'convert "'..ifile..'" -type truecolor "'..ifile..'"'
   os.execute(command1)
end
function MAD.pixels.ifile.maskImage(ifile, fmask, ofile)
   local cmd = 'magick composite -gravity center "'..fmask..'" "'..ifile..'" "'..ofile..'"'
   os.execute(cmd)
end
function MAD.pixels.ifile.ratio(ifile)
   local ratio = 'portrait'
   local img = image.load(ifile, 3, 'float' )
   local dims = #img
   local h,w = dims[2],dims[3]
   if w > h then
      ratio = 'landscape'
   end
   if w == h then
      ratio = 'square'
   end
   return ratio
end
function MAD.pixels.ifile.alpha(opt)
   opt = opt or {}
   local ifile = opt.ifile or error('!!ifile')
   local ofile = opt.ofile or error('!!ofile')
   local alpha = opt.alpha or error('!!alpha')
   local command = 'convert "'..ifile..'"  -alpha set -background none -channel A -evaluate multiply '..alpha..' +channel "'..ofile..'"'
   os.execute(command)
end
function MAD.pixels.ifile.scale2fill(opt)
   opt = opt or {}
   local ifile = opt.ifile or error('!!ifile')
   local ofile = opt.ofile or error('!!ofile')
   local w = opt.w or error('!!w')
   local h = opt.h or error('!!h')
   local cmd = 'convert "'..ifile..'" -resize '..w..'x'..h..'^ "'..ofile..'"'
   os.execute(cmd)
end
function MAD.pixels.ifile.padImage(opt)
   opt = opt or {}
   local padding = opt.padding or 16

   local img = {}

   img.file = opt.ifile
   img.map = image.load(img.file)
   img.dims = #(img.map)
   img.w = img.dims[3]
   img.h = img.dims[2]

   local bgd = {}

   bgd.file = opt.bgd
   bgd.map = image.load(bgd.file)
   bgd.w = img.w + 2 * padding
   bgd.h = img.h + 2 * padding
   bgd.map = image.scale(bgd.map,bgd.w,bgd.h)

   img.t = (bgd.h-img.h)/2
   img.b = img.h + img.t - 1
   img.l = (bgd.w-img.w)/2
   img.r = img.w + img.l - 1

   bgd.map[{ {},{img['t'],img['b']},{img['l'],img['r']} }] = img.map
   return bgd.map
end
function MAD.pixels.ifile.scale2fill(opt)
    opt = opt or {}
    local ifile = opt.ifile or error('!!ifile')
    local ofile = opt.ofile or error('!!ofile')
    local w = opt.w or error('!!w')
    local h = opt.h or error('!!h')
    local cmd = 'convert "'..ifile..'" -resize '..w..'x'..h..'^ "'..ofile..'"'
    os.execute(cmd)
end
function MAD.pixels.ifile.stretch2fill(opt)
    opt = opt or {}
    local ifile = opt.ifile or error('!!ifile')
    local ofile = opt.ofile or error('!!ofile')
    local w = opt.w or error('!!w')
    local h = opt.h or error('!!h')
    local cmd = 'convert "'..ifile..'" -resize '..w..'x'..h..' "'..ofile..'"'
    os.execute(cmd)
end
function MAD.pixels.ifile.mask(opt)
    opt = opt or {}
    local command = 'magick composite -gravity center "'..opt.fmask..'" "'..opt.file..'" "'..opt.ofile..'"'
    os.execute(command)
end
function MAD.pixels.ifile.CropBox(opt)
    opt = opt or {}
    local ifile = opt.ifile
    local ofile = opt.ofile
    local geometry = opt.geometry

    local bw, bh, bx, by

    bw = geometry['w']
    bh = geometry['h']
    bx = geometry['x']
    by = geometry['y']

    local img  = image.load(ImageFile)
    local iw, ih = (#img)[3], (#img)[2]

    local t,b,l,r

    t = by + 1
    b = t + bh -1
    l = bx +1
    r = l + bw -1

    print('🀣')
    MAD.P2('ih', i.h)
    MAD.P2('iw', i.w)
    print('✂')
    MAD.P2('bw', b.w)
    MAD.P2('bh', b.h)
    MAD.P2('bx', b.x)
    MAD.P2('by', b.y)
    MAD.P2('t', t)
    MAD.P2('b', b)
    MAD.P2('l', l)
    MAD.P2('r', r)

    image.save(ofile, img[{ {},{b.t, b.b},{b.l,b.r} }])
end
function MAD.pixels.ifile.toRGBA(opt)
    opt = opt or {}
    local ifile = opt.ifile
    local ofile = opt.ofile
    local alpha = opt.alpha
    local command = 'convert "'..file..'"  -alpha set -background none -channel A -evaluate multiply '..alpha..' +channel "'..ofile..'"'
    -- print( command )
    os.execute( command )
end


MAD.pixels.img = {}

function MAD.pixels.img.tint(img, colorName, factor)
    local factor = factor or 2
    local iw = (#img)[3]
    local ih = (#img)[2]
    local hue = {
        red = {1,.27,.23},
        black = {0,0,0},
        white = {1,1,1},
        gray = {.5,.5,.5},
        green = {.196,.843,0.294},
    }
    local v = hue[colorName]
    print(v)
    local map = torch.FloatTensor(3,ih,iw)
    print(#map)
    map[1] = torch.uniform( v[1] , v[1] )
    map[2] = torch.uniform( v[2] , v[2] )
    map[3] = torch.uniform( v[3] , v[3] )
    local omg = map + img
    if color == 'black' then
        omg = map + map + map + img
        factor = 4
    end
    omg = omg/factor
    return omg
end
function MAD.pixels.img.okRatio(img, maxRatio)
    local okRatio = false
    local dim, w, h = img:size()[1], img:size()[2], img:size()[3]
    local shortEdge = math.min(w,h)
    local longEdge = math.max(w,h)
    local absRatio = longEdge/shortEdge
    if absRatio < maxRatio then
        okRatio = true
    end
    return okRatio
end
function MAD.pixels.img.okSize(img, minSize)
    local okSize = false
    local dim, w, h = img:size()[1], img:size()[2], img:size()[3]
    local shortEdge = math.min(w,h)
    if shortEdge > minSize then
        okSize = true
    end
    return okSize
end
function MAD.pixels.img.centerRatioCrop(img, ratio)
    local iw = img:size(3)
    local ih = img:size(2)
    local ir = iw / ih
    local outputWidth, outputHeight
    if ratio >= ir then
        outputWidth = iw
        outputHeight = torch.round(outputWidth / ratio)
    else
        outputHeight = ih
        outputWidth = torch.round(outputHeight * ratio)
    end
    local top = torch.floor((ih - outputHeight)/2) + 1
    local left = torch.floor((iw - outputWidth)/2) + 1
    local bottom = top + outputHeight - 1
    local right = left + outputWidth - 1
    local omg = img[{ {},{top,bottom},{left,right} }]
    return omg
end
function MAD.pixels.img.cropFromSides(img, opt)
    opt = opt or {}
    local crop_t = opt.t or 259
    local crop_l = opt.l or 259
    local crop_r = opt.r or 259
    local crop_b = opt.b or 259
    local dims = #img
    local iw = dims[3]
    local ih = dims[2]


    local t = crop_t + 1
    local l = crop_l + 1
    local b = ih - crop_b --- 1
    local r = iw - crop_r --- 1
    omg = img[{ {},{t,b},{l,r} }]

    return omg
end
function MAD.pixels.img.xHSL(opt)
    opt = opt or {}
    local img = opt.img
    local xH = opt.xH or 1
    local xS = opt.xS or 1
    local xL = opt.xL or 1

    local imgHSL = image.rgb2hsv(img)*0.99
    imgHSL[1] = imgHSL[1] * xH
    imgHSL[2] = imgHSL[2] * xS
    imgHSL[3] = imgHSL[3] * xL

    return image.hsv2rgb(imgHSL)
end


MAD.pixels.img.shuffle = {}

function MAD.pixels.img.shuffle.global(img)
    local channels = img:size(1)
    local h = img:size(2)
    local w = img:size(3)
    local matrix = img:view(channels, w * h)
    local perm = torch.randperm(w * h):long()
    local pixels = matrix:index(2,perm)
    local result = pixels:view(channels, h, w)
    return result
end
function MAD.pixels.img.shuffle.gaussian(img, spread)
    opt = opt or {}

    img = img:clone()
    local raw = torch.data(img)
    local w = (#img)[3]
    local h  = (#img)[2]
    local channels = (#img)[1]
    local npixels = w * h
    -- print(spread)
    local maxSpread = math.max( w, h  )
    local meanMaxSpread = maxSpread
    local spread = spread or meanMaxSpread
    if spread == 0 then
       return img
    end
    local offsets_x = torch.data( torch.Tensor(npixels):normal(0, spread) )
    local offsets_y = torch.data( torch.Tensor(npixels):normal(0, spread) )
    local i = 0

    for y = 0,h -1 do
        -- xlua.progress(y, h -1)

        for x = 0,w-1 do
            local dx = math.floor(0.5 + math.max(math.min(w-1,  x+offsets_x[i]), 0))
            local dy = math.floor(0.5 + math.max(math.min(h -1, y+offsets_y[i]), 0))
            local di = w*dy + dx

            for c = 0,channels-1 do
                local buffer = raw[ npixels*c + i ]
                raw[ npixels*c + i ] = raw[ npixels*c + di ]
                raw[ npixels*c + di ] = buffer
            end
            i = i + 1
        end
    end
    collectgarbage()
    return img
end
function MAD.pixels.img.shuffle.bin(ifile, opt)

    -- local rng         = mad.list.create.range(2,15,2)
    -- local rdmNo       = mad.list.sample_one(rng)
    local opt         = opt or {}
    local img         = image.load(ifile, 3, 'float' )
    local ih          = opt.ih or 512
    local iw          = opt.iw or 512
    local ncol        = opt.ncol or 16
    local nrow        = opt.nrow or 16
    local img         = image.scale(img,ih,iw)[{{1,3}}]
    local imgdims     = #img
    local blockw      = imgdims[3]/ncol
    local blockh      = imgdims[2]/nrow
    local imgHSL      = image.rgb2hsv(img)*0.99
    local blocks      = imgHSL:unfold(3,blockw,blockw):unfold(2,blockh,blockh)
    local allBlocks   = blocks:reshape( (#blocks)[1],(#blocks)[2]*(#blocks)[3],(#blocks)[4]*(#blocks)[5] )

    for i = 1, (#allBlocks)[2] do
    
        xlua.progress(i,(#allBlocks)[2])
        local rdmPositions = torch.randperm((#allBlocks)[3]) --Randomize Bins

      for j = 1, (#allBlocks)[3] do

         allBlocks[{ 1,i,j }] = allBlocks[{ 1,i,rdmPositions[j] }]
         allBlocks[{ 2,i,j }] = allBlocks[{ 2,i,rdmPositions[j] }]
         allBlocks[{ 3,i,j }] = allBlocks[{ 3,i,rdmPositions[j] }]
      end
    end

    img = allBlocks:reshape((#blocks)[1],(#blocks)[2],(#blocks)[3],(#blocks)[4],(#blocks)[5])
    print('Shuffle')
    P2('channels', (#img)[1])
    P2('height', (#img)[2])
    P2('width', (#img)[3])

    img = image.hsv2rgb(img:transpose(3,4):reshape(3,ih,iw))
    print('Reorganize')
    P2('channels', (#img)[1])
    P2('height', (#img)[2])
    P2('width', (#img)[3])

    return img
end
function MAD.pixels.img.shuffle.cut(ifile, opt)

    opt = opt or {}
    local img       = image.load(ifile, 3, 'float' )
    local ih        = opt.ih or 1024
    local iw        = opt.iw or 1024
    local img       = image.scale(img,ih,iw)[{ {1,3} }]
    local imgSize   = #img
    local ncol      = opt.ncol or 16
    local nrow      = opt.nrow or 16
    local totalBlocksNo = ncol * nrow
    local blockw = imgSize[3] / ncol
    local blockh = imgSize[2] / nrow
    local blocks = img:unfold(3,blockw,blockw):unfold(2,blockh,blockh)
    local allBlocks = blocks:reshape((#blocks)[1],
                                    (#blocks)[2]*(#blocks)[3],
                                    (#blocks)[4]*(#blocks)[5])
    -- Generate Random posiiton & Randomize Bin Posiiton
    local rdmPositions = torch.randperm((#allBlocks)[2])
    for i = 1, (#allBlocks)[2] do
      xlua.progress(i,(#allBlocks)[2])
      allBlocks[{ 1,i }] = allBlocks[{ 1,rdmPositions[i] }]
      allBlocks[{ 2,i }] = allBlocks[{ 2,rdmPositions[i] }]
      allBlocks[{ 3,i }] = allBlocks[{ 3,rdmPositions[i] }]
    end
    local img = allBlocks:reshape((#blocks)[1],
                                 (#blocks)[2],
                                 (#blocks)[3],
                                 (#blocks)[4],
                                 (#blocks)[5])
    local img = img:transpose(3,4):reshape(3,ih,iw)
    return img
end


MAD.pixels.color = {}
function MAD.pixels.color.rotate(opt)
    opt = opt or {}
    local img = opt.img
    local dim = opt.dim
    local shift = opt.shift or torch.uniform()
    local i = image.rgb2hsl(img)
    local dimidx
    if dim == 'h' then dimidx = 1 end
    if dim == 's' then dimidx = 2 end
    if dim == 'l' then dimidx = 3 end
    i[dimidx]:apply(function(x) return (x+shift)%1 end)
    return image.hsl2rgb(i)
end
function MAD.pixels.color.invert(img)
    return -img +1
end
function MAD.pixels.color.filter(img,opt)
    local opt = opt or {}
    local img = img
    local rdm_min = torch.uniform(0.1,0.5)
    local rdm_max = torch.uniform(0.5,0.9)

    local mR = opt.mR or torch.uniform(rdm_min,rdm_max) --0.4
    local mG = opt.mG or torch.uniform(rdm_min,rdm_max) --0.3
    local mB = opt.mB or torch.uniform(rdm_min,rdm_max) --0.2

    local i3 = img:clone()
    -- (0) normalize the image energy to be 0 mean:
    i3:add(-i3:mean())
    -- (1) normalize all channels to have unit standard deviation:
    i3:div(i3:std())
    -- (2) filter indivudal channels differently (here we give an orange
    --     filter, to warm up the image):
    i3[1]:mul(mR)
    i3[2]:mul(mG)
    i3[3]:mul(mB)
    -- (3) soft clip the image between 0 and 1
    i3:mul(4):tanh():add(1):div(2)
    return i3
end
-- function MAD.pixels.color.bw(img)
--     return img:mean(1)
-- end

function MAD.pixels.color.bw(im)
    -- Image.rgb2y uses a different weight mixture

    local dim, w, h = im:size()[1], im:size()[2], im:size()[3]
    if dim ~= 3 then
       print('<error> expected 3 channels')
       return im
    end

    -- a cool application of tensor:select
    local r = im:select(1, 1)
    local g = im:select(1, 2)
    local b = im:select(1, 3)

    local z = torch.Tensor(w, h):zero()

    -- z = z + 0.21r
    z = z:add(0.21, r)
    z = z:add(0.72, g)
    z = z:add(0.07, b)

    local map = torch.FloatTensor(3, h, w):uniform( 0,.1)
    map[1] = z
    map[2] = z
    map[3] = z
    return map
end


MAD.pixels.blur = {}

function MAD.pixels.blur_gaussian(img,kernelsize)
    local h           = img:size(2)
    local w           = img:size(3)
    local kernelsize  = kernelsize or math.min(w,h)/8
    -- Gaussian Kernel + Transpose
    local g1 = image.gaussian1D(kernelsize):resize(1,kernelsize):float()
    local g2 = g1:t() --transpose(1,2)
    -- Check Dimensiosn
    -- print(#g1)
    -- print(#g2)
    -- Resize & Clone
    local i = img
    c = i:clone():fill(1)
    -- print{c,g1}
    -- Convolution
    c = image.convolve(c, g1, 'same')
    c = image.convolve(c, g2, 'same')
    i = image.convolve(i, g1, 'same')
    i = image.convolve(i, g2, 'same')
    -- Component-wise division + retransform
    i:cdiv(c)
    return i
end
function MAD.pixels.blur.aperture(img,apertureSize)
    apertureSize = tostring(apertureSize)
    local aperture = image.load("assets/mad.pixels/"..'aperture_'..apertureSize..'.png',4)
    aperture:div(aperture:sum())
    local res = image.convolve(img,aperture[1],'same')
    res:div(res:max())
    return res
end

MAD.pixels.idir = {}

function MAD.pixels.idir.bw2rgb(idir)
    local files = MAD.idir.jpgs(idir)
    for i, file in ipairs(files) do
        xlua.progress(i,#files)
        local img = image.load(file)
        local dims = #img
        if dims[1]~=3 then
            print(file)
            MAD.pixels.ifile.bw2rgb(file)
        end
    end
end
function MAD.pixels.idir.mu(files, S, talk)
    local sum = torch.FloatTensor(3, S, S):uniform( 0,.001)
    for i, file in ipairs(files) do
        if talk == 'talk' then
            xlua.progress(i, #files)
        end
      local img = image.load(file, 3, 'float' )
      img = image.scale( img, S, S)
      sum = sum + img
    end
    return sum/#files
end
function MAD.pixels.idir.hsvx(opt)
    MAD.print.title("MAD.pixels.idir.hsvx()")
    print(idir)
    local idir = opt.idir
    local fcsv = opt.fcsv
    local fth = opt.fth

    local files = MAD.idir.jpgs(idir 'reparse')
    local id2hsvx = {}
    local f = io.open(fcsv, 'w')
    local header = 'id'..','..'h'..','..'s'..','..'v'..','..'x'
    f:write(header, "\n")
    for i, file in ipairs(files) do
        xlua.progress(i,#files)
        local hsvx = MAD.pixels.ifile.hsvx(file)
        local id = path.basename(file)
        id2hsvx[id] = hsvx
        local row = id..','..hsvx.h..','..hsvx.s..','..hsvx.v..','..hsvx.x
        f:write(row, "\n")
    end
    f:close()
    torch.save(fth, id2hsvx)
end
function MAD.pixels.idir.bw2rgb(idir)
    MAD.print.title("MAD.pixels.idir.bw2rgb()")
    print(idir)
    local files = MAD.idir.jpgs(idir, 'reparse')
    for i, file in ipairs(files) do
        xlua.progress(i,#files)
        local img = image.load(file)
        local dims = #img
        print(file)
        if dims[1]~=3 then
            MAD.pixels.ifile.bw2rgb(file)
        end
    end
end
function MAD.pixels.idir.gif(idir, ofile, delay)
    local cmd = 'cd "'..idir..'" && convert -delay '..delay..' -loop 0 *.jpg "'..ofile..'"'
    -- print(cmd)
    os.execute(cmd)
end



function MAD.pixels.img.rgbmean(img)
   img = image.scale(img, 16,16)
   local sum = img[{{},{1,1},{1,1}}]
   local n = 0
   for x=1, 16 do
      for y=1, 16 do
         sum = sum + img[{{},{x,x},{y,y}}]
         n = n + 1
      end
   end
   local mean = sum/n
   local r = mean[1][1][1]
   local g = mean[2][1][1]
   local b = mean[3][1][1]
   return {r,g,b}
end
function MAD.pixels.img.box(img, opt)
    opt = opt or {}
    local rgb = opt.rgb
    local s = opt.size
    -- print(s)
   local box = torch.FloatTensor(3,s,s)


   box[1] = rgb[1]
   box[2] = rgb[2]
   box[3] = rgb[3]

   local iw = (#img)[3]
   local ih = (#img)[2]
   local ir = iw / ih
   local w,h,t,b,l,r
   if ir > 1 then
      w = s
      h = math.floor(s/ir)
      t = math.ceil((s-h)/2)
      b = t + h -1
      l = 1
      r = s
   elseif ir < 1 then
      w = math.floor(s*ir)
      h = s
      t = 1
      l = math.ceil((s-w)/2)
      b = s
      r = l + w - 1
   elseif ir == 1 then
      w = s
      h = s
      t = 1
      b = s
      l = 1
      r = s
   end
   -- print(t,b,l,r)
   img = image.scale(img, w, h)
   -- print(#img)
   box[{ {},{t,b},{l,r} }] = img
   return box
end

function MAD.pixels.img.shortEdgeScale(img, opt)
    opt = opt or {}


   local dims = #img
   local h,w = dims[2],dims[3]
   local r = w/h

   local ow,oh
   if r > 1 then
      -- print("r>1")
        oh = opt.shortedge
        ow = torch.round(oh * r)
   end
   if r < 1 then
      -- print("r<1")
      ow = opt.shortedge
      oh = torch.round(ow / r)
   end
   if r ==1 then
      ow = opt.shortedge
      oh = opt.shortedge
   end
   local res = image.scale(img, ow, oh)
   return res
end
function MAD.pixels.img.scaleCrop(img, opt)
    opt = opt or {}
    local ratio = opt.ratio or 1
    return image.scale( MAD.pixels.img.centerRatioCrop(img, ratio), opt.size, opt.size )
end


MAD.mosaics = {}
function MAD.mosaics.files2map(opt)
    opt = opt or {}

    local files = opt.files or error('!!files')
    local mr    = opt.mr or 1
    local iw    = opt.iw or 64
    local ih    = opt.ih or 64
    local quiet = opt.quiet or true

    local ir    = iw/ih
    local nfiles = #files
    local n =  nfiles
    local ncol = math.floor(math.sqrt(n * mr / ir))
    local nrow = math.floor(n/ncol)
    local total = ncol*nrow
    local mh = nrow * ih
    local mw = ncol * iw
    local map = torch.FloatTensor(3, mh, mw):uniform( 0,1)

    if not quiet then
        MAD.print.two('n', n)
        MAD.print.two('mr', mr)
        MAD.print.two('iw', iw)
        MAD.print.two('ih', ih)
        MAD.print.two('ir', ir)
    end

    local c = 1
    for i = 1,nrow do
        for j = 1,ncol do
            -- if not quiet then
            --     local pretty_total = MAD.number2comas(total)
            --     local pretty_c = MAD.number2comas(c)
            --     io.write(pretty_total.." "..col.Green(pretty_c), '\r') io.flush()
            -- end
            local pretty_total = MAD.number2comas(total)
                local pretty_c = MAD.number2comas(c)
                io.write(pretty_total.." "..col.Green(pretty_c), '\r') io.flush()
            local file = files[c]
            local ok,img = pcall(image.load, file, {
                type = 'float',
                channels = 3,
            })
                local dims = #img
            if ok and img  and dims[1] == 3 then
                img = image.scale( MAD.pixels.img.centerRatioCrop(img, ir), iw, ih)
                local t = (i-1) * ih + 1
                local l = (j-1) * iw + 1
                local b = t + ih - 1
                local r = l + iw - 1
                map[{ {},{t,b},{l,r} }] = img
                c = c + 1
            end
        end
    end
    return map
end
function MAD.mosaics.files2map_rdmboost(opt)
    opt = opt or {}
    local files = opt.files or error('!!files')
    local mr = opt.mr
    local iw = opt.iw
    local ih = opt.ih
    local ir = iw/ih

    local nfiles = #files
    local n =  nfiles
    local ncol = math.floor(math.sqrt(n * mr / ir))
    local nrow = math.floor(n/ncol)
    local mh = nrow * ih
    local mw = ncol * iw
    local map = torch.FloatTensor(3, mh, mw):uniform( 0,.1)

    MAD.print.two('n', n)
    MAD.print.two('mr', mr)
    MAD.print.two('iw', iw)
    MAD.print.two('ih', ih)
    MAD.print.two('ir', ir)
    MAD.print.two('idir', idir)

    local c = 1
    for i = 1,nrow do
        for j = 1,ncol do
            xlua.progress(c,n)
            local file = files[c]
            -- print(file)
            local img = MAD.pixels.color.filter(file)
            img = image.scale( MAD.img.crop(img, ir), iw, ih)
            local t = (i-1) * ih + 1
            local l = (j-1) * iw + 1
            local b = t + ih - 1
            local r = l + iw - 1
            map[{ {},{t,b},{l,r} }] = img
            c = c + 1
        end
    end
    return map
end
function MAD.mosaics.files2mapDetails(opt)
    opt = opt or {}
    local files = opt.files or error('!!files')
    local quiet = opt.quiet or 'not quiet'
    local iw = opt.iw
    local ih = opt.ih
    local ncol = opt.ncol
    local nrow = opt.nrow

    local ir = iw/ih
    local nfiles = #files
    local n =  nfiles
    local mh = nrow * ih
    local mw = ncol * iw
    local map = torch.FloatTensor(3, mh, mw):uniform( 0,.1)

    if not quiet == 'quiet' then
        MAD.print.two('n', n)
        MAD.print.two('iw', iw)
        MAD.print.two('ncol', ncol)
        MAD.print.two('ih', ih)
        MAD.print.two('nrow', nrow)
    end
    local c = 1
    for i = 1,nrow do
        for j = 1,ncol do
            -- if not quiet == 'quiet' then
                xlua.progress(c,n)
            -- end
            local file = files[c]
            local ok,img = pcall(image.load, file, {
                type = 'float',
                channels = 3,
            })
            local dims = #img
            if dims[1] == 3 then
                if ok and img then
                    img = image.scale( MAD.pixels.img.centerRatioCrop(img, ir), iw, ih)
                    local t = (i-1) * ih + 1
                    local l = (j-1) * iw + 1
                    local b = t + ih - 1
                    local r = l + iw - 1
                    map[{ {},{t,b},{l,r} }] = img
                    c = c + 1
                end
            end
        end
    end
    return map
end
function MAD.mosaics.idir(idir, ofile)
    -- local idir= "/Volumes/1tb/xx-960*960"
    local files = MAD.idir.jpgs(idir)
    files = MAD.list.permute(files)
    local n = #files
    -- files = MAD.list.sample_n(files, n)
    -- local mr = 1920/1080
    -- local iw = 8
    -- local ih = 8
    local mosaic = MAD.mosaics.files2map({
            files = files,
            mr = 1,
            iw = 64,
            ih= 64,
        })
    image.save(ofile, mosaic)
end
function MAD.mosaics.leafs()
    local idir = "/Volumes/1tb/ogai/taxonomy"
    local fleafs = idir..'-leafs.th'
    local mr = 1
    local min = 100
    local odir = idir..'-mosaics'
    dir.makepath(odir)
    -- local leafs = MAD.idir.leafs(idir)
    -- torch.save(fleafs, leafs)
    local leafs = torch.load(fleafs)
    leafs = MAD.list.permute(leafs)
    for i, leaf in ipairs(leafs) do
        local dirname = path.dirname(leaf)
        local odir_mosaic = stringx.replace(dirname, idir, odir)
        dir.makepath(odir_mosaic)
        local name = path.basename(leaf)..'.jpg'
        local ofile = path.join(odir_mosaic, name)
        if not path.exists(ofile) then
            local files = MAD.idir.jpgs(leaf)
            local n = #files
            if n > min then
                local iw = 64
                local ih = 64
                local mosaic = MAD.mosaics.files2map({
                    files = files,
                    mr = mr,
                    iw = iw,
                    ih = ih,
                })
                image.save(ofile, mosaic)
            else
                print(leaf)
            end
        end
    end
end
function MAD.mosaics.waldo()
    local ncol = 80    
    local nrow = 64
    local n = ncol*nrow
    local _waldos = MAD.idir.jpgs("//Users/laeh/Documents/ohgod/design/waldo/_waldo")
    local waldo = "/Users/laeh/Documents/ohgod/design/waldo/waldo/waldo_1.jpg"
    local files = {}
    for i=1, n-1 do 
        table.insert(files, MAD.list.sample_one(_waldos))
    end
    table.insert(files, waldo)
    files = MAD.list.permute(files)
    local map = MAD.mosaics.files2mapDetails({
        files = files,
        iw = 110,
        ncol = ncol,
        ih = 110,
        nrow = nrow,    
    })
    local odir = "/Users/laeh/Google Drive/Google Sync Anna-LA/InstaPage-Assets/My Locker/Waldo"
    local waldo_name = path.basename(waldo)
    local ofile = path.join(odir,MAD.rdmid(1)..'_'..ncol..'*'..nrow..'_'..waldo_name )
    print(ofile)
    image.save(ofile, map)
end
function MAD.mosaics.idirByRatio(idir)
    local idir = idir or "/Users/laeh/Pictures/assets/xx-web-best-originals/playboy"
    local files = _.idir.jpgs(idir)
    local byRatio = {
        ['Landscape'] = {},
        ['Portrait'] = {},
        ['Square'] = {},
    }
    for i, file in ipairs(files) do
        xlua.progress(i, #files)
        table.insert(byRatio[ifile2ratio(file)], file)
    end

    print( #byRatio['Landscape'])
    print( #byRatio['Portrait'])
    print( #byRatio['Square'])

    image.save(idir..'-'.._.rdmid()..'.jpg', MAD.mosaics.files2map({
        files = byRatio['Portrait'],
        mr = 0.4,
        iw = 80,
        ih = 200,
    }))

    image.save(idir..'-'.._.rdmid()..'.jpg', MAD.mosaics.files2map({
        files = byRatio['Portrait'],
        mr = 3,
        iw = 80,
        ih = 200,
    }))
end

MAD.mosaics.m2 = {}
function MAD.mosaics.m2.make(opt)
   opt = opt or {}
   local files = {}
   if opt.idir then
      files = mad.idir.getfiles(idir)
      local shuffle = true
      if shuffle then
         print("shuffling...")
         mad.list.permute(files)
      end
   end

   if opt.ifile then
      for i=1, 1000 do
         table.insert(files, opt.ifile)
      end
   end

   local nFiles = #files

   -- Geometry
   local h_mosaic = opt.h_mosaic or  4096
   local w_mosaic = opt.w_mosaic or  4096
   local nCol = opt.nCol or  16
   local tile_min_ratio = opt.tile_min_ratio or  .16
   local tile_max_ratio = opt.tile_max_ratio or  .84
   local w_column = opt.w_column or  w_mosaic/nCol
   local minHeight = opt.minHeight or  w_column
   local nTiles =  0


   mad.print.two('idir',tostring(idir))
   mad.print.two('h_mosaic',tostring(h_mosaic))
   mad.print.two('w_mosaic',tostring(w_mosaic))
   mad.print.two('nCol',tostring(nCol))
   mad.print.two('tile_min_ratio',tostring(tile_min_ratio))
   mad.print.two('tile_max_ratio',tostring(tile_max_ratio))
   mad.print.two('nTiles',tostring(nTiles))
   mad.print.two('w_column',tostring(w_column))
   mad.print.two('minHeight',tostring(minHeight))
   mad.print.two('nFiles',tostring(nFiles))

   local geometry = {}
   for i=1, nCol do
      local columnTiles = {}
      local usedHeight = 0
      local leftHeight = h_mosaic
      local nRow = 0
      while usedHeight < h_mosaic - minHeight do
         local tile = {}
         tile['width'] = w_column
         tile['ratio'] = torch.uniform(tile_min_ratio, tile_max_ratio)
         tile['left'] = (i-1) * w_column + 1
         tile['right'] = tile.left + w_column - 1
         tile['top'] = usedHeight + 1
         if leftHeight < minHeight then
            tile['height'] = h_mosaic - usedHeight
         else
            tile['height']  = math.floor(tile['width']/tile['ratio'])
         end
         tile['bottom'] = usedHeight + tile['height']
         usedHeight = usedHeight + tile['height']
         leftHeight = h_mosaic - usedHeight
         table.insert(columnTiles, tile)
         nRow = nRow + 1
         nTiles = nTiles + 1
      end
      table.insert(geometry, columnTiles)
   end

   -- if not enough files in directory given geometry design
   if nTiles > nFiles then
      local diff = nTiles - nFiles
      for i=1, diff + 1 do
         table.insert(files, files[i])
      end
      files = mad.list.permute(files)
   end

   -- draw mosaic
   local clock = 1
   local map = torch.FloatTensor(3, h_mosaic, w_mosaic):uniform( 0,.1)
   for i, column in ipairs(geometry) do
      for j, tile in ipairs(column) do
         clock = clock + 1
         xlua.progress(clock, nTiles)

         local tile = geometry[i][j]
         local t = tile['top']
         local l = tile['left']
         local b = tile['bottom']
         local r = tile['right']
         if j == #column then
            b = h_mosaic
         end
         local ifile = files[clock]
         local img = image.load(ifile)
         img = image.scale( MAD.pixels.img.centerRatioCrop(img, tile['ratio']), tile['width'], b-t+1)
         local shift = torch.uniform()
         -- local shift = .9

         -- Distortions
         -- img = MAD.pixels.color.rotate(img, shift)
         img = MAD.pixels.color.filter(img)
         local draw = mad.list.permute({true,false})[1]
         if draw then
            img = MAD.pixels.color.bw3channels(img)
         end

         -- draw
         map[{ {},{t,b},{l,r} }] = img

      end
   end
   return map
end
function MAD.mosaics.m2.onBackground(map, ofile)
   local bgd = image.load('og003.jpg')
   t = 1
   b = h_mosaic
   l = h_mosaic - w_mosaic + 1
   r = h_mosaic
   bgd[{ {},{t,b},{l,r} }] = map
   image.save(ofile, bgd)
end
function MAD.mosaics.m2.fromDirectoriesList(idir)
   local idirs = {
      "/Volumes/1tb-PSAi/PSAi-Assets/Assets-Lightroom/1/1. ok.380to760",
      "/Volumes/1tb-PSAi/PSAi-Assets/Assets-Lightroom/5/5. xx.Woman.JustBoobs",
      "/Volumes/1tb-PSAi/PSAi-Assets/Assets-Lightroom/5/5. xx.Woman.JustPussy",
      "/Volumes/1tb-PSAi/PSAi-Assets/Assets-Lightroom/5/5. xx.Woman.Ass",
   }
   local name = path.basename(idir)
   local ofile = "/Users/laeh/Pictures/TMP/m2-"..name..'-'..mad.uid(2)..'.jpg'
   local img = m2_make({
      idir = idir,
      h_mosaic =  h_mosaic,
      w_mosaic =  w_mosaic,
      nCol =  16,
      tile_min_ratio = .16,
      tile_max_ratio = .84,
   })

   local map = image.load('/Users/laeh/Documents/ilovelua/mad/PS002-bgd.jpg')
   t = 1
   b = h_mosaic
   l = h_mosaic - w_mosaic + 1
   r = h_mosaic

   map[{ {},{t,b},{l,r} }] = img
   image.save(ofile, map)
   -- os.execute('open "'..ofile..'"')
end
function MAD.mosaics.m2.fromImagesList()
   local ifiles = {
      "/Users/laeh/Desktop/emily_ratajkowski1.jpg",
      "/Users/laeh/Desktop/emily_ratajkowski14.jpg",
      "/Users/laeh/Documents/ilovelua/mad/jay.jpg",
      "/Users/laeh/Documents/ilovelua/mad/rick.jpg",
   }
   for _, ifile in ipairs(ifiles) do
      for i=1, 10 do
         local name = path.basename(ifile)
         local ofile = "/Users/laeh/Pictures/TMP/m2-"..name..'-'..mad.uid(2)..'.jpg'
         local img = MAD.mosaics.m2.make({
            ifile = ifile,
            h_mosaic =  h_mosaic,
            w_mosaic =  w_mosaic,
            nCol =  16,
            tile_min_ratio = .16,
            tile_max_ratio = .84,
         })
         local map = image.load('/Users/laeh/Documents/ilovelua/mad/PS002-bgd.jpg')
         t = 1
         b = h_mosaic
         l = h_mosaic - w_mosaic + 1
         r = h_mosaic

         map[{ {},{t,b},{l,r} }] = img
         -- pritn(ofile)
         image.save(ofile, map)
      end
   end
end

MAD.mosaics.geometries = {
    ['square_square'] = {
        files = files,
        mr = 1,
        iw = 32,
        ih = 32,
    },
    ['landscape_square'] = {
        files = files,
        mr = 2,
        iw = 32,
        ih = 32,
    },
    ['portrait_square'] = {
        files = files,
        mr = 1,
        iw = 32,
        ih = 32,
    },
    ['square_portrait'] = {
        files = files,
        mr = .5,
        iw = 16,
        ih = 32,
    },
    ['landscape_portrait'] = {
        files = files,
        mr = .5,
        iw = 16,
        ih = 32,
    },
    ['portrait_portrait'] = {
        files = files,
        mr = .5,
        iw = 16,
        ih = 32,
    },
    ['square_landscape'] = {
        files = files,
        mr = 2,
        iw = 16,
        ih = 32,
    },
    ['landscape_landscape'] = {
        files = files,
        mr = 2,
        iw = 16,
        ih = 32,
    },
    ['portrait_landscape'] = {
        files = files,
        mr = 2,
        iw = 16,
        ih = 32,
    }
}

return MAD


