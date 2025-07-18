Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'winner',
		'board',
		'bucketOfDices',
		'ships',
		'status',
		'turnManager',
		'battleManager',
		'cards',
		'activeCards',
		'historicalCards',
		'historicalEffects',
		'cardManager',
		'effectManager'
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

{ #category : 'adding' }
Game >> addToActiveCardsThisCard: aCard [ 
	activeCards add: aCard .
]

{ #category : 'playing' }
Game >> applyAccelerationCardEffect [
	ships do: [:ship | ship increaseBonusThrow  ].
]

{ #category : 'playing' }
Game >> applyAtomicEffectOn: aShip [ 
	ships do:[ :ship | ship receiveAtomicBombEffect]
]

{ #category : 'playing' }
Game >> applyBlackHoleEffectOn: aShip [

	aShip receiveBlackHoleEffectFrom: board 
]

{ #category : 'playing' }
Game >> applyHyperJumEffectOn: aShip moving: cellsToJump [

	aShip receiveHyperJumpIn: board moving: cellsToJump
]

{ #category : 'playing' }
Game >> applyHyperSpaceJumpEffectOn: aShip [

	aShip recieveHyperSpaceJumpIn: board
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
Game >> initializeWith: arg1 using: arg2 andShipsNamed: arg3 until: arg4 cardManager: arg5 [

	| tmp1 |
	board := arg1 with: arg4.
	ships := arg3 collect: [ :arg6 | Ship create: arg6 ].
	bucketOfDices := arg2.
	status := Started creation.
	turnManager := TurnManager with: ships.
	battleManager := BattleManager with: arg2.
	effectManager := EffectManager creation.
	cardManager := arg5.
	ships do: [ :arg7 | cardManager drawInitialCardsFor: arg7 ]
]

{ #category : 'testing' }
Game >> isBefore: shipA than: shipB [

	^ (ships indexOf: shipA) < (ships indexOf: shipB)
]

{ #category : 'accessing' }
Game >> permanentCardsPlayed [
	^ activeCards .
]

{ #category : 'playing' }
Game >> play [

	status play:self.

	^ 'Game over'
]

{ #category : 'playing' }
Game >> playTurn [

	| currentShip rolledDistance boardEffect |
	currentShip := turnManager currentShip.
	rolledDistance := bucketOfDices rollFor: currentShip.
	currentShip move: rolledDistance in: board.

	boardEffect := board effectOnPosition: currentShip position.
	effectManager apply: boardEffect to: currentShip in: self.
	battleManager resolveIfNeededAt: currentShip in: self.

	self someShipWon
]

{ #category : 'playing' }
Game >> shipNamed: arg1 useCard: arg2 with: arg3 [

	| tmp1 tmp2 |
	tmp1 := self findShipBy: arg1.
	tmp2 := self findShipBy: arg3.
	tmp1 useCard: arg2 with: tmp2 in: self
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

	| laps |
	laps := board laps.
	winner := ships detect: [ :ship | ship winAt: board ] ifNone: [ nil ].
	winner ifNotNil: [ status := Finished new ]
]
