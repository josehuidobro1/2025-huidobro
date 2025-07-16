Class {
	#name : 'MercenaryCard',
	#superclass : 'Card',
	#instVars : [
		'mercenary',
		'shipWithMercenary',
		'shipBeingMercenary'
	],
	#classInstVars : [
		'mercenary'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
MercenaryCard class >> applyTo: aShip [

	aShip receiveMercenaryCardEffectWith: mercenary
]

{ #category : 'as yet unclassified' }
MercenaryCard class >> applyTo: aShip using: aShip2 [

	aShip receiveMercenaryCardEffectWith: aShip2
]

{ #category : 'instance creation' }
MercenaryCard class >> with: aShip [

	mercenary := aShip
]

{ #category : 'playing' }
MercenaryCard >> applyTo: aShip using: aMercenary in:aGame [
	shipWithMercenary := aShip.
	shipBeingMercenary := aMercenary .
	aShip receiveMercenaryCardEffectWith: aMercenary
]

{ #category : 'testing' }
MercenaryCard >> isPermanent [

	^ true
]

{ #category : 'removing' }
MercenaryCard >> removePermanentEffect [
	shipBeingMercenary isNotMercenaryAnymore.
	shipWithMercenary popThisMercenary: shipBeingMercenary .
]
