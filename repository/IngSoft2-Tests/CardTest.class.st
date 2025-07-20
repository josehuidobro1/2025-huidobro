Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> test000WhenCreateSpeedCardThenShipSumOneInItThrow [

	| aDice dices aDiceBucket amountOfCells aWorm distributions aBoard ships aGame typesOfCards cards cardManager |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	ships := OrderedCollection new.
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	aBoard := aBoard := Board
		                    with: amountOfCells
		                    and: aWorm
		                    has: distributions
		                    basedOn: (Distance parsecs: 20).
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
		         until: 1
		         cardManager: cardManager.
	self assert: (aGame ships at: 1) cards size equals: 2
]

{ #category : 'tests' }
CardTest >> test001WhenUseSpeedCardFromDeckThenApplyItEffect [

	| aDice dices aDiceBucket ship fixedCardFactory distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard cards typesOfCards cardManager |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ships := OrderedCollection new.
	ships add: ship1.
	aCard := SpeedCard new.
	cards := OrderedCollection new.
	cards add: aCard.
	cards add: SpeedCard new.
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: aCard with: ship1.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) position equals: 8
]

{ #category : 'tests' }
CardTest >> test002WhenShipWantsToPlayThatItDoesNotHaveThenRaiseError [

	| aDice dices aDiceBucket distributions amountOfCells aWorm aBoard laps ship1 ships typesOfCards aGame aCard cardManager |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ships := OrderedCollection new.
	ships add: ship1.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: AccelerationCard new with: 0.5).
	distributions add: (Distribution at: RedoCard new with: 0.5).
	cardManager := CardManager
		               createAmountOf: 10
		               andDistribution: distributions.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aCard := SpeedCard new.

	self
		should: [ aGame shipNamed: ship1 useCard: aCard with: ship1 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'Cannot play a card you do not have' ]
]

{ #category : 'tests' }
CardTest >> test003WhenShipUseMercenaryCardWithShip2ThenTheyDoNotBattle [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards mercenary cardManager cards |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	mercenary := 'mercenary'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: mercenary.
	aCard := MercenaryCard new.
	cards := OrderedCollection new.
	cards add: aCard.
	5 timesRepeat: [cards add: SpeedCard new].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: aCard with: mercenary.
	aGame playTurn.
	aGame playTurn.
	self
		assert: (aGame findShipBy: ship1) shields
		equals: (aGame findShipBy: mercenary) shields
]

{ #category : 'tests' }
CardTest >> test004WhenAShipUseSpeedCardThenIsRemovedFromDeckOfShip [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards cardManager cards |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ships := OrderedCollection new.
	ships add: ship1.
	aCard := SpeedCard new.
	cards := OrderedCollection new.
	cards add: aCard.
	cards add: SpeedCard new.
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.

	aGame shipNamed: ship1 useCard: aCard with: ship1.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) cards size equals: 1
]

{ #category : 'tests' }
CardTest >> test005WhenShip1FightToShip3UsingShip2AsMErcenaryThenShip1WinTheBattle [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards ship2 ship3 cardManager cards |
	aDice := LoadedDice withSequence: #( 2 3 2 5 2 4 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ship3 := 'ship 3'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	aCard := MercenaryCard new.
	cards := OrderedCollection new.
	cards add: aCard.
	5 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: aCard with: ship2.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame findShipBy: ship3) shields equals: 2
]

{ #category : 'tests' }
CardTest >> test006WhenShip1FightToShip3UsingShip2AsMErcenaryAndShip3WonThenShip1AndShip2Loss1Shield [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards ship2 ship3 cardManager cards |
	aDice := LoadedDice withSequence: #( 1 3 1 7 2 4 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ship3 := 'ship 3'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	aCard := MercenaryCard new.
	cards := OrderedCollection new.
	cards add: aCard.
	6 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: aCard with: ship2.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self
		assert:
		(aGame findShipBy: ship2) shields
		+ (aGame findShipBy: ship1) shields
		equals: 4
]

{ #category : 'tests' }
CardTest >> test007WhenShip3AndShip1WanttheSameShipAsMercenaryThenRaiseError [

	| aDice dices aDiceBucket ship2 ship3 distributions amountOfCells aWorm aBoard laps ship1 ships typesOfCards aGame aCard cardManager aCard1 aCard2 cards |
	aDice := LoadedDice withSequence: #( 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 2 and: 4.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ship3 := 'ship 3'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	aCard1 := MercenaryCard new.
	aCard2 := MercenaryCard new.
	cards := OrderedCollection new.
	cards add: aCard1.
	3 timesRepeat: ([cards add: SpeedCard new]).
	cards add: aCard2.
	3 timesRepeat: (cards add: SpeedCard new).
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: aCard1 with: ship2.
	self
		should: [ aGame shipNamed: ship3 useCard: aCard2 with: ship2 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'You can not use this ship as a mercenary' ]
]

{ #category : 'tests' }
CardTest >> test008WhenUseAccelerationCardThenAllThrowsIncrementsBy1 [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards ship2 ship3 cardManager cards |
	aDice := LoadedDice withSequence: #( 1 2 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ship3 := 'ship 3'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	aCard := AccelerationCard new.
	cards := OrderedCollection new.
	cards add: aCard.
	6 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: aCard with: ship1.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) position equals: 3.
	self assert: (aGame findShipBy: ship2) position equals: 4.
	self assert: (aGame findShipBy: ship3) position equals: 5
]

{ #category : 'tests' }
CardTest >> test009WhenUseCancellationCardThenRemoveSpeedCard [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aSpeedCard aCancellationCard aFixedCardFactory cardManager cards |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ships := OrderedCollection new.
	ships add: ship1.
	aCancellationCard := CancellationCard newWithCard: SpeedCard new.
	aSpeedCard := SpeedCard new.
	cards := OrderedCollection new.
	cards add: aCancellationCard.
	cards add: aSpeedCard.
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: aSpeedCard with: ship1.
	aGame shipNamed: ship1 useCard: aCancellationCard with: ship1.
	aGame playTurn.

	self assert: (aGame findShipBy: ship1) position equals: 4
]

{ #category : 'tests' }
CardTest >> test010WhenUseCancellationCardWithAccelerationThenRemoveAcceleration [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aAccelerationCard aCancellationCard ship2 aFixedCardFactory cardManager accelerationCard cards |
	aDice := LoadedDice withSequence: #( 1 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	cards := OrderedCollection new.
	accelerationCard := AccelerationCard new.
	aCancellationCard := CancellationCard newWithCard:
		                     AccelerationCard new.
	cards add: accelerationCard.
	cards add: aCancellationCard.
	2 timesRepeat: ([cards add: AccelerationCard new]).
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: accelerationCard with: ship1.
	aGame playTurn.
	aGame shipNamed: ship1 useCard: aCancellationCard with: ship1.
	aGame playTurn.
	self assert: (aGame cardManager hasActiveCard: accelerationCard) not
]

{ #category : 'tests' }
CardTest >> test011WhenUseCancellationCardWithMercenaryThenRemoveMercenary [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aMercenaryCard aCancellationCard aFixedCardFactory ship2 ship3 cardManager mercenaryCard cards |
	aDice := LoadedDice withSequence: #( 1 3 1 5 2 4 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ship3 := 'ship 3'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	cards := OrderedCollection new.
	mercenaryCard := MercenaryCard new.
	aCancellationCard := CancellationCard newWithCard: mercenaryCard.
	cards add: mercenaryCard.
	cards add: AccelerationCard new.
	cards add: aCancellationCard.
	3 timesRepeat: ([cards add: AccelerationCard new]).
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: mercenaryCard with: ship3.
	aGame shipNamed: ship2 useCard: aCancellationCard with: ship1.
	self deny: ((aGame findShipBy: ship1) hasAsMercery: ship3)
]

{ #category : 'tests' }
CardTest >> test012WhenUseCancellationCardAndNoActiveCardsThenRaiseError [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aSpeedCard aCancellationCard cardManager cards |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ships := OrderedCollection new.
	ships add: ship1.
	aSpeedCard := SpeedCard new.
	aCancellationCard := CancellationCard newWithCard: SpeedCard.
	cards := OrderedCollection new.
	cards add: aSpeedCard.
	cards add: aCancellationCard.
	cardManager := FixCardManager withCards: cards.

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	self
		should: [
		aGame shipNamed: ship1 useCard: aCancellationCard with: ship1 ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals:
				'Cannot play cancellation card with no active permanent cards' ]
]

{ #category : 'tests' }
CardTest >> test013WhenUseREDOCardThenItTakesTheEffectOfTheLastCardUsed [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard cardManager cards |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	acceleration := AccelerationCard new.
	redocard := RedoCard new.
	cards := OrderedCollection new.
	cards add: acceleration.
	cards add: redocard.
	2 timesRepeat: (cards add: SpeedCard new).
	cardManager := FixCardManager withCards: cards.

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame playTurn.
	aGame shipNamed: ship1 useCard: acceleration with: ship1.
	aGame playTurn.
	aGame shipNamed: ship1 useCard: redocard with: ship1.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) position equals: 9
]

{ #category : 'tests' }
CardTest >> test014WhenUseRepeatCardBeforePlayingThenItDoesNotApplyTheLastEffectOnGame [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager cards |
	aDice := LoadedDice withSequence: #( 3 5 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	repeatcard := RepeatCard new.
	cards := OrderedCollection new.
	cards add: AccelerationCard new.
	cards add: repeatcard.
	2 timesRepeat: ([cards add: SpeedCard new]).
	cardManager := FixCardManager withCards: cards.

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: repeatcard with: ship2.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame findShipBy: ship2) position equals: 2
]

{ #category : 'tests' }
CardTest >> test015WhenUseRepeatCardThenItApplyTheLastEffectOnGame [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager cards |
	aDice := LoadedDice withSequence: #( 3 7 1 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: BlackHole with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	cards := OrderedCollection new.
	cards add: AccelerationCard new.
	repeatcard := RepeatCard new.
	cards add: repeatcard.
	4 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame playTurn.
	aGame playTurn.
	aGame shipNamed: ship1 useCard: repeatcard with: ship2.
	self assert: (aGame findShipBy: ship2) position equals: 1
]

{ #category : 'tests' }
CardTest >> test016WhenUseRepeatCardButThereIsNoEffectThenItDoesNotApplyTheLastEffectOnGame [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager cards |
	aDice := LoadedDice withSequence: #( 3 7 1 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	cards := OrderedCollection new.
	cards add: AccelerationCard new.
	repeatcard := RepeatCard new.
	cards add: repeatcard.
	2 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame playTurn.
	aGame playTurn.
	aGame shipNamed: ship1 useCard: repeatcard with: ship2.
	self assert: (aGame findShipBy: ship2) position equals: 8
]

{ #category : 'tests' }
CardTest >> test017WhenTheShipMovesThrowTheBoardAndITACrdGiverCellThenShipRecieveOneCard [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager cards |
	aDice := LoadedDice withSequence: #( 3 7 1 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: CardGiver with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	cards := OrderedCollection new.
	cards add: AccelerationCard new.
	cards add: repeatcard.
	5 timesRepeat: ([cards add: SpeedCard new]).
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) cards size equals: 3
]

{ #category : 'tests' }
CardTest >> test018WhenShipUseRepeatCardAndLastEffectWasaCardGiverThenItDoesNotReceiveTheCard [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager cards |
	aDice := LoadedDice withSequence: #( 3 7 1 6 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: CardGiver with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	repeatcard := RepeatCard new.
	cards := OrderedCollection new.
	cards add: AccelerationCard new.
	cards add: repeatcard.
	6 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame playTurn.
	aGame shipNamed: ship1 useCard: repeatcard with: ship2.
	self assert: (aGame findShipBy: ship2) cards size equals: 2
]

{ #category : 'tests' }
CardTest >> test019WhenShipFightToAnotherShipButHasBonusThrowThenItCanWin [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard cards |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	cards := OrderedCollection new.
	speedCard := SpeedCard new.
	3 timesRepeat: ([cards add: SpeedCard new]).
	cards add: speedCard.
	3 timesRepeat: ([cards add: SpeedCard new]).
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame playTurn.
	aGame shipNamed: ship2 useCard: speedCard with: ship1.
	aGame playTurn.
	self assert: (aGame findShipBy: ship2) shields equals: 2
]

{ #category : 'tests' }
CardTest >> test020WhenCreateCardManagerThenDeckHasCaRdLessThanTheCardsTheShipsReceive [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: SpeedCard new with: 0.5).
	distributions add: (Distribution at: RedoCard new with: 0.5).
	cardManager := CardManager
		               createAmountOf: 10
		               andDistribution: distributions.

	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	self assert: aGame cardManager deck size equals: (10 - (ships size * 2))
]

{ #category : 'tests' }
CardTest >> test021WhenCardManagerIsCreatedThenCardTypesAreDistributedAccordingToProbability [

	| initialDeckSize cardDistributions cardManager speedCardCount mercenaryCardCount accelerationCardCount cancellationCardCount redoCardCount repeatCardCount totalCards tolerance |
	initialDeckSize := 1000.
	cardDistributions := OrderedCollection new.
	cardDistributions add: (Distribution at: SpeedCard with: 0.10).
	cardDistributions add: (Distribution at: MercenaryCard with: 0.20).
	cardDistributions add: (Distribution at: AccelerationCard with: 0.20).
	cardDistributions add: (Distribution at: CancellationCard with: 0.30).
	cardDistributions add: (Distribution at: RedoCard with: 0.10).
	cardDistributions add: (Distribution at: RepeatCard with: 0.10).
	cardManager := CardManager
		               createAmountOf: initialDeckSize
		               andDistribution: cardDistributions.
	speedCardCount := cardManager deck count: [ :card |
		                  card isKindOf: SpeedCard ].
	mercenaryCardCount := cardManager deck count: [ :card |
		                      card isKindOf: MercenaryCard ].
	accelerationCardCount := cardManager deck count: [ :card |
		                         card isKindOf: AccelerationCard ].
	cancellationCardCount := cardManager deck count: [ :card |
		                         card isKindOf: CancellationCard ].
	redoCardCount := cardManager deck count: [ :card |
		                 card isKindOf: RedoCard ].
	repeatCardCount := cardManager deck count: [ :card |
		                   card isKindOf: RepeatCard ].
	totalCards := cardManager deck size.
	tolerance := 0.20.
	self assert:
		speedCardCount asFloat / totalCards >= (0.10 - tolerance).
	self assert:
		speedCardCount asFloat / totalCards <= (0.10 + tolerance).
	self assert:
		mercenaryCardCount asFloat / totalCards >= (0.10 - tolerance).
	self assert:
		mercenaryCardCount asFloat / totalCards <= (0.10 + tolerance).
	self assert:
		accelerationCardCount asFloat / totalCards >= (0.20 - tolerance).
	self assert:
		accelerationCardCount asFloat / totalCards <= (0.20 + tolerance).
	self assert:
		cancellationCardCount asFloat / totalCards >= (0.20 - tolerance).
	self assert:
		cancellationCardCount asFloat / totalCards <= (0.20 + tolerance).
	self assert: redoCardCount asFloat / totalCards >= (0.10 - tolerance).
	self assert: redoCardCount asFloat / totalCards <= (0.10 + tolerance).
	self assert:
		repeatCardCount asFloat / totalCards >= (0.10 - tolerance).
	self assert:
		repeatCardCount asFloat / totalCards <= (0.10 + tolerance).
	self
		assert: speedCardCount + mercenaryCardCount + accelerationCardCount
			+ cancellationCardCount + redoCardCount + repeatCardCount
		equals: totalCards
]

{ #category : 'tests' }
CardTest >> test022WhenUseACardThenDiscardPileIncrease [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: SpeedCard new with: 1).
	cardManager := CardManager
		               createAmountOf: 10
		               andDistribution: distributions.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: SpeedCard with: ship2.
	self assert: aGame cardManager discardPile size equals: 1
]

{ #category : 'tests' }
CardTest >> test023WhenItUsedAlCardsDeckThenTheDiscardPileShuffledAndCreateTheDeckAgain [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: CardGiver with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: SpeedCard new with: 1).
	cardManager := CardManager
		               createAmountOf: 4
		               andDistribution: distributions.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: SpeedCard with: ship2.
	aGame shipNamed: ship1 useCard: SpeedCard with: ship2.
	aGame shipNamed: ship2 useCard: SpeedCard with: ship1.
	aGame shipNamed: ship2 useCard: SpeedCard with: ship1.
	aGame playTurn.
	self assert: aGame cardManager deck size equals: 3
]

{ #category : 'tests' }
CardTest >> test024WhenItUsedAlCardsDeckAndThereIsNoCardsInDeckAndAskForCardCardInDeckThenRaiseError [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: CardGiver with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: SpeedCard new with: 1).
	cardManager := CardManager
		               createAmountOf: 4
		               andDistribution: distributions.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	self
		should: [ aGame playTurn ]
		raise: Error
		withExceptionDo: [ :error |
			self
				assert: error messageText
				equals: 'No cards available to draw and discard pile is empty' ]
]

{ #category : 'tests' }
CardTest >> test025WhenShipUseDoubleCardThenItDuplicateTheThrowInTheBattle [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard cards doubleCard |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: CardGiver with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	cards := OrderedCollection new.
	doubleCard := DoubleCard new.
	cards add: doubleCard.
	5 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: doubleCard with: ship2.
	self assert: (aGame findShipBy: ship2) hasDoubleThrow
]

{ #category : 'tests' }
CardTest >> test027WhenShipUseDoubleCardAndFightThenItDuplicateTheThrowInTheBattle [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard cards doubleCard |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: CardGiver with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	cards := OrderedCollection new.
	doubleCard := DoubleCard new.
	cards add: doubleCard.
	5 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: doubleCard with: ship2.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) shields equals: 2.
	self assert: (aGame findShipBy: ship2) shields equals: 3
]

{ #category : 'tests' }
CardTest >> test028WhenShipUseDoubleCardAndFightThenTheEffectIsConsumed [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard cards doubleCard |
	aDice := LoadedDice withSequence: #( 3 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: CardGiver with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	cards := OrderedCollection new.
	doubleCard := DoubleCard new.
	cards add: doubleCard.
	5 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: doubleCard with: ship2.
	aGame playTurn.
	aGame playTurn.
	self deny: (aGame findShipBy: ship2) hasDoubleThrow
]

{ #category : 'tests' }
CardTest >> test029WhenShipFightButHasMercenaryShipAndThisOneHasDoubleThrowThenAplyToTheBattle [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard cards doubleCard ship3 mercenaryCard result |
	aDice := LoadedDice withSequence: #( 3 2 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ship3 := 'ship 3'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	cards := OrderedCollection new.
	mercenaryCard := MercenaryCard new.
	doubleCard := DoubleCard new.
	cards add: doubleCard.
	cards add: mercenaryCard.
	5 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: doubleCard with: ship3.
	aGame shipNamed: ship1 useCard: mercenaryCard with: ship3.
	result:=(aGame findShipBy: ship1) throwDicesWith: aDiceBucket .
	self assert: result equals: 7.
]

{ #category : 'tests' }
CardTest >> test030WhenShipFightButHasMercenaryShipAndThisOneHasDoubleThrowThenAplyToTheBattle [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager speedCard cards doubleCard ship3 mercenaryCard result defend |
	aDice := LoadedDice withSequence: #( 3 3 1 4 ).
	dices := OrderedCollection new.
	dices add: aDice.
	aDiceBucket := DiceBucket with: dices.
	distributions := OrderedCollection new.
	distributions add: (Distribution at: NoEffect with: 1).
	amountOfCells := 10.
	aWorm := Worm with: 9 and: 10.
	aBoard := Board
		          with: amountOfCells
		          and: aWorm
		          has: distributions
		          basedOn: (Distance parsecs: 20).
	laps := 1.
	ship1 := 'ship 1'.
	ship2 := 'ship 2'.
	ship3 := 'ship 3'.
	ships := OrderedCollection new.
	ships add: ship1.
	ships add: ship2.
	ships add: ship3.
	cards := OrderedCollection new.
	defend := DefendCard new.
	cards add: defend.
	5 timesRepeat: [ cards add: SpeedCard new ].
	cardManager := FixCardManager withCards: cards.
	aGame := Game
		         with: aBoard
		         using: aDiceBucket
		         andShipsNamed: ships
		         until: 1
		         cardManager: cardManager.
	aGame shipNamed: ship1 useCard: defend with: ship2.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame findShipBy: ship1) shields equals: 3.
	self assert: (aGame findShipBy: ship2) shields equals: 3
]
