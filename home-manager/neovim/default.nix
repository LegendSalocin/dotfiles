{ config, pkgs, lib, ... }:
{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        extraConfig = builtins.readFile ./vimrc;
        extraLuaConfig = builtins.readFile ./neovim.lua;

        plugins = with pkgs.vimPlugins; [
            # Theme
            catppuccin-nvim
            
            # Explorer (VIM Tree)
            nui-nvim
            plenary-nvim
            neo-tree-nvim
            nvim-web-devicons

            # Treesitter
            nvim-treesitter.withAllGrammars

            # UI
            nvim-notify
            nvim-lsp-notify
            dressing-nvim
            lualine-nvim
            bufferline-nvim
            noice-nvim

            # LSPs
            nvim-lspconfig

            # Completions and suggestions
            nvim-cmp
            cmp-nvim-lsp
            cmp-path
            cmp_luasnip

            comment-nvim
            vim-illuminate
            which-key-nvim
            vim-startuptime
        ];
    };

    home.packages = with pkgs; [
        vscode-langservers-extracted

        # Nix LSP
        nixd
        # XML LSP
        lemminx
        # Bash LSP
        nodePackages.bash-language-server
    ];
}
