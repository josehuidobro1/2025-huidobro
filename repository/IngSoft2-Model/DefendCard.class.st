Class {
	#name : 'DefendCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
DefendCard >> applyTo: aShip using: aShip2 in: aGame [

	aShip2 increaseAShield
]
