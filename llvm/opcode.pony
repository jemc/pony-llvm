
trait val Opcode
  fun apply(): I32

// Terminator Instructions
primitive OpRet            is Opcode fun apply(): I32 => 1
primitive OpBr             is Opcode fun apply(): I32 => 2
primitive OpSwitch         is Opcode fun apply(): I32 => 3
primitive OpIndirectBr     is Opcode fun apply(): I32 => 4
primitive OpInvoke         is Opcode fun apply(): I32 => 5
// removed 6 due to API changes
primitive OpUnreachable    is Opcode fun apply(): I32 => 7

// Standard Binary Operators
primitive OpAdd            is Opcode fun apply(): I32 => 8
primitive OpFAdd           is Opcode fun apply(): I32 => 9
primitive OpSub            is Opcode fun apply(): I32 => 10
primitive OpFSub           is Opcode fun apply(): I32 => 11
primitive OpMul            is Opcode fun apply(): I32 => 12
primitive OpFMul           is Opcode fun apply(): I32 => 13
primitive OpUDiv           is Opcode fun apply(): I32 => 14
primitive OpSDiv           is Opcode fun apply(): I32 => 15
primitive OpFDiv           is Opcode fun apply(): I32 => 16
primitive OpURem           is Opcode fun apply(): I32 => 17
primitive OpSRem           is Opcode fun apply(): I32 => 18
primitive OpFRem           is Opcode fun apply(): I32 => 19

// Logical Operators
primitive OpShl            is Opcode fun apply(): I32 => 20
primitive OpLShr           is Opcode fun apply(): I32 => 21
primitive OpAShr           is Opcode fun apply(): I32 => 22
primitive OpAnd            is Opcode fun apply(): I32 => 23
primitive OpOr             is Opcode fun apply(): I32 => 24
primitive OpXor            is Opcode fun apply(): I32 => 25

// Memory Operators
primitive OpAlloca         is Opcode fun apply(): I32 => 26
primitive OpLoad           is Opcode fun apply(): I32 => 27
primitive OpStore          is Opcode fun apply(): I32 => 28
primitive OpGetElementPtr  is Opcode fun apply(): I32 => 29

// Cast Operators
primitive OpTrunc          is Opcode fun apply(): I32 => 30
primitive OpZExt           is Opcode fun apply(): I32 => 31
primitive OpSExt           is Opcode fun apply(): I32 => 32
primitive OpFPToUI         is Opcode fun apply(): I32 => 33
primitive OpFPToSI         is Opcode fun apply(): I32 => 34
primitive OpUIToFP         is Opcode fun apply(): I32 => 35
primitive OpSIToFP         is Opcode fun apply(): I32 => 36
primitive OpFPTrunc        is Opcode fun apply(): I32 => 37
primitive OpFPExt          is Opcode fun apply(): I32 => 38
primitive OpPtrToInt       is Opcode fun apply(): I32 => 39
primitive OpIntToPtr       is Opcode fun apply(): I32 => 40
primitive OpBitCast        is Opcode fun apply(): I32 => 41
primitive OpAddrSpaceCast  is Opcode fun apply(): I32 => 60

// Other Operators
primitive OpICmp           is Opcode fun apply(): I32 => 42
primitive OpFCmp           is Opcode fun apply(): I32 => 43
primitive OpPHI            is Opcode fun apply(): I32 => 44
primitive OpCall           is Opcode fun apply(): I32 => 45
primitive OpSelect         is Opcode fun apply(): I32 => 46
primitive OpUserOp1        is Opcode fun apply(): I32 => 47
primitive OpUserOp2        is Opcode fun apply(): I32 => 48
primitive OpVAArg          is Opcode fun apply(): I32 => 49
primitive OpExtractElement is Opcode fun apply(): I32 => 50
primitive OpInsertElement  is Opcode fun apply(): I32 => 51
primitive OpShuffleVector  is Opcode fun apply(): I32 => 52
primitive OpExtractValue   is Opcode fun apply(): I32 => 53
primitive OpInsertValue    is Opcode fun apply(): I32 => 54

// Atomic operators
primitive OpFence          is Opcode fun apply(): I32 => 55
primitive OpAtomicCmpXchg  is Opcode fun apply(): I32 => 56
primitive OpAtomicRMW      is Opcode fun apply(): I32 => 57

// Exception Handling Operators
primitive OpResume         is Opcode fun apply(): I32 => 58
primitive OpLandingPad     is Opcode fun apply(): I32 => 59
primitive OpCleanupRet     is Opcode fun apply(): I32 => 61
primitive OpCatchRet       is Opcode fun apply(): I32 => 62
primitive OpCatchPad       is Opcode fun apply(): I32 => 63
primitive OpCleanupPad     is Opcode fun apply(): I32 => 64
primitive OpCatchSwitch    is Opcode fun apply(): I32 => 65

primitive _OpcodeUtil
  fun tag _from_i32(code: I32): Opcode =>
    match code
    | 1  => OpRet
    | 2  => OpBr
    | 3  => OpSwitch
    | 4  => OpIndirectBr
    | 5  => OpInvoke
    | 7  => OpUnreachable
    | 8  => OpAdd
    | 9  => OpFAdd
    | 10 => OpSub
    | 11 => OpFSub
    | 12 => OpMul
    | 13 => OpFMul
    | 14 => OpUDiv
    | 15 => OpSDiv
    | 16 => OpFDiv
    | 17 => OpURem
    | 18 => OpSRem
    | 19 => OpFRem
    | 20 => OpShl
    | 21 => OpLShr
    | 22 => OpAShr
    | 23 => OpAnd
    | 24 => OpOr
    | 25 => OpXor
    | 26 => OpAlloca
    | 27 => OpLoad
    | 28 => OpStore
    | 29 => OpGetElementPtr
    | 30 => OpTrunc
    | 31 => OpZExt
    | 32 => OpSExt
    | 33 => OpFPToUI
    | 34 => OpFPToSI
    | 35 => OpUIToFP
    | 36 => OpSIToFP
    | 37 => OpFPTrunc
    | 38 => OpFPExt
    | 39 => OpPtrToInt
    | 40 => OpIntToPtr
    | 41 => OpBitCast
    | 60 => OpAddrSpaceCast
    | 42 => OpICmp
    | 43 => OpFCmp
    | 44 => OpPHI
    | 45 => OpCall
    | 46 => OpSelect
    | 47 => OpUserOp1
    | 48 => OpUserOp2
    | 49 => OpVAArg
    | 50 => OpExtractElement
    | 51 => OpInsertElement
    | 52 => OpShuffleVector
    | 53 => OpExtractValue
    | 54 => OpInsertValue
    | 55 => OpFence
    | 56 => OpAtomicCmpXchg
    | 57 => OpAtomicRMW
    | 58 => OpResume
    | 59 => OpLandingPad
    | 61 => OpCleanupRet
    | 62 => OpCatchRet
    | 63 => OpCatchPad
    | 64 => OpCleanupPad
    | 65 => OpCatchSwitch
    else    OpUnreachable // should never happen
    end
