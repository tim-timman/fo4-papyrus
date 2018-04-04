ScriptName TestEventsScript extends ObjectReference

Group Special Collapsed
	Bool Property ShowAsMessageBox Auto
	{If true will pop up a message box instead of notification}
	Bool Property InvertEventSelections Auto
	{ If true will invert the current event (non-registered), OnHit and OnMagicEffectApply selections. Overridden by bNotifyAllEvents }
	Bool Property NotifyAllEvents = true Auto
	{ If true will and notify for all (non-registered) events, OnHit and OnMagicEffectApply. Will override any selection }
	Bool Property StopAll Auto Hidden
	{ If true will override everything and stop all event notifications }
EndGroup

Group WorkshopEvents
	Bool Property bOnWorkshopObjectPlaced Auto
	Bool Property bOnWorkshopObjectGrabbed Auto
	Bool Property bOnWorkshopObjectMoved Auto
	Bool Property bOnWorkshopObjectDestroyed Auto
	Bool Property bOnWorkshopObjectRepaired Auto
	Bool Property bOnWorkshopNPCTransfer Auto
EndGroup

Group LoadEvents
	Bool Property bOnInit Auto
	Bool Property bOnLoad Auto
	Bool Property bOnUnload Auto
	Bool Property bOnCellLoad Auto
	Bool Property bOnCellAttach Auto
	Bool Property bOnCellDetach Auto
	Bool Property bOnReset Auto
EndGroup

Group ContainerEvents
	Bool Property bOnItemAdded Auto
	Bool Property bOnItemRemoved Auto
EndGroup

Group PowerEvents
	Bool Property bOnPowerOn Auto
	Bool Property bOnPowerOff Auto
EndGroup

Group InteractionEvents
	Bool Property bOnActivate Auto
	Bool Property bOnGrab Auto
	Bool Property bOnRelease Auto
	Bool Property bOnRead Auto
	Bool Property bOnOpen Auto
	Bool Property bOnClose Auto
	Bool Property bOnLockStateChanged Auto
EndGroup

Group ClothingEvents
	Bool Property bOnEquipped Auto
	Bool Property bOnUnequipped Auto
EndGroup

Group TransferEvents
	Bool Property bOnContainerChanged Auto
	Bool Property bOnSell Auto
EndGroup

Group TriggerEvents
	Bool Property bOnTriggerEnter Auto
	{ Requires a model with a triggerbox }
	Bool Property bOnTriggerLeave Auto
	{ Requires a model with a triggerbox }
EndGroup

Group MiscEvents
	Bool Property bOnDestructionStageChanged Auto
	Bool Property bOnExitFurniture Auto
	Bool Property bOnHolotapeChatter Auto
	Bool Property bOnHolotapePlay Auto
	Bool Property bOnPipboyRadioDetection Auto
	Bool Property bOnPlayerDialogueTarget Auto
	Bool Property bOnSpellCast Auto
	Bool Property bOnTrapHitStart Auto
	Bool Property bOnTrapHitStop Auto
	Bool Property bOnTranslationAlmostComplete Auto
	Bool Property bOnTranslationComplete Auto
	Bool Property bOnTranslationFailed Auto
EndGroup

Group RegisteredEvents
	Bool Property bOnHit Auto
	Bool Property ShouldReRegisterOnHit = true Auto
	Bool Property bOnMagicEffectApply Auto
	Bool Property ShouldReRegisterOnMagicEffectApply = true Auto
	Bool Property bRemoteWorkshopEvents Auto
	{ Will register for all workshop events at the Sanctuary workshop }
	Bool Property bOnAnimationEvent Auto
	{ If true, will attempt to register for the events listed in sAnimationEvents }
	ObjectReference Property kRefToRegisterAnimationsOn = None Auto
	{ If set, animation events will be registered for on it instead }
	ReferenceAlias Property kAliasToRegisterAnimationsOn = None Auto
	{ If set, animation events will be registered for on it instead }
	Bool Property bRegisterAnimationsOnPlayer = false Auto
	{ If set, animation events will be registered for on it instead }
	String[] Property sAnimationEvents Auto
	{ List of AnimationEvent names registered for if bOnAnimationEvent is true }
	Bool Property bOnMenuOpenCloseEvent Auto
	{ If true, will register for the events listed in sMenuOpenCloseEvents }
	String[] Property sMenuOpenCloseEvents Auto
	{ List of MenuOpenCloseEvent names registered for if bOnMenuOpenCloseEvent is true }
EndGroup

; #### Console Help Functions ####

Function TraceGlobalFunction(string asScriptName, string asFuncName, ScriptObject akScriptObj1, string asObject1Type, ScriptObject akScriptObj2, string asObject2Type, ScriptObject akScriptObj3, string asObject3Type)
	Var[] aParams = new Var[0]
	If (asObject1Type == "Form")
		aParams.Add(akScriptObj1 as Form)
	ElseIf (asObject1Type == "Keyword")
		aParams.Add(akScriptObj1 as Keyword)
	ElseIf (asObject1Type == "ObjectReference")
		aParams.Add(akScriptObj1 as ObjectReference)
	ElseIf (asObject1Type == "Message")
		aParams.Add(akScriptObj1 as Message)
	EndIf
	If (asObject2Type == "Form")
		aParams.Add(akScriptObj2 as Form)
	ElseIf (asObject2Type == "Keyword")
		aParams.Add(akScriptObj2 as Keyword)
	ElseIf (asObject2Type == "ObjectReference")
		aParams.Add(akScriptObj2 as ObjectReference)
	ElseIf (asObject1Type == "Message")
		aParams.Add(akScriptObj1 as Message)
	EndIf
	If (asObject3Type == "Form")
		aParams.Add(akScriptObj3 as Form)
	ElseIf (asObject3Type == "Keyword")
		aParams.Add(akScriptObj3 as Keyword)
	ElseIf (asObject3Type == "ObjectReference")
		aParams.Add(akScriptObj3 as ObjectReference)
	ElseIf (asObject1Type == "Message")
		aParams.Add(akScriptObj1 as Message)
	EndIf
	Var result = Utility.CallGlobalFunction(asScriptName, asFuncName, aParams)
	Debug.TraceSelf(self, "TraceGlobalFunction(" + "\"" + asScriptName + "\""+ "\"" + asFuncName + "\""+ "\"" + aParams + "\"",result)
EndFunction

Function TraceScriptFunction(ScriptObject akCallOn, string asCallOnType, string asFuncName, ScriptObject akScriptObj1, string asObject1Type, ScriptObject akScriptObj2, string asObject2Type, ScriptObject akScriptObj3, string asObject3Type)
	Var[] aParams = new Var[0]
	If (akScriptObj1)
		aParams.Add(akScriptObj1.CastAs(asObject1Type))
	EndIf
	If (akScriptObj2)
		aParams.Add(akScriptObj2.CastAs(asObject2Type))
	EndIf
	If (akScriptObj3)
		aParams.Add(akScriptObj3.CastAs(asObject3Type))
	EndIf
	ScriptObject obj = akCallOn.CastAs(asCallOnType)
	Var result = obj.CallFunction(asFuncName, aParams)
	Debug.TraceSelf(self, "TraceScriptFunction(" + "\"" + obj + "." + asFuncName + "\""+ "\"" + aParams + "\"",result)
EndFunction

Function TempFunction(ScriptObject akCallOn, string asCallOnType, string asFuncName)
	Var[] aParams = new Var[0]
	int i = 0
	While (i < 9)
		aParams.Add(0 as float)
		i += 1
	EndWhile
	ScriptObject obj = akCallOn.CastAs(asCallOnType)
	Var result = obj.CallFunction(asFuncName, aParams)
	Debug.TraceSelf(self, "TraceScriptFunction(" + "\"" + obj + "." + asFuncName + "\""+ "\"" + aParams + "\"",result)
EndFunction

Function TempFunction2(Form akForm, float afRadius)
	ObjectReference[] result = self.FindAllReferencesOfType(akForm, afRadius)
	Debug.TraceSelf(self, "FindAllReferencesOfType", result)
EndFunction

Function TempFunction3(ObjectReference akReference, Keyword apKeyword)
	ObjectReference[] result = akReference.GetRefsLinkedToMe(apKeyword)
	Debug.TraceSelf(self, "GetRefsLinkedToMe", result)
EndFunction

Function attach(ObjectReference akReference, ObjectReference akOtherRef)
	akReference.AttachTo(akOtherRef)
EndFunction

; ================================

Function Initialize()
	If (InvertEventSelections)
		bOnWorkshopObjectPlaced = !bOnWorkshopObjectPlaced
		bOnWorkshopObjectGrabbed = !bOnWorkshopObjectGrabbed
		bOnWorkshopObjectMoved = !bOnWorkshopObjectMoved
		bOnWorkshopObjectDestroyed = !bOnWorkshopObjectDestroyed
		bOnWorkshopObjectRepaired = !bOnWorkshopObjectRepaired
		bOnWorkshopNPCTransfer = !bOnWorkshopNPCTransfer
		bOnInit = !bOnInit
		bOnLoad = !bOnLoad
		bOnUnload = !bOnUnload
		bOnCellLoad = !bOnCellLoad
		bOnCellAttach = !bOnCellAttach
		bOnCellDetach = !bOnCellDetach
		bOnReset = !bOnReset
		bOnItemAdded = !bOnItemAdded
		bOnItemRemoved = !bOnItemRemoved
		bOnPowerOn = !bOnPowerOn
		bOnPowerOff = !bOnPowerOff
		bOnActivate = !bOnActivate
		bOnGrab = !bOnGrab
		bOnRelease = !bOnRelease
		bOnRead = !bOnRead
		bOnOpen = !bOnOpen
		bOnClose = !bOnClose
		bOnLockStateChanged = !bOnLockStateChanged
		bOnEquipped = !bOnEquipped
		bOnUnequipped = !bOnUnequipped
		bOnContainerChanged = !bOnContainerChanged
		bOnSell = !bOnSell
		bOnTriggerEnter = !bOnTriggerEnter
		bOnTriggerLeave = !bOnTriggerLeave
		bOnDestructionStageChanged = !bOnDestructionStageChanged
		bOnExitFurniture = !bOnExitFurniture
		bOnHolotapeChatter = !bOnHolotapeChatter
		bOnHolotapePlay = !bOnHolotapePlay
		bOnPipboyRadioDetection = !bOnPipboyRadioDetection
		bOnPlayerDialogueTarget = !bOnPlayerDialogueTarget
		bOnSpellCast = !bOnSpellCast
		bOnTrapHitStart = !bOnTrapHitStart
		bOnTrapHitStop = !bOnTrapHitStop
		bOnTranslationAlmostComplete = !bOnTranslationAlmostComplete
		bOnTranslationComplete = !bOnTranslationComplete
		bOnTranslationFailed = !bOnTranslationFailed
    bOnHit = !bOnHit
    bOnMagicEffectApply = !bOnMagicEffectApply
	EndIf
EndFunction

Function RegRemoteWorkshopEvents()
	ObjectReference sanctuaryWorkshopRef = Game.GetFormFromFile(0x00250fe, "Fallout4.esm") as ObjectReference
	RegisterForRemoteEvent(sanctuaryWorkshopRef, "OnWorkshopObjectGrabbed")
	RegisterForRemoteEvent(sanctuaryWorkshopRef, "OnWorkshopObjectMoved")
	RegisterForRemoteEvent(sanctuaryWorkshopRef, "OnWorkshopObjectPlaced")
	RegisterForRemoteEvent(sanctuaryWorkshopRef, "OnWorkshopObjectDestroyed")
	RegisterForRemoteEvent(sanctuaryWorkshopRef, "OnWorkshopObjectRepaired")
EndFunction

Function RegAnimationEvents()
	ObjectReference refToReg
	If (kRefToRegisterAnimationsOn)
		refToReg = kRefToRegisterAnimationsOn
	ElseIf (kAliasToRegisterAnimationsOn)
		refToReg = kAliasToRegisterAnimationsOn.GetReference()
	ElseIf (bRegisterAnimationsOnPlayer)
		refToReg = Game.GetPlayer()
	Else
		refToReg = Self
		WaitFor3DLoad()
	EndIf
	Debug.TraceSelf(self, "RegAnimationEvents", "Registering animation events on " + refToReg)
	int i = 0
	While (i < sAnimationEvents.Length)
		If (!RegisterForAnimationEvent(refToReg, sAnimationEvents[i]))
			Debug.MessageBox("Failed to register for animation event: " + sAnimationEvents[i])
		EndIf
		i += 1
	EndWhile
EndFunction

Function RegMenuOpenCloseEvents()
	int i = 0
	While (i < sMenuOpenCloseEvents.Length)
		RegisterForMenuOpenCloseEvent(sMenuOpenCloseEvents[i])
		i += 1
	EndWhile
EndFunction

Function Register()
	If (NotifyAllEvents || bOnHit)
		RegisterForHitEvent(Self)
	EndIf
	If (NotifyAllEvents || bOnMagicEffectApply)
		RegisterForMagicEffectApplyEvent(Self)
	EndIf
	If (bRemoteWorkshopEvents)
		RegRemoteWorkshopEvents()
	EndIf
	If (bOnAnimationEvent)
		RegAnimationEvents()
	EndIf
	If (bOnMenuOpenCloseEvent)
		RegMenuOpenCloseEvents()
	EndIf
EndFunction

Function Unregister()
	kRefToRegisterAnimationsOn = None
	UnregisterForAllEvents()
EndFunction

Function Present(String asMessage)
	If (!StopAll)
		If (ShowAsMessageBox)
			Debug.MessageBox(asMessage)
		Else
			Debug.Notification(asMessage)
		EndIf
	EndIf
	Debug.Trace(self + " " + asMessage)
EndFunction

Event OnActivate(ObjectReference akActionRef)
	If (NotifyAllEvents || bOnActivate)
		Present("OnActivate() by " + akActionRef)
	EndIf
EndEvent
Event OnCellAttach()
	If (NotifyAllEvents || bOnCellAttach)
		Present("OnCellAttach()")
	EndIf
EndEvent
Event OnCellDetach()
	If (NotifyAllEvents || bOnCellDetach)
		Present("OnCellDetach()")
	EndIf
EndEvent
Event OnCellLoad()
	If (NotifyAllEvents || bOnCellLoad)
		Present("OnCellLoad()")
	EndIf
EndEvent
Event OnClose(ObjectReference akActionRef)
	If (NotifyAllEvents || bOnClose)
		Present("OnClose() by " + akActionRef)
	EndIf
EndEvent
Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	If (NotifyAllEvents || bOnContainerChanged)
		Present("OnContainerChanged() to " + akNewContainer + " from " + akOldContainer)
	EndIf
EndEvent
Event OnDestructionStageChanged(int aiOldStage, int aiCurrentStage)
	If (NotifyAllEvents || bOnDestructionStageChanged)
		Present("OnDestructionStageChanged() old: " + aiOldStage + " , cur: " + aiCurrentStage)
	EndIf
EndEvent
Event OnEquipped(Actor akActor)
	If (NotifyAllEvents || bOnEquipped)
		Present("OnEquipped() by " + akActor)
	EndIf
EndEvent
Event OnExitFurniture(ObjectReference akActionRef)
	If (NotifyAllEvents || bOnExitFurniture)
		Present("OnExitFurniture() by " + akActionRef)
	EndIf
EndEvent
Event OnGrab()
	If (NotifyAllEvents || bOnGrab)
		Present("OnGrab()")
	EndIf
EndEvent
Event OnHolotapeChatter(string astrChatter, float afNumericData)
	If (NotifyAllEvents || bOnHolotapeChatter)
		Present("OnHolotapeChatter(): " + astrChatter + " , " + afNumericData)
	EndIf
EndEvent
Event OnHolotapePlay(ObjectReference akTerminalRef)
	If (NotifyAllEvents || bOnHolotapePlay)
		Present("OnHolotapePlay() by " + akTerminalRef)
	EndIf
EndEvent
Event OnInit()
	Initialize()
	If (NotifyAllEvents || bOnInit)
		Present("OnInit()")
	EndIf
EndEvent
Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	If (NotifyAllEvents || bOnItemAdded)
		Present("OnItemAdded() baseItem: " + akBaseItem + " (" + aiItemCount + "), ref: " + akItemReference + " from container: " + akSourceContainer)
	EndIf
EndEvent
Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	If (NotifyAllEvents || bOnItemRemoved)
		Present("OnItemAdded() baseItem: " + akBaseItem + " (" + aiItemCount + "), ref: " + akItemReference + " to container: " + akDestContainer)
	EndIf
EndEvent
Event OnLoad()
	If (NotifyAllEvents || bOnLoad)
		Present("OnLoad()")
	EndIf
	Register()
EndEvent
Event OnLockStateChanged()
	If (NotifyAllEvents || bOnLockStateChanged)
		Present("OnLockStateChanged()")
	EndIf
EndEvent
Event OnOpen(ObjectReference akActionRef)
	If (NotifyAllEvents || bOnOpen)
		Present("OnOpen() by " + akActionRef)
	EndIf
EndEvent
Event OnPipboyRadioDetection(bool abDetected)
	If (NotifyAllEvents || bOnPipboyRadioDetection)
		Present("OnPipboyRadioDetection() is detected: " + abDetected)
	EndIf
EndEvent
Event OnPlayerDialogueTarget()
	If (NotifyAllEvents || bOnPlayerDialogueTarget)
		Present("OnPlayerDialogueTarget()")
	EndIf
EndEvent
Event OnPowerOn(ObjectReference akPowerGenerator)
	If (NotifyAllEvents || bOnPowerOn)
		Present("OnPowerOn() generator: " + akPowerGenerator)
	EndIf
EndEvent
Event OnPowerOff()
	If (NotifyAllEvents || bOnPowerOff)
		Present("OnPowerOff()")
	EndIf
EndEvent
Event OnRead()
	If (NotifyAllEvents || bOnRead)
		Present("OnRead()")
	EndIf
EndEvent
Event OnRelease()
	If (NotifyAllEvents || bOnRelease)
		Present("OnRelease()")
	EndIf
EndEvent
Event OnReset()
	If (NotifyAllEvents || bOnReset)
		Present("OnReset()")
	EndIf
EndEvent
Event OnSell(Actor akSeller)
	If (NotifyAllEvents || bOnSell)
		Present("OnSell() seller: " + akSeller)
	EndIf
EndEvent
Event OnSpellCast(Form akSpell)
	If (NotifyAllEvents || bOnSpellCast)
		Present("OnSpellCast() spell: " + akSpell)
	EndIf
EndEvent
Event OnTrapHitStart(ObjectReference akTarget, float afXVel, float afYVel, float afZVel, float afXPos, float afYPos, float afZPos, int aeMaterial, bool abInitialHit, int aeMotionType)
	If (NotifyAllEvents || bOnTrapHitStart)
		Present("OnTrapHitStart() on target: " + akTarget)
	EndIf
EndEvent
Event OnTrapHitStop(ObjectReference akTarget)
	If (NotifyAllEvents || bOnTrapHitStop)
		Present("OnTrapHitStart() on target: " + akTarget)
	EndIf
EndEvent
Event OnTranslationAlmostComplete()
	If (NotifyAllEvents || bOnTranslationAlmostComplete)
		Present("OnTranslationAlmostComplete()")
	EndIf
EndEvent
Event OnTranslationComplete()
	If (NotifyAllEvents || bOnTranslationComplete)
		Present("OnTranslationComplete()")
	EndIf
EndEvent
Event OnTranslationFailed()
	If (NotifyAllEvents || bOnTranslationFailed)
		Present("OnTranslationFailed()")
	EndIf
EndEvent
Event OnTriggerEnter(ObjectReference akActionRef)
	If (NotifyAllEvents || bOnTriggerEnter)
		Present("OnTriggerEnter() entered: " + akActionRef)
	EndIf
EndEvent
Event OnTriggerLeave(ObjectReference akActionRef)
	If (NotifyAllEvents || bOnTriggerLeave)
		Present("OnTriggerLeave() left: " + akActionRef)
	EndIf
EndEvent
Event OnUnequipped(Actor akActor)
	If (NotifyAllEvents || bOnUnequipped)
		Present("OnUnequipped() by " + akActor)
	EndIf
EndEvent
Event OnUnload()
	If (NotifyAllEvents || bOnUnload)
		Present("OnUnload()")
	EndIf
	Unregister()
EndEvent
Event OnWorkshopNPCTransfer(Location akNewWorkshop, Keyword akActionKW)
	If (NotifyAllEvents || bOnWorkshopNPCTransfer)
		Present("OnWorkshopNPCTransfer() to location " + akNewWorkshop + " with keyword " + akActionKW)
	EndIf
EndEvent
Event OnWorkshopObjectDestroyed(ObjectReference akReference)
	If (NotifyAllEvents || bOnWorkshopObjectDestroyed)
		Present("OnWorkshopObjectDestroyed() by " + akReference.GetFormID())
	EndIf
EndEvent
Event OnWorkshopObjectGrabbed (ObjectReference akReference)
	If (NotifyAllEvents || bOnWorkshopObjectGrabbed)
		Present("OnWorkshopObjectGrabbed() by " + akReference.GetFormID())
	EndIf
EndEvent
Event OnWorkshopObjectMoved(ObjectReference akReference)
	If (NotifyAllEvents || bOnWorkshopObjectMoved)
		Present("OnWorkshopObjectMoved() by " + akReference.GetFormID())
	EndIf
EndEvent
Event OnWorkshopObjectPlaced(ObjectReference akReference)
	If (NotifyAllEvents || bOnWorkshopObjectPlaced)
		Present("OnWorkshopObjectPlaced() by " + akReference.GetFormID())
	EndIf
EndEvent
Event OnWorkshopObjectRepaired(ObjectReference akReference)
	If (NotifyAllEvents || bOnWorkshopObjectRepaired)
		Present("OnWorkshopObjectRepaired() by " + akReference.GetFormID())
	EndIf
EndEvent
Event OnHit(ObjectReference akTarget, ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked, string apMaterial)
	Present("OnHit() by " + akAggressor)
	If (NotifyAllEvents || ShouldReRegisterOnHit)
		RegisterForHitEvent(Self)
	EndIf
EndEvent
Event OnMagicEffectApply(ObjectReference akTarget, ObjectReference akCaster, MagicEffect akEffect)
	Present("OnHit() by " + akCaster)
	If (NotifyAllEvents || ShouldReRegisterOnMagicEffectApply)
		RegisterForMagicEffectApplyEvent(Self)
	EndIf
EndEvent
Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	Present("OnAnimationEvent() animation " + asEventName + " from " + akSource)
EndEvent
Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	string openAsString = "opening"
	If (!abOpening)
		openAsString = "closing"
	EndIf
	Present("OnMenuOpenCloseEvent() " + asMenuName + " is " + openAsString)
EndEvent
Event ObjectReference.OnWorkshopObjectDestroyed(ObjectReference akSender, ObjectReference akReference)
	Present("Remote OnWorkshopObjectDestroyed() regarding " + akReference)
EndEvent
Event ObjectReference.OnWorkshopObjectGrabbed (ObjectReference akSender, ObjectReference akReference)
	Present("Remote OnWorkshopObjectGrabbed() regarding " + akReference)
EndEvent
Event ObjectReference.OnWorkshopObjectMoved(ObjectReference akSender, ObjectReference akReference)
	Present("Remote OnWorkshopObjectMoved() regarding " + akReference)
EndEvent
Event ObjectReference.OnWorkshopObjectPlaced(ObjectReference akSender, ObjectReference akReference)
	Present("Remote OnWorkshopObjectPlaced() regarding " + akReference)
EndEvent
Event ObjectReference.OnWorkshopObjectRepaired(ObjectReference akSender, ObjectReference akReference)
	Present("Remote OnWorkshopObjectRepaired() regarding " + akReference)
EndEvent