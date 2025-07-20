Class {
	#name : 'TurnState',
	#superclass : 'Object',
	#instVars : [
		'turnsToSkip',
		'optionalTurn',
		'ship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
TurnState class >> initializeWith: aShip [

	^ self new initializeWith: aShip
]

{ #category : 'testing' }
TurnState >> canIPlay [

	^ turnsToSkip = 0
]

{ #category : 'as yet unclassified' }
TurnState >> chooseToNotPlay [

	turnsToSkip := turnsToSkip + 1
]

{ #category : 'as yet unclassified' }
TurnState >> increaseTurnsToSkip: amountOfTurns [

	turnsToSkip := turnsToSkip + amountOfTurns
]

{ #category : 'initialization' }
TurnState >> initializeWith: aShip [

	ship := aShip.
	turnsToSkip := 0.
	optionalTurn := true
]

{ #category : 'accessing' }
TurnState >> optionalTurn [

	^ optionalTurn
]

{ #category : 'as yet unclassified' }
TurnState >> reduceTurnsToSkip [

	turnsToSkip := turnsToSkip - 1.
	turnsToSkip = 0 ifTrue: [ ship recoverShields ]
]

{ #category : 'accessing' }
TurnState >> turnsToSkip [

	^ turnsToSkip
]
