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

{ #category : 'as yet unclassified' }
CardManager class >> createAmountOf: amountOfCards andDistribution: distributions [

	^ self new
		  intializeWith: amountOfCards
		  andDistribution: distributions
]

{ #category : 'as yet unclassified' }
CardManager >> activePermanentCards [

	^ activeCards
]

{ #category : 'as yet unclassified' }
CardManager >> applyRedoEffectOn: aShip in: aGame [

	| realCard |
    discardPile isEmpty ifTrue: [
        ^ Error signal: 'There are no cards played before.'
    ].
    realCard := discardPile reversed
        detect: [ :card | card isRedo not ]
        ifNone: [ ^ Error signal: 'No real card to redo.' ].

    realCard applyTo: aShip using: aShip in: aGame.
]

{ #category : 'as yet unclassified' }
CardManager >> applyTo: aShip using: aShip2 in: aGame [

	| realCard |
    discardPile isEmpty ifTrue: [
        ^ Error signal: 'There are no cards played before.'
    ].
    realCard := discardPile reversed
        detect: [ :card | card isRedo not ]
        ifNone: [ ^ Error signal: 'No real card to redo.' ].

    realCard applyTo: aShip using: aShip in: aGame.
]

{ #category : 'as yet unclassified' }
CardManager >> cancelCard: aCard [

	| card |
	card := activeCards
		        detect: [ :c | c matches: aCard class ]
		        ifNone: [
		        Error signal: 'No active card matches the one to cancel' ].
	card removePermanentEffect.
	activeCards remove: card
]

{ #category : 'accessing' }
CardManager >> deck [

	^ deck
]

{ #category : 'accessing' }
CardManager >> discardPile [

	^ discardPile
]

{ #category : 'as yet unclassified' }
CardManager >> drawCard [

	| card |
	deck isEmpty ifTrue: [ self reshuffleDiscardPileIntoDeck ].
	card := deck removeFirst.
	^ card
]

{ #category : 'as yet unclassified' }
CardManager >> drawCardOn: aShip [

	| card |
	card := self drawCard.
	aShip receiveCard: card
]

{ #category : 'as yet unclassified' }
CardManager >> drawInitialCardsFor: aShip [

	| card |
	self drawCardOn: aShip.
	self drawCardOn: aShip
]

{ #category : 'testing' }
CardManager >> hasActiveCard: aCard [

	^ activeCards anySatisfy: [ :each | each matches: aCard class ]
]

{ #category : 'as yet unclassified' }
CardManager >> intializeWith: amountOfCards andDistribution: distributions [

	| aDistributor |
	aDistributor := Distributor
		                withDistribution: distributions
		                on: amountOfCards.
	deck := aDistributor recieveAmountOfItems.
	discardPile := OrderedCollection new.
	activeCards := OrderedCollection new
]

{ #category : 'testing' }
CardManager >> isValidMercenary: aShip in: ships [

	^ ships noneSatisfy: [ :ship | ship hasAsMercery: aShip ]
]

{ #category : 'as yet unclassified' }
CardManager >> playCard: aCardClass by: aShip target: aShip2 in: aGame [

	| aCard |
	aCard := aShip hasCard: aCardClass.
	aCard ifNil: [ Error signal: 'Cannot play a card you do not have' ].

	(aCard isCancellationCard and: [ self activePermanentCards isEmpty ])
		ifTrue: [
			self error:
				'Cannot play cancellation card with no active permanent cards' ].

	aCard applyTo: aShip using: aShip2 in: aGame.
	aShip removeCard: aCard.
	self registerCard: aCard
]

{ #category : 'as yet unclassified' }
CardManager >> registerCard: aCard [
	discardPile add:aCard.
    (aCard isPermanent )ifTrue:[ activeCards add: aCard ]
]

{ #category : 'as yet unclassified' }
CardManager >> reshuffleDiscardPileIntoDeck [

	| shuffledCards |
	discardPile isEmpty ifTrue: [
		Error signal: 'No cards available to draw and discard pile is empty' ].
	shuffledCards := discardPile shuffled.
	deck addAll: shuffledCards.
	discardPile := OrderedCollection new
]
