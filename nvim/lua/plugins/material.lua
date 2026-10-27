return {
	"marko-cerovac/material.nvim",
	lazy = false,
	priority = 1000,

	config = function()
		vim.g.material_style = "deep ocean"

		-- true: let Ghostty provide the terminal background and opacity.
		-- false: use this file's configured c.bg color instead.
		local transparent_background = true
		local function bg(color)
			return transparent_background and "NONE" or color
		end

		-- ============================================================
		-- MUTED DEEP OCEAN PALETTE
		-- ============================================================

		local c = {
			-- Editor backgrounds used when transparent_background = false
			bg = "#202226",
			bg_alt = "#090B10",
			float = "#11141D",
			surface = "#171B25",
			cursorline = "#191D27",
			selection = "#252A38",
			border = "#303747",
			highlight = "#252A38",

			-- Text
			fg = "#AEB8CA",
			text = "#e0e0f0", -- Headings, emphasized text, and selected labels
			muted = "#8993A6",
			dim = "#6E788D",
			comment = "#687387",
			line_nr = "#596276",

			-- Main UI accent: keep this desaturated cyan-gray
			accent = "#87969A",
			accent_dim = "#717F84",

			-- Syntax colors: original Material palette (100%)
			red = "#F07178",
			red_dim = "#C53B53",
			green = "#a3E88D",
			green_dim = "#71B859",
			yellow = "#FFCB6B",
			yellow_dim = "#F98C6C",
			blue = "#82AAFF",
			blue_dim = "#5F87E5",
			paleblue = "#B2CCD6",
			cyan = "#89DDFF",
			cyan_dim = "#39ADB5",
			purple = "#C792EA",
			purple_dim = "#A37ACC",
			orange = "#F78C6C",
			orange_dim = "#D9826B",
			pink = "#F4aFa1",
			pink_dk = "#FF5370",

			-- Semantic colors
			property = "#FFdB7B",
			identifier = "#EEFFFF",
			constant = "#EEFFFF",
			func = "#82AAFF",
			type = "#FFCB6B",
			keyword = "#C792EA",
			string = "#a3E88D",
			number = "#F78C6C",
			punctuation = "#89DDFF",
			operator = "#89DDFF",

			-- Diagnostics
			error = "#F07178",
			warning = "#FFCB6B",
			info = "#82AAFF",
			hint = "#C792EA",
			ok = "#a3E88D",
			--
			-- Git
			git_add = "#6BBF59",
			git_change = "#4A88F8",
			git_delete = "#FF5C54",

			-- Search
			search = "#383c98",
			inc_search = "#f8fc88",
			cur_search = "#c83c93",
		}

		-- ============================================================
		-- HIGHLIGHT HELPERS
		-- ============================================================

		local h = {}

		local function set_fg(groups, color, attrs)
			for _, group in ipairs(groups) do
				h[group] = { fg = color }

				if attrs then
					for key, value in pairs(attrs) do
						h[group][key] = value
					end
				end
			end
		end

		local function set_bg(groups, color)
			for _, group in ipairs(groups) do
				h[group] = { bg = color }
			end
		end

		-- ============================================================
		-- EDITOR AND UI
		-- ============================================================

		h.Normal = { fg = c.fg, bg = bg(c.bg) }
		h.NormalNC = { fg = c.fg, bg = bg(c.bg) }
		h.EndOfBuffer = { fg = c.bg_alt, bg = bg(c.bg) }
		h.NonText = { fg = c.dim }
		h.Whitespace = { fg = c.dim }

		h.CursorLine = { bg = c.cursorline }
		h.CursorLineNr = { fg = c.text, bold = true }
		h.LineNr = { fg = c.line_nr }

		h.ColorColumn = { bg = c.surface }
		h.Visual = { bg = c.selection }
		h.Search = { fg = c.text, bg = c.search }
		h.IncSearch = { fg = c.bg_alt, bg = c.inc_search }
		h.CurSearch = { fg = c.bg, bg = c.cur_search, bold = true }
		h.MatchParen = { fg = c.text, bg = c.selection, bold = true }

		h.WinSeparator = { fg = c.border, bg = bg(c.bg) }
		h.VertSplit = { fg = c.border, bg = bg(c.bg) }
		h.FloatBorder = { fg = c.border, bg = c.float }
		h.NormalFloat = { fg = c.fg, bg = c.float }
		h.FloatTitle = { fg = c.text, bg = c.float }
		h.FloatFooter = { fg = c.muted, bg = c.float }

		h.Folded = { fg = c.muted, bg = c.surface }
		h.FoldColumn = { fg = c.dim }
		h.SignColumn = { bg = bg(c.bg) }

		h.Pmenu = { fg = c.fg, bg = c.float }
		h.PmenuSel = { fg = c.text, bg = c.selection }
		h.PmenuSbar = { bg = c.surface }
		h.PmenuThumb = { bg = c.border }

		h.StatusLine = { fg = c.fg, bg = c.surface }
		h.StatusLineNC = { fg = c.muted, bg = c.bg_alt }
		h.TabLine = { fg = c.muted, bg = c.bg_alt }
		h.TabLineFill = { bg = c.bg_alt }
		h.TabLineSel = { fg = c.text, bg = c.surface, bold = true }

		h.Title = { fg = c.text, bold = true }
		h.Directory = { fg = c.blue }
		h.QuickFixLine = { bg = c.selection }
		h.MatchWord = { bg = c.selection }
		h.Substitute = { fg = c.bg_alt, bg = c.yellow }
		h.Conceal = { fg = c.muted }
		h.WildMenu = { fg = c.text, bg = c.selection }

		-- ============================================================
		-- STANDARD VIM SYNTAX GROUPS
		-- ============================================================

		set_fg({ "Comment", "SpecialComment" }, c.comment)
		set_fg({ "Constant" }, c.constant)
		set_fg({ "Character", "Number", "Float", "Boolean" }, c.orange)
		set_fg({ "Identifier" }, c.identifier)
		set_fg({ "Function" }, c.func)

		set_fg({
			"Statement",
			"Conditional",
			"Repeat",
			"Label",
			"Keyword",
			"Exception",
		}, c.keyword)

		set_fg({
			"Type",
			"StorageClass",
			"Structure",
			"Typedef",
		}, c.type)

		set_fg({
			"PreProc",
			"Include",
			"Define",
			"Macro",
			"PreCondit",
		}, c.purple_dim)

		set_fg({
			"Operator",
			"Special",
			"SpecialChar",
		}, c.operator)

		set_fg({ "Delimiter", "@punctuation.bracket" }, c.paleblue)
		set_fg({ "@punctuation", "@punctuation.delimiter", "@punctuation.special" }, c.punctuation)

		set_fg({ "String" }, c.string)
		set_fg({ "Underlined" }, c.blue, { underline = true })
		set_fg({ "Todo" }, c.yellow, { bold = true })
		set_fg({ "Error" }, c.error)
		set_fg({ "WarningMsg" }, c.warning)
		set_fg({ "MoreMsg" }, c.green)
		set_fg({ "Question" }, c.accent)
		set_fg({ "NonText" }, c.dim)
		set_fg({ "@number", "@number.float", "@boolean" }, c.orange)

		-- ============================================================
		-- TREESITTER: VARIABLES, PROPERTIES AND CONSTANTS
		-- ============================================================

		-- Keep ordinary identifiers and constants in Material's light foreground.
		set_fg({
			"@variable",
			"@variable.builtin",
			"@variable.parameter.builtin",
			"@parameter.reference",
		}, c.identifier)

		set_fg({
			"@constant",
			"@constant.builtin",
			"@constant.macro",
		}, c.constant)

		-- Properties/fields use the property color defined in the palette.
		set_fg({ "@variable.member", "@property", "@field" }, c.property)

		set_fg({
			"@variable.parameter",
			"@parameter",
		}, c.yellow)

		-- ============================================================
		-- TREESITTER: FUNCTIONS
		-- ============================================================

		set_fg({
			"@function",
			"@function.call",
			"@function.builtin",
			"@function.method",
			"@function.method.call",
			"@function.macro",
			"@constructor",
		}, c.func)

		-- ============================================================
		-- TREESITTER: TYPES AND KEYWORDS
		-- ============================================================

		set_fg({
			"@type",
			"@type.builtin",
			"@type.definition",
			"@type.qualifier",
			"@type.parameter",
			"@namespace",
			"@module",
		}, c.type)

		set_fg({
			"@keyword",
			"@keyword.conditional",
			"@keyword.coroutine",
			"@keyword.debug",
			"@keyword.directive",
			"@keyword.directive.define",
			"@keyword.exception",
			"@keyword.function",
			"@keyword.import",
			"@keyword.modifier",
			"@keyword.operator",
			"@keyword.repeat",
			"@keyword.return",
			"@keyword.storage",
		}, c.keyword)

		-- ============================================================
		-- TREESITTER: STRINGS, OPERATORS AND PUNCTUATION
		-- ============================================================

		set_fg({
			"@string",
			"@string.documentation",
			"@string.regexp",
			"@string.special",
			"@string.special.symbol",
			"@character",
		}, c.string)

		set_fg({ "@string.escape", "@character.special" }, c.cyan)

		set_fg({
			"@operator",
		}, c.operator)

		set_fg({
			"@attribute",
			"@tag.attribute",
		}, c.yellow_dim)

		set_fg({ "@tag", "@tag.builtin" }, c.red)
		set_fg({ "@tag.delimiter" }, c.paleblue)

		set_fg({ "@label" }, c.blue_dim)
		set_fg({ "@annotation" }, c.purple_dim)

		set_fg({
			"@comment",
			"@comment.documentation",
			"@comment.error",
			"@comment.warning",
			"@comment.note",
			"@comment.todo",
		}, c.comment)

		-- Markdown and documentation
		set_fg({
			"@markup.heading",
			"@markup.heading.1",
			"@markup.heading.2",
			"@markup.heading.3",
			"@markup.heading.4",
			"@markup.heading.5",
			"@markup.heading.6",
		}, c.text)

		set_fg({ "@markup.strong" }, c.text, { bold = true })
		set_fg({ "@markup.italic" }, c.fg, { italic = true })
		set_fg({ "@markup.quote" }, c.comment, { italic = true })
		set_fg({ "@markup.raw", "@markup.raw.block" }, c.string)
		set_fg({ "@markup.link", "@markup.link.label" }, c.blue_dim)
		set_fg({ "@markup.link.url" }, c.accent, { underline = true })
		set_fg({ "@markup.list" }, c.operator)

		-- ============================================================
		-- LSP SEMANTIC TOKENS
		-- ============================================================

		-- These complement Treesitter. LSP semantic tokens can override
		-- Treesitter colors depending on the server and your configuration.

		set_fg({ "@lsp.type.variable", "@lsp.type.parameter" }, c.identifier)
		set_fg({ "@lsp.type.property" }, c.property)
		set_fg({ "@lsp.type.enumMember" }, c.constant)
		set_fg({ "@lsp.type.namespace" }, c.type)
		set_fg({ "@punctuation", "@punctuation.delimiter" }, c.punctuation)

		set_fg({
			"@lsp.type.class",
			"@lsp.type.enum",
			"@lsp.type.interface",
			"@lsp.type.struct",
			"@lsp.type.type",
			"@lsp.type.typeParameter",
			"@lsp.type.decorator",
		}, c.type)

		set_fg({
			"@lsp.type.function",
			"@lsp.type.method",
		}, c.func)

		set_fg({
			"@lsp.type.macro",
			"@lsp.type.keyword",
		}, c.keyword)

		-- ============================================================
		-- LSP DIAGNOSTICS
		-- ============================================================

		set_fg({
			"DiagnosticError",
			"DiagnosticSignError",
			"DiagnosticFloatingError",
			"DiagnosticVirtualTextError",
		}, c.error)

		set_fg({
			"DiagnosticWarn",
			"DiagnosticSignWarn",
			"DiagnosticFloatingWarn",
			"DiagnosticVirtualTextWarn",
		}, c.warning)

		set_fg({
			"DiagnosticInfo",
			"DiagnosticSignInfo",
			"DiagnosticFloatingInfo",
			"DiagnosticVirtualTextInfo",
		}, c.info)

		set_fg({
			"DiagnosticHint",
			"DiagnosticSignHint",
			"DiagnosticFloatingHint",
			"DiagnosticVirtualTextHint",
		}, c.hint)

		set_fg({
			"DiagnosticOk",
			"DiagnosticSignOk",
		}, c.ok)

		set_fg({
			"DiagnosticUnderlineError",
		}, c.error, { undercurl = true })

		set_fg({
			"DiagnosticUnderlineWarn",
		}, c.warning, { undercurl = true })

		set_fg({
			"DiagnosticUnderlineInfo",
		}, c.info, { undercurl = true })

		set_fg({
			"DiagnosticUnderlineHint",
		}, c.hint, { undercurl = true })

		set_fg({
			"DiagnosticUnnecessary",
			"DiagnosticDeprecated",
		}, c.dim, { italic = true })

		set_fg({
			"LspInlayHint",
			"LspCodeLens",
		}, c.comment, { italic = true })

		set_bg({
			"LspReferenceText",
			"LspReferenceRead",
			"LspReferenceWrite",
		}, c.selection)

		h.LspSignatureActiveParameter = {
			fg = c.text,
			bg = c.selection,
			bold = true,
		}

		-- ============================================================
		-- BLINK.CMP
		-- ============================================================

		-- Neutral background, border and selection.
		-- In particular, avoid using bright cyan for matching labels.

		h.BlinkCmpMenu = { fg = c.fg, bg = c.float }
		h.BlinkCmpMenuBorder = { fg = c.border, bg = c.float }
		h.BlinkCmpMenuSelection = {
			fg = c.text,
			bg = c.selection,
		}

		h.BlinkCmpScrollBarThumb = { bg = c.border }
		h.BlinkCmpScrollBarGutter = { bg = c.float }

		h.BlinkCmpLabel = { fg = c.fg }
		h.BlinkCmpLabelMatch = { fg = c.text, bold = true }
		h.BlinkCmpLabelDetail = { fg = c.muted }
		h.BlinkCmpLabelDescription = { fg = c.muted, italic = true }
		h.BlinkCmpLabelDeprecated = { fg = c.comment, strikethrough = true }
		h.BlinkCmpSource = { fg = c.comment }
		h.BlinkCmpKind = { fg = c.accent }

		h.BlinkCmpGhostText = { fg = c.comment, italic = true }

		h.BlinkCmpDoc = { fg = c.fg, bg = c.float }
		h.BlinkCmpDocBorder = { fg = c.border, bg = c.float }

		h.BlinkCmpSignatureHelp = { fg = c.fg, bg = c.float }
		h.BlinkCmpSignatureHelpBorder = { fg = c.border, bg = c.float }
		h.BlinkCmpSignatureHelpActiveParameter = {
			fg = c.text,
			bg = c.selection,
			bold = true,
		}

		-- Keep completion kind labels neutral. Blink icons get their own
		-- highlight groups so only the icons carry a subtle color accent.
		h.BlinkCmpKind = { fg = c.muted }

		local blink_kinds = {
			"Text",
			"Method",
			"Function",
			"Constructor",
			"Field",
			"Variable",
			"Class",
			"Interface",
			"Module",
			"Property",
			"Unit",
			"Value",
			"Enum",
			"Keyword",
			"Snippet",
			"Color",
			"File",
			"Reference",
			"Folder",
			"EnumMember",
			"Constant",
			"Struct",
			"Event",
			"Operator",
			"TypeParameter",
		}

		for _, kind in ipairs(blink_kinds) do
			h["BlinkCmpKind" .. kind] = { fg = c.muted }
		end

		local blink_icon_colors = {
			Text = c.muted,
			Method = c.blue_dim,
			Function = c.blue,
			Constructor = c.purple_dim,
			Field = c.cyan_dim,
			Variable = c.blue_dim,
			Class = c.purple,
			Interface = c.purple_dim,
			Module = c.purple_dim,
			Property = c.cyan_dim,
			Unit = c.green_dim,
			Value = c.orange_dim,
			Enum = c.purple_dim,
			Keyword = c.purple,
			Snippet = c.purple_dim,
			Color = c.pink,
			File = c.blue_dim,
			Reference = c.blue,
			Folder = c.yellow_dim,
			EnumMember = c.green_dim,
			Constant = c.orange_dim,
			Struct = c.purple_dim,
			Event = c.orange_dim,
			Operator = c.orange,
			TypeParameter = c.purple_dim,
		}

		for kind, color in pairs(blink_icon_colors) do
			h["BlinkCmpIcon" .. kind] = { fg = color }
		end

		-- ============================================================
		-- GITSIGNS
		-- ============================================================

		set_fg({
			"GitSignsAdd",
			"GitSignsAddInline",
			"GitSignsStagedAdd",
		}, c.git_add)

		set_fg({
			"GitSignsChange",
			"GitSignsChangeInline",
			"GitSignsStagedChange",
		}, c.git_change)

		set_fg({
			"GitSignsDelete",
			"GitSignsDeleteInline",
			"GitSignsTopdelete",
			"GitSignsChangedelete",
			"GitSignsUntracked",
			"GitSignsStagedDelete",
		}, c.git_delete)

		-- ============================================================
		-- OTHER CORE UI GROUPS
		-- ============================================================

		set_fg({
			"FidgetTitle",
			"FidgetTask",
			"WhichKey",
			"WhichKeyGroup",
		}, c.muted)

		set_fg({
			"IblScope",
			"SnacksIndentScope",
		}, c.accent)

		set_fg({
			"IblIndent",
			"IblWhitespace",
		}, c.dim)

		-- Markdown inline highlights
		h["@markup.link.url.markdown_inline"] = { link = "Special" }
		h["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }
		h["@markup.italic.markdown_inline"] = { link = "Exception" }
		h["@markup.raw.markdown_inline"] = { link = "String" }
		h["@markup.list.markdown"] = { link = "Function" }
		h["@markup.quote.markdown"] = { link = "Error" }
		h["@markup.list.checked.markdown"] = { link = "WarningMsg" }

		-- ============================================================
		-- APPLY MATERIAL CONFIGURATION
		-- ============================================================

		require("material").setup({
			contrast = {
				terminal = false,
				sidebars = false,
				floating_windows = false,
				cursor_line = false,
				lsp_virtual_text = false,
				non_current_windows = false,
				filetypes = {},
			},

			plugins = {
				"blink",
				"gitsigns",
				"indent-blankline",
				"fidget",
				"trouble",
				"which-key",
			},
			-- Theme behavior
			disable = {
				colored_cursor = false,
				borders = false,
				background = transparent_background, -- Use Ghostty background when transparent
				term_colors = false,
				eob_lines = false,
			},

			-- Load highlights synchronously
			async_loading = false,

			custom_colors = function(colors)
				-- Keep the Deep Ocean palette available when opaque mode is enabled.
				colors.editor.bg = c.bg
				colors.editor.bg_alt = c.bg_alt
				colors.editor.fg = c.fg
				colors.editor.fg_dark = c.muted
				colors.editor.selection = c.selection
				colors.editor.contrast = c.bg_alt
				colors.editor.active = c.cursorline
				colors.editor.border = c.border
				colors.editor.line_numbers = c.line_nr
				colors.editor.highlight = c.highlight
				colors.editor.disabled = c.dim

				-- Main accent: replace the original bright cyan.
				colors.editor.accent = c.accent
				colors.editor.link = c.accent
				colors.editor.title = c.text
				colors.editor.cursor = c.text

				-- Main syntax palette; all original color values are retained.
				colors.main.white = c.text
				colors.main.gray = c.muted
				colors.main.black = c.bg_alt
				colors.main.red = c.red
				colors.main.green = c.green
				colors.main.yellow = c.yellow
				colors.main.blue = c.blue
				colors.main.paleblue = c.paleblue
				colors.main.cyan = c.cyan
				colors.main.purple = c.purple
				colors.main.orange = c.orange
				colors.main.pink = c.pink

				colors.main.darkred = c.red_dim
				colors.main.darkgreen = c.green_dim
				colors.main.darkyellow = c.yellow_dim
				colors.main.darkblue = c.blue_dim
				colors.main.darkcyan = c.cyan_dim
				colors.main.darkpurple = c.purple_dim
				colors.main.darkorange = c.orange_dim

				-- The plugin derives some semantic colors from these fields.
				colors.syntax.comments = c.comment
				colors.syntax.variable = c.identifier
				colors.syntax.field = c.property
				colors.syntax.keyword = c.keyword
				colors.syntax.value = c.number
				colors.syntax.operator = c.operator
				colors.syntax.fn = c.func
				colors.syntax.parameter = c.yellow
				colors.syntax.string = c.string
				colors.syntax.type = c.type

				colors.git.added = c.git_add
				colors.git.modified = c.git_change
				colors.git.removed = c.git_delete

				colors.lsp.error = c.error
				colors.lsp.warning = c.warning
				colors.lsp.info = c.info
				colors.lsp.hint = c.hint

				-- These are UI background groups too; keep the main canvas transparent.
				colors.backgrounds.sidebars = bg(c.bg)
				colors.backgrounds.floating_windows = bg(c.bg)
				colors.backgrounds.non_current_windows = bg(c.bg)
				-- Keep a concrete color here because Material uses it as a blend fallback.
				colors.backgrounds.bg_blend = c.bg
				colors.backgrounds.cursor_line = c.cursorline
			end,

			custom_highlights = h,
		})

		vim.cmd.colorscheme("material")
	end,
}
