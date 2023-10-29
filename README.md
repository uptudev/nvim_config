# nvim_config

This is my Neovim configuration folder (found at `~/.config/nvim`). In order to get this to work, simply follow the below steps:

## Installing Packer

#### Unix/Linux

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

#### Windows (Git Bash)

```powershell
rm -rf $HOME/AppData/Local/nvim-data && git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
```

## Installing Config

#### Unix/Linux

```sh
rm -rf ~/.config/nvim && git clone https://github.com/uptudev/nvim_config ~/.config/nvim --depth 1
```

#### Windows

```powershell
git clone https://github.com/uptudev/nvim_config $HOME/AppData/Local/nvim-data --depth 1
```

Once loaded, run `:PackerInstall`, then `:PackerCompile`.

After that, restart Neovim, and you should see your new config!
