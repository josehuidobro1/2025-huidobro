Class {
	#name : 'FixCardManager',
	#superclass : 'CardManager',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'adding' }
FixCardManager >> addCardsToDeck: cards [

	deck addAll: cards
]

{ #category : 'as yet unclassified' }
FixCardManager >> drawCard [

	^ deck removeFirst
]
