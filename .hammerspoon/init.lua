local fennel = require("fennel")

-- allow requiring of fennel modules
table.insert(package.loaders or package.searchers, fennel.searcher)

fennel.dofile("init.fnl", { allowedGlobals = false })
