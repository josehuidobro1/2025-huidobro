Class {
	#name : 'CancellationCard',
	#superclass : 'InstantCard',
	#instVars : [
		'chosenCard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CancellationCard class >> newWithCard: aChosenCardClass [

	^ self new initializeWith:aChosenCardClass.
]

{ #category : 'playing' }
CancellationCard >> applyTo: aShip using: aShip2 in: aGame [ 
	aGame permanentCardsPlayed ifEmpty: [Error signal: 'This card must be played when there is at least one active card']. 
	aGame applyCancellationCardEffectOn: chosenCard.
]

{ #category : 'playing' }
CancellationCard >> chosenCard [

	^ chosenCard
]

{ #category : 'initialization' }
CancellationCard >> initializeWith:aChosenCardClass [
	chosenCard := aChosenCardClass .
]
