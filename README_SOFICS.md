# ShellGPT implemented on Seabert

changed to custsoft (has deploy ssh key)
cloned repo into /opt/Sofics/shell_gpt

git fetch
git checkout origin/sofics

su localadmin
sudo /opt/Sofics/fix_permissions.sh

--------------------
Seabert implementation fix
----------------------
container images are only available per user => to fix this I made 1 user to share his shellgpt image

sudo useradd -m podman-shared
sudo passwd podman-shared  # aimi...

which podman
=> /usr/bin/podman

edit sudoers file:
sudo visudo
ALL ALL=(podman-shared) NOPASSWD: /usr/bin/podman

build image as podman-shared user:
sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 podman-shared
su - podman-shared -c "podman build -t 'shellgpt' /opt/Sofics/shell_gpt --no-cache"
su - podman-shared -c "podman images"

# the weird extra step /w function is to ensure the user podman-shared executes in a directory he has access to

vim /etc/bashrc
alias shellgpt="sudo -u podman-shared /usr/bin/podman run --rm --volume /opt/Sofics/shell_gpt/gpt-cache:/tmp/shell_gpt --env SHELL_NAME=$(echo $SHELL) shellgpt"
function sgpt
{
 local DIR
 DIR=$(pwd)
 cd /opt/Sofics && shellgpt "$@" && cd "$DIR" || return
}
