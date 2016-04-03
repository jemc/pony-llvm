
class Module is _Ref
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(name': String, context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMModuleCreateWithNameInContext[_Ptr](_Message.copy_out(name'), c._p())
    else
      @LLVMModuleCreateWithName[_Ptr](_Message.copy_out(name'))
    end
  
  new clone(that: Module) =>
    _ptr = @LLVMCloneModule[_Ptr](that._p())
  
  fun ref dispose() =>
    @LLVMDisposeModule[None](_p())
  
  fun string(): String =>
    _Message.copy_in(@LLVMPrintModuleToString[Pointer[U8] val](_p()))
  
  fun context(): this->Context! =>
    let p = @LLVMGetModuleContext[_Ptr](_p())
    recover Context._from_p(p) end
  
  fun find_type(name': String): this->Type!? =>
    let p = @LLVMGetTypeByName[_Ptr](_p(), name'.cstring())
    if (identityof p) == 0 then error end
    recover _TypeUtil._from_p(p) end
  
  fun ref add_function(name': String, type': FunctionType): FunctionValue! =>
    let p = @LLVMAddFunction[_Ptr](_p(), _Message.copy_out(name'), type'._p())
    recover FunctionValue._from_p(p) end
  
  fun find_function(name': String): this->FunctionValue!? =>
    let p = @LLVMGetNamedFunction[_Ptr](_p(), name'.cstring())
    if (identityof p) == 0 then error end
    recover FunctionValue._from_p(p) end
  
  fun functions(): Iterator[this->FunctionValue!]^ =>
    let p = @LLVMGetFirstFunction[_Ptr](_p())
    _NextIterator[this->FunctionValue](
      recover FunctionValue._from_p(p) end)
  
  fun reverse_functions(): Iterator[this->FunctionValue!]^ =>
    let p = @LLVMGetLastFunction[_Ptr](_p())
    _PrevIterator[this->FunctionValue](
      recover FunctionValue._from_p(p) end)
