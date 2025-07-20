Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Card class >> initializeThis [

	^ self new
]

{ #category : 'initialization' }
Card >> initializeThis [

	^ self
]

{ #category : 'testing' }
Card >> isCancellationCard [

	^ false
]

{ #category : 'testing' }
Card >> isPermanent [

	^ false
]

{ #category : 'testing' }
Card >> isRedo [

	^ false
]

{ #category : 'testing' }
Card >> matches: anotherCard [

	^ self class = anotherCard
]
