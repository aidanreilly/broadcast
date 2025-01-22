--- Dumb broadcast to icecast server
-- @oootini

function init()
  local toinstall=""
  local s=util.os_capture("which icecast2")
  if s=="" then
    print("installing icecast2")
    toinstall=toinstall.."icecast2 "
  end
  local s=util.os_capture("which ffmpeg")
  if s=="" then
    print("installing ffmpeg")
    toinstall=toinstall.."ffmpeg "
  end
  local s=util.os_capture("which darkice")
  if s=="" then
    print("installing darkice")
    toinstall=toinstall.."darkice "
  end
  if toinstall~="" then
    local cmd="sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq "..toinstall
    print('running '..cmd)
    os.execute("sudo apt-get update")
    os.execute(cmd)
  end
  -- load pset
  params:read(1)

  -- Clean up the old
  os.execute("pkill -f broadcast0")
  os.execute("pkill -f broadcast2")
  os.execute("pkill -f radio.mp3")
  os.execute("pkill -f broadcast1")
  os.execute("pkill -9 icecast2")
  os.execute("pkill -9 darkice")

  -- Enable the new
  os.execute("chmod +x /home/we/dust/code/broadcast/broadcast0.sh")
  os.execute("chmod +x /home/we/dust/code/broadcast/broadcast1.sh")
  os.execute("chmod +x /home/we/dust/code/broadcast/broadcast2.sh")

  -- Broadcast!
  os.execute("bash -c 'set -a && source /home/we/dust/code/broadcast/icecast.env && nohup /home/we/dust/code/broadcast/broadcast0.sh &'")

  -- Say something
  redraw()
end

function redraw()
  screen.clear()
  screen.move(10,10)
  screen.text("Broadcasting live!")
  screen.move(10,30)
  screen.text("Éist x Plugd")
  screen.update()
end
