(* Created with the Wolfram Language : www.wolfram.com *)
{x_String /; StringMatchQ[x, RegularExpression["https://auth.cir.nii.ac.jp/.*"]] -> 
  voc["ci:*,authenticate,"]}
