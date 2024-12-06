local colors = require('colors.custom')
local backdrops = require('utils.backdrops')

return {
   max_fps = 120,
   front_end = 'WebGpu',
   -- webgpu_power_preference = 'HighPerformance',

   -- Cursor settings
   animation_fps = 1,
   cursor_blink_ease_in = 'EaseOut',
   cursor_blink_ease_out = 'EaseOut',
   default_cursor_style = 'BlinkingBlock',
   cursor_blink_rate = 650,

   -- Color scheme
   colors = colors,

   -- Background
   background = backdrops:initial_options(false),

   -- Scrollbar
   enable_scroll_bar = false,

   -- Tab bar
   enable_tab_bar = false,
   hide_tab_bar_if_only_one_tab = true,
   use_fancy_tab_bar = false,

   -- Window
   window_padding = {
      left = 5,
      right = 5,
      top = 10,
      bottom = 7.5,
   },
   adjust_window_size_when_changing_font_size = false,
   window_close_confirmation = 'NeverPrompt',
   window_frame = {
      active_titlebar_bg = '#090909',
   },
   inactive_pane_hsb = {
      saturation = 1,
      brightness = 1,
   },
}
