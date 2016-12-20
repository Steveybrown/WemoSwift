### Early WiP

# WemoSwift
Allows for the control of Wemo switches on a local network.

To build: 

1. cd into cloned dir
2. ```swift build ```

This generates you an executable file in .build/debug/Wemo

```
./Wemo on {{ip of switch}} 
```

```
./Wemo off {{ip of switch}} 
```


### How to wemo globally

To run the wemo script globally add a bin folder in your home directory and link it in your bash profile.
```bash
export PATH=$PATH:$HOME/bin
``` 
Place the wemo executable in the folder. This should allow you to run Wemo [command] globally. 

This will allow you to run
```bash
wemo off bedroom-light
```
Dont forget to source against your profile :) 
