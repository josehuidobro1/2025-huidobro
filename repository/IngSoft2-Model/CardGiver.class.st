Class {
	#name : 'CardGiver',
	#superclass : 'Effect',
	#instVars : [
		'card'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
CardGiver >> applyTo: aShip in: aGame [

	aGame cardManager drawCardOn: aShip
]

{ #category : 'testing' }
CardGiver >> isCardGiver [

	^ true
]
