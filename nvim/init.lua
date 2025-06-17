-- Ensure lazy.nvim is installed if not already
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require("lazy").setup({
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "moon",
        styles = {
          bold = true,
          italic = false,
          transparency = true,
        },
        enable = {
          terminal = true,
          legacy_highlights = false,
        }
      })
      vim.cmd("colorscheme rose-pine")
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({ options = { theme = 'rose-pine' } })
    end
  },
  { "neoclide/coc.nvim", branch = "release" },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        hijack_netrw = true,
        disable_netrw = true,
        view = {
          width = 35,
          side = "left",
          relativenumber = true,
          preserve_window_proportions = true,
        },
        renderer = {
          full_name = true,
          highlight_git = true,
          highlight_opened_files = "all",
          indent_markers = {
            enable = true,
            inline_arrows = true,
          },
          root_folder_label = ":t",
          icons = {
            glyphs = {
              default = "󰈚",
              symlink = "",
              bookmark = "",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "",
                staged = "",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
          show_on_dirs = true,
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
          ignore_list = {},
        },
      })
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup{}
    end
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('dashboard').setup({
        theme = 'doom',
        config = {
          header = {
            '',
            '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
            '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
            '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
            '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
            '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
            '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
            '',
          },
          center = {
            { icon = '  ', desc = 'New File', action = 'enew', shortcut = 'n' },
            { icon = '  ', desc = 'Open File Tree', action = 'NvimTreeToggle', shortcut = 'f' },
            { icon = '  ', desc = 'Find File', action = function() require('telescope.builtin').find_files() end, shortcut = 's' },
            { icon = '  ', desc = 'Quit', action = 'qa', shortcut = 'q' },
          },
          footer = { "", "Happy coding with Neovim ❤️"},
        }
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = { indent = { char = "│" }, scope = { enabled = true } }
  },
  {
    "rcarriga/nvim-notify",
    config = function() vim.notify = require("notify") end
  },
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({})
    end,
  },
  { "stevearc/dressing.nvim", opts = {} },
  { "karb94/neoscroll.nvim", config = function() require('neoscroll').setup() end },
  { "folke/zen-mode.nvim", config = function() require("zen-mode").setup() end },
  { "gen740/SmoothCursor.nvim", config = function() require("smoothcursor").setup() end },
  { "folke/drop.nvim", config = function() require("drop").setup({ theme = "stars" }) end },
  { "echasnovski/mini.animate", version = false, config = function() require("mini.animate").setup() end },
})

-- Keymaps
vim.cmd([[
  inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"
  nnoremap <F2> :NvimTreeToggle<CR>
  nnoremap <C-p> :Telescope find_files<CR>
]])

-- Coc extensions
vim.g.coc_global_extensions = {
  'coc-snippets',
  'coc-pyright',
  'coc-clangd',
  'coc-json',
  'coc-tsserver'
}

-- تحسين العرض
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.foldcolumn = "0"
vim.opt.scrolloff = 5

-- تشغيل Python بـ F5
local Terminal = require("toggleterm.terminal").Terminal
vim.keymap.set("n", "<F5>", function()
  local file = vim.fn.expand("%:t")
  if file:match("%.py$") then
    vim.cmd("w")
    local term = Terminal:new({
      cmd = "python3 " .. file,
      direction = "float",
      close_on_exit = false,
      hidden = true,
      start_in_insert = true,
    })
    term:toggle()
  end
end)

-- تشغيل C++ بـ F6 داخل ملفات cpp
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    local Terminal = require("toggleterm.terminal").Terminal
    vim.keymap.set("n", "<F6>", function()
      vim.cmd("w")
      local filename = vim.fn.expand("%:t")
      local output = vim.fn.expand("%:t:r") .. ".out"
      local cmd = string.format("g++ %s -o %s && ./%s", filename, output, output)
      local term = Terminal:new({
        cmd = cmd,
        direction = "float",
        close_on_exit = false,
        hidden = true,
        start_in_insert = true,
      })
      term:toggle()
    end, { buffer = true })
  end,
})
