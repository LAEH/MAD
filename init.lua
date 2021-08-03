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


MAD.pixels = {}

MAD.pixels.file_rick = "assets/rick.jpg"

MAD.pixels.img_rick = image.load(MAD.pixels.file_rick)

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
function MAD.pixels.ifile.img2rgba(ifile, ofile, alpha)
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


MAD.pixels.img.dim = {}

function MAD.pixels.img.dim.white(img, factor)
    local img = img or MAD.jay.img()
    local factor = factor or 2
    local iw, ih = (#img)[3], (#img)[2]
    local white = torch.FloatTensor(3, ih, iw):uniform(1,1)
    local result = white + img
    result = result/factor
    return result
end
function MAD.pixels.img.dim.black(img, factor)
    local img = img or MAD.jay.img()
    local factor = factor or 2
    local iw, ih = (#img)[3], (#img)[2]
    local black = torch.FloatTensor(3, ih, iw):uniform(0,0)
    local result = black + img
    if color == 'black' then
        factor =3
    end
    result = result/factor
    return result
end


MAD.pixels.shuffle = {}

function MAD.pixels.shuffle.global(img)
    local channels = img:size(1)
    local h = img:size(2)
    local w = img:size(3)
    local matrix = img:view(channels, w * h)
    local perm = torch.randperm(w * h):long()
    local pixels = matrix:index(2,perm)
    local result = pixels:view(channels, h, w)
    return result
end
function MAD.pixels.shuffle.gaussian(img, spread)
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
function MAD.pixels.shuffle.bin(ifile, opt)

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
function MAD.pixels.shuffle.cut(ifile, opt)

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
function MAD.pixels.shuffle.TEST()
    local f_test = MAD.pixels.assets..'jay.jpg'
    function MAD.pixels.shuffle.global_TEST()
        MAD.pixels.show( MAD.pixels.shuffle.global(f_test) )
    end
    -- MAD.pixels.shuffle.global_TEST()
    function MAD.pixels.shuffle.gaussian_TEST()
        MAD.pixels.show( MAD.pixels.shuffle.gaussian(f_test, {spread = 64}) )
    end
    -- MAD.pixels.shuffle.gaussian_TEST()
    function MAD.pixels.shuffle.bin_TEST()
        local ifile = fs.pussy
        local out = MAD.pixels.shuffle.bin(f_test, {
            ih = 512,
            iw = 512,
            ncol = 2,
            nrow = 2,
        })
        MAD.pixels.show(out, 'pussy')
    end
    -- MAD.pixels.shuffle.bin_TEST()
    function MAD.pixels.shuffle.cut_TEST()
        local out = MAD.pixels.shuffle.cut(f_test, {
            ih = 1024,
            iw = 1024,
            ncol = 16,
            nrow = 16,
        })
        MAD.pixels.show(out)
    end
    -- MAD.pixels.shuffle.cut_TEST()
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
    local img = img or jay
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


function MAD.pixels.mask(opt)
    opt = opt or {}
    local command = 'magick composite -gravity center "'..opt.fmask..'" "'..opt.file..'" "'..opt.ofile..'"'
    os.execute(command)
end
function MAD.pixels.create_alpha_mask()
    local idir_masks = "/Users/laeh/Documents/MAD/masks/100"
    local odir_masks = "/Users/laeh/Documents/MAD/masks/1024*1024"

    local masks ={}
    for file in dir.dirtree(idir_masks) do
        if path.isfile(file) and path.extension(file) =='.png' then
            table.insert(masks, file)
        end
    end
    local colors= {}
    for _, file in ipairs( masks ) do

        local color = path.basename(file)
        color = stringx.replace(color, path.extension(file), '')
        table.insert(colors, color)

        print(color)
        for i=1, 99 do
            xlua.progress(i,99)
            local alpha = i/100
            local ofile =  path.join(odir_masks, color, i..'.png' )

            dir.makepath(path.dirname(ofile))
            if not path.exists(ofile) then
                local command = 'convert "'..file..'"  -alpha set -background none -channel A -evaluate multiply '..alpha..' +channel "'..ofile..'"'
                -- print( command )
                os.execute( command )
            end
        end
    end
end
function MAD.pixels.ifile.CropBoxFromImage(opt)
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
function MAD.pixels.img.box(img, rgb, s)
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
   img = image.scale(img, w, h)
   box[{ {},{t,b},{l,r} }] = img
   return box
end


local ifile = MAD.pixels.file_rick

function MAD.pixels.img.shortEdgeScale(img, shortedge)
   local shortEdge = 332
   local dims = #img
   local h,w = dims[2],dims[3]
   local r = w/h

   local ow,oh
   if r > 1 then
      -- print("r>1")
        oh = shortEdge
        ow = torch.round(oh * r)
   end
   if r < 1 then
      -- print("r<1")
      ow = shortEdge
      oh = torch.round(ow / r)
   end
   if r ==1 then
      ow = shortEdge
      oh = shortEdge
   end
   local res = image.scale(img, ow, oh)
   return res
end
return MAD


