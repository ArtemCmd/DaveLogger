local logger = require("dave_logger:logger")

function on_world_open()
    logger.save()
end

function on_world_save()
    logger.save()
end
