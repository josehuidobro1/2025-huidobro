Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
Card >> applyTo: aShip using: anotherShip in: aGame [

	self subclassResponsibility
]

{ #category : 'testing' }
Card >> isPermanent [

	^ false
]

{ #category : 'testing' }
Card >> isRedo [

	^ false
]
