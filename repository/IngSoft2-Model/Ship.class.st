Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'currentLap',
		'shields',
		'turnsToSkip',
		'diceBucket',
		'optionalTurn',
		'cards',
		'bonusThrow',
		'bonusBattle',
		'shipsIAmMercenaryTo',
		'amIMercenary'
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

{ #category : 'testing' }
Ship >> canPlay [

	^ turnsToSkip = 0
]

{ #category : 'playing' }
Ship >> cards [

	^ cards
]

{ #category : 'playing' }
Ship >> choiceToNotPlay [

	self recoverShields.
	turnsToSkip := turnsToSkip + 1
]

{ #category : 'playing' }
Ship >> decreaseBonusThrow [
	bonusThrow := bonusThrow -1.
]

{ #category : 'playing' }
Ship >> giveBonusThrow [
	^ bonusThrow.
]

{ #category : 'testing' }
Ship >> hasAsMercery: aShip [

	^ bonusBattle anySatisfy: [ :ship | aShip = ship name ]
]

{ #category : 'testing' }
Ship >> hasCard: aCard [
	^ cards anySatisfy: [ :card | card matches: aCard ]
]

{ #category : 'playing' }
Ship >> helpToFightWith: aDiceBucket [

	^ aDiceBucket throw
]

{ #category : 'playing' }
Ship >> increaseBonusThrow [
	bonusThrow := bonusThrow +1.
]

{ #category : 'initialization' }
Ship >> initializeWith: aName [

	currentLap := 1.
	position := 1.
	name := aName.
	shields := 3.
	turnsToSkip := 0.
	optionalTurn := true.
	bonusThrow := 0.
	bonusBattle := OrderedCollection new.
	shipsIAmMercenaryTo := OrderedCollection new.
	cards := OrderedCollection new.
	amIMercenary:=false.
]

{ #category : 'testing' }
Ship >> isAheadOf: anotherShip [

	^ self laps > anotherShip laps or: [
		  self laps = anotherShip laps and: [
			  self position > anotherShip position ] ]
]

{ #category : 'testing' }
Ship >> isNotMercenaryAnymore [
	amIMercenary := false.
]

{ #category : 'testing' }
Ship >> isSomeoneMercenary [
	^ amIMercenary.
]

{ #category : 'accessing' }
Ship >> laps [

	^ currentLap
]

{ #category : 'playing' }
Ship >> loseFight [

	bonusBattle do:[:mercenaryShip|mercenaryShip loseShield ].
	self loseShield.
	
	position := 1
]

{ #category : 'playing' }
Ship >> loseShield [

	shields := shields - 1.
	shields = 0 ifFalse: [ ^ self ].

	self recoverShields.
	turnsToSkip := 2
]

{ #category : 'playing' }
Ship >> markedAsMercenary [
	amIMercenary := true.
]

{ #category : 'playing' }
Ship >> move: numberOfCells in: aBoard [

	| newPosition result newPositionAndLap |
	newPosition := position + numberOfCells.
	newPositionAndLap := aBoard
		                     move: newPosition
		                     at: currentLap
		                     having: 0. "New method in Board"
	position := newPositionAndLap at: 1.
	currentLap := newPositionAndLap at: 2
]

{ #category : 'playing' }
Ship >> moveToFirstPosition [

	position := 1
]

{ #category : 'accessing' }
Ship >> name [

	^ name
]

{ #category : 'playing' }
Ship >> popThisMercenary: shipBeingMercenary [ 
	bonusBattle remove: shipBeingMercenary .
]

{ #category : 'accessing' }
Ship >> position [

	^ position
]

{ #category : 'playing' }
Ship >> receiveAtomicBombEffect [
	self moveToFirstPosition. 
	self loseShield.
]

{ #category : 'playing' }
Ship >> receiveBlackHoleEffectFrom: aBoard [

	| newPosition result |
	newPosition := position - 4.
	result := aBoard move: newPosition at: currentLap having: 0.
	position := result at: 1.
	currentLap := result at: 2
]

{ #category : 'playing' }
Ship >> receiveCard: aCard [

	cards add: aCard
]

{ #category : 'playing' }
Ship >> receiveHyperJumpIn: aBoard moving: numberOfParsecs [

	| result |
	result := aBoard move: position at: currentLap having: numberOfParsecs.
	position := result at: 1.
	currentLap := result at: 2
]

{ #category : 'playing' }
Ship >> receiveMercenaryCardEffectWith: aShip [

	aShip isSomeoneMercenary ifTrue: [ Error signal:'You can not use this ship as a mercenary' ] ifFalse: [ bonusBattle add: aShip. aShip markedAsMercenary].
	
]

{ #category : 'playing' }
Ship >> receiveSpeedCardEffect [
	self increaseBonusThrow .
]

{ #category : 'playing' }
Ship >> receiveThis: aCard [

	cards add: aCard
]

{ #category : 'as yet unclassified' }
Ship >> receiveWormHoleEfffect: aPosition [

	position := aPosition
]

{ #category : 'playing' }
Ship >> recieveCardsFrom: cardFactory [

	cards := cardFactory generateInitialCards
]

{ #category : 'playing' }
Ship >> recieveHyperSpaceJumpIn: aBoard [

	| newPosition result |
	newPosition := position + 4.
	result := aBoard move: newPosition at: currentLap having: 0.
	position := result at: 1.
	currentLap := result at: 2.
	self loseShield
]

{ #category : 'playing' }
Ship >> recoverShields [

	shields := 3.
	turnsToSkip :=0.
	optionalTurn :=true.
]

{ #category : 'removing' }
Ship >> removeAccelerationCardEffect [
	self decreaseBonusThrow.
]

{ #category : 'removing' }
Ship >> removeCard: aCard [

	| cardToRemove |
	cardToRemove := cards detect: [ :card | card matches: aCard ].

	cards
		remove: cardToRemove
		ifAbsent: [
		Error signal: 'Tried to remove a card that is not in hand' ]
]

{ #category : 'removing' }
Ship >> removeSpeedCardEffect [
	self decreaseBonusThrow .
]

{ #category : 'accessing' }
Ship >> shields [

	^ shields
]

{ #category : 'playing' }
Ship >> skipTurn [

	turnsToSkip := turnsToSkip - 1
]

{ #category : 'playing' }
Ship >> throwDices [

	^ diceBucket throw
]

{ #category : 'playing' }
Ship >> throwDicesWith: aDiceBucket [

	| count |
	count := 0.
	bonusBattle do: [ :mercenaryShip |
		count := count + (mercenaryShip helpToFightWith: aDiceBucket) ].
	^ aDiceBucket throw + count
]

{ #category : 'accessing' }
Ship >> turnsThatHasToSkip [

	^ turnsToSkip
]

{ #category : 'playing' }
Ship >> useBonusThrow [

	| increment |
	increment := 0.
	bonusThrow > 0 ifTrue: [ increment := 1 ].
	bonusThrow := bonusThrow - 1.
	^ increment
]

{ #category : 'playing' }
Ship >> useCard: aCard with: aShip in: aGame [

	(self hasCard: aCard) ifFalse: [
		Error signal: 'Cannot play a card you do not have' ].
	aGame cardManager
		playCard: aCard
		by: self
		target: aShip
		in: aGame.
	self removeCard: aCard
]

{ #category : 'accessing' }
Ship >> wantsToPlay [

	^ optionalTurn 
]

{ #category : 'playing' }
Ship >> winAt: aBoard [

	^ (currentLap = aBoard laps and: position >= aBoard amountOfCells)
		  or: currentLap > aBoard laps
]
