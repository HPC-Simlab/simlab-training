## Useful staff

### Short path to access Simlab & Toubkal
- Open `~/.ssh/config` file, and add:
	- Change `<login>` with yours.
```shell
host toubkal
     hostname toubkal.hpc.um6p.ma
     user <login>
     Compression yes
     ForwardX11 yes
     
host simlab
     hostname simlab-cluster.um6p.ma
     user <login>
     Compression yes
     ForwardX11 yes
```
***You can now run `ssh simlab` and `ssh toubkal` directly.***

### Generating private and public keys (Does not work for Toubkal)<a name="gen"></a>

```sh
$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/machine-locale/login/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/machine-locale/login/.ssh/id_rsa.
Your public key has been saved in /home/machine-locale/login/.ssh/id_rsa.pub.
The key fingerprint is:
26:e3:d4:29:b7:5b:29:15:d7:68:39:eb:a3:12:0b:02 login@machine-locale.domaine.fr
```
### SSH key authentification <a name="sshkey"></a>

SSH key authentification is allowed on SIMLAB. You have to generate a pair of keys following [ssh recommendations](https://github.com/HPC-Simlab/Tutorials/blob/master/ALL/B_Computing_environment/ssh_recommandation.md) and type:
```sh
$ ssh-copy-id <login>@simlab-cluster.um6p.ma
```
It copies your public key in the file `$HOME/.ssh/authorized_keys` on SIMLAB.

### Copy data to the remote host <a name="copytoremote"></a> 

- Without synchronization ([scp](https://en.wikipedia.org/wiki/Secure_copy_protocol))

```sh
$  scp -r <filename>  <login>@simlab-cluster.um6p.ma:<remote_directory>
```
- With synchronization (rsync):
```sh
$  rsync -avz <filename>  <login>@simlab-cluster.um6p.ma:<remote_directory>
```

 ### Copy data from the remote host <a name="copytohost"></a> 

- Without synchronization (scp):

```sh
$  scp -r <remote_directory> <login>@simlab-cluster.um6p.ma:<path/to/filename>
```

- With synchronization (rsync):
 
```sh
$  rsync -avz <remote_directory> <login>@simlab-cluster.um6p.ma:<path/to/filename>
```
