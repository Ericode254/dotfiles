local wilder = require('wilder')

-- Set up wilder with command modes
wilder.setup({modes = {':', '/', '?'}})

-- Disable Python remote plugin if you're not using it
wilder.set_option('use_python_remote_plugin', 0)

-- Set up the pipeline
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,  -- Enable fuzzy matching
      fuzzy_filter = wilder.lua_fzy_filter(),  -- Use lua_fzy for filtering
    }),
    wilder.vim_search_pipeline()  -- Use vim's native search pipeline
  ),
})

-- Set up the renderer with custom highlighters
wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),  -- Use lua_fzy for highlighting
    left = {
      ' ',
      wilder.popupmenu_devicons(),  -- Optional: Show file type icons
    },
    right = {
      ' ',
      wilder.popupmenu_scrollbar(),  -- Optional: Show scrollbar
    },
  }),
  ['/'] = wilder.wildmenu_renderer({
    highlighter = wilder.lua_fzy_highlighter(),  -- Use lua_fzy for highlighting
  }),
}))

wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_palette_theme({
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
    border = 'rounded',
    max_height = '75%',      -- max height of the palette
    min_height = 0,          -- set to the same as 'max_height' for a fixed height window
    prompt_position = 'top', -- 'top' or 'bottom' to set the location of the prompt
    reverse = 0,             -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
  })
))
