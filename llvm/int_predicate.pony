
trait val IntPredicate
  fun apply(): I32

primitive IntEQ  is IntPredicate fun apply(): I32 => 32
primitive IntNE  is IntPredicate fun apply(): I32 => 33
primitive IntUGT is IntPredicate fun apply(): I32 => 34
primitive IntUGE is IntPredicate fun apply(): I32 => 35
primitive IntULT is IntPredicate fun apply(): I32 => 36
primitive IntULE is IntPredicate fun apply(): I32 => 37
primitive IntSGT is IntPredicate fun apply(): I32 => 38
primitive IntSGE is IntPredicate fun apply(): I32 => 39
primitive IntSLT is IntPredicate fun apply(): I32 => 40
primitive IntSLE is IntPredicate fun apply(): I32 => 41

primitive _IntPredicateUtil
  fun tag _from_i32(code: I32): IntPredicate =>
    match code
    | 32 => IntEQ
    | 33 => IntNE
    | 34 => IntUGT
    | 35 => IntUGE
    | 36 => IntULT
    | 37 => IntULE
    | 38 => IntSGT
    | 39 => IntSGE
    | 40 => IntSLT
    | 41 => IntSLE
    else    IntEQ // should never happen
    end
