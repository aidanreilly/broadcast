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

  -- Clean up the old
  os.execute("pkill -f broadcast0")
  os.execute("pkill -f broadcast2")
  os.execute("pkill -f radio.mp3")
  os.execute("pkill -f broadcast1")
  os.execute("pkill -9 icecast2")
  os.execute("pkill -9 darkice")

  -- Source and export variables from the .env file
  os.execute("source .env")

  -- Will this actually work? IDK too tired
  os.execute("export username")
  os.execute("export password")
  os.execute("export icecast-server")
  os.execute("export port")
  os.execute("export stream-slug")
  os.execute("export mount-point")
  os.execute("chmod +x /home/we/dust/code/radio-broadcast/broadcast0.sh")
  os.execute("chmod +x /home/we/dust/code/radio-broadcast/broadcast1.sh")
  os.execute("chmod +x /home/we/dust/code/radio-broadcast/broadcast2.sh")

  -- Broadcast!
  os.execute("nohup /home/we/dust/code/radio-broadcast/broadcast0.sh &")

  -- Say something
  screen.level(15)
  screen.move(0, 5)
  screen.text("We live on the internet!")
end