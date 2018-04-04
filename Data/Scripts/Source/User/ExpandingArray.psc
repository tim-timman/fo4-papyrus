ScriptName ExpandingArray extends ObjectReference

Function Initialize(Formlist dataflst)
        data = dataflst
        If (data)
                GotoState("Master")
                end = 0
                size = 0
        EndIf
EndFunction
                        
int BLOCK_SIZE = 128 Const

int end
int size
formlist data
State Master
        int Function Add(var val)
                ExpandingArray block
                If (end >= size)
                        block = PlaceAtMe(GetBaseObject(), 1, true, true, false) as ExpandingArray
                        block.GotoState("Slave")
                        data.AddForm(block)
                        size += BLOCK_SIZE
                Else
                        int block_idx = size / BLOCK_SIZE - 1
                        block = data.GetAt(block_idx) as ExpandingArray
                EndIf
                block.Add(val)
                end += 1
                return end
        EndFunction

        var Function GetAt(int idx)
                If (0 <= idx && idx < end)
                        int block_idx = Math.Floor(idx / BLOCK_SIZE)
                        ExpandingArray block = data.GetAt(block_idx) as ExpandingArray
                        int sub_idx = idx % BLOCK_SIZE
                        return block.GetAt(sub_idx)
                Else
                        Debug.Trace("Index "+idx+" out of range 0-"+end)
                EndIf
                return none
        EndFunction

        Function Free()
                int numb = data.GetSize() - 1
                While (numb >= 0)
                        ExpandingArray block = data.GetAt(numb) as ExpandingArray
                        block.Free()
                        numb -= 1
                EndWhile
                data.Revert()
                data = None
                end = 0
                size = 0
                GotoState("")
        EndFunction

        Function Initialize(Formlist dataflst)
                Debug.Trace("Calling 'Initialize' on already initialized ExpandingArray. Ignoring.", 1)
        EndFunction
EndState

var[] values
State Slave
        Event OnBeginState(string asOldState)
                values = new var[BLOCK_SIZE]
                end = 0
                size = BLOCK_SIZE
        EndEvent
        int Function Add(var val)
                values[end] = val
                end += 1
                return end
        EndFunction
        var Function GetAt(int idx)
                return values[idx]
        EndFunction
        Function Free()
                values.Clear()
                Delete()
        EndFunction
                
        Function Initialize(Formlist dataflst)
                Debug.Trace("Calling 'Initialize' on Slave of already initialized ExpandingArray. Ignoring.", 1)
        EndFunction
EndState

;; Empty state functions
int Function Add(var val)
        UninitializedWarning("Add")
EndFunction

var Function GetAt(int idx)
        UninitializedWarning("GetAt")
EndFunction

Function Free()
        UninitializedWarning("Free")
EndFunction
;/
int Function RemoveAt(int idx)
        UninitializedWarning("RemoveAt")
EndFunction

Function Clear()
        UninitializedWarning("Clear")
EndFunction
/;
Function UninitializedWarning(string name)
        Debug.Trace("Calling '"+name+"' on uninitialized ExpandingArray. Ignoring.", 1)
EndFunction


Function Test(int numb)
        Formlist fl = Game.GetFormFromFile(0x801, "ArrayCreator.esp") as FormList
        Initialize(fl)
        int i = 0
        while (i < numb)
                Add(i)
                i += 1
        endwhile
        int j = 0
        while (j < end)
                Debug.Trace(GetAt(j) as int)
                j += 1
        endwhile
        ;Free()
EndFunction
