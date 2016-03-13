
class Context is _Ref
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create() => _ptr = @LLVMContextCreate[_Ptr]()
  new global() => _ptr = @LLVMGetGlobalContext[_Ptr]()
  
  fun ref dispose() => @LLVMContextDispose[None](_p())
