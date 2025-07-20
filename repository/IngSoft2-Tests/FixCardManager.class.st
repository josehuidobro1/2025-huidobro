Class {
	#name : 'FixCardManager',
	#superclass : 'CardManager',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
FixCardManager class >> withCards: cardToAdd [

	^ self new intializeWith: cardToAdd
]

{ #category : 'adding' }
FixCardManager >> addCardsToDeck: cards [

	deck addAll: cards
]

{ #category : 'as yet unclassified' }
FixCardManager >> drawCard [

	^ deck removeFirst
]

{ #category : 'as yet unclassified' }
FixCardManager >> intializeWith: cardsToAdd [

	deck := cardsToAdd.
	discardPile := OrderedCollection new.
	activeCards := OrderedCollection new
]

{ #category : 'as yet unclassified' }
FixCardManager >> playCard: aCardClass by: aShip target: aShip2 in: aGame [

	| aCard |
	aCard := aShip hasCard: aCardClass class.
	aCard ifNil: [ Error signal: 'Cannot play a card you do not have' ].

	(aCardClass isCancellationCard and: [
		 self activePermanentCards isEmpty ]) ifTrue: [
		self error:
			'Cannot play cancellation card with no active permanent cards' ].

	aCard applyTo: aShip using: aShip2 in: aGame.
	aShip removeCard: aCardClass.
	self registerCard: aCardClass
]
