--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- helper keymaps
vim.keymap.set('n', '<leader>o', 'mzo<Esc>`z')
vim.keymap.set('n', '<leader>O', 'mzO<Esc>`z')
vim.keymap.set({ 'n', 'x' }, '<leader>h', '^')
vim.keymap.set({ 'n', 'x' }, '<leader>l', 'g_')

-- Jump to mark
vim.keymap.set('n', '<leader>m', '`', { desc = 'Jump to mark' })


-- Open config file
vim.keymap.set('n', '<leader>co', '<cmd>edit ' .. vim.fn.stdpath('config') .. '/init.lua<CR>',
  { desc = 'Open init.lua config' })

-- disable s key so that it doesn't initiate insert mode
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
-- activate surround with capital S in visual mode
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })
-- Exit insert mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = false })

if vim.g.vscode then
  -- Require the VSCode API module
  local vscode = require('vscode')
  local opts = { noremap = true, silent = true }

  local mappings = {
    -- {mode, command, vscodeAction}
    { 'n', 'gi',          'editor.action.goToImplementation' },
    { 'n', 'gs',          'workbench.action.gotoSymbol' },
    { 'n', 'gR',          'editor.action.referenceSearch.trigger' },
    { 'n', 'gI',          'editor.action.peekImplementation' },
    { 'n', 'gS',          'workbench.action.showAllSymbols' },
    { 'n', '<leader>rf',  'editor.action.refactor' },
    { 'n', '<leader>ff',  'workbench.action.quickOpen' },
    { 'n', '<leader>fif', 'actions.find' },
    { 'n', '<leader>fr',  'editor.action.startFindReplaceAction' },
    { 'n', '<leader>faf', 'workbench.action.findInFiles' },
    { 'n', '<leader>qf',  'editor.action.quickFix' },
    { 'n', '<leader>ne',  'editor.action.marker.next' },
    { 'n', '<leader>Ne',  'editor.action.marker.prev' },
    { 'n', '<leader>rt',  'workbench.action.tasks.runTask' },
    { 'n', '<leader>ex',  'workbench.files.action.showActiveFileInExplorer' },
  }

  for _, mapping in ipairs(mappings) do
    local mode, command, action = mapping[1], mapping[2], mapping[3]
    vim.keymap.set(mode, command, function() vscode.call(action) end, opts)
  end
end


-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  {                   -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup({
        highlight_duration = 5000,
        n_lines = 50,
      })


      require('mini.jump').setup()
      require('mini.jump2d').setup({
        mappings = {
          start_jumping = '<leader><leader>',
        },
      })


      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
          require("nvim-treesitter.configs").setup({
            textobjects = {
              select = {
                enable = true,
                lookahead = true,
                keymaps = {
                  ["af"] = "@function.outer",
                  ["if"] = "@function.inner",
                  ["ac"] = "@class.outer",
                  ["ic"] = "@class.inner",
                  ["aA"] = "@assignment.outer",
                  ["iA"] = "@assignment.inner",
                },
                selection_modes = {
                  -- ['@function.outer'] = 'V',
                  ['@class.outer'] = 'V',
                },
                include_surrounding_whitespace = false,
              },
            },
          })
        end,
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
        },
        highlight = { enable = true },
        indent = { enable = false },
        auto_install = true,
        playground = { enable = false },
      })
    end,
    -- "nvim-treesitter/playground", -- ← This installs the playground module
  },
  {
    'vscode-neovim/vscode-multi-cursor.nvim',
    event = 'VeryLazy',
    cond = not not vim.g.vscode,
    opts = {
      -- Disable default mappings to use custom ones
      default_mappings = false,
      no_selection = false,
    },
    config = function()
      local cursors = require('vscode-multi-cursor')

      -- Custom mappings with capital M
      vim.keymap.set({ 'n', 'x' }, 'Mc', cursors.create_cursor, { expr = true, desc = 'Create cursor' })
      vim.keymap.set({ 'n', 'x' }, 'Mi', cursors.start_left, { desc = 'Start cursors on the left' })
      vim.keymap.set({ 'n', 'x' }, 'MI', cursors.start_left_edge, { desc = 'Start cursors on the left edge' })
      vim.keymap.set({ 'n', 'x' }, 'Ma', cursors.start_right, { desc = 'Start cursors on the right' })
      vim.keymap.set({ 'n', 'x' }, 'MA', cursors.start_right, { desc = 'Start cursors on the right' })

      -- VSCode wrapped commands
      vim.keymap.set({ 'n', 'x' }, 'Ms', cursors.selectHighlights, { desc = 'Select all highlights' })
      vim.keymap.set('n', 'Mw', 'Mciw*<Cmd>nohl<CR>', { remap = true })

      -- Clear cursors with Escape
      vim.keymap.set('n', '<Esc>', function()
        cursors.cancel()
        vim.cmd('nohlsearch')
      end, { desc = 'Clear cursors and search highlights' })
    end,
  }


})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
