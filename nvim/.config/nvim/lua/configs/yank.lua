require("tiny-glimmer").setup {
  enabled = true,
  default_animation = "rainbow",
  refresh_interval_ms = 6,

  -- Only use if you have a transparent background
  -- It will override the highlight group background color for `to_color` in all animations
  transparency_color = "blue",

  animations = {
    fade = {
      max_duration = 250,
      chars_for_max_duration = 10,
    },
    bounce = {
      max_duration = 500,
      chars_for_max_duration = 20,
      oscillation_count = 1,
    },
    left_to_right = {
      max_duration = 350,
      chars_for_max_duration = 40,
      lingering_time = 50,
    },
    pulse = {
      max_duration = 400,
      chars_for_max_duration = 15,
      pulse_count = 2,
      intensity = 1.2,
    },
    rainbow = {
      max_duration = 600,
      chars_for_max_duration = 20,
    },
    custom = {
      max_duration = 350,
      chars_for_max_duration = 40,
      color = hl_visual_bg,

      -- Custom effect function
      -- @param self table The effect object
      -- @param progress number The progress of the animation [0, 1]
      --
      -- Should return a color and a progress value
      -- that represents how much of the animation should be drawn
      effect = function(self, progress)
        return self.settings.color, progress
      end,
    },
  },
  virt_text = {
    priority = 2048,
  },
}
