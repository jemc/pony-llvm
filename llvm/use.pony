
class Use is _Ref
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  fun user(): this->AnyValue! =>
    let p = @LLVMGetUser[_Ptr](_p())
    recover AnyValue._from_p(p) end
  
  fun used_value(): this->AnyValue! =>
    let p = @LLVMGetUsedValue[_Ptr](_p())
    recover AnyValue._from_p(p) end
