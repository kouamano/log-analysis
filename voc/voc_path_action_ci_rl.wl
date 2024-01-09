(* Created with the Wolfram Language : www.wolfram.com *)
{x_ /; StringMatchQ[x, RegularExpression["https://cir.nii.ac.jp/"]] -> 
  voc["ci:*,view,top"], 
 x_ /; StringMatchQ[x, RegularExpression["https://cir.nii.ac.jp/ja"]] -> 
  voc["ci,*,view,top"], 
 x_ /; StringMatchQ[x, RegularExpression["https://cir.nii.ac.jp/\\?.*"]] -> 
  voc["ci:*,view,top"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/robots.txt"]] -> voc["ci:robot,view,robot.txt"], 
 x_ /; StringMatchQ[x, RegularExpression["https://cir.nii.ac.jp/all.*"]] -> 
  voc["ci:*,explore,all"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/articles.*"]] -> voc["ci:*,search,articles"], 
 x_ /; StringMatchQ[x, RegularExpression["https://cir.nii.ac.jp/books.*"]] -> 
  voc["ci:*,search,books"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/dissertations.*"]] -> 
  voc["ci:*,search,dssertations"], 
 x_ /; StringMatchQ[x, RegularExpression["https://cir.nii.ac.jp/data.*"]] -> 
  voc["ci:*,search,data"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/projects.*"]] -> voc["ci:*,search,projects"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid/[0-9]+/{0,1}(\\?){0,1}.*"]] -> 
  voc["ci:*,confirm,detail"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid/[0-9]+\\?.*"]] -> 
  voc["ci:*,confirm,detail"], 
 x_ /; StringMatchQ[x, RegularExpression["https://auth.cir.nii.ac.jp/.*"]] -> 
  voc["ci:*,authenticate,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid.*/refworks(\\?.*){0,1}"]] -> 
  voc["ci:*,export,bib"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid.*/endnote(\\?.*){0,1}"]] -> 
  voc["ci:*,export,bib"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid.*/mendeley(\\?.*){0,1}"]] -> 
  voc["ci:*,export,bib"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid.*\\.ris(\\?.*){0,1}"]] -> 
  voc["ci:*,export,bib"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid.*\\.bib(\\?.*){0,1}"]] -> 
  voc["ci:*,export,bib"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid.*\\.bix(\\?.*){0,1}"]] -> 
  voc["ci:*,export,bib"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid.*\\.json(\\?.*){0,1}"]] -> 
  voc["ci:*,export,bib"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid.*\\.tsv(\\?.*){0,1}"]] -> 
  voc["ci*,export,bib"], 
 x_ /; StringMatchQ[x, RegularExpression["https://cir.nii.ac.jp/api/.*"]] -> 
  voc["ci:*,request,api"], 
 x_ /; StringMatchQ[x, RegularExpression["https://cir.nii.ac.jp/opensearch/.*\
"]] -> voc["ci:*,request,api"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/resourcesync/.*"]] -> 
  voc["ci:*,request,resourcesync"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://cir.nii.ac.jp/crid/[0-9]+\\.rdf.*"]] -> voc["ci:*,request,rdf"]}
