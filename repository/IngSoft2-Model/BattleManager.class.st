Class {
	#name : 'BattleManager',
	#superclass : 'Object',
	#instVars : [
		'diceBucket'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BattleManager class >> fightBetween: shipA and: shipB [

	| resultA resultB |
	[
	resultA := shipA throwDices.
	resultB := shipB throwDices.
	resultA = resultB ] whileTrue.

	resultA > resultB
		ifTrue: [ shipB loseFight ]
		ifFalse: [ shipA loseFight ]
]

{ #category : 'instance creation' }
BattleManager class >> with: aDiceBucket [

	^ self new initializeWith: aDiceBucket
]

{ #category : 'playing' }
BattleManager >> fightBetween: shipA and: shipB [

	| resultA resultB |
	[
	resultA := shipA throwDicesWith: diceBucket.
	resultB := shipB throwDicesWith: diceBucket.
	resultA = resultB ] whileTrue.

	resultA > resultB
		ifTrue: [ shipB loseFight ]
		ifFalse: [ shipA loseFight ]
]

{ #category : 'initialization' }
BattleManager >> initializeWith: aDiceBucket [

	diceBucket := aDiceBucket
]

{ #category : 'accessing' }
BattleManager >> resolveIfNeededAt: actualShip in: aGame [

	| shipsInSamePosition |
	shipsInSamePosition := (aGame ships) select: [ :ship |
		                       ship ~~ actualShip and: [
			                       ship position = actualShip position and:
				                       ship laps = actualShip laps ] ].
	shipsInSamePosition do: [ :enemy |
		((actualShip hasAsMercery: enemy name) or: [
			 enemy hasAsMercery: actualShip name ]) ifFalse: [
			self fightBetween: actualShip and: enemy ] ]
]
