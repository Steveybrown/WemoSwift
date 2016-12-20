### Early WiP

# WemoSwift
Allows for the control of Wemo switches on a local network.

To build: 

1. cd into cloned dir
2. ```swift build ```

This generates you an executable file in .build/debug/Wemo

### Set up
A config file can be created instead of remembering IPs for devices. This allows you to assign meaningful name for a device. To create a config file simple run 'wemo setup'.

This enables you to refer a device using an alias. 

```bash
wemo on hall-light
```

### How to wemo globally

To run the wemo script globally add a bin folder in your home directory and link it in your bash profile.

```bash
export PATH=$PATH:$HOME/bin
``` 

Place the wemo executable in the folder. This will allow you to run Wemo [command] globally. 

```bash
wemo off bedroom-light
```

Dont forget to source against your profile :) 
