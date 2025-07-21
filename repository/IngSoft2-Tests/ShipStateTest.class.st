Class {
	#name : 'ShipStateTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipStateTest >> test000WhenShipStateISCreatedThenBonusThrowIsZeroAndCardsAreEmptyAndDoubleThrowFalse [

	| state |
	state := ShipState creation.
	self assert: state bonusThrow equals: 0.
	self assert: state cards isEmpty.
	self deny: state hasDoubleThrow
]

{ #category : 'tests' }
ShipStateTest >> test001WhenAddMercenaryThenMercenariesHasAsMErcenarySomeOne [

	| state ship |
	state := ShipState creation.
	ship := Ship create: 'ship'.
	state addMercenary: ship.

	self assert: (state checkIfIHaveAsMercery: ship)
]

{ #category : 'tests' }
ShipStateTest >> test002WhenAddACardThenCardIsNotEmpty [

	| state ship |
	state := ShipState creation.
	ship := Ship create: 'ship'.
	state addThisCard: SpeedCard new.

	self assert: state cards size equals: 1
]

{ #category : 'tests' }
ShipStateTest >> test003WhenCheckIFIHAveaMErcenaryComeShipThatISNotThenReturnFalse [
	| state ship ship2 |
	state := ShipState creation.
	ship := Ship create: 'ship'.
	ship2 := Ship create: 'ship2'.
	state addMercenary: ship.

	self deny: (state checkIfIHaveAsMercery: ship2).
]

{ #category : 'tests' }
ShipStateTest >> test004WhenPayHElpToMyMercenariesThenReturnMercenariesPoints [

	| state ship ship2 aDiceBucket points dices |
	state := ShipState creation.
	ship := Ship create: 'ship'.
	ship2 := Ship create: 'ship2'.
	state addMercenary: ship.
	state addMercenary: ship2.
	dices := OrderedCollection new.
	dices add: (LoadedDice withSequence: #( 3 7 )).
	aDiceBucket := DiceBucket with: dices.
	points := state payHelpToMyMercenariesWith: aDiceBucket.

	self assert: points equals: 10
]

{ #category : 'tests' }
ShipStateTest >> test005WhenPayHElpToMyMercenariesAndSomeMErcenaryHAsDoubleThrowThenReturnMercenariesPoints [

	| state ship ship2 aDiceBucket points dices ships aDice amountOfCells aWorm distributions laps aBoard distributions1 cardManager aGame double |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	dices add: (LoadedDice withSequence: #( 5 2 )).
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	laps := 3.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          until: laps
		          has: distributions
		          basedOn: (Distance parsecs: 20).

	ships add: 'ship 1'.
	distributions1 := OrderedCollection new.
	distributions1 add: (Distribution at: SpeedCard with: 0.5).
	distributions1 add: (Distribution at: RedoCard with: 0.5).
	cardManager := CardManager
		               createAmountOf: 10
		               andDistribution: distributions1.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         cardManager: cardManager.
	state := ShipState creation.
	ship := Ship create: 'ship'.
	ship2 := Ship create: 'ship2'.
	double := DoubleCard new.
	double applyTo: ship2 using: ship in: aGame.
	state addMercenary: ship.
	state addMercenary: ship2.
	points := state payHelpToMyMercenariesWith: aDiceBucket.

	self assert: points equals: 12
]

{ #category : 'tests' }
ShipStateTest >> test006WhenIncreaseBonusThrowThenBonusThrowISOne [

	| state ship |
	state := ShipState creation.

	state increaseBonus.

	self assert: state bonusThrow equals: 1
]

{ #category : 'tests' }
ShipStateTest >> test007WhenDecreaseBonusThrowThenBonusThrowISZero [

	| state ship |
	state := ShipState creation.

	state increaseBonus.
	state decreaseBonus.

	self assert: state bonusThrow equals: 0
]
