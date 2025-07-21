Class {
	#name : 'RepeatCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
RepeatCard >> applyTo: aShip using: aShip2 in: aGame [

	| effectToRepeat |
	effectToRepeat := aGame lastRealEffect.
	effectToRepeat applyTo: aShip2 in: aGame
]
