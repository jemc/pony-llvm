
class Value
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
