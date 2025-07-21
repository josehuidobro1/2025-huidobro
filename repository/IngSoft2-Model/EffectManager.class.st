Class {
	#name : 'EffectManager',
	#superclass : 'Object',
	#instVars : [
		'lastRealEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
EffectManager class >> creation [

	^ self new initialization
]

{ #category : 'initialization' }
EffectManager >> initialization [

	lastRealEffect := NoEffect new
]

{ #category : 'accessing' }
EffectManager >> lastRealEffect [

	^ lastRealEffect
]

{ #category : 'as yet unclassified' }
EffectManager >> registerEffect: anEffect [

	lastRealEffect := anEffect
]
