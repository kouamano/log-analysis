(* Created with the Wolfram Language : www.wolfram.com *)
{x_ /; StringMatchQ[x, RegularExpression["https://jdcat.jsps.go.jp/"]] -> 
  voc["top"], x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/\\?.*"]] -> voc["search"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/search.*"]] -> voc["search"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/facet-search/.*"]] -> voc["search/facet"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/get_search_setting.*"]] -> 
  voc["search/setting"], 
 x_ /; StringMatchQ[x, RegularExpression["https://jdcat.jsps.go.jp/robots.txt\
"]] -> voc["robot"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/get_child_list.*"]] -> 
  voc["internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/journal_info.*"]] -> 
  voc["internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/get_path_name_dict.*"]] -> 
  voc["internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression["https://jdcat.jsps.go.jp/accounts.*\
"]] -> voc["internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/records/[0-9]+$"]] -> voc["detail"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/records/[0-9]+/export.*"]] -> voc["export"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/oai\\?.*"]] -> voc["export"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/items.*"]] -> voc["admin-function"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/workflow.*"]] -> voc["admin-function"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/admin.*"]] -> voc["admin-function"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/login.*"]] -> voc["authenticate"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/JDCatmetadata.html"]] -> voc["scheme"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/inform.html"]] -> voc["information"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/about"]] -> voc["about"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/manual.html"]] -> voc["manual"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/link.html"]] -> voc["link_list"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/guidance.html"]] -> voc["guide"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jdcat.jsps.go.jp/analysis.html"]] -> voc["analisys"]}
