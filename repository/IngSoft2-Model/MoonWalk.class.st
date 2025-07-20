Class {
	#name : 'MoonWalk',
	#superclass : 'Effect',
	#instVars : [
		'numberOfCells'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
MoonWalk class >> move: numberOfCells [

	numberOfCells <= 0 ifTrue: [
		Error signal: 'Amount of cells must be greater than zero' ].

	^ self new initializeWith: numberOfCells
]

{ #category : 'instance creation' }
MoonWalk class >> with: aAmountOfCells [

	^ self new initializeWith: aAmountOfCells
]

{ #category : 'playing' }
MoonWalk >> applyTo: aShip in: aGame [

	aGame applyMoonWalkEffectOn: aShip  moving: numberOfCells
]

{ #category : 'initialization' }
MoonWalk >> initializeThis [

	^ self
]

{ #category : 'initialization' }
MoonWalk >> initializeWith: cells [

	numberOfCells := cells
]

{ #category : 'accessing' }
MoonWalk >> numberOfCells [
	^ numberOfCells
]
