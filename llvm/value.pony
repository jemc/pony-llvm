
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
    var start = @LLVMGetFirstUse[_Ptr](_p())            // TODO: use let (compiler bug)
    _RefIterator[this->Use](start,
      recover lambda tag(ptr': _Ptr): _Ptr =>
        @LLVMGetNextUse[_Ptr](ptr')
      end end)
  
  fun reverse_uses(): Iterator[this->Use!]^ =>
    var start = @LLVMGetLastUse[_Ptr](_p())             // TODO: use let (compiler bug)
    _RefIterator[this->Use](start,
      recover lambda tag(ptr': _Ptr): _Ptr =>
        @LLVMGetPreviousUse[_Ptr](ptr')
      end end)

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
  
  fun basic_blocks(): Iterator[this->BasicBlock!]^ =>
    let start = @LLVMGetFirstBasicBlock[_Ptr](_p())
    _RefIterator[this->BasicBlock](start,
      recover lambda tag(ptr': _Ptr): _Ptr =>
        @LLVMGetNextBasicBlock[_Ptr](ptr')
      end end)
  
  fun reverse_basic_blocks(): Iterator[this->BasicBlock!]^ =>
    let start = @LLVMGetLastBasicBlock[_Ptr](_p())
    _RefIterator[this->BasicBlock](start,
      recover lambda tag(ptr': _Ptr): _Ptr =>
        @LLVMGetPreviousBasicBlock[_Ptr](ptr')
      end end)
  
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

class TermInstructionValue is Value
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
