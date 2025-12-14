local function detect_project_name()
  local cmake = io.open("CMakeLists.txt", "r")
  if not cmake then return nil end

  for line in cmake:lines() do
    local name = line:match("project%s*%(%s*([%w_%-]+)")
    if name then
      cmake:close()
      return name
    end
  end
  cmake:close()
  return nil
end

local function dir_exists(path)
  return vim.fn.isdirectory(path) == 1
end

local function detect_paths()
  local project = detect_project_name()

  local header_dir = "."
  local source_dir = "."

  -- Prefer CMake-style include/project_name/
  if project and dir_exists("include/" .. project) then
    header_dir = "include/" .. project
  elseif dir_exists("include") then
    header_dir = "include"
  end

  -- Standard CMake src/
  if dir_exists("src") then
    source_dir = "src"
  end

  return header_dir, source_dir
end

local function make_class()
  local options = { "Class (.h + .cpp)", "Header Only (.h)", "Qt Class (.h + .cpp)" }

  vim.ui.select(options, { prompt = "Choose template type:" }, function(choice)
    if not choice then return end

    vim.ui.input({ prompt = "Enter class name: " }, function(name)
      if not name or name == "" then return end

      local header_dir, source_dir = detect_paths()
      vim.fn.mkdir(header_dir, "p")
      vim.fn.mkdir(source_dir, "p")

      local ext = "h"
      local header, source = "", ""

      -- Templates
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

%s::~%s() {}
]], name, ext, name, name, name, name)

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

%s::%s() {}

%s::~%s() {}
]], name, ext, name, name, name, name)

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

      -- Paths
      local header_path = string.format("%s/%s.%s", header_dir, name, ext)
      local source_path = string.format("%s/%s.cpp", source_dir, name)

      -- Write files
      if header ~= "" then
        local f = io.open(header_path, "w")
        f:write(header)
        f:close()
      end

      if source ~= "" then
        local f = io.open(source_path, "w")
        f:write(source)
        f:close()
      end

      -- Open them
      vim.cmd("edit " .. header_path)
      if source ~= "" then
        vim.cmd("vsplit " .. source_path)
      end

      print("Created class " .. name .. " in:")
      print("  Header: " .. header_dir)
      if source ~= "" then
        print("  Source: " .. source_dir)
      end
    end)
  end)
end

vim.api.nvim_create_user_command("MakeClass", make_class, {})
vim.keymap.set("n", "<leader>mc", make_class)

