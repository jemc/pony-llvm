
primitive _Message
  fun copy_out(str: String box): Pointer[U8] val =>
    // TODO: confirm that LLVM doesn't clean up name strings as I suspect,
    // and replace this with something that won't leak memory in that case.
    @LLVMCreateMessage[Pointer[U8] val](str.cstring())
  
  fun copy_in(cstr: Pointer[U8] val): String =>
    let str = recover val String.copy_cstring(cstr) end
    @LLVMDisposeMessage[None](cstr)
    str
