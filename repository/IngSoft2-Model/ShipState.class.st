Class {
	#name : 'ShipState',
	#superclass : 'Object',
	#instVars : [
		'turnsToSkip',
		'optionalTurn',
		'bonusThrow',
		'mercenaries',
		'cards',
		'shields',
		'hasDoubleThrow',
		'shieldsManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
ShipState class >> creation [

	^ self new initialization
]

{ #category : 'as yet unclassified' }
ShipState >> activateDoubleThrow [

	hasDoubleThrow := true
]

{ #category : 'adding' }
ShipState >> addMercenary: aShip [

	mercenaries add: aShip
]

{ #category : 'adding' }
ShipState >> addThisCard: aCard [

	cards add: aCard
]

{ #category : 'accessing' }
ShipState >> bonusThrow [

	^ bonusThrow
]

{ #category : 'accessing' }
ShipState >> cards [

	^ cards
]

{ #category : 'as yet unclassified' }
ShipState >> checkIfIHaveAsMercery: aShip [

	^ mercenaries anySatisfy: [ :ship | aShip = ship ]
]

{ #category : 'as yet unclassified' }
ShipState >> decreaseBonus [

	bonusThrow := bonusThrow - 1
]

{ #category : 'accessing' }
ShipState >> hasDoubleThrow [

	^ hasDoubleThrow
]

{ #category : 'as yet unclassified' }
ShipState >> hasThisCard: aCardClass [

	^ cards detect: [ :card | card matches: aCardClass ] ifNone: [ nil ]
]

{ #category : 'as yet unclassified' }
ShipState >> increaseBonus [

	bonusThrow := bonusThrow + 1
]

{ #category : 'initialization' }
ShipState >> initialization [

	turnsToSkip := 0.
	optionalTurn := true.
	bonusThrow := 0.
	mercenaries := OrderedCollection new.
	shieldsManager := ShieldsManager creation.
	cards := OrderedCollection new.
	hasDoubleThrow := false
]

{ #category : 'as yet unclassified' }
ShipState >> mercenariesLoseFight [

	mercenaries do: [ :mercenary | mercenary loseFight ]
]

{ #category : 'as yet unclassified' }
ShipState >> payHelpToMyMercenariesWith: aDiceBucket [

	| count |
	count := 0.
	mercenaries do: [ :ship |
		count := count + (ship helpToFightWith: aDiceBucket) ].
	^ count + bonusThrow
]

{ #category : 'removing' }
ShipState >> removeACard: aCard [

	| cardToRemove |
	cardToRemove := cards detect: [ :card | card matches: aCard ].

	cards
		remove: cardToRemove
		ifAbsent: [
		Error signal: 'Tried to remove a card that is not in hand' ]
]

{ #category : 'removing' }
ShipState >> removeCard: aCard [

	cards remove: aCard
]

{ #category : 'removing' }
ShipState >> removeDoubleEffect [

	hasDoubleThrow := false
]

{ #category : 'removing' }
ShipState >> removeMercenaries: aShip [

	mercenaries remove: aShip
]
