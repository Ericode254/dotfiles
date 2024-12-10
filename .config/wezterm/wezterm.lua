local Config = require('config')

require('utils.backdrops')
   :set_files()
   -- :set_focus('#000000')
   :random()

return Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch')).options
