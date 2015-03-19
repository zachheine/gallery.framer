define = (name, value) ->
  Object.defineProperty exports, name,
    value: value
    enumerable: true
  return

DEVICE_WIDTH = Framer.Device.screen.width
DEVICE_HEIGHT = Framer.Device.screen.height

if DEVICE_WIDTH < 640 # Hack for Nexus 5 (and hopefully other Androids)
	DEVICE_WIDTH = DEVICE_WIDTH * 2
	DEVICE_HEIGHT = DEVICE_HEIGHT * 2

define("DEVICE_WIDTH", DEVICE_WIDTH);
define("DEVICE_HEIGHT", DEVICE_HEIGHT);

HEADER = 120
define("HEADER", HEADER)

MARGIN = 30
define("MARGIN", MARGIN)

GUTTER = 16
define("GUTTER", GUTTER)

FOOTER = 90
define("FOOTER", FOOTER)

ORIGINAL_IMAGE_WIDTH = 282
ORIGINAL_IMAGE_HEIGHT = 206
IMAGE_HEIGHT_RATIO = ORIGINAL_IMAGE_HEIGHT / ORIGINAL_IMAGE_WIDTH

IMAGE_WIDTH = (DEVICE_WIDTH - (MARGIN * 2 + GUTTER)) / 2
define("IMAGE_WIDTH", IMAGE_WIDTH)

IMAGE_HEIGHT = IMAGE_WIDTH * IMAGE_HEIGHT_RATIO
define("IMAGE_HEIGHT", IMAGE_HEIGHT)

DETAIL_IMAGE_HEIGHT_RATIO = 428 / 640 # Original detail image dimensions
DETAIL_IMAGE_HEIGHT = DEVICE_WIDTH * DETAIL_IMAGE_HEIGHT_RATIO
define("DETAIL_IMAGE_HEIGHT", DETAIL_IMAGE_HEIGHT)

DETAIL_IMAGE_Y_POSITION = (DEVICE_HEIGHT * .5) - (DETAIL_IMAGE_HEIGHT / 2)
define("DETAIL_IMAGE_Y_POSITION", DETAIL_IMAGE_Y_POSITION)

SLIDE_UP_SCALE = .91
define("SLIDE_UP_SCALE", SLIDE_UP_SCALE)

SLIDE_UP_POSITION = ((DETAIL_IMAGE_Y_POSITION + DEVICE_HEIGHT) * SLIDE_UP_SCALE) - DEVICE_HEIGHT
define("SLIDE_UP_POSITION", SLIDE_UP_POSITION)

COLOR_BLUE = "#40a6f1"
define("COLOR_BLUE", COLOR_BLUE)

COLOR_MAGENTA = "#df0077"
define("COLOR_MAGENTA", COLOR_MAGENTA)
