Class {
	#name : 'ShieldsManager',
	#superclass : 'Object',
	#instVars : [
		'maxShields',
		'actualShields',
		'ship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ShieldsManager class >> initializeWith: aShip [

	^ self new intializeWith: aShip
]

{ #category : 'adding' }
ShieldsManager >> addAShield [

	actualShields = maxShields ifTrue: [ maxShields := maxShields + 1 ].
	actualShields := actualShields + 1
]

{ #category : 'initialization' }
ShieldsManager >> initialization [

	maxShields := 3.
	actualShields := 3
]

{ #category : 'as yet unclassified' }
ShieldsManager >> intializeWith: aShip [

	maxShields := 3.
	actualShields := 3.
	ship := aShip
]

{ #category : 'playing' }
ShieldsManager >> loseShield [

	actualShields := actualShields - 1.
	actualShields = 0 ifTrue: [ ship turnsThatHasToSkip: 2 ]
]

{ #category : 'playing' }
ShieldsManager >> recoverShields [

	actualShields := maxShields .

]

{ #category : 'accessing' }
ShieldsManager >> shields [

	^ actualShields
]
