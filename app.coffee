# UX Engineer, Design - Prototyping Exercise
# Zach Heineman, 2015

DEVICE_WIDTH = 640
DEVICE_HEIGHT = 920
HEADER = 120
MARGIN = 30
GUTTER = 16
IMAGE_WIDTH = 282
IMAGE_HEIGHT = 206

background = new BackgroundLayer
	backgroundColor: "#fff"

staticGridLayer = new Layer
	width: 640
	height: 920
	image: "images/grid.jpg"
	
headerLayer = new Layer
	width: DEVICE_WIDTH
	height: HEADER
	backgroundColor: "#40a6f1"
	opacity: .8
	
gridLayers = {}

for row in [1..4]
	for column in ['A', 'B']
		layerName = column + row
		xPosition = if column == 'A' then MARGIN else MARGIN + IMAGE_WIDTH + GUTTER
		yPosition = (HEADER + MARGIN) + ((row - 1) * (IMAGE_HEIGHT + GUTTER))
		gridLayers[layerName] = new Layer
			width: IMAGE_WIDTH
			height: IMAGE_HEIGHT
			x: xPosition
			y: yPosition
			backgroundColor: "#df0077"
			opacity: .8
			
staticDetailLayer = new Layer
	width: 640
	height: 920
	image: "images/detail.jpg"
	opacity: 0
