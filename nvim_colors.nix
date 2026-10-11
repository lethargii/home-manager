{ config, pkgs, lib, nix-flatpak, ... }:
{
	programs.nixvim.colorschemes.mini-base16 = {
		enable = true;
		callSetup = false;

		luaConfig.post = ''
			local base16 = require("mini.base16")
			local palette = assert(loadfile(vim.fn.expand("~/.cache/hellwal/nvim_colors.lua")))()

			-- mini.base16 attend des couleurs "#rrggbb"
			for k, v in pairs(palette) do
				if type(v) == "string" and not v:find("^#") then
					palette[k] = "#" .. v
				end
			end

			base16.setup({ palette = palette, use_cterm = false })
		'';
	};
}
