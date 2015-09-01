(* WebAssembly-compatible wasm_float64 implementation *)

type wasm_float64 = int64 (* approximate *)

let float_of_bits x = 0.0 (* TODO *)
let bits_of_float f = 0   (* TODO *)

let isnan f = f <> f

(* TODO: Do something meaningful with nondeterminism *)
let float64_nondeterministic_nan =
  0x7fff0f0f0f0f0f0f

let float64_add x y =
  let f = (float_of_bits x) +. (float_of_bits y) in
  if isnan f then float64_nondeterministic_nan else bits_of_float f

let float64_sub x y =
  let f = (float_of_bits x) -. (float_of_bits y) in
  if isnan f then float64_nondeterministic_nan else bits_of_float f

let float64_mul x y =
  let f = (float_of_bits x) *. (float_of_bits y) in
  if isnan f then float64_nondeterministic_nan else bits_of_float f

let float64_div x y =
  let f = (float_of_bits x) /. (float_of_bits y) in
  if isnan f then float64_nondeterministic_nan else bits_of_float f

let float64_sqrt x =
  let f = sqrt (float_of_bits x) in
  if isnan f then float64_nondeterministic_nan else bits_of_float f

let float64_min x y =
  let xf = float_of_bits x in
  let yf = float_of_bits y in
  (* min(-0, 0) is -0 *)
  if xf = 0.0 && yf = 0.0 then x lor y else
  if xf < yf then x else
  if xf > yf then y else
  float64_nondeterministic_nan

let float64_max x y =
  let xf = float_of_bits x in
  let yf = float_of_bits y in
  (* max(-0, 0) is 0 *)
  if xf = 0.0 && yf = 0.0 then x land y else
  if xf > yf then x else
  if xf < yf then y else
  float64_nondeterministic_nan

let float64_ceil x =
  let f = ceil (float_of_bits x) in
  if isnan f then float64_nondeterministic_nan else bits_of_float f

let float64_floor x =
  let f = floor (float_of_bits x) in
  if isnan f then float64_nondeterministic_nan else bits_of_float f

let float64_trunc x =
  let xf = float_of_bits x in
  (* preserve the sign of zero *)
  if xf = 0.0 then x else
  (* trunc is either ceil or floor depending on which one is toward zero *)
  let f = if xf < 0.0 then ceil xf else floor xf
  if isnan f then float64_nondeterministic_nan else bits_of_float f

let float64_nearestint x =
  let xf = float_of_bits x in
  (* preserve the sign of zero *)
  if xf = 0.0 then x else
  (* nearestint is either ceil or floor depending on which is nearest or even *)
  let u = ceil xf in
  let d = floor xf in
  let um = abs_float (xf -. u) in
  let dm = abs_float (xf -. d) in
  let u_or_d = um < dm || ((um = dm) && (((bits_of_float u) land 1) = 0)) in
  let f = if u_or_d then u else d in
  if isnan f then float64_nondeterministic_nan else bits_of_float f

(* abs, neg, and copysign are purely bitwise operations, even on NaN values *)
let float64_abs x =
  x land 0x7fffffffffffffff

let float64_neg x =
  x lxor (-0x7fffffffffffffff - 1)

let float64_copysign x y =
  (float64_abs x) lor (y land (-0x7fffffffffffffff - 1))

let float64_eq x y = (float_of_bits x) =  (float_of_bits y)
let float64_ne x y = (float_of_bits x) <> (float_of_bits y)
let float64_lt x y = (float_of_bits x) <  (float_of_bits y)
let float64_gt x y = (float_of_bits x) >  (float_of_bits y)
let float64_le x y = (float_of_bits x) <= (float_of_bits y)
let float64_ge x y = (float_of_bits x) >= (float_of_bits y)
