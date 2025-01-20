# Broadcast

Broadcast stereo inputs to a configured icecast server from the norns music computer. Starts broadcasting on script load.

`broadcast-01.pset` with configured broadcast compression settings gets loaded on first run.

Create an `icecast.env` file at the root of the repo with the following content, updating the variables with values:

```txt
username=<USERNAME>
password=<PASSWORD>
icecast-server=<ICECAST SERVER URL>
port=<PORT>
mountpoint=<STREAM MOUNTPOINT>
slug=<STREAM SLUG>
```

Install from an SSH connection to norns:

```cmd
cd ~/dust/code && git clone https://github.com/aidanreilly/broadcast.git
```

Note if you are running this on a headless norns, you need to run `norns.shutdown()` from maiden to ensure that the script starts up on next reboot.

Load the script via SSH connection:

```
/home/we/bin/maiden-repl <<< 'norns.script.load("code/broadcast/radio.lua")'
```

Add the following after core/state.lua#81 `norns.scripterror("NO SCRIPT")`:

```lua
norns.script.load("code/broadcast/radio.lua")  -- Always start the radio
```
