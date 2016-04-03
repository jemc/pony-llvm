
trait val RealPredicate
  fun apply(): I32

primitive RealPredicateFalse is RealPredicate fun apply(): I32 => 0
primitive RealOEQ            is RealPredicate fun apply(): I32 => 1
primitive RealOGT            is RealPredicate fun apply(): I32 => 2
primitive RealOGE            is RealPredicate fun apply(): I32 => 3
primitive RealOLT            is RealPredicate fun apply(): I32 => 4
primitive RealOLE            is RealPredicate fun apply(): I32 => 5
primitive RealONE            is RealPredicate fun apply(): I32 => 6
primitive RealORD            is RealPredicate fun apply(): I32 => 7
primitive RealUNO            is RealPredicate fun apply(): I32 => 8
primitive RealUEQ            is RealPredicate fun apply(): I32 => 9
primitive RealUGT            is RealPredicate fun apply(): I32 => 10
primitive RealUGE            is RealPredicate fun apply(): I32 => 11
primitive RealULT            is RealPredicate fun apply(): I32 => 12
primitive RealULE            is RealPredicate fun apply(): I32 => 13
primitive RealUNE            is RealPredicate fun apply(): I32 => 14
primitive RealPredicateTrue  is RealPredicate fun apply(): I32 => 15

primitive _RealPredicateUtil
  fun tag _from_i32(code: I32): RealPredicate =>
    match code
    | 0  => RealPredicateFalse
    | 1  => RealOEQ
    | 2  => RealOGT
    | 3  => RealOGE
    | 4  => RealOLT
    | 5  => RealOLE
    | 6  => RealONE
    | 7  => RealORD
    | 8  => RealUNO
    | 9  => RealUEQ
    | 10 => RealUGT
    | 11 => RealUGE
    | 12 => RealULT
    | 13 => RealULE
    | 14 => RealUNE
    | 15 => RealPredicateTrue
    else    RealPredicateFalse // should never happen
    end
