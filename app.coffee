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

staticLayer = new Layer
	width:640
	height:920
	image:"images/grid.jpg"
	
headerLayer = new Layer
	width: DEVICE_WIDTH
	height: HEADER
	color: "#40a6f1"