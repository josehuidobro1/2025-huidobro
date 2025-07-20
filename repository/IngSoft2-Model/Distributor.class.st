Class {
	#name : 'Distributor',
	#superclass : 'Object',
	#instVars : [
		'distribution',
		'cells',
		'amount',
		'defaultItem'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Distributor class >> withDistribution: aDistribution on: aAmount [

	^ self new initializeWith: aDistribution and: aAmount
]

{ #category : 'as yet unclassified' }
Distributor class >> withDistribution: aDistribution on: amountOfCells andDefaultItem: defaultClass [

	^ self new
		  initializeWith: aDistribution
		  on: amountOfCells
		  andWithDefault: defaultClass
]

{ #category : 'initialization' }
Distributor >> initializeWith: aDistribution and: amountOfItems [

	distribution := aDistribution.
	amount := amountOfItems
]

{ #category : 'initialization' }
Distributor >> initializeWith: aDistribution on: amountOfCells andWithDefault: defaultClass [

	distribution := aDistribution.
	amount := amountOfCells.
	defaultItem := defaultClass
]

{ #category : 'playing' }
Distributor >> recieveAmountOfItems [

	| cumulativeProbabilities cum effectsOnCells randomItem effectSelected random |
	cumulativeProbabilities := OrderedCollection new.
	random := Random new.
	cum := 0.0.

	distribution do: [ :dist |
		cum := cum + dist probability.
		cumulativeProbabilities add: cum -> dist cellClass ].

	effectsOnCells := OrderedCollection new.

	amount timesRepeat: [
		randomItem := random next. "Entre 0 y 1"
		effectSelected := cumulativeProbabilities
			                  detect: [ :assoc | randomItem <= assoc key ].
		effectsOnCells add: effectSelected value ].

	^ effectsOnCells
]
