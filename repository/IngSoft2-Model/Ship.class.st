Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'currentLap',
		'state'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Ship class >> create: aName [

	aName isString ifFalse: [
		^ Error signal: 'Ship´s name must be a string.' ].

	^ self new initializeWith: aName
]

{ #category : 'as yet unclassified' }
Ship >> activateDoubleEffect [

	state activateDoubleThrow
]

{ #category : 'adding' }
Ship >> addMercenary: aShip [

	state addMercenary: aShip
]

{ #category : 'playing' }
Ship >> bonusThrow [

	^ state bonusThrow
]

{ #category : 'testing' }
Ship >> canPlay [

	^ state canIPlay
]

{ #category : 'playing' }
Ship >> cards [

	^ state cards
]

{ #category : 'playing' }
Ship >> choiceToNotPlay [

	^ state chooseToNotPlay
]

{ #category : 'playing' }
Ship >> decreaseBonusThrow [

	state decreaseBonus
]

{ #category : 'testing' }
Ship >> hasAsMercery: aShip [

	^ state checkIfIHaveAsMercery: aShip
]

{ #category : 'testing' }
Ship >> hasCard: aCard [

	^ state hasThisCard: aCard
]

{ #category : 'testing' }
Ship >> hasDoubleThrow [

	^state hasDoubleThrow
]

{ #category : 'playing' }
Ship >> helpToFightWith: aDiceBucket [

	| result |
	result := aDiceBucket throw.
	state hasDoubleThrow ifTrue: [
		result := result * 2.
		state removeDoubleEffect ].
	^ result
]

{ #category : 'as yet unclassified' }
Ship >> increaseAShield [

	state addAShield
]

{ #category : 'playing' }
Ship >> increaseBonusThrow [

	state increaseBonus
]

{ #category : 'initialization' }
Ship >> initializeWith: aName [

	currentLap := 1.
	position := 1.
	name := aName.
	state := ShipState creation
]

{ #category : 'testing' }
Ship >> isAheadOf: anotherShip [

	^ self laps > anotherShip laps or: [
		  self laps = anotherShip laps and: [
			  self position > anotherShip position ] ]
]

{ #category : 'accessing' }
Ship >> laps [

	^ currentLap
]

{ #category : 'playing' }
Ship >> loseFight [

	position := 1.
	state loseFight
]

{ #category : 'playing' }
Ship >> loseShield [

	state loseShield
]

{ #category : 'playing' }
Ship >> move: numberOfCells in: aBoard [

	| newPosition |
	newPosition := position + numberOfCells.
	aBoard move: newPosition ship: self
]

{ #category : 'as yet unclassified' }
Ship >> moveToPosition: aPosition [

	position := aPosition
]

{ #category : 'accessing' }
Ship >> name [

	^ name
]

{ #category : 'accessing' }
Ship >> position [

	^ position
]

{ #category : 'playing' }
Ship >> receiveCard: aCard [

	state add: aCard
]

{ #category : 'playing' }
Ship >> recoverShields [

	state recoverShields
]

{ #category : 'removing' }
Ship >> removeCard: aCard [

	state removeCard: aCard
]

{ #category : 'removing' }
Ship >> removeMercenary: aShip [

	state removeMercenaries: aShip
]

{ #category : 'accessing' }
Ship >> shields [

	^ state shields
]

{ #category : 'playing' }
Ship >> skipTurn [

	state reduceTurnsToSkip
]

{ #category : 'playing' }
Ship >> throwDicesWith: aDiceBucket [

	| result helper |
	result := aDiceBucket throw.
	state hasDoubleThrow ifTrue: [
		result := result * 2.
		state removeDoubleEffect ].
	helper := state payHelpToMyMercenariesWith: aDiceBucket.
	^ result + helper
]

{ #category : 'accessing' }
Ship >> turnsThatHasToSkip [

	^ state turnsToSkip
]

{ #category : 'as yet unclassified' }
Ship >> updatePosition: newPosition andLap: newLaps [

	position := newPosition.
	currentLap := newLaps
]

{ #category : 'as yet unclassified' }
Ship >> usedDoubleEffect [

	state removeDoubleEffect
]

{ #category : 'accessing' }
Ship >> wantsToPlay [

	^ state optionalTurn
]

{ #category : 'playing' }
Ship >> winAt: aBoard [

	^ (currentLap = aBoard laps and: position >= aBoard amountOfCells)
		  or: currentLap > aBoard laps
]
