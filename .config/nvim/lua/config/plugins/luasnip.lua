function config()
	local ls = require("luasnip")
	local s = ls.snippet
	local sn = ls.snippet_node
	local isn = ls.indent_snippet_node
	local t = ls.text_node
	local i = ls.insert_node
	local f = ls.function_node
	local c = ls.choice_node
	local d = ls.dynamic_node
	local r = ls.restore_node
	local events = require("luasnip.util.events")
	local ai = require("luasnip.nodes.absolute_indexer")
	local extras = require("luasnip.extras")
	local l = extras.lambda
	local rep = extras.rep
	local p = extras.partial
	local m = extras.match
	local n = extras.nonempty
	local dl = extras.dynamic_lambda
	local fmt = require("luasnip.extras.fmt").fmt
	local fmta = require("luasnip.extras.fmt").fmta
	local conds = require("luasnip.extras.expand_conditions")
	local postfix = require("luasnip.extras.postfix").postfix
	local types = require("luasnip.util.types")
	local parse = require("luasnip.util.parser").parse_snippet

	ls.config.set_config({
		history = true,
		-- Update more often, :h events for more info.
		updateevents = "TextChanged,TextChangedI",
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "choiceNode", "Comment" } },
				},
			},
		},
		-- treesitter-hl has 100, use something higher (default is 200).
		ext_base_prio = 300,
		-- minimal increase in priority.
		ext_prio_increase = 1,
		enable_autosnippets = true,
	})

	-- vim.keymap.set({ "i", "v" }, "<c-k>", function()
	-- 	if ls.expand_or_jumpable() then
	-- 		ls.expand_or_jump()
	-- 	end
	-- end)
	--
	ls.add_snippets("rust", {
		s("print", {
			-- t {'println!("'}, i(1), t {' {:?}", '}, i(0), t {');'}}),
			t({ 'println!("' }),
			i(1),
			t({ " {" }),
			i(0),
			t({ ':?}");' }),
		}),

		s("struct", {
			t({ "#[derive(Debug)]", "" }),
			t({ "struct " }),
			i(1),
			t({ " {", "" }),
			i(0),
			t({ "}", "" }),
		}),

		s("test", {
			t({ "#[test]", "" }),
			t({ "fn " }),
			i(1),
			t({ "() {", "" }),
			t({ "	assert" }),
			i(0),
			t({ "", "" }),
			t({ "}" }),
		}),

		s("testcfg", {
			t({ "#[cfg(test)]", "" }),
			t({ "mod tests {", "" }),
			t({ "	use super::*;", "" }),
			t({ "	use pretty_assertions::assert_eq;", "" }),
			t({ "" }),
			t({ "	#[test]", "" }),
			t({ "	fn " }),
			i(0),
			t({ "() {", "" }),
			t({ "		assert", "" }),
			t({ "	}", "" }),
			t({ "}" }),
		}),
	})

	ls.add_snippets("vue", {
		s("newfile", {
			t({
				"<template>",
				"</template>",
				"<script>",
				"",
				"export default {",
				"	props: [],",
				"	components: {",
				"	},",
				"	data: () => ({",
				"	}),",
				"	methods: {",
				"	},",
				"	computed: {",
				"	},",
				"	watch: {",
				"	}",
				"}",
				"</script>",
				'<style lang="scss" scoped>',
				"</style>",
			}),
		}),
	})
end

return {
	"L3MON4D3/LuaSnip",
	config = config,
	event = "BufReadPost",

	keys = {
		{ "<leader>zn", "<Plug>luasnip-jump-next", noremap = true, desc = "LuaSnip Next" },
		{ "<leader>zN", "<Plug>luasnip-jump-prev", noremap = true, desc = "LuaSnip Prev" },
	},
}
