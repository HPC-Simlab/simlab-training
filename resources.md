<h1 align="center">Reservation commands</h1>

### `srun` command
- to obtain a terminal on a CPU compute node within which you can execute your code,
- or to directly execute your code on the CPU partition.

It is possible to open a terminal directly on a compute node on which the resources have been reserved for you (here 4 cores) by using the following command:

#### Example 1: Connecting to a compute node 
```shell
srun --pty --ntasks=1 bash
```
- Running this command will redirect you directly to a compute node
- An interactive terminal is obtained with the --pty option.
- By default, the allocated CPU memory is proportional to the number of reserved cores. For example, if you request 1/4 of the cores of a node, you will have access to 1/4 of its memory.

#### Example 2: Running python script 
- Create file `script.py`
```python
import socket

def get_host_info():
    # Get the hostname
    hostname = socket.gethostname()
    return hostname

if __name__ == "__main__":
    host = get_host_info()
    print(f"Hostname: {host}")

```
- Run the script
```shell
srun --ntasks=1 python3 script.py
```
- Output:
```shell
Hostname: node03
```
