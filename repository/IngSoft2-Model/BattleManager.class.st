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

	^ result
]

{ #category : 'initialization' }
BattleManager >> initializeWith: aDiceBucket [

	diceBucket := aDiceBucket
]

{ #category : 'accessing' }
BattleManager >> resolveIfNeededAt: actualShip in: aGame [

	| shipsInSamePosition enemyShipIsMercenary actualShipIsMercenary |
	shipsInSamePosition := aGame ships select: [ :ship |
		                       ship ~~ actualShip and: [
			                       ship position = actualShip position and:
				                       ship laps = actualShip laps ] ].
	shipsInSamePosition do: [ :enemy |
		enemyShipIsMercenary := actualShip hasAsMercery: enemy.
		actualShipIsMercenary := enemy hasAsMercery: actualShip.
		(enemyShipIsMercenary or: [ actualShipIsMercenary ]) ifFalse: [
			self fightBetween: actualShip and: enemy ] ]
]
