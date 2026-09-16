---@brief
---
--- https://github.com/typed-ember/glint
--- https://typed-ember.gitbook.io/glint/
--- `glint-language-server` is installed when adding `@glint/core` to your project's devDependencies:
---
--- ```sh
--- npm install @glint/core --save-dev
--- yarn add -D @glint/core
---
--- This configuration uses the local installation of `glint-language-server`
--- (found in the `node_modules` directory of your project).
---
--- To use a global installation of `glint-language-server`,
--- set the `init_options.glint.useGlobal` to `true`.
---
--- vim.lsp.config('glint', {
---   init_options = {
---     glint = {
---       useGlobal = true,
---     },
---   },
--- })
--- > [!IMPORTANT]
--- > When installing via an `nvm`-managed `npm`, do so under your "default" version:
--- > ```sh
--- > nvm use default && npm install -g glint-language-server
--- > ```

local util = require 'lspconfig.util'

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = 'glint-language-server'
    ---@diagnostic disable-next-line: undefined-field
    if not config.init_options.glint.useGlobal then
      return util.start_rpc_node_lsp({ cmd }, dispatchers, config)
    end
    return vim.lsp.rpc.start({ cmd }, dispatchers)
  end,
  init_options = {
    glint = {
      useGlobal = false,
    },
  },
  filetypes = {
    'html.handlebars',
    'handlebars',
    'typescript',
    'typescript.glimmer',
    'javascript',
    'javascript.glimmer',
  },
  root_markers = {
    '.glintrc.yml',
    '.glintrc',
    '.glintrc.json',
    '.glintrc.js',
    'glint.config.js',
    'package.json',
  },
  workspace_required = true,
}
