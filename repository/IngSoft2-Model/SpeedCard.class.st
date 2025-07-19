Class {
	#name : 'SpeedCard',
	#superclass : 'Card',
	#instVars : [
		'linkedShip'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
SpeedCard class >> applyTo: aShip [

	aShip increaseBonusThrow
]

{ #category : 'playing' }
SpeedCard >> applyTo: aShip using: aShip2 in: aGame [

	linkedShip := aShip.
	aShip increaseBonusThrow
]

{ #category : 'testing' }
SpeedCard >> isPermanent [

	^ true
]

{ #category : 'removing' }
SpeedCard >> removePermanentEffect [

	linkedShip decreaseBonusThrow
]
