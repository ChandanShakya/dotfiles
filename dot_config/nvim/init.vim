syntax on                   " Turn Syntax highlighting On
filetype plugin indent on

set mouse=a
set nocompatible
set t_Co=256
set encoding=utf-8
set relativenumber          " Turn relative line numbering On
set number                  " Turn line number on
set visualbell              " Use Visual Bell instead of audible bell
set t_vb=                   " Set no visual bell
set noerrorbells            " Turn Error Bells off
set noshowmode              " Show no mode below status bar
set tabstop=4               " Put 4 spaces = 1 tab
set softtabstop=4           " While editing, count 4 spaces = 1 tab
set shiftwidth=4            " While indenting, indent 4 spaces inside
set expandtab               " Allow individual space navigation in tabs
set smartindent             " Perform smart indent
set showmatch               " Highlight matching brackets
set nohlsearch              " After searching, remove the highlight
set smartcase               " Case sensitive highlighting while search
set nowrap                  " Do not wrap text when reaching max window length
set noswapfile              " Creates no swap file
set nobackup                " Do not create a backup file before overwriting
set incsearch               " Highilights the words as you type

highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE

call plug#begin('~/.vim/plugged')   " Call the plugins from plugin directory

Plug 'tpope/vim-fugitive'
Plug 'ap/vim-css-color'
Plug 'preservim/nerdtree'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'andweeb/presence.nvim'
Plug 'rust-lang/rust.vim'
Plug 'simrat39/rust-tools.nvim'
Plug 'Chiel92/vim-autoformat'

Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind.nvim'
Plug 'vim-syntastic/syntastic'
Plug 'github/copilot.vim'

call plug#end()                     " End the plugin call

colorscheme zellner                 " Set Colorscheme to slate
set background=dark                 " Set background to dark

let mapleader = " "                 " Set the leader key to space
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <silent> <leader>= :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>. :resize +5<CR>
nnoremap <silent> <leader>, :resize -5<CR>
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <C-n> :tabnew<CR>
nnoremap <C-q> :tabclose<CR>
nnoremap <C-f> :Autoformat<CR>
augroup CBuild
    autocmd!
    autocmd filetype c nnoremap <buffer> <C-b> :w !gcc % -o %< & ./%<<CR>
    autocmd filetype javascript nnoremap <buffer> <C-b> :w !node %<CR>
    autocmd filetype python nnoremap <buffer> <C-b> :w !python %<CR>
    autocmd filetype html nnoremap <buffer> <C-b> :w !google-chrome-stable --incognito %<CR>
augroup END
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

let g:lightline = {
            \ 'active': {
                \   'left': [ [ 'mode', 'paste' ],
                \             [ 'readonly', 'filename', 'gitbranch', 'modified' ] ]
                \ },
                \ 'right': [ [ 'lineinfo', 'syntastic' ],
                \            [ 'percent' ],
                \            [ 'fileformat', 'fileencoding', 'filetype' ] ],
                \ 'component_function': {
                    \   'gitbranch': 'FugitiveHead',
                    \   'syntastic': 'SyntasticStatuslineFlag',
                    \ },
                    \ }
let g:syntastic_mode_map = { 'mode': 'passive',
            \                      'active_filetypes': ['c', 'cpp', 'rust'] }
let g:syntastic_rust_checkers = ['cargo']

" Start NERDTree when Vim is started without file arguments.
let g:python3_host_prog = '/usr/bin/python3'
let g:vimwiki_list_ignore_newline = 0
let g:vimwiki_list = [{'auto_diary_index': 1}]
"let NERDTreeShowHidden=0
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

"autocmd BufWritePre * :%s/\s\+$//e
set completeopt=menu,menuone,noselect

lua << EOF
local cmp = require'cmp'

--require'lspconfig'.bashls.setup{}
require("nvim-lsp-installer").setup {}

require'nvim-treesitter.configs'.setup {
    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {"c","html","css","javascript","php","bash","vim","markdown","lua","rust","java"},

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        -- disable = { "html" },

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
        },
    indent = {
        enable = true
        },
    }

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
    { name = 'buffer' },
    })
})

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
          { name = 'buffer' }
          }
      })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
      { name = 'path' }
      }, {
      { name = 'cmdline' }
      })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['bashls'].setup {
      capabilities = capabilities
      }
  require('lspconfig')['ltex'].setup {
      capabilities = capabilities
      }
  require('lspconfig').ccls.setup {
      capabilities=capabilities,
      init_options = {
          cache = {
              directory = ".ccls-cache";
              };
          }
      }
  require('lspconfig')['dockerls'].setup {
      capabilities = capabilities
      }

  require('lspconfig')['yamlls'].setup {
      capabilities = capabilities
      }
  require('lspconfig')['sqls'].setup {
      capabilities = capabilities
      }

  require('lspconfig')['jdtls'].setup {
      capabilities = capabilities
      }
  require('lspconfig')['html'].setup {
      capabilities=capabilities
      }
  require('lspconfig')['intelephense'].setup {
      capabilities=capabilities
      }
  require('lspconfig')['tsserver'].setup {
      capabilities=capabilities,
      on_attach = custom_attach, root_dir = vim.loop.cwd
      }
  require('lspconfig')['pyright'].setup {
      capabilities=capabilities
      }
  require('lspconfig')['cssls'].setup {
      capabilities=capabilities
      }
  require('lspconfig')['pyright'].setup {
      capabilities=capabilities
      }
  require('lspconfig')['vimls'].setup {
      capabilities=capabilities
      }
  local lspkind = require('lspkind')
  cmp.setup {
      formatting = {
          format = lspkind.cmp_format({
          mode = 'symbol', -- show only symbol annotations
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

          -- The function below will be called before any actual modifications from lspkind
          -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
          before = function (entry, vim_item)
          return vim_item
          end
          })
      }
  }
  local nvim_lsp = require'lspconfig'

  local opts = {
      tools = { -- rust-tools options
      autoSetHints = true,
      hover_with_actions = false,
      inlay_hints = {
          show_parameter_hints = false,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
          },
      hover_actions = {
          border = {
              {"╭", "FloatBorder"}, {"─", "FloatBorder"},
              {"╮", "FloatBorder"}, {"│", "FloatBorder"},
              {"╯", "FloatBorder"}, {"─", "FloatBorder"},
              {"╰", "FloatBorder"}, {"│", "FloatBorder"}
              },
          auto_focus = true
          }
      },
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
      -- on_attach is a callback called when the language server attachs to the buffer
      -- on_attach = on_attach,
      settings = {
          -- to enable rust-analyzer settings visit:
          -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
          ["rust-analyzer"] = {
              -- enable clippy on save
              checkOnSave = {
                  command = "clippy"
                  },
              }
          }
      },
  }

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
-- Enable LSP snippets
snippet = {
    expand = function(args)
    vim.fn["vsnip#anonymous"](args.body)
    end,
    },
mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Insert,
    select = true,
    })
},

  -- Installed sources
  sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
      { name = 'buffer' },
      },
  })
local util = require 'lspconfig.util'

local root_files = {
    'compile_commands.json',
    '.ccls',
    }

return {
    default_config = {
        cmd = { 'ccls' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_dir = function(fname)
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
        end,
        offset_encoding = 'utf-32',
        -- ccls does not support sending a null root directory
        single_file_support = false,
        },
    docs = {
        description = [[
        https://github.com/MaskRay/ccls/wiki

        ccls relies on a [JSON compilation database](https://clang.llvm.org/docs/JSONCompilationDatabase.html) specified
        as compile_commands.json or, for simpler projects, a .ccls.
        For details on how to automatically generate one using CMake look [here](https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html). Alternatively, you can use [Bear](https://github.com/rizsotto/Bear).

        Customization options are passed to ccls at initialization time via init_options, a list of available options can be found [here](https://github.com/MaskRay/ccls/wiki/Customization#initialization-options). For example:

        ```lua
        local lspconfig = require'lspconfig'
        lspconfig.ccls.setup {
            init_options = {
                compilationDatabaseDirectory = "build";
                index = {
                    threads = 0;
                    };
                clang = {
                    excludeArgs = { "-frounding-math"} ;
                    };
                }
            }

        ```

        ]],
    default_config = {
        root_dir = function(fname)
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
        end,
        },
    },
}
EOF
