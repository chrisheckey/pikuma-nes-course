--This is an example Lua (https://www.lua.org) script to give a general idea of how to build scripts
--Press F5 or click the Run button to execute it
--Type "emu." to show a list of all available API function

function printInfo()
  --Get the emulation state
  state = emu.getState()
  
  --Get the mouse's state (x, y, left, right, middle)
  mouseState = emu.getMouseState()  
  
  --Select colors based on whether the left button is held down
  if mouseState.left == true then
    buffer = emu.getScreenBuffer()
    for i = 1, #buffer do
      buffer[i] = buffer[i] & 0xFFFF
    end
    emu.setScreenBuffer(buffer)

    bgColor = 0x30FF6020
    fgColor = 0x304040FF
  else 
    bgColor = 0x302060FF
    fgColor = 0x30FF4040
  end
  
  --Draw some rectangles and print some text
  emu.drawRectangle(8, 8, 128, 24, bgColor, true, 1)
  emu.drawRectangle(8, 8, 128, 24, fgColor, false, 1)
  emu.drawString(12, 12, "Frame: " .. state["frameCount"], 0xFFFFFF, 0xFF000000)
  emu.drawString(12, 21, "Clock: " .. state["masterClock"], 0xFFFFFF, 0xFF000000)  

  
  emu.drawRectangle(8, 218, 193, 11, bgColor, true, 1)
  emu.drawRectangle(8, 218, 193, 11, fgColor, false, 1)  
  emu.drawString(11, 220, "Hold left mouse button to switch colors", 0xFFFFFF, 0xFF000000)
  
  --Draw a block behind the mouse cursor - leaves a trail when moving the mouse
  emu.drawRectangle(mouseState.x - 2, mouseState.y - 2, 5, 5, 0xAF00FF90, true, 20)
  emu.drawRectangle(mouseState.x - 2, mouseState.y - 2, 5, 5, 0xAF000000, false, 20)
end

--Register some code (printInfo function) that will be run at the end of each frame
emu.addEventCallback(printInfo, emu.eventType.endFrame);

--Display a startup message
emu.displayMessage("Script", "Example Lua script loaded.")


-- Copy Paste

prev_string = "unknown"
address_start = 0x0300

function logIt() 
  --emu.memType.cpu
  address = address_start
  log_string = ""
  repeat
  byte_number = emu.read( address, emu.memType.cpu)
  log_string = log_string .. string.char(byte_number)
  address = address + 1
  until byte_number == 0 

--  if log_string ~= prev_string then
    emu.log("log=" .. log_string)
--  end
  prev_string = log_string
  -- emu.drawString(12, 30, "Debug: " .. log_string, 0xFFFFFF, 0xFF000000) 
end

emu.log("begin")
emu.addEventCallback(logIt, emu.eventType.endFrame);