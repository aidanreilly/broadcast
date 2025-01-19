# radio-broadcast

Broadcast stereo inputs to a configured icecast server from the norns music computer. Starts broadcasting on script load.

`radio-broadcast-01.pset` with configured broadcast compression settings gets loaded on first run.

Create an `.env` file at the root of the repo with the following content, updating the variables with values:

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
cd ~/dust/code && git clone https://github.com/aidanreilly/radio-broadcast.git
```

# Hacking

-- start the broadcast after booting
norns.script.load("code/radio-broadcast/broadcast.lua")
