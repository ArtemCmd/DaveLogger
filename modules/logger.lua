local logger = {}
logger.__index = logger

local loggers = {}
local logs = {}
local packs
local launchDate = os.date("%y-%m-%d_%H-%M-%S")

setmetatable(logger, {
    __call = function(self, name)
        return self.new(name)
    end
})

local function get_name()
    local pack_id, _ = parse_path(debug.getinfo(3).source)

    if not packs then
        packs = pack.get_info(pack.get_installed())
    end

    return packs[pack_id].title
end

local function log(self, level, msg, ...)
    local date = os.date("%Y/%m/%d %H:%M:%S.000%z")
    local str = string.format("[%s] %s [%20s] %s", level, date, self.name, string.format(msg, ...))

    table.insert(logs, str)
    print(str)
end

function logger:info(msg, ...)
	log(self, "I", msg, ...)
end

function logger:debug(msg, ...)
	log(self, "D", msg, ...)
end

function logger:warning(msg, ...)
	log(self, "W", msg, ...)
end

function logger:error(msg, ...)
	log(self, "E", msg, ...)
end

function logger:save()
    file.write(pack.data_file("dave_logger", string.format("[%s].log", launchDate)), table.concat(logs, "\n"))
end

function logger.new(name)
    local object = loggers[name]

    if not object then
        object = {
            name = name or get_name()
        }
        setmetatable(object, logger)

        loggers[object.name] = object
    end

    return object
end

return logger
