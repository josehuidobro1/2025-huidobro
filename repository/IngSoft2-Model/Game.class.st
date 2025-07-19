Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'bucketOfDices',
		'ships',
		'status',
		'turnManager',
		'battleManager',
		'cardManager',
		'effectManager',
		'winner'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> validateUniqueNames: ships [

	| uniqueNames duplicatedNames |
	uniqueNames := Set new.
	duplicatedNames := OrderedCollection new.

	ships do: [ :shipName |
		(uniqueNames includes: shipName)
			ifTrue: [ duplicatedNames add: shipName ]
			ifFalse: [ uniqueNames add: shipName ] ].

	duplicatedNames isEmpty ifFalse: [
		^ Error signal: 'Ship´s name must not be reapeated.' ].

	^ ships
]

{ #category : 'as yet unclassified' }
Game class >> with: arg1 using: arg2 andShipsNamed: arg3 until: arg4 cardManager: arg5 [

	arg3 ifEmpty: [ ^ Error signal: 'List of ships must not be empty.' ].
	self validateUniqueNames: arg3.
	^ self new
		  initializeWith: arg1
		  using: arg2
		  andShipsNamed: arg3
		  until: arg4
		  cardManager: arg5
]

{ #category : 'playing' }
Game >> applyAccelerationCardEffect [
	ships do: [:ship | ship increaseBonusThrow  ].
]

{ #category : 'playing' }
Game >> applyAtomicEffectOn: aShip [

	ships do: [ :ship |
		ship moveToPosition: 1.
		ship loseShield ]
]

{ #category : 'playing' }
Game >> applyMoonWalkEffectOn: aShip moving: numberOfCells [
	 ships do: [ :otherShip |
		otherShip ~~ aShip ifTrue: [
			otherShip move: numberOfCells * -1 in: board ] ].
]

{ #category : 'accessing' }
Game >> board [

	^ board
]

{ #category : 'accessing' }
Game >> cardManager [

	^ cardManager
]

{ #category : 'accessing' }
Game >> currentStatus [

	^ status
]

{ #category : 'accessing' }
Game >> currentTopPlayer [

	^ self shipsSortedByPosition at: 1.
]

{ #category : 'as yet unclassified' }
Game >> effectManager [

	^ effectManager
]

{ #category : 'accessing' }
Game >> findShipBy: aName [

	^ ships detect: [ :ship | ship name = aName ]
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard using: diceBucket andShipsNamed: shipsname until: laps cardManager: aCardManager [

	| tmp1 |
	board := aBoard with: laps.
	ships := shipsname collect: [ :ship | Ship create: ship ].
	bucketOfDices := diceBucket.
	status := Started creation.
	turnManager := TurnManager with: ships.
	battleManager := BattleManager with: diceBucket.
	effectManager := EffectManager creation.
	cardManager := aCardManager.
	ships do: [ :ship | cardManager drawInitialCardsFor: ship ]
]

{ #category : 'playing' }
Game >> play [

	status play:self.

	^ 'Game over'
]

{ #category : 'playing' }
Game >> playTurn [

	| currentShip rolledDistance boardEffect |
	currentShip := turnManager nextShip.
	rolledDistance := bucketOfDices rollFor: currentShip.
	currentShip move: rolledDistance in: board.

	boardEffect := board effectOnPosition: currentShip position.
	effectManager apply: boardEffect to: currentShip in: self.
	battleManager resolveIfNeededAt: currentShip in: self.

	self someShipWon
]

{ #category : 'playing' }
Game >> shipNamed: shipName useCard: aCard with: anotherShipName [

	| ship anotherShip |
	ship := self findShipBy: shipName.
	anotherShip := self findShipBy: anotherShipName.
	cardManager
		playCard: aCard
		by: ship
		target: anotherShip
		in: self
]

{ #category : 'accessing' }
Game >> ships [
	^ ships
]

{ #category : 'accessing' }
Game >> shipsSortedByPosition [

	^ ships copy sort: [ :a :b | a isAheadOf: b ]
]

{ #category : 'accessing' }
Game >> showRanking [

	| top ranking sorted |
	status isFinished
		ifTrue: [
			top := 1.
			ranking := OrderedCollection new.
			sorted := self shipsSortedByPosition.

			[ top <= 3 and: [ top <= sorted size ] ] whileTrue: [
				ranking add: (sorted at: top) name.
				top := top + 1 ].
			^ ranking ]
		ifFalse: [
			Error signal:
				'The Game has not been played yet so it doesn`t have a ranking' ]
]

{ #category : 'playing' }
Game >> showShipsPositions [

	| result |
	result := Dictionary new.
	ships do: [ :ship | result at: ship name put: ship position ].
	^ result
]

{ #category : 'accessing' }
Game >> showWinner [

	^ status showWinner: self
]

{ #category : 'playing' }
Game >> skipTurnForShipNamed: shipName [ 
	turnManager skipTurnForShipNamed: shipName.
]

{ #category : 'playing' }
Game >> someShipWon [

	| laps winner result |
	laps := board laps.
	result := ships anySatisfy: [ :ship | ship winAt: board ].
	result ifTrue: [ status := Finished new ]
]
