
interface _CanNext[A]
  fun next(): A?

interface _CanPrev[A]
  fun prev(): A?

class _NextIterator[A: _CanNext[A] #read] is Iterator[A]
  var _next: (A | None)
  new create(next': A) => _next = next'
  
  fun has_next(): Bool => _next isnt None
  fun ref next(): A? =>
    let current = (_next as A)
    _next = try current.next() else None end
    current

class _PrevIterator[A: _CanNext[A] #read] is Iterator[A]
  var _next: (A | None)
  new create(next': A) => _next = next'
  
  fun has_next(): Bool => _next isnt None
  fun ref next(): A? =>
    let current = (_next as A)
    _next = try current.next() else None end
    current
