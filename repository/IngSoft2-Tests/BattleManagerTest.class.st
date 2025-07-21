Class {
	#name : 'BattleManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BattleManagerTest >> test001WhenTwoShipsFightAndShip2WinsThenShip1LoseBatle [

	| ships dices1 aDice1 aDiceBucket1 amountOfCells ship1 ship2 battleManager |
	ships := OrderedCollection new.
	dices1 := OrderedCollection new.
	aDice1 := LoadedDice withSequence: #( 6 9 ).
	dices1 add: aDice1.
	aDiceBucket1 := DiceBucket with: dices1.
	amountOfCells := 10.
	ship1 := Ship create: 'ship 1'.
	ship2 := Ship create: 'ship 2'.
	battleManager := BattleManager with: aDiceBucket1.
	battleManager fightBetween: ship1 and: ship2.
	self assert: ship1 position equals: 1
]

{ #category : 'tests' }
BattleManagerTest >> test002WhenBatleStartThenIrFinishedWhenSomeResultIsDifferent [

	| ships dices1 aDice1 aDiceBucket1 amountOfCells ship1 ship2 battleManager |
	ships := OrderedCollection new.
	dices1 := OrderedCollection new.
	aDice1 := LoadedDice withSequence: #( 6 6 6 6 6 9 ).
	dices1 add: aDice1.
	aDiceBucket1 := DiceBucket with: dices1.
	amountOfCells := 10.
	ship1 := Ship create: 'ship 1'.
	ship2 := Ship create: 'ship 2'.
	battleManager := BattleManager with: aDiceBucket1.
	battleManager fightBetween: ship1 and: ship2.
	self assert: ship1 shields equals: 2.
	self assert: ship2 shields equals: 3
]

{ #category : 'tests' }
BattleManagerTest >> test003WhenBatleResolveIfNeedIFTwoShipsInSamePositionThenTheyFight [

	| ships dices1 aDice1 aDiceBucket1 amountOfCells ship1 ship2 battleManager dices aDice aDiceBucket aWorm distributions aBoard laps cardManager aGame |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 2 5  ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    until: 1
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
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
	battleManager := BattleManager with: aDiceBucket.
	battleManager
		resolveIfNeededAt: (aGame findShipBy: 'ship 2')
		in: aGame.
	self assert: (aGame findShipBy: 'ship 1') shields equals: 3.
	self assert: (aGame findShipBy: 'ship 2') shields equals: 2
]

{ #category : 'tests' }
BattleManagerTest >> test004WhenBatleResolveIfNeedIFTwoShipsInDifferentPositionThenTheyDoNotFight [

	| ships dices1 aDice1 aDiceBucket1 amountOfCells ship1 ship2 battleManager dices aDice aDiceBucket aWorm distributions aBoard laps cardManager aGame |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 2 3 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    until: 1
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
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
	battleManager := BattleManager with: aDiceBucket.
	battleManager
		resolveIfNeededAt: (aGame findShipBy: 'ship 2')
		in: aGame.
	self assert: (aGame findShipBy: 'ship 1') shields equals: 3.
	self assert: (aGame findShipBy: 'ship 2') shields equals: 3
]

{ #category : 'tests' }
BattleManagerTest >> test005WhenBatleResolveIfNeedIFTwoShipsInSamePositionButOneIsMercenaryOfTheAnotherThenTheyDoNotFight [

	| ships dices1 aDice1 aDiceBucket1 amountOfCells ship1 ship2 battleManager dices aDice aDiceBucket aWorm distributions aBoard laps cardManager aGame cards mercenaryCard |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 3 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    until: 1
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	cards := OrderedCollection new.
	mercenaryCard := MercenaryCard new.
	cards add: mercenaryCard.
	5 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         cardManager: cardManager.
	aGame shipNamed: 'ship 1' useCard: mercenaryCard with: 'ship 2'.
	battleManager := BattleManager with: aDiceBucket.
	battleManager
		resolveIfNeededAt: (aGame findShipBy: 'ship 2')
		in: aGame.
	self assert: (aGame findShipBy: 'ship 1') shields equals: 3.
	self assert: (aGame findShipBy: 'ship 2') shields equals: 3
]

{ #category : 'tests' }
BattleManagerTest >> test006WhenGetShipPointsWithMercenaryThenReceiveTheSumOfTheTwoShips [

	| ships dices1 aDice1 aDiceBucket1 amountOfCells ship1 ship2 battleManager dices aDice aDiceBucket aWorm distributions aBoard laps cardManager aGame cards mercenaryCard result |
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	aDice := LoadedDice withSequence: #( 3 5 ).
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    until: 1
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
	laps := 3.
	ships add: 'ship 1'.
	ships add: 'ship 2'.
	cards := OrderedCollection new.
	mercenaryCard := MercenaryCard new.
	cards add: mercenaryCard.
	5 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         cardManager: cardManager.
	aGame shipNamed: 'ship 1' useCard: mercenaryCard with: 'ship 2'.
	battleManager := BattleManager with: aDiceBucket.
	result := battleManager getShipPoints: (aGame findShipBy: 'ship 1').
	self assert: result equals: 8
]
