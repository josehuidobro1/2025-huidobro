Class {
	#name : 'FixedCardFactory',
	#superclass : 'CardFactory',
	#instVars : [
		'types',
		'index'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'accessing' }
FixedCardFactory class >> withTypes: cardsTypes [

	^ self new initializeWithTypes: cardsTypes
]

{ #category : 'generators' }
FixedCardFactory >> generateRandomCard [

	|  card |
	card := typesOfCards at: index.
	index := index \\ typesOfCards size + 1.
	^ card
]

{ #category : 'initialization' }
FixedCardFactory >> initializeWithTypes: cards [

	index := 1.
	typesOfCards := cards
]
