# Settings

Under Construction is a CTF vulnerable VM. You can test it on TryHackMe http://tryhackme.com/jr/underconstruction0k.  
Using this repository, you can create this CTF VM on your network.

## Pre-requisite

Install ubuntu server, setting the following user: `theboss` and password: `thebigboss`

## Install

Launch the VM and log as `theboss`

```bash
cd /tmp
sudo apt install git
git clone https://github.com/OlivierProTips/under_construction.git
cd under_construction
chmod +x install.sh
sudo su
./install.sh
```