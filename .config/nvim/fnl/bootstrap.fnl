(local nvim (require :aniseed.nvim))

(require :plugins)

(require :config.icons)
(require :config.lsp)
(require :config.tab)
(require :config.editor)
(require :config.ui)
(require :config.scroll)
(require :config.completion)
(require :config.formatting)
(require :config.terminal)
(require :config.tree)

(nvim.fn.glaive#Install)