
class BasicBlock is _Ref
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  fun as_value(): this->AnyValue! =>
    let p = @LLVMBasicBlockAsValue[_Ptr](_p())
    recover AnyValue._from_p(p) end
  
  fun parent(): this->FunctionValue! =>
    let p = @LLVMGetBasicBlockParent[_Ptr](_p())
    recover FunctionValue._from_p(p) end
  
  fun terminator(): this->TermInstructionValue! =>
    let p = @LLVMGetBasicBlockTerminator[_Ptr](_p())
    recover TermInstructionValue._from_p(p) end
  
  fun first_instruction(): this->InstructionValue! =>
    let p = @LLVMGetFirstInstruction[_Ptr](_p())
    recover InstructionValue._from_p(p) end
  
  fun last_instruction(): this->InstructionValue! =>
    let p = @LLVMGetLastInstruction[_Ptr](_p())
    recover InstructionValue._from_p(p) end
  
  fun ref insert_basic_block(
    name': String, context': (Context | None) = None
  ): BasicBlock! =>
    let cstr = _Message.copy_out(name')
    let p = match context' | let c: Context =>
      @LLVMInsertBasicBlockInContext[_Ptr](c._p(), _p(), cstr)
    else
      @LLVMInsertBasicBlock[_Ptr](_p(), cstr)
    end
    recover BasicBlock._from_p(p) end
  
  fun ref delete() =>
    @LLVMDeleteBasicBlock[None](_p())
  
  fun ref remove_from_parent() =>
    @LLVMRemoveBasicBlockFromParent[None](_p())
  
  fun ref move_to_before(that: BasicBlock box) =>
    @LLVMMoveBasicBlockBefore[None](_p(), that._p())
  
  fun ref move_to_after(that: BasicBlock box) =>
    @LLVMMoveBasicBlockBefore[None](_p(), that._p())
