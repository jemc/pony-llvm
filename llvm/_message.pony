
primitive _Message
  fun apply(cstr: Pointer[U8] val): String =>
    let str = recover val String.copy_cstring(cstr) end
    @LLVMDisposeMessage[None](cstr)
    str
