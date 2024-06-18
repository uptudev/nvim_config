# nvim_config

This is my Neovim configuration folder (found at `~/.config/nvim`). In order to get this to work, simply follow the below steps:

## Installing Config

#### Unix/Linux

```sh
rm -rf ~/.config/nvim && git clone https://github.com/uptudev/nvim_config ~/.config/nvim --depth 1
```

#### Windows

```powershell
git clone https://github.com/uptudev/nvim_config $HOME/AppData/Local/nvim-data --depth 1
```

Once loaded, run `:Lazy sync`.

After that, restart Neovim, and you should see your new config!
