Class {
	#name : 'CardManager',
	#superclass : 'Object',
	#instVars : [
		'deck',
		'activeCards',
		'discardPile'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
CardManager class >> creation [

	^ self new initialization
]

{ #category : 'as yet unclassified' }
CardManager >> activePermanentCards [

	^ discardPile select: [ :card | card isPermanent ]
]

{ #category : 'adding' }
CardManager >> addCardToDeck: aCard [

	deck add: aCard
]

{ #category : 'adding' }
CardManager >> addCardsToDeck: cards [

	deck addAll: cards
]

{ #category : 'as yet unclassified' }
CardManager >> cancelCard: aCard [

	| card |
	card := activeCards
		        detect: [ :c | c matches: aCard ]
		        ifNone: [
		        Error signal: 'No active card matches the one to cancel' ].
	card removePermanentEffect.
	activeCards remove: card
]

{ #category : 'accessing' }
CardManager >> deck [

	^ deck
]

{ #category : 'as yet unclassified' }
CardManager >> drawCard [

	self shuffleDeck.
	^ (deck at: 1).
]

{ #category : 'as yet unclassified' }
CardManager >> drawInitialCardsFor: aShip [

	| card |
	card := self drawCard.
	aShip receiveCard: card.
	card := self drawCard.
	aShip receiveCard: card
]

{ #category : 'as yet unclassified' }
CardManager >> ensureHasEnoughCardsForShips: shipCount [

	deck size >= (shipCount * 2) ifFalse: [
		Error signal: 'Not enough cards to give 2 to each ship.' ]
]

{ #category : 'testing' }
CardManager >> hasActiveCard: aCard [

	^ activeCards anySatisfy: [ :each | each matches: aCard ]
]

{ #category : 'initialization' }
CardManager >> initialization [

	deck := OrderedCollection new.
	discardPile :=OrderedCollection new.
	activeCards := OrderedCollection new.
]

{ #category : 'as yet unclassified' }
CardManager >> playCard: aCard by: aShip target: aShip2 in: aGame [

	(aCard isCancellationCard and: [ self activePermanentCards isEmpty ])
		ifTrue: [
			self error:
				'Cannot play cancellation card with no active permanent cards' ].

	aCard applyTo: aShip using: aShip2 in: aGame.
	self registerCard: aCard .
]

{ #category : 'as yet unclassified' }
CardManager >> registerCard: aCard [
	discardPile add:aCard.
    (aCard isPermanent )ifTrue:[ activeCards add: aCard ]
]

{ #category : 'as yet unclassified' }
CardManager >> shuffleDeck [

	deck := deck shuffled
]
