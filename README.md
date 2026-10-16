# config-files

Various personal config files

## Checklist

Copy or symlink each file into `~` on a new machine, and check it off once it's in place.

### Shell

- [ ] `.zshrc` — zsh config (PATH, oh-my-zsh setup)
- [ ] `.zprofile` — zsh login profile (Homebrew shellenv, `glog` alias)
- [ ] `.bash_profile` — bash prompt, completion and git aliases
- [ ] `.oh-my-zsh/themes/fireplacetv.zsh-theme` — custom oh-my-zsh theme

### Git

- [ ] `.gitconfig` — shared git settings (includes `~/.gitconfig.local`)
- [ ] `.gitconfig.local.example` — copy to `~/.gitconfig.local` and fill in your identity
- [ ] `.gitignore_global` — global ignore patterns (`core.excludesfile`)

### Vim

- [ ] `.vim/vimrc` — main vim config
- [ ] `.vim/pyte.vim` — light color scheme
- [ ] `.vim/config/dbt.vimrc` — dbt path and `gf` helpers
- [ ] `.vim/config/dbtrpc.vimrc` — submit buffers to a dbt RPC server
