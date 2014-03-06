Vagrant4SIW
===========

Vagrant experiment with Tomee, PostgreSQL, Ruby, RoR



HOW TO INSTALL
===========

1. Download and install Virtualbox https://www.virtualbox.org/wiki/Downloads
  * Vagrant is compatible with VirtualBox versions 4.0.x, 4.1.x, 4.2.x, and 4.3.x. Any other version is unsupported and the provider will display an error message.
* Download and install Vagrant http://www.vagrantup.com/downloads.html
  * You **must** download the latest version from site. Your vagrant version (`vagrant -v`) have to be >= 1.4
  * **Ubuntu users:** The package in *Ubuntu Software Center* or in *apt* is **OLD**. Download the new version from site.
* Download and unzip [this repository](https://github.com/Takeno/Vagrant4SIW/archive/master.zip). It contains all Vagrant configurations to build VM.
* Move with your command line to unzipped directory
* Run `vagrant up`
* Test your webserver [here](http://localhost:8080)



HOW TO FIX PROBLEMS
===========

#### Problem #1: *"The forwarded port to 5432 is already in use on the host machine."*

There is a software which is listening the port 5432 - have you Postgresql installed in your host? To fix it, open Vagrantfile with a text editor and change the 8th line:
```ruby
config.vm.network :forwarded_port, guest: 5432, host: 5432 #postgresql
```
with
```ruby
config.vm.network :forwarded_port, guest: 5432, host: 5431 #postgresql`
```
For linux/mac users: `$ sed -i "s/host: 5432/host: 5431/g" Vagrantfile`


Your virtualized PostgreSQL will be reacheable as localhost:5431



#### Problem #2: *"The forwarded port to 8080 is already in use on the host machine."*

There is a software which is listening the port 8080. To fix it, open Vagrantfile with a text editor and change the 6th line:
```ruby
config.vm.network :forwarded_port, guest: 8080, host: 8080 #tomee
```
with
```ruby
config.vm.network :forwarded_port, guest: 8080, host: 8800 #tomee`
```
For linux/mac users: `$ sed -i "s/host: 8080/host: 8800/g" Vagrantfile`


Now you can see the webserver as localhost:8800


#### Problem #3: localhost:8080 (or 8800 or something else) is unreachable

Try restarting web server:

**For linux/mac users:**
```sh
$ vagrant ssh # Get access to virtual server's shell
```
**For windows users:**
Open `ssh.bat`

**then, for all:**

```sh
$ sudo /opt/tomee/bin/shutdown.sh # take down a possible blocked process - it can return an error
$ sudo /opt/tomee/bin/startup.sh # start the webserver - it can't return errors
$ exit # back to host's shell
```

#### Problem #4: *Timed out while waiting for the machine to boot*

This error is caused by virtual machine which is not responding to Vagrant. To fix it, open Virtualbox and force shutdown of VM:
![Alt Text](http://i.imgur.com/RAX2st2.png)


#### Problem #5: *The host path of the shared folder is missing: ./lib/*

This problem is solved with the new version of project. To fix it without downloading again the project, you have to make a directory called **lib** near **www**.

**From command line - for all platforms:** `mkdir lib`

#### Problem #6: *VM already provisioned run vagrant provision to force it*

This **IS NOT** a problem. It will appear everytime you start a VM after the first because it means *you have already launched installation scripts successfully and if you want re-launch it intentionally run `vagrant provision`*