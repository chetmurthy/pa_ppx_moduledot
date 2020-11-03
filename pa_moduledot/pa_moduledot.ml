(* camlp5r *)
(* pa_moduledot.ml,v *)
(* Copyright (c) INRIA 2007-2017 *)

open Pa_ppx_base ;
open Pa_passthru ;
open Ppxutil ;

value extended_longident_of_expr e =
  let rec exrec = fun [
    <:expr< $longid:li$ >> -> li
  | <:expr:< $e1$ $e2$ >> -> <:extended_longident< $longid:exrec e1$ ( $longid:exrec e2$ ) >>
  | e -> Ploc.raise (MLast.loc_of_expr e) (Failure "extended_longident_of_expr: unsupported expression")
  ] in
  exrec e
;

value rewrite_expr arg = fun [
  <:expr:< [%"module" $exp:e$ ;] . $lid:member$ >> ->
    let me = module_expr_of_longident (extended_longident_of_expr e) in
    <:expr< let module M__ = $me$ in M__. $lid:member$ >>
| _ -> assert False
]
;

value install () = 
let ef = EF.mk () in 
let ef = EF.{ (ef) with
            expr = extfun ef.expr with [
    <:expr:< [%"module" $exp:_$;] . $lid:_$ >> as z ->
    fun arg fallback ->
      Some (rewrite_expr arg z)
  ] } in
  Pa_passthru.(install { name = "pa_moduledot"; ef =  ef ; pass = None ; before = [] ; after = [] })
;

install();
