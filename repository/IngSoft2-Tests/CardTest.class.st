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
	cardManager := CardManager creation.
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
	cardManager := FixCardManager creation.
	cardManager addCardsToDeck: {
			aCard.
			SpeedCard new }.
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
	cardManager := FixCardManager creation.
	cardManager addCardsToDeck: {
			MercenaryCard new.
			AccelerationCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards mercenary cardManager |
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
	cardManager := FixCardManager creation.
	cardManager addCardsToDeck: {
			aCard.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards cardManager |
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
	cardManager := FixCardManager creation.
	cardManager addCardsToDeck: { aCard. SpeedCard new. }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards ship2 ship3 cardManager |
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
	cardManager := FixCardManager creation.
	cardManager addCardsToDeck: {
			aCard.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards ship2 ship3 cardManager |
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
	cardManager := FixCardManager creation.
	cardManager addCardsToDeck: {
			aCard.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket ship2 ship3 distributions amountOfCells aWorm aBoard laps ship1 ships typesOfCards aGame aCard cardManager aCard1 aCard2 |
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
	cardManager := FixCardManager creation.
	cardManager addCardsToDeck: {
			aCard1.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			aCard2.
			SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame aCard typesOfCards ship2 ship3 cardManager |
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
	cardManager := FixCardManager creation.
	cardManager addCardsToDeck: {
			aCard.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aSpeedCard aCancellationCard aFixedCardFactory cardManager |
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
	cardManager := FixCardManager creation.
	aSpeedCard := SpeedCard new.
	cardManager addCardsToDeck: {
			aSpeedCard.
			aCancellationCard }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aAccelerationCard aCancellationCard ship2 aFixedCardFactory cardManager accelerationCard |
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
	cardManager := FixCardManager creation.
	accelerationCard:= AccelerationCard new.
	cardManager := FixCardManager creation.
	aCancellationCard :=CancellationCard newWithCard:
		                     AccelerationCard new.
	cardManager addCardsToDeck: {accelerationCard. aCancellationCard. AccelerationCard new. AccelerationCard new.}.	
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
	self assert:  (aGame cardManager hasActiveCard: accelerationCard) not.
]

{ #category : 'tests' }
CardTest >> test011WhenUseCancellationCardWithMercenaryThenRemoveMercenary [

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aMercenaryCard aCancellationCard aFixedCardFactory ship2 ship3 cardManager mercenaryCard |
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
	cardManager := FixCardManager creation.
	mercenaryCard := MercenaryCard new.
	aCancellationCard := CancellationCard newWithCard: mercenaryCard.
	cardManager addCardsToDeck: {
			mercenaryCard.
			AccelerationCard new.
			aCancellationCard.
			AccelerationCard new.
			AccelerationCard new.
			AccelerationCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards aSpeedCard aCancellationCard cardManager |
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
	cardManager := FixCardManager creation.
	aSpeedCard := SpeedCard new.
	aCancellationCard := CancellationCard newWithCard: SpeedCard.
	cardManager addCardsToDeck: {
			aSpeedCard.
			aCancellationCard }.

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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard cardManager |
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
	cardManager := FixCardManager creation.
	acceleration := AccelerationCard new.
	redocard := RedoCard new.
	cardManager addCardsToDeck: {
			acceleration.
			redocard.
			SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager |
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
	cardManager := FixCardManager creation.
	repeatcard := RepeatCard new.
	cardManager addCardsToDeck: {
			AccelerationCard new.
			repeatcard.
			SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager |
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
	cardManager := FixCardManager creation.
	repeatcard := RepeatCard new.
	cardManager addCardsToDeck: {
			AccelerationCard new.
			repeatcard.
			SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager |
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
	cardManager := FixCardManager creation.
	repeatcard := RepeatCard new.
	cardManager addCardsToDeck: {
			AccelerationCard new.
			repeatcard.
			SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager |
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
	cardManager := FixCardManager creation.
	repeatcard := RepeatCard new.
	cardManager addCardsToDeck: {
			repeatcard.
			AccelerationCard new.
			SpeedCard new.
			SpeedCard new . SpeedCard new.
			SpeedCard new }.
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

	| aDice dices aDiceBucket distributions aBoard amountOfCells aWorm laps ship1 ships aGame typesOfCards ship2 acceleration redocard repeatcard cardManager |
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
	cardManager := FixCardManager creation.
	repeatcard := RepeatCard new.
	cardManager addCardsToDeck: {
			repeatcard.
			RedoCard new.
			SpeedCard new.
			SpeedCard new. SpeedCard new.
			SpeedCard new  }.
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
	cardManager := FixCardManager creation.
	speedCard := SpeedCard new.
	cardManager addCardsToDeck: {
			RedoCard new.
			SpeedCard new.
			speedCard.
			SpeedCard new.
			SpeedCard new }.
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
