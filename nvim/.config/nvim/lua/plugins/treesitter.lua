return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    ts.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    ts.install({
        "lua",
        "vim",
        "python",
        "javascript",
        "html",
        "markdown",
        "bash",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "html", "javascript", "c", "lua", "vim" },
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    -- Neovim's built-in Python indentexpr (python#GetIndent) mis-indents the
    -- two lines created when splitting an open `(`/`[`/`{` that's at end of
    -- line: it gives 2x shiftwidth to BOTH the content line and the closing
    -- bracket line, instead of 1x for the content line and 0 (aligned with
    -- the opener's line) for the closing bracket. Fix just those two cases;
    -- defer everything else to python#GetIndent.
    function _G.python_hanging_indent()
      local lnum = vim.v.lnum
      local line = vim.fn.getline(lnum)

      -- Closing-bracket-only line: align with the line holding the opener.
      local close = line:match("^%s*([%)%]}])")
      if close then
        local open_map = { [")"] = "(", ["]"] = "\\[", ["}"] = "{" }
        local close_esc = { [")"] = ")", ["]"] = "\\]", ["}"] = "}" }
        local pos = vim.fn.searchpairpos(open_map[close], "", close_esc[close], "bWn", "", 0)
        if pos[1] > 0 then
          return vim.fn.indent(pos[1])
        end
      end

      -- Hanging indent: previous non-blank line ends with an unmatched
      -- opening bracket at EOL -> indent one level deeper than it.
      local prevlnum = vim.fn.prevnonblank(lnum - 1)
      if prevlnum > 0 then
        local prevline = vim.fn.getline(prevlnum)
        if prevline:match("[%(%[{]%s*$") then
          return vim.fn.indent(prevlnum) + vim.fn.shiftwidth()
        end
      end

      return vim.fn["python#GetIndent"](lnum)
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function(args)
        vim.bo[args.buf].indentexpr = "v:lua.python_hanging_indent()"
      end,
    })
  end,
}
