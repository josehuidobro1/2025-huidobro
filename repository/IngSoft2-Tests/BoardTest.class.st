Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test000WhenCreateBoardWithAmountOfCellsThenShowAmountOfCells [

	| aBoard amountOfCells aWorm distributions |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 6.

	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).

	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 200).
	self assert: aBoard amountOfCells equals: amountOfCells
]

{ #category : 'tests' }
BoardTest >> test001WhenPlayGameThenReturnGameOver [

	| aBoard amountOfCells aWorm aX aY distributions |
	amountOfCells := 10.
	aX := 4.
	aY := 6.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).

	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	self assert: aBoard wormHole positions equals: {
			aX.
			aY }
]

{ #category : 'tests' }
BoardTest >> test002WhenCreateBoardWithWrongWormHolePostionThenReturnsError [

	| amountOfCells aWorm distributions |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 11.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	self
		should: [
			Board
				with: amountOfCells
				and: aWorm
				until: 1
				has: distributions
				basedOn: (Distance parsecs: 20) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Position of the worm hole exceed amount board`s cells' ]
]

{ #category : 'tests' }
BoardTest >> test003WhenCreateBoardWithCellsLessThan1ThenReturnsError [

	| amountOfCells aWorm distributions |
	amountOfCells := 0.
	aWorm := Worm with: 4 and: 11.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	self
		should: [
			Board
				with: amountOfCells
				and: aWorm
				until: 1
				has: distributions
				basedOn: (Distance parsecs: 20) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Amount of cells must be greater than zero' ]
]

{ #category : 'tests' }
BoardTest >> test004WhenCreateBoardWithCellsNotIntegerThenReturnsError [

	| amountOfCells aWorm distributions |
	amountOfCells := 3.14.
	aWorm := Worm with: 4 and: 11.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	self
		should: [
			Board
				with: amountOfCells
				and: aWorm
				until: 1
				has: distributions
				basedOn: (Distance parsecs: 20) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Amount of cells must be an integer' ]
]

{ #category : 'tests' }
BoardTest >> test005WhenShipMovesToWormholeThenBoardKnowsThePositionOfShip [

	| amountOfCells aX aY aWorm aBoard aShip distributions aLoadedDice aDiceBucket ships cardManager aGame dices ship1 |
	amountOfCells := 10.
	aX := 4.
	aY := 7.
	aWorm := Worm with: aX and: aY.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	aLoadedDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aLoadedDice.
	aDiceBucket := DiceBucket with: dices.
	ships := OrderedCollection new.
	ships add: 'ship 1'.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: SpeedCard with: 0.5).
	distributions add: (Distribution at: RedoCard with: 0.5).
	cardManager := CardManager
		               createAmountOf: 10
		               andDistribution: distributions.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         cardManager: cardManager.
	aGame playTurn.
	ship1 := aGame findShipBy: 'ship 1'.
	self assert: ship1 position equals: 4
]

{ #category : 'tests' }
BoardTest >> test006WhenShipMoveMoreThanCellsInTheBoardThenPositionIsAmountOfCells [

	| amountOfCells aX aY aWorm aBoard aShip loadedDice distributions |
	amountOfCells := 4.
	aX := 1.
	aY := 2.
	aWorm := Worm with: aX and: aY.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	loadedDice := LoadedDice withSequence: #( 6 ).
	aShip := Ship create: 'ship1'.
	aShip move: loadedDice throw in: aBoard.
	self assert: aShip position equals: 4
]

{ #category : 'tests' }
BoardTest >> test007WhenGivenDistributionToABoardThenAllAddUpToTheExacAmountOfCells [

	| amountOfCells aX aY aWorm aBoard distributions total |
	amountOfCells := 5.
	"El numero de celdas por ahora esta logicamente implementado para que sea siempre un entero, un par"
	aX := 1.
	aY := 2.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 0.4).
	distributions add: (Distribution at: BlackHole with: 0.6).

	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 100).
	total := (aBoard amountOfCellsOf: 'NoEffect')
	         + (aBoard amountOfCellsOf: 'BlackHole').
	self assert: total equals: amountOfCells
]

{ #category : 'tests' }
BoardTest >> test008WhenAskForEffectOnPositionThenBoardReturnItEffect [

	| amountOfCells aX aY aWorm aBoard distributions effect |
	amountOfCells := 4.
	"El numero de celdas por ahora esta logicamente implementado para que sea siempre un entero, un par"
	aX := 1.
	aY := 2.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).

	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 100).
	effect := aBoard effectOnPosition: 3.
	self assert: effect className equals: 'BlackHole'
]

{ #category : 'tests' }
BoardTest >> test009WhenGivenDistributionToABoardThenAllAddUpToTheExactAmountOfCellsAs4 [

	| amountOfCells aX aY aWorm aBoard distributions total |
	amountOfCells := 2.
	"El numero de celdas por ahora esta logicamente implementado para que sea siempre un entero, un par"
	aX := 1.
	aY := 2.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 0.4).
	distributions add: (Distribution at: BlackHole with: 0.6).

	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 1).
	total := (aBoard amountOfCellsOf: 'NoEffect')
	         + (aBoard amountOfCellsOf: 'BlackHole').
	self assert: total equals: amountOfCells
]

{ #category : 'tests' }
BoardTest >> test010WhenCreateBoardWithDistributionsThenEffectsOFCellsISNoEFfect [

	| amountOfCells aX aY aWorm aBoard distributions |
	amountOfCells := 4.
	"El numero de celdas por ahora esta logicamente implementado para que sea siempre un entero, un par"
	aX := 1.
	aY := 2.
	aWorm := Worm with: aX and: aY.

	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).

	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	self
		assert: (aBoard effectOnPosition: 3) className
		equals: 'NoEffect'
]

{ #category : 'tests' }
BoardTest >> test011WhenBoardIsCreatedThenEffectsAreDistributedAccordingToProbability [

	| board amountOfCells worm distributions cardEffectCount blackHoleCount noEffectCount totalCells tolerance distanceToMove effect name hyperSpaceCount hyperJumpCount moonWalkCount atomicBombCount |
	amountOfCells := 1000.
	worm := Worm with: 2 and: 4.
	distanceToMove := OrderedCollection new.
	distanceToMove add: (Distance lightYear: 27).
	distanceToMove add: (Distance lightYear: 18).
	distanceToMove add: (Distance lightYear: 9).
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 0.38).
	distributions add: (Distribution at: CardGiver with: 0.10).
	distributions add: (Distribution at: BlackHole with: 0.20).
	distributions add: (Distribution at: HyperSpaceJump with: 0.20).
	distributions add: (Distribution at: MoonWalk with: 0.10).
	distributions add:
		(Distribution at: (HyperJump with: distanceToMove) with: 0.08).
	distributions add: (Distribution at: AtomicBomb with: 0.02).

	board := Board
		         with: amountOfCells
		         and: worm
		         until: 1
		         has: distributions
		         basedOn: (Distance parsecs: 20).

	cardEffectCount := board amountOfCellsOf: 'CardGiver'.
	blackHoleCount := board amountOfCellsOf: 'BlackHole'.
	noEffectCount := board amountOfCellsOf: 'NoEffect'.
	hyperSpaceCount := board amountOfCellsOf: 'HyperSpaceJump'.
	hyperJumpCount := board amountOfCellsOf: 'HyperJump'.
	moonWalkCount := board amountOfCellsOf: 'MoonWalk'.
	atomicBombCount := board amountOfCellsOf: 'AtomicBomb'.

	totalCells := amountOfCells.
	tolerance := 0.05. "5% de margen de error\"

	self assert: cardEffectCount / totalCells >= (0.10 - tolerance).
	self assert: cardEffectCount / totalCells <= (0.10 + tolerance).

	self assert: blackHoleCount / totalCells >= (0.20 - tolerance).
	self assert: blackHoleCount / totalCells <= (0.20 + tolerance).

	self assert: noEffectCount / totalCells >= (0.38 - tolerance).
	self assert: noEffectCount / totalCells <= (0.38 + tolerance)
]

{ #category : 'tests' }
BoardTest >> test012WhenCreateBoardWithLessThan1LapThenRaiseError [

	| amountOfCells aWorm distributions |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	self
		should: [
			Board
				with: amountOfCells
				and: aWorm
				until: 0
				has: distributions
				basedOn: (Distance parsecs: 20) ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Laps must be equal or greater than one' ]
]

{ #category : 'tests' }
BoardTest >> test013WhenCreateBoardThenReturnCorrectLaps [

	| amountOfCells aWorm distributions laps aBoard |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	self assert: aBoard laps equals: laps
]

{ #category : 'tests' }
BoardTest >> test014WhenCreateBoardThenReturnCorrectLightYears [

	| amountOfCells aWorm distributions laps aBoard |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	self assert: aBoard lightYearsPerCell equals:6
]

{ #category : 'tests' }
BoardTest >> test015WhenCreateBoardThenReturnCorrectParsecsPerCell [

	| amountOfCells aWorm distributions laps aBoard |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance lightYear: 60).
	self assert: aBoard parsecsPerCell equals: 2
]

{ #category : 'tests' }
BoardTest >> test016WhenCreateBoardWithAllBlackHoleEffectThenEffectOnPositionOnAnyCellIsBlackHole [

	| amountOfCells aWorm distributions laps aBoard effect |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance lightYear: 60).
	effect := aBoard effectOnPosition: 3.
	self assert: effect class equals: BlackHole
]

{ #category : 'tests' }
BoardTest >> test017WhenAskForEffectOnPositionOnaWormHoleCellThenReturnWormHole [

	| amountOfCells aWorm distributions laps aBoard effect |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance lightYear: 60).
	effect := aBoard effectOnPosition: 4.
	self assert: effect class equals: Worm
]

{ #category : 'tests' }
BoardTest >> test018WhenMoveAShipThrowLapsThenNewPosiitionAndLapsAreTheCorrects [

	| amountOfCells aWorm distributions laps aBoard effect ship lap |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance lightYear: 60).
	ship := Ship create: 'ship'.
	lap := aBoard moveThrowTheLaps: ship laps this: 12.
	self assert: lap equals: 2
]

{ #category : 'tests' }
BoardTest >> test019WhenMoveAShipThrowLapsWithNegativePositionThenRaiseError [

	| amountOfCells aWorm distributions laps aBoard effect ship lap |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance lightYear: 60).
	ship := Ship create: 'ship'.
	self
		should: [ aBoard moveThrowTheLaps: ship laps this: -12 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Current lap cannot be negative' ]
]

{ #category : 'tests' }
BoardTest >> test020WhenMoveAShipADistanceThenTheNewPositionIsCorrect [

	| amountOfCells aWorm distributions laps aBoard effect ship lap |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance lightYear: 60).
	ship := Ship create: 'ship'.
	aBoard move: 25 ship: ship.
	self assert: ship position equals: 5.
	self assert: ship laps equals: 3
]

{ #category : 'tests' }
BoardTest >> test021WhenMoveAShipANegativeDistanceThenThePositionIsOne [

	| amountOfCells aWorm distributions laps aBoard effect ship lap |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance lightYear: 60).
	ship := Ship create: 'ship'.
	aBoard move: -5 ship: ship.
	self assert: ship position equals: 1
]

{ #category : 'tests' }
BoardTest >> test022WhenMoveAShipADistanceBiggerThanLapsThenThePositionIsLastOne [

	| amountOfCells aWorm distributions laps aBoard effect ship lap |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance lightYear: 60).
	ship := Ship create: 'ship'.
	aBoard move: 32 ship: ship.
	self assert: (ship winAt: aBoard)
]

{ #category : 'tests' }
BoardTest >> test023WhenCalcularePositionByParsecsThenReturnCorrectPosition [

	| amountOfCells aWorm distributions laps aBoard effect ship lap position |
	amountOfCells := 10.
	aWorm := Worm with: 4 and: 7.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance parsecs: 30).
	position := aBoard calculatePositionByParsecs: 7.
	self assert: position equals: 3
]

{ #category : 'tests' }
BoardTest >> test024WhenApplyEffectOnShipThenShipReceiveTheEffect [

	| amountOfCells aWorm distributions laps aBoard effect ship lap position ships dices aDice aDiceBucket cardManager aGame |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 7 and: 9.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperSpaceJump with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 20).

	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: SpeedCard with: 0.5).
	distributions add: (Distribution at: RedoCard with: 0.5).
	cardManager := CardManager
		               createAmountOf: 10
		               andDistribution: distributions.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         cardManager: cardManager.
	ship := aGame findShipBy: 'ship 1'.
	aBoard applyEffectOn: ship atPosition: 1 in: aGame.
	self assert: ship position equals: 5.
	self assert: ship shields equals: 2
]

{ #category : 'tests' }
BoardTest >> test025WhenApplyEffectOnShipThenGameRegisterTheEffectIfItIsnotACardGiver [

	| amountOfCells aWorm distributions laps aBoard effect ship lap position ships dices aDice aDiceBucket cardManager aGame |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 7 and: 9.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: HyperSpaceJump with: 1).
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: 1
		          has: distributions
		          basedOn: (Distance parsecs: 20).

	ships add: 'ship 1'.
	ships add: 'ship 2'.
	ships add: 'ship 3'.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: SpeedCard with: 0.5).
	distributions add: (Distribution at: RedoCard with: 0.5).
	cardManager := CardManager
		               createAmountOf: 10
		               andDistribution: distributions.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         cardManager: cardManager.
	ship := aGame findShipBy: 'ship 1'.
	aBoard applyEffectOn: ship atPosition: 1 in: aGame.
	self assert: aGame lastRealEffect class equals: HyperSpaceJump
]
