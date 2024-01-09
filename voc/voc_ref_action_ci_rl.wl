(* Created with the Wolfram Language : www.wolfram.com *)
{x_ /; StringMatchQ[x, RegularExpression["https://auth.cir.nii.ac.jp/.*"]] -> 
  voc["ci:*,authenticate,"]}
