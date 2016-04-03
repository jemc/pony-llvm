
trait Value is _Ref
  fun string(): String =>
    _Message.copy_in(@LLVMPrintValueToString[Pointer[U8] val](_p()))
  
  fun get_type(): this->Type! =>
    var p = @LLVMTypeOf[_Ptr](_p())                     // TODO: use let (compiler bug)
    recover _TypeUtil._from_p(p) end
  
  fun name(): String =>
    var cstr = @LLVMGetValueName[Pointer[U8] val](_p()) // TODO: use let (compiler bug)
    recover String.copy_cstring(cstr) end
  
  fun ref set_name(name': String box) =>
    @LLVMSetValueName[None](_p(), _Message.copy_out(name'))
  
  fun is_constant(): Bool =>
    0 != @LLVMIsConstant[I32](_p())
  
  fun is_undef(): Bool =>
    0 != @LLVMIsUndef[I32](_p())
  
  fun replace_all_uses_with(that: Value box) =>
    @LLVMReplaceAllUsesWith[None](_p(), that._p())
  
  fun uses(): Iterator[this->Use!]^ =>
    var p = @LLVMGetFirstUse[_Ptr](_p())            // TODO: use let (compiler bug)
    _NextIterator[this->Use](
      recover Use._from_p(p) end)
  
  fun reverse_uses(): Iterator[this->Use!]^ =>
    var p = @LLVMGetLastUse[_Ptr](_p())             // TODO: use let (compiler bug)
    _PrevIterator[this->Use](
      recover Use._from_p(p) end)

class AnyValue is Value
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  fun is_basic_block(): Bool =>
    0 != @LLVMValueIsBasicBlock[I32](_p())
  
  fun as_basic_block(): this->BasicBlock! =>
    let p = @LLVMValueAsBasicBlock[_Ptr](_p())
    recover BasicBlock._from_p(p) end

class FunctionValue is Value
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  fun next(): this->FunctionValue!? =>
    let p = @LLVMGetNextFunction[_Ptr](_p())
    if (identityof p) == 0 then error end
    recover FunctionValue._from_p(p) end
  
  fun prev(): this->FunctionValue!? =>
    let p = @LLVMGetPreviousFunction[_Ptr](_p())
    if (identityof p) == 0 then error end
    recover FunctionValue._from_p(p) end
  
  fun basic_blocks(): Iterator[this->BasicBlock!]^ =>
    let p = @LLVMGetFirstBasicBlock[_Ptr](_p())
    _NextIterator[this->BasicBlock](
      recover BasicBlock._from_p(p) end)
  
  fun reverse_basic_blocks(): Iterator[this->BasicBlock!]^ =>
    let p = @LLVMGetLastBasicBlock[_Ptr](_p())
    _PrevIterator[this->BasicBlock](
      recover BasicBlock._from_p(p) end)
  
  fun entry_basic_block(): this->BasicBlock! =>
    let p = @LLVMGetEntryBasicBlock[_Ptr](_p())
    recover BasicBlock._from_p(p) end
  
  fun ref append_basic_block(
    name': String, context': (Context | None) = None
  ): BasicBlock! =>
    let cstr = _Message.copy_out(name')
    let p = match context' | let c: Context =>
      @LLVMAppendBasicBlockInContext[_Ptr](c._p(), _p(), cstr)
    else
      @LLVMAppendBasicBlock[_Ptr](_p(), cstr)
    end
    recover BasicBlock._from_p(p) end

class InstructionValue is Value
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new clone(that: InstructionValue box) =>
    _ptr = @LLVMInstructionClone[_Ptr](that._p())
  
  fun next(): this->InstructionValue!? =>
    let p = @LLVMGetNextInstruction[_Ptr](_p())
    if (identityof p) == 0 then error end
    recover InstructionValue._from_p(p) end
  
  fun prev(): this->InstructionValue!? =>
    let p = @LLVMGetPreviousInstruction[_Ptr](_p())
    if (identityof p) == 0 then error end
    recover InstructionValue._from_p(p) end
  
  fun has_metadata(): Bool =>
    0 != @LLVMHasMetadata[I32](_p())
  
  fun get_metadata(kind: U32): this->MetadataValue!? =>
    let p = @LLVMGetMetadata[_Ptr](_p(), kind)
    if (identityof p) == 0 then error end
    recover MetadataValue._from_p(p) end
  
  fun ref set_metadata(kind: U32, node: Value) =>
    @LLVMSetMetadata[None](_p(), kind, node._p())
  
  fun parent(): this->BasicBlock!? =>
    let p = @LLVMGetInstructionParent[_Ptr](_p())
    if (identityof p) == 0 then error end
    recover BasicBlock._from_p(p) end
  
  fun erase_from_parent() =>
    @LLVMInstructionEraseFromParent[None](_p())

class TermInstructionValue is Value
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'

class MetadataValue is Value
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
