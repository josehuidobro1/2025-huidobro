Class {
	#name : 'FixCardManager',
	#superclass : 'CardManager',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
FixCardManager >> drawCard [

	^ deck removeFirst
]
