Class {
	#name : 'TurnStateTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
TurnStateTest >> test000WhenCreateTurnStateThenTurnsToSkipIsZero [

	| ship turnState |
	ship := Ship create: 'ship'.
	turnState := TurnState initializeWith: ship.
	self assert: turnState turnsToSkip equals: 0
]

{ #category : 'tests' }
TurnStateTest >> test001WhenTurnStateAskCanIPlayAndTurnToSkipAreZeroThenReturnTrue [

	| ship turnState |
	ship := Ship create: 'ship'.
	turnState := TurnState initializeWith: ship.
	self assert: turnState canIPlay
]

{ #category : 'tests' }
TurnStateTest >> test002WhenTurnStateAskCanIPlayAndTurnToSkipIsNotZeroThenReturnFalse [

	| ship turnState |
	ship := Ship create: 'ship'.
	turnState := TurnState initializeWith: ship.
	turnState increaseTurnsToSkip: 2.
	self deny: turnState canIPlay
]

{ #category : 'tests' }
TurnStateTest >> test003WhenIHaveTurnsToSkipAndChooseToNotPlayThenIHAveMoreTurnToSkip [

	| ship turnState |
	ship := Ship create: 'ship'.
	turnState := TurnState initializeWith: ship.
	turnState increaseTurnsToSkip: 2.
	turnState chooseToNotPlay.
	self assert: turnState turnsToSkip equals: 3.
]
