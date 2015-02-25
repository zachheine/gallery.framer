# UX Engineer, Design - Prototyping Exercise
# Zach Heineman, 2015

# This needs to be loaded at the beginning...
# Hammer.js integration by Koen Bok

HammerEvents =
	Hold: "hold"

window.Events = _.extend Events, HammerEvents

class HammerLayer extends Framer.Layer
	on: (eventName, f) ->
		if eventName in _.values(HammerEvents)
			@ignoreEvents = false			
			hammer = Hammer(@_element).on eventName, f
		else
			super eventName, f

window.Layer = HammerLayer

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
DETAIL_IMAGE_HEIGHT_RATIO = 428 / 640 # Original detail image dimensions
DETAIL_IMAGE_HEIGHT = DEVICE_WIDTH * DETAIL_IMAGE_HEIGHT_RATIO
DETAIL_IMAGE_Y_POSITION = (DEVICE_HEIGHT * .5) - (DETAIL_IMAGE_HEIGHT / 2)
SLIDE_UP_SCALE = .91
SLIDE_UP_POSITION = ((DETAIL_IMAGE_Y_POSITION + DEVICE_HEIGHT) * SLIDE_UP_SCALE) - DEVICE_HEIGHT
COLOR_BLUE = "#40a6f1"; COLOR_MAGENTA = "#df0077"
SHOW_IMAGES = true

new BackgroundLayer backgroundColor: "#fff"

currentDetailLayer = {} # Store this in a global
currentState = "default"
gridItems = {}

# Set up the grid
for row in [1..5]
	for column in ["A", "B"]
		itemName = column + row
		xPosition = if column is "A" then MARGIN else MARGIN + IMAGE_WIDTH + GUTTER
		yPosition = (HEADER + MARGIN) + ((row - 1) * (IMAGE_HEIGHT + GUTTER))
		imagePath = "images/grid/" + itemName + ".jpg"
		xPart = if column == "A" then xPosition - IMAGE_WIDTH else xPosition + IMAGE_WIDTH
		item = {}
		item.containerLayer = new Layer
			name: itemName
			width: IMAGE_WIDTH
			height: IMAGE_HEIGHT
			x: xPosition
			y: yPosition
			clip: true
			backgroundColor: "transparent"
			#backgroundColor: COLOR_MAGENTA
			xPart: xPart
		item.imageLayer = new Layer
			name: itemName
			width: IMAGE_WIDTH
			height: IMAGE_HEIGHT
			#backgroundColor: "orange"
		gridItems[itemName] = item
		item.imageLayer.image = imagePath if SHOW_IMAGES
		item.containerLayer.draggable.enabled = true
		item.containerLayer.draggable.speedX = 0
		item.containerLayer.draggable.speedY = 0
		item.containerLayer.addSubLayer(item.imageLayer)
		item.containerLayer.states.add
			detail: 
				x: 0
				y: DETAIL_IMAGE_Y_POSITION
				width: DEVICE_WIDTH
				height: DETAIL_IMAGE_HEIGHT
			parted:
				x: xPart
			bottom_bar:
				x: 0
				y: SLIDE_UP_POSITION
		item.imageLayer.states.add
			detail:
				width: DEVICE_WIDTH
				height: DETAIL_IMAGE_HEIGHT
			bottom_bar:
				scale: SLIDE_UP_SCALE
		item.containerLayer.states.animationOptions =
			curve: "spring(300,25,0)"
		item.imageLayer.states.animationOptions =
			curve: "spring(300,25,0)"

# EVENTS
for itemName, item of gridItems
	item.containerLayer.on Events.DragEnd, ->
		if currentState is "default" # Go to detail
			goToDetail(@)
		else if currentState is "detail" or "bottom_bar"
			if @.y > (DETAIL_IMAGE_Y_POSITION - 10)
				backToGrid(@)
			else
				bringBottomBar(@)
	item.containerLayer.on Events.AnimationEnd, ->
		if currentState is "default" # Reset the grid layers
			resetGrid()
	item.containerLayer.on Events.DragStart, ->
		@.hasGoneOffScreen = false
	item.containerLayer.on Events.DragMove, ->
		if currentState isnt "default" # Avoid DragMove events in the grid view
			imageScale = mapRange(@.y, -DEVICE_HEIGHT, DETAIL_IMAGE_Y_POSITION, 0, 1)
			backgroundOpacity = mapRange(@.y, DETAIL_IMAGE_Y_POSITION, DETAIL_IMAGE_Y_POSITION + DEVICE_HEIGHT * .3, 1, 0)
			@.subLayers[0].scale = imageScale
			yOffset = DETAIL_IMAGE_Y_POSITION - @.y
			if yOffset > 0 # Dragging up
				if 0 < yOffset < 90
					if currentState isnt "bottom_bar" and @.hasGoneOffScreen isnt true
						detailLayers.Header.layer.rotationX = DETAIL_IMAGE_Y_POSITION - @.y
				else if yOffset > 90
					@.hasGoneOffScreen = true
					detailLayers.Header.layer.states.switchInstant("default")
				detailLayers.Footer.layer.y = DEVICE_HEIGHT - 90 - (yOffset * 1.2)
			else # Dragging down
				if -90 < yOffset < 0
					if currentState isnt "bottom_bar" and @.hasGoneOffScreen isnt true
						detailLayers.Header.layer.rotationX = Math.abs(yOffset)
				else if yOffset < -90
					@.hasGoneOffScreen = true
					detailLayers.Header.layer.states.switchInstant("default")
					if currentState isnt "bottom_bar" and @.hasGoneOffScreen isnt true
						detailIconCloseLayer.opacity = backgroundOpacity ^ 10
				detailLayers.Footer.layer.rotationX = Math.abs(yOffset / 5)
				detailLayers.Background.layer.opacity = backgroundOpacity

mapRange = (value, low1, high1, low2, high2) ->
	if value < low1
		return low2
	else if value > high1
		return high2
	else return low2 + (high2 - low2) * (value - low1) / (high1 - low1)

goToDetail = (containerLayer) ->
	currentState = "detail"
	currentDetailLayer = containerLayer
	containerLayer.index = 100
	for itemName, item of gridItems
		item.containerLayer.ignoreEvents = true if itemName isnt containerLayer.name
	#containerLayer.backgroundColor = "green"
	containerLayer.states.switch("detail")
	containerLayer.subLayers[0].states.switch("detail") # Make image come along
	containerLayer.draggable.speedX = 1 # Not sure about this constraint
	containerLayer.draggable.speedY = 1
	for detailitemName, detailLayer of detailLayers
		detailLayer.layer.states.switch("detail")

bringBottomBar = (containerLayer) ->
	currentState = "bottom_bar"
	detailLayers.Header.layer.states.switch("default")
	containerLayer.states.switch("bottom_bar")
	containerLayer.subLayers[0].states.switch("bottom_bar")
	detailLayers.Footer.layer.states.switch("bottom_bar")
	detailIconCloseLayer.states.switch("bottom_bar")

backToGrid = (containerLayer) ->
	currentState = "default"
	#containerLayer.backgroundColor = COLOR_MAGENTA
	containerLayer.states.switch("default")
	containerLayer.subLayers[0].states.switch("default") # Make image come along
	containerLayer.ignoreEvents = true
	containerLayer.draggable.speedX = 0 # Not sure about this constraint
	containerLayer.draggable.speedY = 0
	for detailitemName, detailLayer of detailLayers
		detailLayer.layer.states.switchInstant("default")
	detailIconCloseLayer.states.switch("default")

resetGrid = () ->
	for itemName, item of gridItems
		item.containerLayer.index = 1
		item.containerLayer.ignoreEvents = false

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

headerTitleLayer = new Layer
	width: 640
	x: (DEVICE_WIDTH * .5) - 320
	height: HEADER
	superLayer: headerLayer
headerTitleLayer.image = "images/header.png" if SHOW_IMAGES

# EVENT
headerTitleLayer.on Events.Hold, ()->
	for itemName, layer of gridItems
		if layer.states.state isnt "parted"
			layer.states.switch("parted")
		else
			layer.states.switch("default")
			for itemName, layer of gridItems
				layer.ignoreEvents = false

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
			opacity: .96
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

detailIconCloseLayer = new Layer
	width: 120
	height: 120
	x: DEVICE_WIDTH - 120
	image: "images/icon_close.png"
	opacity: 0
	
detailIconCloseLayer.states.add
	bottom_bar:
		opacity: 1

# EVENTS
detailHeaderExtendRightLayer.on Events.Click, ->
	backToGrid(currentDetailLayer)

detailIconCloseLayer.on Events.Click, ->
	backToGrid(currentDetailLayer)

detailHeaderTitleLayer = new Layer
	width: 480
	x: (DEVICE_WIDTH * .5) - 240
	height: HEADER
	superLayer: detailLayers.Header.layer
detailHeaderTitleLayer.image = "images/detail_header.png" if SHOW_IMAGES

detailLayers.Footer.layer = new Layer
	width: DEVICE_WIDTH
	height: DEVICE_HEIGHT # 306
	y: DEVICE_HEIGHT - FOOTER
# 	backgroundColor: "#333"
	backgroundColor: COLOR_MAGENTA
	index: 10

detailLayers.Footer.layer.originY = 1
detailLayers.Footer.layer.rotationX = 90

detailLayers.Footer.layer.states.add
	detail:
		rotationX: 0
	bottom_bar:
		y: DEVICE_HEIGHT - 300

detailLayers.Footer.layer.states.animationOptions =
	curve: "bezier-curve"
	curveOptions: "ease-out"
	time: .2

CENTER_ICON = (DEVICE_WIDTH * .5) - 30
CENTER_SELECT = (DEVICE_WIDTH * .5) - 80
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
		name: icon.name
		width: 60
		height: 60 
		x: icon.x
		y: 15
		superLayer: detailLayers.Footer.layer
	icon.layer.image = "images/icons/" + icon.img if SHOW_IMAGES
	icon.layer.on Events.Click, ->
		animateActionSelector(@)
		bringBottomBar(currentDetailLayer)

animateActionSelector = (icon) ->
	if currentState is "detail"
		selectedActionLayer.states.switchInstant(icon.name)
		footerActionItemsLayer.states.switchInstant(icon.name)
	else 
		selectedActionLayer.states.switch(icon.name)
		footerActionItemsLayer.states.switch(icon.name)

selectedActionLayer = new Layer
	width: 160
	height: 6
	y: 90
	backgroundColor: "#EAEAEA"
	superLayer: detailLayers.Footer.layer

selectedActionLayer.states.add
	Plus1:
		x: CENTER_SELECT - UNIT * 3
	Comment:
		x: CENTER_SELECT - UNIT
	Add:
		x: CENTER_SELECT + UNIT
	Share:
		x: CENTER_SELECT + UNIT * 3

selectedActionLayer.states.animationOptions =
	curve: "bezier-curve"
	curveOptions: "ease-out"
	time: .2

footerActionItemsLayer = new Layer
	width: DEVICE_WIDTH * 4
	height: 210
	x: 0
	y: 96
	backgroundColor: "transparent"
# 	backgroundColor: COLOR_BLUE
	superLayer: detailLayers.Footer.layer

footerActionItemsLayer.states.add
	Plus1:
		x: 0
	Comment:
		x: -DEVICE_WIDTH
	Add:
		x: -DEVICE_WIDTH * 2
	Share:
		x: -DEVICE_WIDTH * 3

footerActionItemsLayer.states.animationOptions =
	curve: "spring(300,25,0)"

ACTION_ITEM_OFFSET = (DEVICE_WIDTH - 640) / 2

footerActionItems = [
	{ name: "Plus1", img: "action_plus-one.png", x: ACTION_ITEM_OFFSET }
	{ name: "Comment", img: "action_comment.png", x: DEVICE_WIDTH + ACTION_ITEM_OFFSET }
	{ name: "Add", img: "action_add.png", x: (DEVICE_WIDTH * 2) + ACTION_ITEM_OFFSET }
	{ name: "Share", img: "action_share.png", x: (DEVICE_WIDTH * 3) + ACTION_ITEM_OFFSET }
]

for item, i in footerActionItems
# 	xPosition =  i * DEVICE_WIDTH
# 	print parseInt(xPosition)
	item.layer = new Layer
		width: 640
		height: 210
		x: item.x
		y: 0
		superLayer: footerActionItemsLayer
# 		backgroundColor: COLOR_MAGENTA
	item.layer.image = "images/actions/" + item.img if SHOW_IMAGES

# item.layer = new Layer
# 	width: DEVICE_WIDTH
# 	height: 210
# 	x: 10
# 	superLayer: footerActionItemsLayer
# 	backgroundColor: "green"