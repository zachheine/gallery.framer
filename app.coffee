# UX Engineer, Design - Prototyping Exercise
# Zach Heineman, 2015

# iPhone 6 Plus = 828
# iPhone 6 = 750
# iPhone 5/4s = 640
# Nexus 5 = 360 (x2)

DEVICE_WIDTH = Framer.Device.screen.width
DEVICE_HEIGHT = Framer.Device.screen.height
if DEVICE_WIDTH < 640 # Hack for Nexus 5 (and hopefully other Androids)
	DEVICE_WIDTH = DEVICE_WIDTH * 2; DEVICE_HEIGHT = DEVICE_HEIGHT * 2
HEADER = 120; MARGIN = 30; GUTTER = 16; FOOTER = 90
ORIGINAL_IMAGE_WIDTH = 282; ORIGINAL_IMAGE_HEIGHT = 206
IMAGE_HEIGHT_RATIO = ORIGINAL_IMAGE_HEIGHT / ORIGINAL_IMAGE_WIDTH
IMAGE_WIDTH = (DEVICE_WIDTH - (MARGIN * 2 + GUTTER)) / 2
IMAGE_HEIGHT = IMAGE_WIDTH * IMAGE_HEIGHT_RATIO
DETAIL_IMAGE_HEIGHT_RATIO = 428 / 640 # Original detail dimensions
DETAIL_IMAGE_HEIGHT = DEVICE_WIDTH * DETAIL_IMAGE_HEIGHT_RATIO
DETAIL_IMAGE_Y_POSITION = (DEVICE_HEIGHT * .5) - (DETAIL_IMAGE_HEIGHT / 2)
COLOR_BLUE = "#40a6f1"; COLOR_MAGENTA = "#df0077"
SHOW_IMAGES = true

new BackgroundLayer backgroundColor: "#fff"

detailLayer = {}
gridLayers = {}

for row in [1..5]
	for column in ['A', 'B']
		layerName = column + row
		xPosition = if column == 'A' then MARGIN else MARGIN + IMAGE_WIDTH + GUTTER
		yPosition = (HEADER + MARGIN) + ((row - 1) * (IMAGE_HEIGHT + GUTTER))
		imagePath = 'images/grid/' + layerName + '.jpg'
		xPart = if column == 'A' then xPosition - IMAGE_WIDTH else xPosition + IMAGE_WIDTH
		layer = new Layer
			name: layerName
			width: IMAGE_WIDTH
			height: IMAGE_HEIGHT
			x: xPosition
			y: yPosition
			backgroundColor: COLOR_MAGENTA
			xPart: xPart
		layer.image = imagePath if SHOW_IMAGES
		layer.draggable.enabled = true
		gridLayers[layerName] = layer

for name, layer of gridLayers
	layer.states.add
		detail: 
			x: 0
			y: DETAIL_IMAGE_Y_POSITION
			width: DEVICE_WIDTH
			height: DETAIL_IMAGE_HEIGHT
		parted:
			x: xPart
			
	layer.states.animationOptions =
		curve: "spring(300,25,0)"
	layer.on Events.Click, ->
		currentState = this.states.state
		currentLayerName = this.name
		if currentState isnt 'detail' # Go to detail
			goToDetail(this)
		else # Back to grid
			backToGrid(this)
	layer.on Events.AnimationEnd, ->
		currentState = this.states.state
		if currentState isnt 'detail' # Reset the grid layers
			for layerName, layer of gridLayers
				layer.index = 1
				layer.ignoreEvents = false

goToDetail = (currentLayer, currentLayerName) ->
	detailLayer = currentLayer
	currentLayer.index = 100
	for layerName, layer of gridLayers
		layer.ignoreEvents = true if layerName isnt currentLayer.name
	currentLayer.backgroundColor = 'green'
	currentLayer.states.switch('detail')
	for layerName, detailLayer of detailLayers
		detailLayer.layer.states.next()
		
backToGrid = (currentLayer) ->
	currentLayer.backgroundColor = COLOR_MAGENTA
	currentLayer.states.switch('default')
	for layerName, detailLayer of detailLayers
		detailLayer.layer.states.switchInstant('default')

headerLayer = new Layer
	width: DEVICE_WIDTH
	height: HEADER
	
headerExtendLeftLayer = new Layer
	width: 320
	x: 0
	height: HEADER
	image: "images/header_extender.png"
	superLayer: headerLayer

headerExtendRightLayer = new Layer
	width: 320
	x: DEVICE_WIDTH - 320
	height: HEADER
	image: "images/header_extender.png"
	superLayer: headerLayer

headerExtendRightLayer.on Events.Click, ->
	backToGrid(detailLayer)

headerTitleLayer = new Layer
	width: 640
	x: (DEVICE_WIDTH * .5) - 320
	height: HEADER
	superLayer: headerLayer
headerTitleLayer.image = "images/header.png" if SHOW_IMAGES

headerTitleLayer.on Events.Hold, ()=> 
	for layerName, layer of gridLayers
		if layer.states.state isnt 'parted'
			layer.states.switch('parted')
		else
			layer.states.switch('default')

detailLayers = {
	"Background": {
		width: DEVICE_WIDTH
		height: DEVICE_HEIGHT
		backgroundColor: "black"
	}
	"Header": {}
	"Footer": {}
}

for name, layer of detailLayers
	layer.layer = new Layer
		width: layer.width
		height: layer.height
		backgroundColor: layer.backgroundColor
		opacity: 0
	layer.layer.states.add
		detail:
			opacity: 1
	layer.layer.states.animationOptions =
		curve: "bezier-curve"
		curveOptions: "ease-out"
		time: .2

detailLayers.Header.layer = new Layer
	width: DEVICE_WIDTH
	height: HEADER
	backgroundColor: COLOR_BLUE
	index: 10

detailLayers.Header.layer.originY = 0
detailLayers.Header.layer.rotationX = 90

detailLayers.Header.layer.states.add
	detail:
		rotationX: 0

detailLayers.Header.layer.states.animationOptions =
	curve: "bezier-curve"
	curveOptions: "ease-out"
	time: .2

detailHeaderExtendLeftLayer = new Layer
	width: 320
	x: 0
	height: HEADER
	image: "images/detail_header_extender_left.png"
	superLayer: detailLayers.Header.layer

detailHeaderExtendRightLayer = new Layer
	width: 320
	x: DEVICE_WIDTH - 320
	height: HEADER
	superLayer: detailLayers.Header.layer
detailHeaderExtendRightLayer.image = "images/detail_header_extender_right.png" if SHOW_IMAGES

detailHeaderTitleLayer = new Layer
	width: 480
	x: (DEVICE_WIDTH * .5) - 240
	height: HEADER
	superLayer: detailLayers.Header.layer
detailHeaderTitleLayer.image = "images/detail_header.png" if SHOW_IMAGES

detailLayers.Footer.layer = new Layer
	width: DEVICE_WIDTH
	height: FOOTER
	y: DEVICE_HEIGHT - FOOTER
	backgroundColor: COLOR_BLUE
	#image: 
	index: 10
detailLayers.Footer.layer.image = "images/detail_footer.png" if SHOW_IMAGES

detailLayers.Footer.layer.originY = 1
detailLayers.Footer.layer.rotationX = 90

detailLayers.Footer.layer.states.add
	detail:
		rotationX: 0

detailLayers.Footer.layer.states.animationOptions =
	curve: "bezier-curve"
	curveOptions: "ease-out"
	time: .2

CENTER_ICON = (DEVICE_WIDTH * .5) - 30
# UNIT is 86 WHEN DEVICE_WIDTH is 640
UNIT = (DEVICE_WIDTH - (DEVICE_WIDTH * .06)) / 7

detailFooterIcons = [
	{ name: "Plus1", img: "icon_plus-one.png", x: CENTER_ICON - UNIT * 3 }
	{ name: "Comment", img: "icon_comment.png", x: CENTER_ICON - UNIT }
	{ name: "Add", img: "icon_add.png", x: CENTER_ICON + UNIT }
	{ name: "Share", img: "icon_share.png", x: CENTER_ICON + UNIT * 3 }
]

for icon in detailFooterIcons
	icon.layer = new Layer
		width: 60
		height: 60 
		x: icon.x
		y: 15
		superLayer: detailLayers.Footer.layer
	icon.layer.image = "images/icons/" + icon.img if SHOW_IMAGES

# -----------------------------------
#  HAMMERJS - Integration by Koen Bok 
# -----------------------------------

HammerEvents =
	
	Tap: "tap"
	DoubleTap: "doubletap"
	Hold: "hold"
	Touch: "touch"
	Release: "release"
	Gesture: "gesture"

	Swipe: "swipe"
	SwipeUp: "swipeup"
	SwipeDown: "swipedown"
	SwipeLeft: "swipeleft"
	SwipeRight: "swiperight"
	
	Transform: "transform"
	TransformStart: "transformstart"
	TransformEnd: "transformend"

	Rotate: "rotate"

	Pinch: "pinch"
	PinchIn: "pinchin"
	PinchOut: "pinchout"

# Add the Hammer events to the base Framer events
window.Events = _.extend Events, HammerEvents

# Patch the on method on layers to listen to Hammer events
class HammerLayer extends Framer.Layer
	
	on: (eventName, f) ->
		
		if eventName in _.values(HammerEvents)
			@ignoreEvents = false			
			hammer = Hammer(@_element).on eventName, f
		
		else
			super eventName, f

# Replace the default Layer with the HammerLayer
window.Layer = HammerLayer
