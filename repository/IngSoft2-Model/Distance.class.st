Class {
	#name : 'Distance',
	#superclass : 'Object',
	#instVars : [
		'lightYear',
		'parsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Distance class >> lightYear: anAmount [

	^ self new intializeWithParsecs: anAmount / 3 andLightYears: anAmount
]

{ #category : 'as yet unclassified' }
Distance class >> parsecs: anAmount [

	^ self new intializeWithParsecs: anAmount andLightYears:(anAmount * 3)
]

{ #category : 'as yet unclassified' }
Distance >> intializeWithParsecs: someParsecs andLightYears: someLightYear [

	parsecs := someParsecs.
	lightYear := someLightYear
]

{ #category : 'accessing' }
Distance >> lightYears [

	^ lightYear
]

{ #category : 'accessing' }
Distance >> parsecs [

	^ parsecs
]
