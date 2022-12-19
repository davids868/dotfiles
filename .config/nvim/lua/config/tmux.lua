require("tmux").setup {
  navigation = {
    cycle_navigation = false,
    enable_default_keybindings = true,
  },
  resize = {
    enable_default_keybindings = true,
    resize_step_x = 5,
    resize_step_y = 5,
  },
}
