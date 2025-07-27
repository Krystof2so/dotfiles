-- environment.lua

local M = {}

-- Fonction utilitaire : vérifie si une commande existe dans le PATH
local function executable_exists(cmd)
  local handle = io.popen("command -v " .. cmd .. " 2>/dev/null")
  if not handle then
    return false
  end
  local result = handle:read "*a"
  handle:close()
  return result ~= nil and result ~= ""
end

-- Shell par défaut avec solution de repli :
if executable_exists "zsh" then
  M.shell = { "zsh" }
else
  M.shell = { "bash" }
end

-- Éditeur par défaut avec solution de repli :
if executable_exists "nvim" then
  M.editor = "nvim"
else
  M.editor = "vi"
end

-- Locale : utilise la locale système si définie, sinon en_US.UTF-8
local locale = os.getenv "LANG"
if locale == nil or locale == "" then
  locale = "en_US.UTF-8"
end
M.locale = locale

return M
