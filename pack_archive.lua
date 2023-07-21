local ar = require "ar"
local filesystem = require "system.filesystem"
local lib = {}
for _, v in ipairs(filesystem.list("ccryptolib")) do
    if v ~= "internal" then
        local f = ar.read("ccryptolib/" .. v)
        f.data = f.data:gsub("ccryptolib%.internal%.", "internal_"):gsub("ccryptolib%.", "")
        lib[#lib+1] = f
    end
end
for _, v in ipairs(filesystem.list("ccryptolib/internal")) do
    local f = ar.read("ccryptolib/internal/" .. v)
    f.data = f.data:gsub("ccryptolib%.internal%.", "internal_"):gsub("ccryptolib%.", "")
    f.name = "internal_" .. f.name
    lib[#lib+1] = f
end
ar.save(lib, "libccryptolib.a")
print("Successfully packed to libccryptolib.a")