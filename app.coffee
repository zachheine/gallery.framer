# UX Engineer, Design - Prototyping Exercise
# Zach Heineman, 2015

DEVICE_WIDTH = 640
DEVICE_HEIGHT = 920
HEADER = 120
MARGIN = 30
GUTTER = 16
IMAGE_WIDTH = 282
IMAGE_HEIGHT = 206
IMAGE_DETAIL_HEIGHT = 428 # Proportional height would be 468
COLOR_BLUE = "#40a6f1"
COLOR_MAGENTA = "#df0077"

background = new BackgroundLayer
	backgroundColor: "#fff"

staticGridLayer = new Layer
	width: 640
	height: 920
	image: "images/grid.jpg"
	
headerLayer = new Layer
	width: DEVICE_WIDTH
	height: HEADER
	backgroundColor: COLOR_BLUE
	opacity: .8
	
gridLayers = {}

for row in [1..4]
	for column in ['A', 'B']
		layerName = column + row
		xPosition = if column == 'A' then MARGIN else MARGIN + IMAGE_WIDTH + GUTTER
		yPosition = (HEADER + MARGIN) + ((row - 1) * (IMAGE_HEIGHT + GUTTER))
		gridLayers[layerName] = new Layer
			name: layerName
			width: IMAGE_WIDTH
			height: IMAGE_HEIGHT
			x: xPosition
			y: yPosition
			backgroundColor: COLOR_MAGENTA
			opacity: .8

for name, layer of gridLayers
	layer.states.add
		detail: 
			x: 0
			y: 246
			width: DEVICE_WIDTH
			height: IMAGE_DETAIL_HEIGHT
	layer.states.animationOptions =
		curve: "spring(300,25,0)"
	layer.on Events.Click, ->
		state = this.states.state
		currentLayer = this.name
		if state isnt 'detail'
# 			print 'Go to detail'
			this.index = 100
			for name, layer of gridLayers
				layer.ignoreEvents = true if name isnt currentLayer
			this.backgroundColor = 'green'
			this.states.next()
			staticDetailLayer.states.next()
		else
# 			print 'Back to grid'
			for name, layer of gridLayers
				layer.index = 1
				layer.ignoreEvents = false
			this.backgroundColor = COLOR_MAGENTA
			this.states.next()
			staticDetailLayer.states.switchInstant('default')

staticDetailLayer = new Layer
	width: 640
	height: 920
	image: "images/detail.jpg"
	opacity: 0
		
staticDetailLayer.states.add
	detail:
		opacity: 1

staticDetailLayer.states.animationOptions =
	curve: "bezier-curve"
	curveOptions: "ease-in"
	time: .3
