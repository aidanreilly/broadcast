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

Update `./norns/lua/core/norns.lua:272` to always start `radio.lua`, regardless of shutdown state. 

```lua
-- startup function will be run after I/O subsystems are initialized,
-- but before I/O event loop starts ticking (see readme-script.md)
_startup = function()
  require('core/startup')
  norns.script.load("code/broadcast/radio.lua")  -- Always start the radio
end

_post_startup = function()
   print('_norns._post_startup')
   hook.system_post_startup()
end

-- comment this for radio hack above
-- rerun the current script
-- norns.rerun = function()
  -- norns.script.load(norns.state.script)
-- end
```
