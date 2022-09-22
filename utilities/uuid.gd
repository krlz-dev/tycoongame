extends Node

class_name UUID

const MODULO_8_BIT = 256

static func getRandomInt():
  randomize()

  return randi() % MODULO_8_BIT

static func uuidbin():
  return [
	getRandomInt(), getRandomInt(), getRandomInt(), getRandomInt(),
	getRandomInt(), getRandomInt(), ((getRandomInt()) & 0x0f) | 0x40, getRandomInt(),
	((getRandomInt()) & 0x3f) | 0x80, getRandomInt(), getRandomInt(), getRandomInt(),
	getRandomInt(), getRandomInt(), getRandomInt(), getRandomInt(),
  ]

static func v4():
  var b = uuidbin()

  return '%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x' % [
	b[0], b[1], b[2], b[3],

	b[4], b[5],

	b[6], b[7],

	b[8], b[9],

	b[10], b[11], b[12], b[13], b[14], b[15]
  ]
