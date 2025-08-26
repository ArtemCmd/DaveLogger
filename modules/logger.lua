local logger = {}
logger.__index = logger

local loggers = {}
local logs = {}

setmetatable(logger, {
    __call = function(self, name)
        return self.new(name)
    end
})

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
    file.write(pack.data_file("dave_logger", "latest.log"), table.concat(logs, "\n"))
end

function logger.new(name)
    local object = loggers[name]

    if not object then
        object = {
            name = name or "lua"
        }
        setmetatable(object, logger)

        loggers[name] = object
    end

    return object
end

return logger
