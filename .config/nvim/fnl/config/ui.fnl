(local nvim (require :aniseed.nvim))

(local lsp-colors (require :lsp-colors))
(local lsp-trouble (require :trouble))
(local telescope (require :telescope))
(local which-key (require :which-key))
(local symbols-outline (require :symbols-outline))
(local lspkind (require :lspkind))
(local gitsigns (require :gitsigns))

(local g nvim.g)
(local o nvim.o)
(local wo nvim.wo)

;; Set theme TODO: move to config
(vim.cmd "set background=dark")
(vim.cmd "colorscheme gruvbox8")

;; Enable syntax highlight
(vim.cmd "syntax enable")
(vim.cmd "syntax on")

;; Disable signcolumn and split between windows
(vim.cmd "set signcolumn=no")
(vim.cmd "set fillchars=vert:\\▕")
(vim.cmd "
  augroup nosplit | au!
    autocmd ColorScheme * hi VertSplit ctermfg=bg guifg=bg
    autocmd ColorScheme * hi NonText guifg=bg
  augroup end
  ")

;; Leader key
(set g.mapleader " ") ; <Space> key

(set g.auto_save 0)

(set g.rainbow_active 1) ;; Enable rainbow brackets

;; Setup dashboard extension
(set g.dashboard_default_executive "telescope")
(set g.dashboard_custom_header [
  "    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠤⠖⠚⢉⣩⣭⡭⠛⠓⠲⠦⣄⡀⠀⠀⠀⠀⠀⠀⠀  "
  "    ⠀⠀⠀⠀⠀⠀⢀⡴⠋⠁⠀⠀⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⢦⡀⠀⠀⠀⠀  "
  "    ⠀⠀⠀⠀⢀⡴⠃⢀⡴⢳⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣆⠀⠀⠀  "
  "    ⠀⠀⠀⠀⡾⠁⣠⠋⠀⠈⢧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⠀⠀  "
  "    ⠀⠀⠀⣸⠁⢰⠃⠀⠀⠀⠈⢣⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠀  "
  "    ⠀⠀⠀⡇⠀⡾⡀⠀⠀⠀⠀⣀⣹⣆⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⠀  "
  "    ⠀⠀⢸⠃⢀⣇⡈⠀⠀⠀⠀⠀⠀⢀⡑⢄⡀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇  "
  "    ⠀⠀⢸⠀⢻⡟⡻⢶⡆⠀⠀⠀⠀⡼⠟⡳⢿⣦⡑⢄⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇  "
  "    ⠀⠀⣸⠀⢸⠃⡇⢀⠇⠀⠀⠀⠀⠀⡼⠀⠀⠈⣿⡗⠂⠀⠀⠀⠀⠀⠀⠀⢸⠁  "
  "    ⠀⠀⡏⠀⣼⠀⢳⠊⠀⠀⠀⠀⠀⠀⠱⣀⣀⠔⣸⠁⠀⠀⠀⠀⠀⠀⠀⢠⡟⠀  "
  "    ⠀⠀⡇⢀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⢸⠃⠀  "
  "    ⠀⢸⠃⠘⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠁⠀⠀⢀⠀⠀⠀⠀⠀⣾⠀⠀  "
  "    ⠀⣸⠀⠀⠹⡄⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⡞⠀⠀⠀⠸⠀⠀⠀⠀⠀⡇⠀⠀  "
  "    ⠀⡏⠀⠀⠀⠙⣆⠀⠀⠀⠀⠀⠀⠀⢀⣠⢶⡇⠀⠀⢰⡀⠀⠀⠀⠀⠀⡇⠀⠀  "
  "    ⢰⠇⡄⠀⠀⠀⡿⢣⣀⣀⣀⡤⠴⡞⠉⠀⢸⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣧⠀⠀  "
  "    ⣸⠀⡇⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⢹⠀⠀⢸⠀⠀⢀⣿⠇⠀⠀⠀⠁⠀⢸⠀⠀  "
  "    ⣿⠀⡇⠀⠀⠀⠀⠀⢀⡤⠤⠶⠶⠾⠤⠄⢸⠀⡀⠸⣿⣀⠀⠀⠀⠀⠀⠈⣇⠀  "
  "    ⡇⠀⡇⠀⠀⡀⠀⡴⠋⠀⠀⠀⠀⠀⠀⠀⠸⡌⣵⡀⢳⡇⠀⠀⠀⠀⠀⠀⢹⡀  "
  "    ⡇⠀⠇⠀⠀⡇⡸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠮⢧⣀⣻⢂⠀⠀⠀⠀⠀⠀⢧  "
  "    ⣇⠀⢠⠀⠀⢳⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⡎⣆⠀⠀⠀⠀⠀⠘  "])

;; Setup Code Action Menu
(set g.code_action_menu_show_diff false)

;; Setup Symbols Outline
(symbols-outline.setup {
  :highlight_hovered_item true
  :show_guides true
})

;; Setup Git Signs
(gitsigns.setup {})

;; Setup Which Key
(which-key.setup {})

;; Setup LSP Trouble
(lsp-trouble.setup {})

;; Setup LSP Colors
(lsp-colors.setup {
  :Error "#db4b4b"
  :Warning "#e0af68"
  :Information "#0db9d7"
  :Hint "#10B981"
})

;; Disable builtin statusline
(vim.cmd "set noshowmode")

;; Setup LspKind symbols
(set vim.o.completeopt "menuone,noselect")

(lspkind.init {
  :with_text true
  :symbol_map {
    :Text ""
    :Method ""
    :Function "ƒ"
    :Constructor ""
    :Variable ""
    :Class "פּ "
    :Interface "蘒"
    :Module ""
    :Property ""
    :Field ""
    :Event ""
    :TypeParameter "<>"
    :Unit "塞"
    :Value ""
    :Enum "練"
    :Keyword ""
    :Snippet ""
    :Color ""
    :File ""
    :Folder ""
    :EnumMember ""
    :Constant ""
    :Struct ""
  }
})

;; Setup telescope
(telescope.setup {
  :pickers {
    :find_files {:theme :dropdown :prompt_prefix "🔍"}
    :buffers {:theme :dropdown}
    :colorscheme {:theme :dropdown}
    :help_tags {:theme :dropdown}
    :live_grep {:theme :dropdown}
  }
  :extensions {
    :fzf {
      :fuzzy true
      :override_generic_sorter true
      :override_file_sorter true
      :case_mode "smart_case"
    }
    :media_files {
      :filetypes ["png" "jpeg" "jpg" "mp4" "webm" "pdf" "webp"]
      :find_cmd "find"
    }
  }
})

;; Setup key bindings

(vim.api.nvim_set_keymap "n" "<leader>ltt" "<cmd>LspTroubleToggle<CR>"      {:noremap true}) ;; Open diagnostic menu
(vim.api.nvim_set_keymap "n" "<leader>ltd" "<cmd>TroubleToggle<CR>"         {:noremap true}) ;; Open TODO menu
(vim.api.nvim_set_keymap "n" "<leader>so"  "<cmd>SymbolsOutline<CR>"        {:noremap true}) ;; Open symbol map

(vim.api.nvim_set_keymap "n" "<leader>ff"  "<cmd>Telescope find_files<CR>"  {:noremap true}) ;; Open find files
(vim.api.nvim_set_keymap "n" "<leader>fg"  "<cmd>Telescope live_grep<CR>"   {:noremap true}) ;; Open live grep
(vim.api.nvim_set_keymap "n" "<leader>fb"  "<cmd>Telescope buffers<CR>"     {:noremap true}) ;; Open openned buffers
(vim.api.nvim_set_keymap "n" "<leader>fh"  "<cmd>Telescope help_tags<CR>"   {:noremap true}) ;; Open help
(vim.api.nvim_set_keymap "n" "<leader>fc"  "<cmd>Telescope colorscheme<CR>" {:noremap true}) ;; Open colorscheme change