package = "MAD"
version = "scm-1"

source = {
   url = "git@github.com/LAEH/MAD",
   branch = "master"
}

description = {
   summary = "MAD",
   detailed = [[
MAD but not stressin
   ]],
   homepage = "https://github.com/LAEH/MAD",
   license = "BSD"
}

dependencies = {
}

build = {
   type = "builtin",
   modules = {
      ['MAD.init'] = 'init.lua',
   }
}
