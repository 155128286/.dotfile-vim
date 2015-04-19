set -e

if [ ! -n "$VIM" ]; then
  VIM=~/.dotfile-vim
fi

if [ -d "$VIM" ]; then
  echo "\033[0;33mYou already have VIM configuration installed.\033[0m You'll need to remove $VIM if you want to install"
  exit
fi

echo "\033[0;34mCloning VIM configuration...\033[0m"
hash git >/dev/null 2>&1 && env git clone --depth=1 https://github.com/155128286/.dotfile-vim.git $VIM || {
  echo "git not installed"
  exit
}

echo "\033[0;34mLooking for an existing vim config...\033[0m"
if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
  echo "\033[0;33mFound ~/.vimrc.\033[0m \033[0;32mBacking up to ~/.vimrc.pre\033[0m";
  mv ~/.vimrc ~/.vimrc.pre;
fi

cd $VIM
echo "\033[0;34mInitialize git submodules...\033[0m"
git submodule init
git submodule update 
ln -s $VIM/vim ~/.vim
ln -s $VIM/vimrc ~/.vimrc

echo "\n\n \033[0;32mDone.\033[0m"
