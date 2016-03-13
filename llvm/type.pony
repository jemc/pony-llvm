
trait Type is _Ref
  fun string(): String =>
    _Message(@LLVMPrintTypeToString[Pointer[U8] val](_p()))
  
  fun context(): this->Context! =>
    var p = @LLVMGetTypeContext[_Ptr](_p()) // TODO: use let (compiler bug)
    recover Context._from_p(p) end
  
  fun is_sized(): Bool =>
    0 != @LLVMTypeIsSized[I32](_p())

primitive _TypeUtil
  fun tag _from_p(p: _Ptr): Type^ =>
    match @LLVMGetTypeKind[I32](p)
    | 0  => VoidType._from_p(p)
    | 1  => HalfType._from_p(p)
    | 2  => FloatType._from_p(p)
    | 3  => DoubleType._from_p(p)
    | 4  => X86FP80Type._from_p(p)
    | 5  => FP128Type._from_p(p)
    | 6  => PPCFP128Type._from_p(p)
    | 7  => LabelType._from_p(p)
    | 8  => IntegerType._from_p(p)
    | 9  => FunctionType._from_p(p)
    | 10 => StructType._from_p(p)
    | 11 => ArrayType._from_p(p)
    | 12 => PointerType._from_p(p)
    | 13 => VectorType._from_p(p)
    | 14 => MetadataType._from_p(p)
    | 15 => X86MMXType._from_p(p)
    | 16 => TokenType._from_p(p)
    else    VoidType._from_p(p)
    end

class VoidType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMVoidTypeInContext[_Ptr](c._p())
    else
      @LLVMVoidType[_Ptr]()
    end

class HalfType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMHalfTypeInContext[_Ptr](c._p())
    else
      @LLVMHalfType[_Ptr]()
    end

class FloatType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMFloatTypeInContext[_Ptr](c._p())
    else
      @LLVMFloatType[_Ptr]()
    end

class DoubleType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMDoubleTypeInContext[_Ptr](c._p())
    else
      @LLVMDoubleType[_Ptr]()
    end

class X86FP80Type is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMX86FP80TypeInContext[_Ptr](c._p())
    else
      @LLVMX86FP80Type[_Ptr]()
    end

class FP128Type is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMFP128TypeInContext[_Ptr](c._p())
    else
      @LLVMFP128Type[_Ptr]()
    end

class PPCFP128Type is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMPPCFP128TypeInContext[_Ptr](c._p())
    else
      @LLVMPPCFP128Type[_Ptr]()
    end

class LabelType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMLabelTypeInContext[_Ptr](c._p())
    else
      @LLVMLabelType[_Ptr]()
    end

class IntegerType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(width': U32, context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMIntTypeInContext[_Ptr](width', c._p())
    else
      @LLVMIntType[_Ptr](width')
    end
  
  new i1(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMInt1TypeInContext[_Ptr](c._p())
    else
      @LLVMInt1Type[_Ptr]()
    end
  
  new i8(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMInt8TypeInContext[_Ptr](c._p())
    else
      @LLVMInt8Type[_Ptr]()
    end
  
  new i16(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMInt16TypeInContext[_Ptr](c._p())
    else
      @LLVMInt16Type[_Ptr]()
    end
  
  new i32(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMInt32TypeInContext[_Ptr](c._p())
    else
      @LLVMInt32Type[_Ptr]()
    end
  
  new i64(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMInt64TypeInContext[_Ptr](c._p())
    else
      @LLVMInt64Type[_Ptr]()
    end
  
  new i128(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMInt128TypeInContext[_Ptr](c._p())
    else
      @LLVMInt128Type[_Ptr]()
    end
  
  fun width(): U32 =>
    @LLVMGetIntTypeWidth[U32](_p())

class FunctionType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(ret: Type box, params: ReadSeq[Type], variadic: Bool = false) =>
    let ps = Array[_Ptr]
    for param in params.values() do ps.push(param._p()) end
    let va: I32 = if variadic then 1 else 0 end
    
    _ptr = @LLVMFunctionType[_Ptr](ret._p(), ps.cstring(), ps.size(), va)
  
  fun return_type(): this->Type! =>
    let p = @LLVMGetReturnType[_Ptr](_p())
    recover _TypeUtil._from_p(p) end
  
  fun param_types(): Iterator[this->Type!] =>
    let count = @LLVMCountParamTypes[U32](_p())
    let ps    = Array[_Ptr](count.usize())
    @LLVMGetParamTypes[None](_p(), ps)
    
    // TODO: refactor similar iterator-returners into sharing a function
    let params = recover iso Array[Type] end
    for p in ps.values() do
      params.push(recover _TypeUtil._from_p(p) end)
    end
    
    let params': this->Array[Type] = consume params
    (consume params').values()
  
  fun is_variadic(): Bool =>
    0 != @LLVMIsFunctionVarArg[I32](_p())

class StructType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(
    elems: ReadSeq[Type],
    packed: Bool,
    context': (Context | None) = None
  ) =>
    let es = Array[_Ptr]
    for elem in elems.values() do es.push(elem._p()) end
    let packed': I32 = if packed then 1 else 0 end
    
    _ptr = match context' | let c: Context =>
      @LLVMStructTypeInContext[_Ptr](c._p(), es.cstring(), es.size(), packed')
    else
      @LLVMStructType[_Ptr](es.cstring(), es.size(), packed')
    end
  
  new named(name': String, context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMStructCreateNamed[_Ptr](c._p(), name'.cstring())
    else
      let c_p = @LLVMGetGlobalContext[_Ptr]()
      @LLVMStructCreateNamed[_Ptr](c_p, name'.cstring())
    end
  
  fun name(): String =>
    let cstr = @LLVMGetStructName[Pointer[U8] val](_p())
    recover String.copy_cstring(cstr) end
  
  fun ref set_body(elems: ReadSeq[Type], packed: Bool) =>
    let es = Array[_Ptr]
    for elem in elems.values() do es.push(elem._p()) end
    let packed': I32 = if packed then 1 else 0 end
    
    @LLVMStructSetBody[None](_p(), es.cstring(), es.size(), packed')
  
  fun element_types(): Iterator[this->Type!] =>
    let count = @LLVMCountStructElementTypes[U32](_p())
    let ps    = Array[_Ptr](count.usize())
    @LLVMGetStructElementTypes[None](_p(), ps)
    
    // TODO: refactor similar iterator-returners into sharing a function
    let params = recover iso Array[Type] end
    for p in ps.values() do
      params.push(recover _TypeUtil._from_p(p) end)
    end
    
    let params': this->Array[Type] = consume params
    (consume params').values()
  
  fun element_type_at(index: U32): this->Type! =>
    let p = @LLVMGetStructElementTypes[_Ptr](_p(), index)
    recover _TypeUtil._from_p(p) end
  
  fun is_packed(): Bool =>
    0 != @LLVMIsPackedStruct[I32](_p())
  
  fun is_opaque(): Bool =>
    0 != @LLVMIsPackedStruct[I32](_p())

trait SequentialType is Type
  fun element_type(): this->Type! =>
    var p = @LLVMGetElementType[_Ptr](_p()) // TODO: use let (compiler bug)
    recover _TypeUtil._from_p(p) end

class ArrayType is SequentialType
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(elem: Type, size': U32) =>
    _ptr = @LLVMArrayType[_Ptr](elem._p(), size')
  
  fun size(): U32 =>
    @LLVMGetArrayLength[U32](_p())

class PointerType is SequentialType
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(elem: Type, address_space': U32) =>
    _ptr = @LLVMPointerType[_Ptr](elem._p(), address_space')
  
  fun address_space(): U32 =>
    @LLVMGetPointerAddressSpace[U32](_p())

class VectorType is SequentialType
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(elem: Type, size': U32) =>
    _ptr = @LLVMVectorType[_Ptr](elem._p(), size')
  
  fun size(): U32 =>
    @LLVMGetVectorSize[U32](_p())

class MetadataType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'

class X86MMXType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
  
  new create(context': (Context | None) = None) =>
    _ptr = match context' | let c: Context =>
      @LLVMX86MMXTypeInContext[_Ptr](c._p())
    else
      @LLVMX86MMXType[_Ptr]()
    end

class TokenType is Type
  let _ptr: _Ptr
  fun _p(): _Ptr => _ptr
  new _from_p(ptr': _Ptr) => _ptr = ptr'
