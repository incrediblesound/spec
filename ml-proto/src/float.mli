(* WebAssembly-compatible wasm_float64 implementation *)

type wasm_float64 = int64 (* approximate *)

val float64_add : wasm_float64 -> wasm_float64 -> wasm_float64
val float64_sub : wasm_float64 -> wasm_float64 -> wasm_float64
val float64_mul : wasm_float64 -> wasm_float64 -> wasm_float64
val float64_div : wasm_float64 -> wasm_float64 -> wasm_float64
val float64_sqrt : wasm_float64 -> wasm_float64
val float64_min : wasm_float64 -> wasm_float64 -> wasm_float64
val float64_max : wasm_float64 -> wasm_float64 -> wasm_float64
val float64_ceil : wasm_float64 -> wasm_float64
val float64_floor : wasm_float64 -> wasm_float64
val float64_trunc : wasm_float64 -> wasm_float64
val float64_nearestint : wasm_float64 -> wasm_float64
val float64_abs : wasm_float64 -> wasm_float64
val float64_neg : wasm_float64 -> wasm_float64
val float64_copysign : wasm_float64 -> wasm_float64 -> wasm_float64
val float64_eq : wasm_float64 -> wasm_float64 -> bool
val float64_ne : wasm_float64 -> wasm_float64 -> bool
val float64_lt : wasm_float64 -> wasm_float64 -> bool
val float64_le : wasm_float64 -> wasm_float64 -> bool
val float64_gt : wasm_float64 -> wasm_float64 -> bool
val float64_ge : wasm_float64 -> wasm_float64 -> bool
