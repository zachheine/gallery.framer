define = (name, value) ->
  Object.defineProperty exports, name,
    value: value
    enumerable: true
  return

define("DEVICE_WIDTH", Framer.Device.screen.width);
define("DEVICE_HEIGHT", Framer.Device.screen.height);
