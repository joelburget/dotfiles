# My Dotfiles

My personal dotfiles for vim, fish, git, etc.

I use [GNU stow](https://www.gnu.org/software/stow/) to use these (ie place config files where they belong):

```sh
$ stow -nvt ~ fish # dry run
$ stow -vSt ~ ghc # actually do it
$ # etc
```
