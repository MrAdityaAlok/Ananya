-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.relativenumber = false

opt.guifont = "Iosevka Nerd Font:h14"

if vim.g.neovide then
  vim.g.neovide_transparency = 0.55
  -- vim.g.neovide_text_gamma = 0.8
  -- vim.g.neovide_text_contrast = 0.1
end
