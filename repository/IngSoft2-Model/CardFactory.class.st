Class {
	#name : 'CardFactory',
	#superclass : 'Object',
	#instVars : [
		'cards',
		'givenCards',
		'typesOfCards',
		'random'
	],
	#classInstVars : [
		'cards'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
CardFactory class >> withTypes: cardsTypes [

	^ self new initializeWithTypesOfCards: cardsTypes
]

{ #category : 'generators' }
CardFactory >> generateInitialCards [

	| initialCards |
	initialCards := OrderedCollection new.
	initialCards add: self generateRandomCard.
	initialCards add: self generateRandomCard.
	^ initialCards
]

{ #category : 'generators' }
CardFactory >> generateRandomCard [

	| card index |
	index := random nextIntegerBetween: 1 and: typesOfCards size.
	card := (typesOfCards at: index).
	^ card
]

{ #category : 'generators' }
CardFactory >> generateRandomCardOn: aShip [

	aShip receiveThis: self generateRandomCard.
]

{ #category : 'initialization' }
CardFactory >> initializeWithTypesOfCards: cardTypes [

	typesOfCards := cardTypes.
	random := Random new
]
