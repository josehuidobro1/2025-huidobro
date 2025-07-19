Class {
	#name : 'SpeedCard',
	#superclass : 'Card',
	#instVars : [
		'linkedShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
SpeedCard >> applyTo: aShip using: aShip2 in: aGame [

	linkedShip := aShip2.
	aShip2 increaseBonusThrow
]

{ #category : 'testing' }
SpeedCard >> isPermanent [

	^ true
]

{ #category : 'removing' }
SpeedCard >> removePermanentEffect [

	linkedShip decreaseBonusThrow
]
