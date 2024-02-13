(* Created with the Wolfram Language : www.wolfram.com *)
{x_String /; StringMatchQ[x, RegularExpression["https://jdcat.jsps.go.jp/"]] -> 
  voc["wk:*,view,top"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/\\?.*"]] -> voc["wk:*,search,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/search.*"]] -> voc["wk:*,search,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/facet-search/.*"]] -> 
  voc["wk:*,search,facet"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/get_search_setting.*"]] -> 
  voc["wk:*,search,setting"], 
 x_String /; StringMatchQ[x, RegularExpression["https://jdcat.jsps.go.jp/robots.txt\
"]] -> voc["wk:robot,view,robot.txt"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/get_child_list.*"]] -> 
  voc["wk:system,internalsystem_access,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/journal_info.*"]] -> 
  voc["wk:system,internalsystem_access"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/get_path_name_dict.*"]] -> 
  voc["wk:system,internalsystem_access"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/accounts.*"]] -> 
  voc["wk:system,internalsystem_access"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/records/[0-9]+$"]] -> voc["wk:*,view,detail"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/records/[0-9]+/export.*"]] -> 
  voc["wk:*,export,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/oai\\?.*"]] -> voc["wk:*,export,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/items.*"]] -> 
  voc["wk:Management,confirm,item"], 
 x_String /; StringMatchQ[x, RegularExpression["https://jdcat.jsps.go.jp/workflow.*\
"]] -> voc["wk:Management,confirm,workflow"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/admin.*"]] -> 
  voc["wk:Management,confirm,admin"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/login.*"]] -> voc["wk:*,authenticate,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/JDCatmetadata.html"]] -> 
  voc["wk:*,view,scheme"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/inform.html"]] -> 
  voc["wk:*,view,information"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/about"]] -> voc["wk:*,view,about"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/manual.html"]] -> voc["wk:*,view,manual"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/link.html"]] -> voc["wk:*,view,link_list"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/guidance.html"]] -> voc["wk:*,view,guide"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/analysis.html"]] -> voc["wk:*,view,analisys"]}
