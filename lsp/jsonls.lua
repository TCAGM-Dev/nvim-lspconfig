---@brief
---
--- https://github.com/hrsh7th/vscode-langservers-extracted
---
--- vscode-json-language-server, a language server for JSON and JSON schema
---
--- `vscode-json-language-server` can be installed via `npm`:
--- ```sh
--- npm i -g vscode-langservers-extracted
--- ```
--- > [!IMPORTANT]
--- > When installing via an `nvm`-managed `npm`, do so under your "default" version:
--- > ```sh
--- > nvm use default && npm i -g vscode-langservers-extracted
--- > ```
---
--- `vscode-json-language-server` only provides completions when snippet support is enabled. If you use Neovim older than v0.10 you need to enable completion, install a snippet plugin and add the following override to your language client capabilities during setup.
---
--- ```lua
--- --Enable (broadcasting) snippet capability for completion
--- local capabilities = vim.lsp.protocol.make_client_capabilities()
--- capabilities.textDocument.completion.completionItem.snippetSupport = true
---
--- vim.lsp.config('jsonls', {
---   capabilities = capabilities,
--- })
--- ```

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local bin = 'vscode-json-language-server'
    local cmd = { bin }
    local env = {}

    local nvm_exec = '/usr/share/nvm/nvm-exec'
    if vim.fn.executable(nvm_exec) then
      cmd = { nvm_exec, bin }
      env['NODE_VERSION'] = 'default'
      env['NVM_DIR'] = vim.fs.joinpath(os.getenv('HOME'), '.nvm')
    end

    if (config or {}).root_dir then
      local local_bin = vim.fs.joinpath(config.root_dir, 'node_modules/.bin', bin)
      if vim.fn.executable(local_bin) == 1 then
        cmd = { local_bin }
      end
    end

    table.insert(cmd, '--stdio')
    return vim.lsp.rpc.start(cmd, dispatchers, { env = env })
  end,
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { '.git' },
}
