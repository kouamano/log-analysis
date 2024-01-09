(* Created with the Wolfram Language : www.wolfram.com *)
{x_ /; StringMatchQ[x, RegularExpression["https://jdcat.jsps.go.jp/"]] -> 
  voc["wk:*,view,top"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/\\?.*"]] -> voc["wk:*,search,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/search.*"]] -> voc["wk:*,search,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/facet-search/.*"]] -> 
  voc["wk:*,search,facet"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/get_search_setting.*"]] -> 
  voc["wk:*,search,setting"], 
 x_ /; StringMatchQ[x, RegularExpression["https://jdcat.jsps.go.jp/robots.txt\
"]] -> voc["wk:robot,view,robot.txt"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/get_child_list.*"]] -> 
  voc["wk:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/journal_info.*"]] -> 
  voc["wk:system,internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/get_path_name_dict.*"]] -> 
  voc["wk:system,internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/accounts.*"]] -> 
  voc["wk:system,internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/records/[0-9]+$"]] -> voc["wk:*,view,detail"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/records/[0-9]+/export.*"]] -> 
  voc["wk:*,export,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/oai\\?.*"]] -> voc["wk:*,export,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/items.*"]] -> 
  voc["wk:Management,confirm,item"], 
 x_ /; StringMatchQ[x, RegularExpression["https://jdcat.jsps.go.jp/workflow.*\
"]] -> voc["wk:Management,confirm,workflow"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/admin.*"]] -> 
  voc["wk:Management,confirm,admin"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/login.*"]] -> voc["wk:*,authenticate,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/JDCatmetadata.html"]] -> 
  voc["wk:*,view,scheme"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/inform.html"]] -> 
  voc["wk:*,view,information"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/about"]] -> voc["wk:*,view,about"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/manual.html"]] -> voc["wk:*,view,manual"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/link.html"]] -> voc["wk:*,view,link_list"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/guidance.html"]] -> voc["wk:*,view,guide"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/analysis.html"]] -> voc["wk:*,view,analisys"]}
