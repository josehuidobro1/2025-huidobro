Class {
	#name : 'Effect',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Effect class >> initializeThis [
	^ self new.
]

{ #category : 'playing' }
Effect >> applyTo: aShip in: aGame [
	self subclassResponsibility .
]

{ #category : 'testing' }
Effect >> isCardGiver [

	^ false
]
