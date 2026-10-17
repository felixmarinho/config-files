vim.filetype.add({
	filename = {
		["docker-compose.yml"] = "yaml.docker-compose",
		["docker-compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",
		["compose.yaml"] = "yaml.docker-compose",
	},

	pattern = {
		[".*docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
	},

	extension = {
		j2 = "jinja",
		jinja2 = "jinja",
	},
})
