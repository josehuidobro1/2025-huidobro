Class {
	#name : 'CardGiver',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
CardGiver >> applyTo: arg1 in: arg2 [

	arg2 cardManager drawCardOn: arg1
]

{ #category : 'testing' }
CardGiver >> isCardGiver [

	^ true
]
