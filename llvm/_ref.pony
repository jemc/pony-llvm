
trait _Ref
  fun _p(): _Ptr
  new _from_p(ptr': _Ptr)

class _RefIterator[A: _Ref #read] is Iterator[A]
  var _iter: _Ptr
  var _first: Bool = true
  let _iter_lambda: {tag(_Ptr): _Ptr} val
  new create(iter': _Ptr, iter_lambda': {tag(_Ptr): _Ptr} val) =>
    _iter = iter'
    _iter_lambda = iter_lambda'
  
  fun ref next(): A? =>
    let p =
      if _first then _iter
      else _iter = _iter_lambda(_iter)
      end
    
    _first = false
    if (identityof p) == 0 then error end
    recover A._from_p(p) end
  
  fun has_next(): Bool =>
    true

