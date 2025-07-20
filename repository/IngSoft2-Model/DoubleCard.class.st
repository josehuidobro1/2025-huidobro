Class {
	#name : 'DoubleCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
DoubleCard >> applyTo: aShip using: aShip2 in: aGame [

	aShip2 activateDoubleEffect
]
