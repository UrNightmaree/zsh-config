# Zsh Configuration :3

## File structure

```
~ -- home dir
├── bin -- contains util scripts
├── starship.toml -- starship prompt config
├── zfunctions -- contains zsh util scripts, loaded via autoload
└── zshrc -- the rc file
```

## Setup

Symlink all files and directories with prefix "." to `~`, except for Starship config (place it in usual `~/.config`).
