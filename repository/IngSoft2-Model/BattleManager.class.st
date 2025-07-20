Class {
	#name : 'BattleManager',
	#superclass : 'Object',
	#instVars : [
		'diceBucket'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
BattleManager class >> with: aDiceBucket [

	^ self new initializeWith: aDiceBucket
]

{ #category : 'playing' }
BattleManager >> fightBetween: shipA and: shipB [

	| resultA resultB |
	[
	resultA := self getShipPoints: shipA.
	resultB := self getShipPoints: shipB.
	resultA = resultB ] whileTrue.

	resultA > resultB
		ifTrue: [ shipB loseFight ]
		ifFalse: [ shipA loseFight ]
]

{ #category : 'as yet unclassified' }
BattleManager >> getShipPoints: ship [

	| result |
	result := ship throwDicesWith: diceBucket.
	ship hasDoubleThrow ifTrue: [
		result := result * 2.
		ship usedDoubleEffect ].
	^ result
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
		((actualShip hasAsMercery: enemy ) or: [
			 enemy hasAsMercery: actualShip ]) ifFalse: [
			self fightBetween: actualShip and: enemy ] ]
]
