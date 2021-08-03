local col = require 'async.repl'.colorize
local image = require 'image'
local home = os.getenv('HOME')

-- print(home)


local MAD = {}

MAD.trash = path.join(home, 'tmp_trash')
dir.makepath(MAD.trash)


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


MAD.jay = {}
MAD.rick = "assets/rick.jpg"
MAD.jay.file = "assets/jay.jpg"
function MAD.jay.img()
    local img = image.load("assets/jay.jpg", 3, 'float' )
    return img
end
MAD.blue = col.blue
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
function MAD.thload(fth)
    print('loading: ', col.green(fth))
    local loaded = torch.load(fth)
    print(col.Green('loaded: '))
    return loaded
end

MAD.print = {}

function MAD.number2comas(n)
   local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
   return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end
MAD.number = {}

function MAD.FormatNumber(Number,opt)
    opt = opt or {}
    local c = a or opt.character or '0'
    local w = a or opt.width or 3
    local o = string.format('%'..c..w..'d', Number)
    return o
end
MAD.number.pad = MAD.FormatNumber
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

MAD.tbl = {}

function MAD.tbl.length(tbl)
    local c = 0
    for k, v in pairs (tbl) do
        c = c + 1
    end
    return c
end

function MAD.tbl.bin(tbl, nbin)
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
end

MAD.csv = {}

function MAD.csv.load(fcsv)
   local csvigo = require('csvigo')
   return csvigo.load{path=fcsv}
end
function MAD.csv.save(fcsv, tbl)
   local csvigo = require('csvigo')
   csvigo.save{data=tbl, path=fcsv}
end

MAD.file = {}

function MAD.file.copy(ifile, ofile)
    if not path.exists(ofile) then
        MAD.parent(ofile)
        local command = 'cp -r "'..ifile..'" "'..ofile..'"'
        -- print(command)
        os.execute(command)
    end
 end
 function MAD.file.name(ifile)
   local basename = path.basename(ifile)
   local ext = path.extension(basename)
   local name = stringx.replace(basename, ext, "")
   return name
end
function MAD.file.move(ifile, ofile)
   local command = 'mv "'..ifile..'" "'..ofile..'"'
   os.execute(command)
end
function MAD.file.trash(file)
    local home = os.getenv('HOME')
    local trash = path.join(home, '_trash')
    local name = path.basename(file)
    local ofile = path.join(trash, MAD.uid(1)..'-'..name)
    MAD.parent(ofile)
    local command = 'mv "'..file..'" "'..ofile..'"'
    os.execute(command)
end
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
function MAD.file.size(f)
    local command = 'stat -f "%z" "' ..f..'"'
    local s = tonumber( sys.execute(command) )
    s = torch.round(s/10000)/100
    -- s = torch.round(s/10000)
    return s
end
function MAD.file.unzip(ifile, odir)
   local cmd = 'unzip "'..ifile..'" -d "'..odir..'"'
   os.execute(cmd)
end
function MAD.file.writekeyword(file, towrite)
    local command = 'exiftool -keywords+='..towrite..' "'..file..'"'
    os.execute(command)
end
function MAD.file.name(file)
    return stringx.replace( path.basename(file), path.extension(file), '')
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

function MAD.idir.copyflat(idir, odir)
    MAD.files.copy_flat(MAD.idir.jpgs(idir), odir)
end
function MAD.idir.getfiles(idir)

    print('')
    print(col.green(idir))
    print('')
    local count = 0 
    local files = {}
    local ext2files = {}
    for file in dir.dirtree(idir) do
        if path.isfile(file) then
            local ext = path.extension(file)
            ext2files[ext] = ext2files[ext] or {}
            count = count + 1
            table.insert(ext2files[ext], file)
            table.insert(files, file)
        end
        io.write(' files found = '..count, '\r') io.flush()
    end
    print('')
    for ext, files in pairs(ext2files) do
        local count = col.Yellow(stringx.rjust(tostring(MAD.number2comas(#files)), 12))
        local ext = col.Blue(stringx.rjust(ext, 12))
        print(ext..count)
    end
    local result = {
        files = files,
        ext2files = ext2files,
    }
    -- return result
end
function MAD.idir.jpgs(idir, reparse)
    local fjpgs = idir..'_jpgs.th'
    local function run()
        local n = 0
        local files = {}
        for file in dir.dirtree(idir) do
            if path.isfile(file) and path.extension(file) == '.jpg' then
                table.insert(files,file)
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
    end
    if not path.exists(fjpgs) or reparse == 'reparse' then
        run()
    end
    return torch.load(fjpgs)
end
function MAD.idir.jpgsIds(idir, opt)
    opt = opt or {}
    local quiet = opt.quiet or false
    local toreturn
    local ofile = idir..'_jpgsIds.th'
    if not path.exists(ofile) or opt.reparse then
        local n = 0
        local ids = {}
        for file in dir.dirtree(idir) do
            if path.isfile(file) and path.extension(file) == '.jpg' then
                table.insert(ids,path.basename(file))
                n = n + 1
                if opt.limit then 
                    if n > opt.limit then break end
                end
            end
            local n_str  = tostring(n)
            n_str = MAD.number2comas(n)
            n_str = stringx.rjust(n_str, 12)
            if not quiet then
                io.write('n jpgs = ',col.Cyan(n_str), '\r') io.flush()
            end
        end
        if not quiet then
            print('')
            print( col.Green(idir), col.Cyan(n) )
        end
        torch.save(ofile, files)
        toreturn = files
    else
        toreturn = MAD.load(ofile)
    end
    return toreturn
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
   MAD.print.function_name('MAD.idir.d1(d0)')
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


function MAD.idir.ids(idir, opt)
    opt = opt or {}
    local toreturn
    local ofile = idir..'_ids.th'
    if not path.exists(ofile) or opt.reparse then
        local n = 0
        local ids = {}
        for file in dir.dirtree(idir) do
            if path.isfile(file) and path.extension(file) == '.jpg' and string.find(file, 'Ai_') then
                local id = path.basename(file)
                table.insert(ids,id)
                n = n + 1
                if opt.limit then 
                    if n > opt.limit then break end
                end
            end
            local n_str  = tostring(n)
            n_str = MAD.number2comas(n)
            n_str = stringx.rjust(n_str, 12)
            if not quiet then
                io.write('n jpgs = ',col.Cyan(n_str), '\r') io.flush()
            end
        end
        if not opt.quiet then
            print('')
            print( col.Green(idir), col.Cyan(n) )
        end
        torch.save(ofile, ids)
        toreturn = ids
    else
        toreturn = MAD.load(ofile)
    end
    return toreturn
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
end


function MAD.totar(idir, ofile)
    -- local destination = "/Volumes/5tb-bckp/og-backup-june30.tgz"
    os.execute('tar cvf '..ofile..' '..idir)
end
function MAD.idir.indexes(idir, name)
    MAD.print.function_name("MAD.idir.indexes(idir)")
    MAD.print.two("idir",idir)
    local name = name or ''
    local f_id2file = idir..name..'-'..'id2file.th'
    local f_id2path = idir..name..'-'..'id2path.th'
    local f_files = idir..name..'-'..'files.th'
    local f_idfile = idir..name..'-'..'idfile.cscv'

    local jpgs = MAD.idir.jpgs(idir)
    local n = #jpgs

    MAD.print.two('idir', idir)
    MAD.print.two('n', n)

    local id2file = {}
    local id2path = {}
    local files = {}
    local idfile = {
        id = {},
        file = {},
    }

    local c = 0
    for i, file in ipairs(jpgs) do
        xlua.progress(i, #jpgs)
        local id = path.basename(file)
        local p = stringx.replace(file, idir, '')

        id2file[id] = file
        id2path[id] = p
        table.insert(files, file)
        table.insert(idfile.id, id)
        table.insert(idfile.file, file)
    end

    torch.save(f_id2file, id2file)
    torch.save(f_id2path, id2path)
    torch.save(f_files, files)
    MAD.csv.save(f_idfile, idfile)
end
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
    local odir = path.join(os.getenv('HOME'),'TMP_show')
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
function MAD.save(ofile, map)
    MAD.parent(ofile)
    image.save(ofile, map)
end
MAD.copy = MAD.file.copy

function MAD.sortUp(list, dim)
    table.sort(list, function(a,b) return a[dim] < b[dim]  end)
    return list
end
function MAD.sortDown(list, dim)
    table.sort(list, function(a,b) return a[dim] > b[dim]  end)
    return list
end

return MAD


