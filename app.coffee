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
		layer = new Layer
			name: layerName
			width: IMAGE_WIDTH
			height: IMAGE_HEIGHT
			x: xPosition
			y: yPosition
			backgroundColor: COLOR_MAGENTA
		layer.image = imagePath if SHOW_IMAGES
		gridLayers[layerName] = layer

for name, layer of gridLayers
	layer.states.add
		detail: 
			x: 0
			y: DETAIL_IMAGE_Y_POSITION
			width: DEVICE_WIDTH
			height: DETAIL_IMAGE_HEIGHT
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
	currentLayer.states.next()
	detailBackgroundLayer.states.next()
	detailHeaderLayer.states.next()
	detailFooterLayer.states.next()

backToGrid = (currentLayer) ->
	currentLayer.backgroundColor = COLOR_MAGENTA
	currentLayer.states.next()
	detailBackgroundLayer.states.switchInstant('default')
	detailHeaderLayer.states.switchInstant('default')
	detailFooterLayer.states.switchInstant('default')

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

detailBackgroundLayer = new Layer
	width: DEVICE_WIDTH
	height: DEVICE_HEIGHT
	backgroundColor: "black"
	opacity: 0
		
detailBackgroundLayer.states.add
	detail:
		opacity: 1

detailBackgroundLayer.states.animationOptions =
	curve: "bezier-curve"
	curveOptions: "ease-out"
	time: .2
	
detailHeaderLayer = new Layer
	width: DEVICE_WIDTH
	height: HEADER
	backgroundColor: COLOR_BLUE
	index: 10

detailHeaderLayer.originY = 0
detailHeaderLayer.rotationX = 90

detailHeaderLayer.states.add
	detail:
		rotationX: 0

detailHeaderLayer.states.animationOptions =
	curve: "bezier-curve"
	curveOptions: "ease-out"
	time: .2

detailHeaderExtendLeftLayer = new Layer
	width: 320
	x: 0
	height: HEADER
	image: "images/detail_header_extender_left.png"
	superLayer: detailHeaderLayer

detailHeaderExtendRightLayer = new Layer
	width: 320
	x: DEVICE_WIDTH - 320
	height: HEADER
	superLayer: detailHeaderLayer
detailHeaderExtendRightLayer.image = "images/detail_header_extender_right.png" if SHOW_IMAGES


detailHeaderTitleLayer = new Layer
	width: 480
	x: (DEVICE_WIDTH * .5) - 240
	height: HEADER
	superLayer: detailHeaderLayer
detailHeaderTitleLayer.image = "images/detail_header.png" if SHOW_IMAGES


detailFooterLayer = new Layer
	width: DEVICE_WIDTH
	height: FOOTER
	y: DEVICE_HEIGHT - FOOTER
	backgroundColor: COLOR_BLUE
	#image: 
	index: 10
detailFooterLayer.image = "images/detail_footer.png" if SHOW_IMAGES

detailFooterLayer.originY = 1
detailFooterLayer.rotationX = 90

detailFooterLayer.states.add
	detail:
		rotationX: 0

detailFooterLayer.states.animationOptions =
	curve: "bezier-curve"
	curveOptions: "ease-out"
	time: .2

CENTER = (DEVICE_WIDTH * .5) - 30
# UNIT is 86 WHEN DEVICE_WIDTH is 640
UNIT = (DEVICE_WIDTH - (DEVICE_WIDTH * .06)) / 7

detailFooterIconPlus1Layer = new Layer
	width: 60
	height: 60
	x: CENTER - UNIT * 3	
	y: 15
	superLayer: detailFooterLayer
detailFooterIconPlus1Layer.image = "images/icons/icon_plus-one.png" if SHOW_IMAGES

detailFooterIconCommentLayer = new Layer
	width: 60
	height: 60
	x: CENTER - UNIT
	y: 15
	superLayer: detailFooterLayer
detailFooterIconCommentLayer.image = "images/icons/icon_comment.png" if SHOW_IMAGES

detailFooterIconAddLayer = new Layer
	width: 60
	height: 60
	x: CENTER + UNIT
	y: 15
	superLayer: detailFooterLayer
detailFooterIconAddLayer.image = "images/icons/icon_add.png" if SHOW_IMAGES

detailFooterIconShareLayer = new Layer
	width: 60
	height: 60
	x: CENTER + UNIT * 3
	y: 15
	superLayer: detailFooterLayer
detailFooterIconShareLayer.image = "images/icons/icon_share.png" if SHOW_IMAGES
