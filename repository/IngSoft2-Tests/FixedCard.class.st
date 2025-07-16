Class {
	#name : 'FixedCard',
	#superclass : 'Card',
	#instVars : [
		'card'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
FixedCard class >> withTypeOfCard: aCard [

	^ aCard 
]

{ #category : 'generators' }
FixedCard >> generateRandomCard [

	^ card
]

{ #category : 'initialization' }
FixedCard >> initializeWithA: aCard [

	card := aCard
]
