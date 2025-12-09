-- ============================================
-- Interactive C++ Class Generator (CMake-aware)
-- ============================================

-- Get the "current folder" in a robust way
local function get_current_folder()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then
    -- Empty buffer, fallback to current working directory
    return vim.fn.getcwd()
  else
    -- Take the directory containing the current file
    return vim.fn.fnamemodify(bufname, ":p:h")
  end
end

-- Select between CMake auto-detection and current folder
local function choose_location(callback)
  local options = {
    "Auto-detect (CMake layout)",
    "Current folder",
  }

  vim.ui.select(options, { prompt = "Choose location:" }, function(choice)
    if not choice then return end

    if choice == "Current folder" then
      local current_dir = get_current_folder()
      callback(current_dir, current_dir)
      return
    end

    -- Auto-detect CMake-style include/src
    local header_dir = "."
    local source_dir = "."

    if vim.fn.isdirectory("include") == 1 then
      local entries = vim.fn.readdir("include")
      local subdir = nil
      for _, entry in ipairs(entries) do
        if vim.fn.isdirectory("include/" .. entry) == 1 then
          subdir = entry
          break
        end
      end
      if subdir then
        header_dir = "include/" .. subdir
      else
        header_dir = "include"
      end
    end

    if vim.fn.isdirectory("src") == 1 then
      source_dir = "src"
    end

    callback(header_dir, source_dir)
  end)
end

-- Main class generator
local function make_class()
  local options = { "Class (.h + .cpp)", "Header Only (.h)", "Qt Class (.h + .cpp)" }

  vim.ui.select(options, { prompt = "Choose template type:" }, function(choice)
    if not choice then return end

    vim.ui.input({ prompt = "Enter class name: " }, function(name)
      if not name or name == "" then return end

      choose_location(function(header_dir, source_dir)
        vim.fn.mkdir(header_dir, "p")
        vim.fn.mkdir(source_dir, "p")

        local ext = "h"
        local header, source = "", ""

        -- Determine include path relative to 'include' folder
        local include_path = name -- default: just the filename
        local include_root = "include"
        if header_dir:sub(1, #include_root) == include_root then
          local relative = header_dir:sub(#include_root + 2) -- remove "include/"
          if relative ~= "" then
            include_path = relative .. "/" .. name
          end
        end

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
#include "%s.h"

%s::%s(QObject *parent)
    : QObject(parent) {}

%s::~%s() {}
]], include_path, name, name, name, name)

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
#include "%s.h"

%s::%s() {}

%s::~%s() {}
]], include_path, name, name, name, name)

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

        -- Build file paths
        local header_path = string.format("%s/%s.%s", header_dir, name, ext)
        local source_path = string.format("%s/%s.cpp", source_dir, name)

        -- Write header
        if header ~= "" then
          local h = io.open(header_path, "w")
          h:write(header)
          h:close()
        end

        -- Write source
        if source ~= "" then
          local c = io.open(source_path, "w")
          c:write(source)
          c:close()
        end

        -- Open files in Neovim
        vim.cmd("edit " .. header_path)
        if source ~= "" then
          vim.cmd("vsplit " .. source_path)
        end

        print("Created class " .. name)
        print("  Header: " .. header_path)
        if source ~= "" then
          print("  Source: " .. source_path)
          print("  #include in source: " .. include_path .. ".h")
        end
      end)
    end)
  end)
end

-- Create command and keymap
vim.api.nvim_create_user_command("MakeClass", make_class, {})
vim.keymap.set("n", "<leader>mc", make_class, { desc = "Make new C++ class from template" })

