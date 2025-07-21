Class {
	#name : 'ShieldManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShieldManagerTest >> test001WhenCreateShipManagerThenshieldsAre3 [

	| ship shieldManager |
	ship := Ship create: 'ship'.
	shieldManager := ShieldsManager initializeWith: ship.
	self assert: shieldManager shields equals: 3
]

{ #category : 'tests' }
ShieldManagerTest >> test002WhenLoseShieldInShipManagerThenshieldsAre2 [

	| ship shieldManager |
	ship := Ship create: 'ship'.
	shieldManager := ShieldsManager initializeWith: ship.
	shieldManager loseShield.
	self assert: shieldManager shields equals: 2
]

{ #category : 'tests' }
ShieldManagerTest >> test003WhenRecoverShieldsAfeterLoseItThenGetMaxshields [

	| ship shieldManager |
	ship := Ship create: 'ship'.
	shieldManager := ShieldsManager initializeWith: ship.
	shieldManager loseShield.
	shieldManager loseShield.
	shieldManager recoverShields.
	self assert: shieldManager shields equals: 3
]

{ #category : 'tests' }
ShieldManagerTest >> test004WhenAddAShieldThenIncreaseTheShield [

	| ship shieldManager |
	ship := Ship create: 'ship'.
	shieldManager := ShieldsManager initializeWith: ship.
	shieldManager loseShield.
	shieldManager addAShield.
	self assert: shieldManager shields equals: 3
]

{ #category : 'tests' }
ShieldManagerTest >> test005WhenAddAShieldAndHasAlready3shieldsThenIncreaseThemaxShield [

	| ship shieldManager |
	ship := Ship create: 'ship'.
	shieldManager := ShieldsManager initializeWith: ship.
	shieldManager addAShield.
	self assert: shieldManager shields equals: 4
]
