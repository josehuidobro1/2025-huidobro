Class {
	#name : 'CancellationCard',
	#superclass : 'Card',
	#instVars : [
		'chosenCard'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
CancellationCard class >> newWithCard: aChosenCard [

	^ self new initializeWith: aChosenCard
]

{ #category : 'playing' }
CancellationCard >> applyTo: aShip using: aTargetShip in: aGame [
    | cardManager |
    cardManager := aGame cardManager.
    
    (cardManager hasActiveCard: chosenCard) ifFalse: [
        Error signal: 'The selected card is not currently active'
    ].

    cardManager cancelCard: chosenCard.

]

{ #category : 'playing' }
CancellationCard >> chosenCard [

	^ chosenCard
]

{ #category : 'initialization' }
CancellationCard >> initializeWith:aChosenCard [
	chosenCard := aChosenCard .
]

{ #category : 'testing' }
CancellationCard >> isCancellationCard [

	^ true
]
