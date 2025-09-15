-- =========================
-- Interactive C++ Class Generator
-- =========================
local function make_class()
  local options = { "Class (.h + .cpp)", "Header Only (.h)", "Qt Class (.h + .cpp)" }

  vim.ui.select(options, { prompt = "Choose template type:" }, function(choice)
    if not choice then return end

    -- Ask for class name
    vim.ui.input({ prompt = "Enter class name: " }, function(name)
      if not name or name == "" then return end

      local ext = "h"
      local header = ""
      local source = ""

      -- ================== QT CLASS ==================
      if choice:find("Qt Class") then
        header = string.format([[
#pragma once

#include <QObject>

class %s : public QObject {
  Q_OBJECT

public:
    explicit %s(QObject *parent = nullptr);
    ~%s();

};
]], name, name, name)

        source = string.format([[
#include "%s.%s"

%s::%s(QObject *parent)
    : QObject(parent) {
}

%s::~%s() {
}
]], name, ext, name, name, name, name)

      -- ================== STANDARD CLASS ==================
      elseif choice:find("Class") then
        header = string.format([[
#pragma once

class %s {
public:
    %s();
    ~%s();

};
]], name, name, name)

        source = string.format([[
#include "%s.%s"

%s::%s() {
}

%s::~%s() {
}
]], name, ext, name, name, name, name)

      -- ================== HEADER ONLY ==================
      elseif choice:find("Header Only") then
        header = string.format([[
#pragma once

class %s {
public:
    %s() {}
    ~%s() {}

};
]], name, name, name)
      end

      local hasHeader = header ~= ""
      local hasSource = source ~= ""

      -- Write header file
      if hasHeader then
        local h_file = name .. "." .. ext
        local h = io.open(h_file, "w")
        h:write(header)
        h:close()
      end

      -- Write source file
      if hasSource then
        local cpp_file = name .. ".cpp"
        local cpp = io.open(cpp_file, "w")
        cpp:write(source)
        cpp:close()
      end

      -- Open files in Neovim
      if hasHeader and hasSource then
        vim.cmd("edit " .. name .. "." .. ext)
        vim.cmd("vsplit " .. name .. ".cpp")
        print("Created " .. name .. "." .. ext .. " and " .. name .. ".cpp")
      elseif hasHeader then
        vim.cmd("edit " .. name .. "." .. ext)
        print("Created " .. name .. "." .. ext)
      elseif hasSource then
        vim.cmd("edit " .. name .. ".cpp")
        print("Created " .. name .. ".cpp")
      end
    end)
  end)
end

vim.api.nvim_create_user_command("MakeClass", make_class, {})
vim.keymap.set("n", "<leader>mc", make_class, { desc = "Make new C++ class from template" })
