
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
  
  fun ref add_function(name': String, type': FunctionType): Value! =>
    let p = @LLVMAddFunction[_Ptr](_p(), _Message.copy_out(name'), type'._p())
    recover Value._from_p(p) end
  
  fun find_function(name': String): this->Value!? =>
    let p = @LLVMGetNamedFunction[_Ptr](_p(), name'.cstring())
    if (identityof p) == 0 then error end
    recover Value._from_p(p) end
  
  fun functions(): Iterator[this->Value!]^ =>
    let p = @LLVMGetFirstFunction[_Ptr](_p())
    _RefIterator[this->Value](p, recover lambda tag(ptr': _Ptr): _Ptr =>
      @LLVMGetNextFunction[_Ptr](ptr')
    end end)
