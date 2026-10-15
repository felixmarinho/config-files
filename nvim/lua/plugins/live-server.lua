return {
	"https://forge.barrettruth.com/barrettruth/live-server.nvim",

	cmd = {
		"LiveServerStart",
		"LiveServerStop",
		"LiveServerToggle",
	},

	keys = {
		{
			"<leader>ls",
			function()
				vim.cmd("LiveServerToggle")
				vim.notify("Live Server toggled", vim.log.levels.INFO, { title = "Live Server" })
			end,
			desc = "Toggle Live Server",
		},
	},

	init = function()
		vim.g.live_server = {
			port = 8080,
			browser = true,
		}
	end,
}
