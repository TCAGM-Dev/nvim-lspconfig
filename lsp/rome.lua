---@brief
---
--- https://rome.tools
---
--- Language server for the Rome Frontend Toolchain.
---
--- (Unmaintained, use [Biome](https://biomejs.dev/blog/annoucing-biome) instead.)
---
--- ```sh
--- npm install [-g] rome
--- ```
--- > [!IMPORTANT]
--- > When installing via an `nvm`-managed `npm`, do so under your "default" version:
--- > ```sh
--- > nvm use default && npm install [-g] rome
--- > ```

local util = require 'lspconfig.util'

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    return util.start_rpc_node_lsp({ 'rome', 'lsp-proxy' }, dispatchers, config)
  end,
  filetypes = {
    'javascript',
    'javascriptreact',
    'json',
    'typescript',
    'typescriptreact',
  },
  root_markers = { 'package.json', 'node_modules', '.git' },
}
