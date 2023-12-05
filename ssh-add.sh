#!/bin/sh


# Start ssh-agent
# check if ssh-agent is already running
if [ -z "$SSH_AUTH_SOCK" ]; then
	#start ssh-agent
	eval "$(ssh-agent -s)"
fi


# Ask for ssh-add
read -p "Do you want to add your SSH public key? (y/n) " response

if [ "$response" = "y" ]; then
	ssh-add ~/.ssh/id_ed25519
	ssh-add -l
elif [ "$response" = "n" ]; then
	echo "No identity on terminal session"
else
	echo "Invalid response"
fi

ssh -T git@github.com

#  remote: Please see https://docs.github.com/en/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls for information on currently recommended modes of authentication.
# walterc@NB:~/wsl_dotfiles$ git remote -v
#  origin  https://github.com/weigian/wsl_dotfiles (fetch)
#  origin  https://github.com/weigian/wsl_dotfiles (push)
# walterc@NB:~/wsl_dotfiles$ git remote set-url origin git@github.com:weigian/wsl_dotfiles
# walterc@NB:~/wsl_dotfiles$ git remote -v
#  origin  git@github.com:weigian/wsl_dotfiles (fetch)
#  origin  git@github.com:weigian/wsl_dotfiles (push)
# walterc@NB:~/wsl_dotfiles$ git push
