Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'generators' }
Card >> generateRandomCard [

	| classes |
	classes := self class subclasses.
	^ (classes at: (Random new nextIntegerBetween: 1 and: classes size)) new. 
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

	^ self class = anotherCard class
]
