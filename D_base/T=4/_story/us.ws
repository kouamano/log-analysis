Print["START"]
(* Setting *)
Print["Setting"]
(*basedir = "/Volumes/home/NII/togo-log/rcoslogs/log/"*)
basedir = "/home/amano/notebooks/data/rcoslogs/log/"
Protect[undefined]

(* voc data *)
Print["voc data"]
(*vocrldir = "/Users/kouamano/gitsrc/log-analysis/voc"*)
vocrldir = "/home/amano/notebooks/data/rcoslogs/voc"
vocRlFiles = FileNames[vocrldir <> "/*rl.wl"]
(vocRlList = Map[Get, vocRlFiles]) // Length
(vocRl["all:path"] = Apply[Join, vocRlList]) // Dimensions
voclist = 
 Sort[Union[Join[Map[#[[2]] &, vocRl["all:path"]], {undefined[]}]]]
voclistEffPos = 
 Flatten[{Table[n, {n, 2, 7}], Table[n, {n, 10, 25}], 
   Table[n, {n, 27, 31}], Table[n, {n, 33, 42}], 
   Table[n, {n, 44, 46}], Table[n, {n, 48, 56}]}]
(voclistEff = voclist[[voclistEffPos]]) // TableForm
vertexLabelList[g_] := Module[{gs, defg},
  gs = ToString[InputForm[g]];
  defg = ToExpression[StringReplace[gs, "Graph" -> "defGraph"]];
  Cases[defg, _voc, Infinity]
  ];
vocQ["all"] = Map[StringSplit[#[[1]], {",", ":"}] &, voclistEff]
vocSubject["all"] = Union[vocQ["all"][[All, 2]]]
vocActivity["all"] = Union[vocQ["all"][[All, 3]]]
vocObject["all"] = Select[vocQ["all"], Length[#] > 3 &][[All, 4]]

(* RDM-ontology map data *)
ontologyfile = \
"/home/amano/gitsrc/log-analysis/rdm-ontology_vs_voc/ログ基盤ボキャブラリとのマッピング_V3.xlsx"
xls = Import[ontologyfile];
(xlssheet = xls[[1]]) // Dimensions

(** ci **)
Print["sheet: ci"]
xlssheetBase["ci"] = Cases[xlssheet, x_ /; x[[1]] == "ci"]
BaseRl["ci", "subject"] = 
 Map[#[[2]] -> #[[3]] &, xlssheetBase["ci"]] // Union
BaseRlrev["ci", "subject"] = 
 Append[Map[#[[3]] -> #[[2]] &, xlssheetBase["ci"]] // Union, 
  "rdm:Person" -> "many-match"]
BaseRl["ci", "activity"] = 
 Map[#[[4]] -> #[[5]] &, xlssheetBase["ci"]] // Union
BaseRlrev["ci", "activity"] = 
 DeleteCases[Map[#[[5]] -> #[[4]] &, xlssheetBase["ci"]] // Union, 
  Rule["UD", _]]
BaseRl["ci", "object"] = 
 Map[#[[6]] -> #[[7]] &, xlssheetBase["ci"]] // Union
BaseRlrev["ci", "object"] = 
 DeleteCases[
  Append[Map[#[[7]] -> #[[6]] &, xlssheetBase["ci"]] // Union, 
   "rdm:Resource" -> "many-match"], Rule["UD", _]]

(** cs **)
Print["sheet: cs"]
xlssheetBase["cs"] = Cases[xlssheet, x_ /; x[[1]] == "cs"]
BaseRl["cs", "subject"] = 
 Map[#[[2]] -> #[[3]] &, xlssheetBase["cs"]] // Union
BaseRlrev["cs", "subject"] = 
 Append[Map[#[[3]] -> #[[2]] &, xlssheetBase["cs"]] // Union, 
  "rdm:Person" -> "many-match"]
BaseRl["cs", "activity"] = 
 Map[#[[4]] -> #[[5]] &, xlssheetBase["cs"]] // Union
BaseRlrev["cs", "activity"] = 
 DeleteCases[Map[#[[5]] -> #[[4]] &, xlssheetBase["cs"]] // Union, 
  Rule["UD", _]]
BaseRl["cs", "object"] = 
 Map[#[[6]] -> #[[7]] &, xlssheetBase["cs"]] // Union
BaseRlrev["cs", "object"] = 
 DeleteCases[
  Append[Map[#[[7]] -> #[[6]] &, xlssheetBase["cs"]] // Union, 
   "rdm:Resource" -> "many-match"], Rule["UD", _]]

(** la **)
Print["sheet: la"]
xlssheetBase["la"] = Cases[xlssheet, x_ /; x[[1]] == "la"]
BaseRl["la", "subject"] = 
 Map[#[[2]] -> #[[3]] &, xlssheetBase["la"]] // Union
BaseRlrev["la", "subject"] = 
 Append[Map[#[[3]] -> #[[2]] &, xlssheetBase["la"]] // Union, 
  "rdm:Person" -> "many-match"]
BaseRl["la", "activity"] = 
 Map[#[[4]] -> #[[5]] &, xlssheetBase["la"]] // Union
BaseRlrev["la", "activity"] = 
 DeleteCases[Map[#[[5]] -> #[[4]] &, xlssheetBase["la"]] // Union, 
  Rule["UD", _]]
BaseRl["la", "object"] = 
 Map[#[[6]] -> #[[7]] &, xlssheetBase["la"]] // Union
BaseRlrev["la", "object"] = 
 DeleteCases[
  Append[Map[#[[7]] -> #[[6]] &, xlssheetBase["la"]] // Union, 
   "rdm:Resource" -> "many-match"], Rule["UD", _]]

(** wk **)
Print["sheet: wk"]
xlssheetBase["wk"] = Cases[xlssheet, x_ /; x[[1]] == "wk"]
BaseRl["wk", "subject"] = 
 Map[#[[2]] -> #[[3]] &, xlssheetBase["wk"]] // Union
BaseRlrev["wk", "subject"] = 
 Append[Map[#[[3]] -> #[[2]] &, xlssheetBase["wk"]] // Union, 
  "rdm:Person" -> "many-match"]
BaseRl["wk", "activity"] = 
 Map[#[[4]] -> #[[5]] &, xlssheetBase["wk"]] // Union
BaseRlrev["wk", "activity"] = 
 DeleteCases[Map[#[[5]] -> #[[4]] &, xlssheetBase["wk"]] // Union, 
  Rule["UD", _]]
BaseRl["wk", "object"] = 
 Map[#[[6]] -> #[[7]] &, xlssheetBase["wk"]] // Union
BaseRlrev["wk", "object"] = 
 DeleteCases[
  Append[Map[#[[7]] -> #[[6]] &, xlssheetBase["wk"]] // Union, 
   "rdm:Resource" -> "many-match"], Rule["UD", _]]

(** extract mapping terms **)
Print["map terms"]
APSubject["all"] = 
 Select[Drop[xlssheet, 1][[All, 3]] // Union, StringLength[#] > 0 &]
APActivity["all"] = 
 Select[Drop[xlssheet, 1][[All, 5]] // Union, StringLength[#] > 0 &]
APObject["all"] = 
 Select[Drop[xlssheet, 1][[All, 7]] // Union, StringLength[#] > 0 &]
APvocSubject["all"] = 
 Select[Drop[xlssheet[[2 ;; 50]], 1][[All, 2]] // Union, 
  StringLength[#] > 0 &]
APvocActivity["all"] = 
 Select[Drop[xlssheet, 1][[All, 4]] // Union, StringLength[#] > 0 &]
APvocObject["all"] = 
 Select[Drop[xlssheet, 1][[All, 6]] // Union, StringLength[#] > 0 &]
Complement[vocSubject["all"], APvocSubject["all"]]
Complement[vocActivity["all"], APvocActivity["all"]]
Complement[vocSubject["all"], APvocSubject["all"]]

(* User story *)
Print["User story"]
(** data **)
Print["User story: data"]
basedir <> "2022NII-RDCユーザーストーリー・機能対応表_V2.1.xlsx"
userStoryXlsx = 
  Import[basedir <> "2022NII-RDCユーザーストーリー・機能対応表_V2.1.xlsx"];
userStoryOtlSheet = userStoryXlsx[[3]][[2 ;; 190]];
(userStoryOtl["all"] = 
   Map[{#[[1]], #[[20]], #[[8]], "rdm:" <> #[[9]], "rdm:" <> #[[11]], 
      "rdm:" <> #[[13]]} &, userStoryOtlSheet]) // Length
userStoryOtlHead = userStoryXlsx[[3]][[1]][[{1, 20, 8, 9, 11, 13}]]
Cases[userStoryOtl["all"], x_ /; x[[2]] == "-"]
(userStoryOtl["sel"] = 
   Cases[userStoryOtl["all"], x_ /; x[[2]] != "-"]) // Length
rdmSubjectToUS["all"] = 
  Map[{#[[2]], #[[4]] -> #[[1]]} &, userStoryOtl["sel"]];
rdmActivityToUS["all"] = 
  Map[{#[[2]], #[[5]] -> #[[1]]} &, userStoryOtl["sel"]];
rdmObjectToUS["all"] = 
  Map[{#[[2]], #[[6]] -> #[[1]]} &, userStoryOtl["sel"]];
rdmSubjectToUS["ci"] = Cases[rdmSubjectToUS["all"], {"ci", __}]
rdmActivityToUS["ci"] = Cases[rdmActivityToUS["all"], {"ci", __}]
rdmObjectToUS["ci"] = Cases[rdmObjectToUS["all"], {"ci", __}]
rdmSubjectToUS["cs"] = Cases[rdmSubjectToUS["all"], {"cs", __}]
rdmActivityToUS["cs"] = Cases[rdmActivityToUS["all"], {"cs", __}]
rdmObjectToUS["cs"] = Cases[rdmObjectToUS["all"], {"cs", __}]
rdmSubjectToUS["la"] = Cases[rdmSubjectToUS["all"], {"la", __}]
rdmActivityToUS["la"] = Cases[rdmActivityToUS["all"], {"la", __}]
rdmObjectToUS["la"] = Cases[rdmObjectToUS["all"], {"la", __}]
rdmSubjectToUS["wk"] = Cases[rdmSubjectToUS["all"], {"wk", __}]
rdmActivityToUS["wk"] = Cases[rdmActivityToUS["all"], {"wk", __}]
rdmObjectToUS["wk"] = Cases[rdmObjectToUS["all"], {"wk", __}]

(** Duplicate check**)
Print["Duplicate check"]
dupRl[list_] := Module[{car, cdr},
  car = list[[1]];
  cdr = list[[2 ;;]];
  Map[# -> car &, cdr]
  ]
userStoryOtl["sel"] // Dimensions
(Gather[userStoryOtl[
    "sel"], #1[[2 ;; 6]] == #2[[2 ;; 6]] &]) // Length
(Gather[userStoryOtl[
    "sel"], #1[[3 ;; 6]] == #2[[3 ;; 6]] &]) // Length

usCount["gr"] = (userStoryOtl["sel", "gr"] = 
    Cases[userStoryOtl["sel"], {_, "gr", __}]) // Length
usCount["gr", 
  "uniq"] = (userStoryOtlGt["sel", "gr"] = 
    Gather[userStoryOtl["sel", 
      "gr"], #1[[2 ;; 6]] == #2[[2 ;; 6]] &]) // Length
usDupPos["gr"] = 
 Flatten[Position[Map[Length, userStoryOtlGt["sel", "gr"]], 
   x_ /; x != 1]]
usDupList["gr"] = 
 Map[#[[1]] &, userStoryOtlGt["sel", "gr"][[usDupPos["gr"]]], {2}]
usDupRl["gr"] = Map[dupRl[#] &, usDupList["gr"]]

usCount["dg"] = (userStoryOtl["sel", "dg"] = 
    Cases[userStoryOtl["sel"], {_, "dg", __}]) // Length
usCount["dg", 
  "uniq"] = (userStoryOtlGt["sel", "dg"] = 
    Gather[userStoryOtl["sel", 
      "dg"], #1[[2 ;; 6]] == #2[[2 ;; 6]] &]) // Length
usDupPos["dg"] = 
 Flatten[Position[Map[Length, userStoryOtlGt["sel", "dg"]], 
   x_ /; x != 1]]
usDupList["dg"] = 
 Map[#[[1]] &, userStoryOtlGt["sel", "dg"][[usDupPos["dg"]]], {2}]
usDupRl["dg"] = Map[dupRl[#] &, usDupList["dg"]]

usCount["dp"] = (userStoryOtl["sel", "dp"] = 
    Cases[userStoryOtl["sel"], {_, "dp", __}]) // Length
usCount["dp", 
  "uniq"] = (userStoryOtlGt["sel", "dp"] = 
    Gather[userStoryOtl["sel", 
      "dp"], #1[[2 ;; 6]] == #2[[2 ;; 6]] &]) // Length
usDupPos["dp"] = 
 Flatten[Position[Map[Length, userStoryOtlGt["sel", "dp"]], 
   x_ /; x != 1]]
usDupList["dp"] = 
 Map[#[[1]] &, userStoryOtlGt["sel", "dp"][[usDupPos["dp"]]], {2}]
usDupRl["dp"] = Map[dupRl[#] &, usDupList["dp"]]

usCount["ci"] = (userStoryOtl["sel", "ci"] = 
    Cases[userStoryOtl["sel"], {_, "ci", __}]) // Length
usCount["ci", 
  "uniq"] = (userStoryOtlGt["sel", "ci"] = 
    Gather[userStoryOtl["sel", 
      "ci"], #1[[2 ;; 6]] == #2[[2 ;; 6]] &]) // Length
usDupPos["ci"] = 
 Flatten[Position[Map[Length, userStoryOtlGt["sel", "ci"]], 
   x_ /; x != 1]]
usDupList["ci"] = 
 Map[#[[1]] &, userStoryOtlGt["sel", "ci"][[usDupPos["ci"]]], {2}]
usDupRl["ci"] = Map[dupRl[#] &, usDupList["ci"]]

usCount["cs"] = (userStoryOtl["sel", "cs"] = 
    Cases[userStoryOtl["sel"], {_, "cs", __}]) // Length
usCount["cs", 
  "uniq"] = (userStoryOtlGt["sel", "cs"] = 
    Gather[userStoryOtl["sel", 
      "cs"], #1[[2 ;; 6]] == #2[[2 ;; 6]] &]) // Length
usDupPos["cs"] = 
 Flatten[Position[Map[Length, userStoryOtlGt["sel", "cs"]], 
   x_ /; x != 1]]
usDupList["cs"] = 
 Map[#[[1]] &, userStoryOtlGt["sel", "cs"][[usDupPos["cs"]]], {2}]
usDupRl["cs"] = Map[dupRl[#] &, usDupList["cs"]]

usCount["la"] = (userStoryOtl["sel", "la"] = 
    Cases[userStoryOtl["sel"], {_, "la", __}]) // Length
usCount["la", 
  "uniq"] = (userStoryOtlGt["sel", "la"] = 
    Gather[userStoryOtl["sel", 
      "la"], #1[[2 ;; 6]] == #2[[2 ;; 6]] &]) // Length
usDupPos["la"] = 
 Flatten[Position[Map[Length, userStoryOtlGt["sel", "la"]], 
   x_ /; x != 1]]
usDupList["la"] = 
 Map[#[[1]] &, userStoryOtlGt["sel", "la"][[usDupPos["la"]]], {2}]
usDupRl["la"] = Map[dupRl[#] &, usDupList["la"]]

usCount["wk"] = (userStoryOtl["sel", "wk"] = 
    Cases[userStoryOtl["sel"], {_, "wk", __}]) // Length
usCount["wk", 
  "uniq"] = (userStoryOtlGt["sel", "wk"] = 
    Gather[userStoryOtl["sel", 
      "wk"], #1[[2 ;; 6]] == #2[[2 ;; 6]] &]) // Length
usDupPos["wk"] = 
 Flatten[Position[Map[Length, userStoryOtlGt["sel", "wk"]], 
   x_ /; x != 1]]
usDupList["wk"] = 
 Map[#[[1]] &, userStoryOtlGt["sel", "wk"][[usDupPos["wk"]]], {2}]
usDupRl["wk"] = Map[dupRl[#] &, usDupList["wk"]]

usDupRl["All"] = 
 Flatten[{usDupRl["gr"], usDupRl["dp"], usDupRl["dg"], usDupRl["ci"], 
   usDupRl["cs"], usDupRl["la"], usDupRl["wk"], {"番号" -> "重複"}}]


(** appearance of ontology term **)
USSubject["all"] = userStoryOtl["sel"][[All, 4]] // Union
USActivity["all"] = 
 Select[userStoryOtl["sel"][[All, 5]] // Union, StringLength[#] > 4 &]
USObject["all"] = 
 DeleteCases[
  Select[userStoryOtl["sel"][[All, 6]] // Union, 
   StringLength[#] > 4 &], 
  x_ /; StringMatchQ[x, RegularExpression["rdm:なし.*"]]]
Complement[USSubject["all"], APSubject["all"]]
Complement[USActivity["all"], APActivity["all"]]
Complement[USObject["all"], APObject["all"]]

(** Reverse match **)
Print["Reverse match"]
(revMatch[
    "ci"] = (Map[{#[[1]], #[[4]] /. 
        BaseRlrev["ci", "subject"], #[[5]] /. 
        BaseRlrev["ci", "activity"], #[[6]] /. 
        BaseRlrev["ci", "object"]} &, 
     userStoryOtl["sel", "ci"]])) // TableForm
(revNoMatchCase["ci"] = 
   Cases[revMatch["ci"], 
    x_ /; StringMatchQ[x[[3]], RegularExpression["rdm:.*"]] && 
      StringMatchQ[x[[4]], RegularExpression["rdm:.*"]]]) // Length
Map[#[[1]] &, revNoMatchCase["ci"]]

(revMatch[
    "cs"] = (Map[{#[[1]], #[[4]] /. 
        BaseRlrev["cs", "subject"], #[[5]] /. 
        BaseRlrev["cs", "activity"], #[[6]] /. 
        BaseRlrev["cs", "object"]} &, 
     userStoryOtl["sel", "cs"]])) // TableForm
(revNoMatchCase["cs"] = 
   Cases[revMatch["cs"], 
    x_ /; StringMatchQ[x[[3]], RegularExpression["rdm:.*"]] && 
      StringMatchQ[x[[4]], RegularExpression["rdm:.*"]]]) // Length
Map[#[[1]] &, revNoMatchCase["cs"]]

(revMatch[
    "la"] = (Map[{#[[1]], #[[4]] /. 
        BaseRlrev["la", "subject"], #[[5]] /. 
        BaseRlrev["la", "activity"], #[[6]] /. 
        BaseRlrev["la", "object"]} &, 
     userStoryOtl["sel", "la"]])) // TableForm
(revNoMatchCase["la"] = 
   Cases[revMatch["la"], 
    x_ /; StringMatchQ[x[[3]], RegularExpression["rdm:.*"]] && 
      StringMatchQ[x[[4]], RegularExpression["rdm:.*"]]]) // Length
Map[#[[1]] &, revNoMatchCase["la"]]

(revMatch[
    "wk"] = (Map[{#[[1]], #[[4]] /. 
        BaseRlrev["wk", "subject"], #[[5]] /. 
        BaseRlrev["wk", "activity"], #[[6]] /. 
        BaseRlrev["wk", "object"]} &, 
     userStoryOtl["sel", "wk"]])) // TableForm
(revNoMatchCase["wk"] = 
   Cases[revMatch["wk"], 
    x_ /; StringMatchQ[x[[3]], RegularExpression["rdm:.*"]] && 
      StringMatchQ[x[[4]], RegularExpression["rdm:.*"]]]) // Length
Map[#[[1]] &, revNoMatchCase["wk"]]

(* Graph *)
Print["Graph"]
"/home/amano/notebooks/data/rcoslogs/log/D=" <> date <> \
"/T=4/_story/storyGrIdxFlDs3." <> date <> ".save"
Get["/home/amano/notebooks/data/rcoslogs/log/D=" <> date <> 
   "/T=4/_story/storyGrIdxFlDs3." <> date <> ".save"];
(dstEdgeListList[4][date] = 
   Map[Map[#[[2]] &, EdgeList[#[[3]]]] &, 
    storyGrIdxFlDs3[4][date]]) // Length
(vocListList[4][date] = 
   dstEdgeListList[4][date] /. vocRl["all:path"]) // Length
(vocListFlt[4][date] = 
   Flatten[dstEdgeListList[4][date] /. 
     vocRl["all:path"]]) // Dimensions

(*voc-term vs. ontology-term match*)
quartPreCount = (quartPre = 
    Map[StringSplit[#[[1]], {":", ","}] &, vocListFlt[4][date]]) // 
  Length
quartCount = (quart = Cases[quartPre, x_ /; Head[x] == List]) // 
  Length
Cases[quartPre, x_ /; Head[x] == StringSplit] // Length
quartCount/quartPreCount // N
Map[Length, quart] // Tally
(vocQ["ci"] = Cases[quart, {"ci", __}]) // Length
(vocQ["cs"] = Cases[quart, {"cs", __}]) // Length
(vocQ["la"] = Cases[quart, {"la", __}]) // Length
(vocQ["wk"] = Cases[quart, {"wk", __}]) // Length

(** match ci **)
rdmMap["ci"][vocq_] := {vocq[[1]], 
  vocq[[2]] /. BaseRl["ci", "subject"], 
  vocq[[3]] /. BaseRl["ci", "activity"], 
  vocq[[4]] /. BaseRl["ci", "object"]}
(rdmOtlQ["ci"] = Map[rdmMap["ci"][#] &, vocQ["ci"]]) // Length
matchPos["ci"] = 
  Position[rdmOtlQ["ci"], 
   x_String /; StringTake[x, 3] == "rdm" || x == "--"];
(matchPosGath["ci"] = 
   Gather[matchPos["ci"], First[#1] == First[#2] &]) // Length
(rdmOtlQTly["ci"] = Tally[rdmOtlQ["ci"]]) /. {"--" -> 
    "rdm:--"} // TableForm
Map[#[[1, 3]] /. Map[#[[2]] &, rdmActivityToUS["ci"]] &, 
 rdmOtlQTly["ci"]]
Map[#[[1, 3]] /. Map[#[[2]] &, rdmObjectToUS["ci"]] &, 
 rdmOtlQTly["ci"]]
Map[#[[2]] &, 
  Cases[rdmOtlQTly["ci"], x_ /; x[[1, 2]] != "system"]] // Total
Map[#[[2]] &, 
  Cases[rdmOtlQTly["ci"], 
   x_ /; x[[1, 2]] != 
      "system" && (StringMatchQ[x[[1, 3]], 
        RegularExpression["rdm:.*"]] || 
       StringMatchQ[x[[1, 4]], 
        RegularExpression["rdm:.*"]])]] // Total
userStoryOtl["sel", "ci"]
(rdmOtlS["ci"] = Map[#[[1, 2]] &, rdmOtlQTly["ci"]]) // Length
Map[Position[userStoryOtl["sel", "ci"], #] &, rdmOtlS["ci"]]
rdmOtlSMP["sel", "ci"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "ci"], #] &, 
     rdmOtlS["ci"]], {_, _}, {2}]] // Union
addPosS["ci"] = Table[i, {i, Length[userStoryOtl["sel", "ci"]]}]
rdmOtlSMP["sel", "ci"] = Union[rdmOtlSMP["sel", "ci"], addPosS["ci"]]
matchSinLog["ci", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "ci"]]], 
  Map[# -> "S" &, rdmOtlSMP["sel", "ci"]]]
(rdmOtlV["ci"] = Map[#[[1, 3]] &, rdmOtlQTly["ci"]]) // Length
Map[Position[userStoryOtl["sel", "ci"], #] &, rdmOtlV["ci"]]
rdmOtlVMP["sel", "ci"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "ci"], #] &, 
     rdmOtlV["ci"]], {_, _}, {2}]] // Union
matchVinLog["ci", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "ci"]]], 
  Map[# -> "V" &, rdmOtlVMP["sel", "ci"]]]
rdmOtlO["ci"] = Map[#[[1, 4]] &, rdmOtlQTly["ci"]]
Map[Position[userStoryOtl["sel", "ci"], #] &, rdmOtlO["ci"]]
rdmOtlOMP["sel", "ci"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "ci"], #] &, 
     rdmOtlO["ci"]], {_, _}, {2}]] // Union
matchOinLog["ci", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "ci"]]], 
  Map[# -> "O" &, rdmOtlOMP["sel", "ci"]]]
Union[rdmOtlVMP["sel", "ci"], rdmOtlOMP["sel", "ci"]]
userStoryOtl["sel", "ci"][[
 Union[rdmOtlVMP["sel", "ci"], rdmOtlOMP["sel", "ci"]]]]
(nonappUS["ci"] = 
   Delete[userStoryOtl["sel", "ci"], 
    Map[{#} &, 
     Union[rdmOtlVMP["sel", "ci"], 
      rdmOtlOMP["sel", "ci"]]]]) // TableForm
(usSVOMatch["sel", "ci"] = {Map[#[[1]] &, userStoryOtl["sel", "ci"]], 
    matchSinLog["ci", date], matchVinLog["ci", date], 
    matchOinLog["ci", date]}) // TableForm

(** match cs **)
rdmMap["cs"][vocq_] := {vocq[[1]], 
  vocq[[2]] /. BaseRl["cs", "subject"], 
  vocq[[3]] /. BaseRl["cs", "activity"], 
  vocq[[4]] /. BaseRl["cs", "object"]}
(rdmOtlQ["cs"] = Map[rdmMap["cs"][#] &, vocQ["cs"]]) // Length
matchPos["cs"] = 
  Position[rdmOtlQ["cs"], 
   x_String /; StringTake[x, 3] == "rdm" || x == "--"];
(matchPosGath["cs"] = 
   Gather[matchPos["cs"], First[#1] == First[#2] &]) // Length
(rdmOtlQTly["cs"] = Tally[rdmOtlQ["cs"]]) /. {"--" -> "rdm:--", 
   Part[List_, _] -> "_no-option_"} // TableForm
Map[#[[1, 3]] /. Map[#[[2]] &, rdmActivityToUS["cs"]] &, 
 rdmOtlQTly["cs"]]
Map[#[[1, 3]] /. Map[#[[2]] &, rdmObjectToUS["cs"]] &, 
 rdmOtlQTly["cs"]]
Map[#[[2]] &, 
  Cases[rdmOtlQTly["cs"], x_ /; x[[1, 2]] != "system"]] // Total
Map[#[[2]] &, 
  Cases[rdmOtlQTly["cs"], 
   x_ /; x[[1, 2]] != 
      "system" && (StringMatchQ[x[[1, 3]], 
        RegularExpression["rdm:.*"]] || 
       StringMatchQ[x[[1, 4]], 
        RegularExpression["rdm:.*"]])]] // Total
(rdmOtlS["cs"] = Map[#[[1, 2]] &, rdmOtlQTly["cs"]])
Map[Position[userStoryOtl["sel", "cs"], #] &, rdmOtlS["cs"]]
rdmOtlSMP["sel", "cs"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "cs"], #] &, 
     rdmOtlS["cs"]], {_, _}, {2}]] // Union
addPosS["cs"] = Table[i, {i, Length[userStoryOtl["sel", "cs"]]}]
rdmOtlSMP["sel", "cs"] = Union[rdmOtlSMP["sel", "cs"], addPosS["cs"]]
matchSinLog["cs", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "cs"]]], 
  Map[# -> "S" &, rdmOtlSMP["sel", "cs"]]]
rdmOtlV["cs"] = Map[#[[1, 3]] &, rdmOtlQTly["cs"]]
rdmOtlVMP["sel", "cs"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "cs"], #] &, 
     rdmOtlV["cs"]], {_, _}, {2}]] // Union
matchVinLog["cs", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "cs"]]], 
  Map[# -> "V" &, rdmOtlVMP["sel", "cs"]]]
rdmOtlO["cs"] = Map[#[[1, 4]] &, rdmOtlQTly["cs"]]
rdmOtlOMP["sel", "cs"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "cs"], #] &, 
     rdmOtlO["cs"]], {_, _}, {2}]] // Union
matchOinLog["cs", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "cs"]]], 
  Map[# -> "O" &, rdmOtlOMP["sel", "cs"]]]
userStoryOtl["sel", "cs"][[
 Union[rdmOtlVMP["sel", "cs"], rdmOtlOMP["sel", "cs"]]]]
nonappUS["cs"] = 
 Delete[userStoryOtl["sel", "cs"], 
  Map[{#} &, Union[rdmOtlVMP["sel", "cs"], rdmOtlOMP["sel", "cs"]]]]
(usSVOMatch["sel", "cs"] = {Map[#[[1]] &, userStoryOtl["sel", "cs"]], 
    matchSinLog["cs", date], matchVinLog["cs", date], 
    matchOinLog["cs", date]}) // TableForm

(** match la **)
rdmMap["la"][vocq_] := {vocq[[1]], 
  vocq[[2]] /. BaseRl["la", "subject"], 
  vocq[[3]] /. BaseRl["la", "activity"], 
  vocq[[4]] /. BaseRl["la", "object"]}
(rdmOtlQ["la"] = Map[rdmMap["la"][#] &, vocQ["la"]]) // Length
matchPos["la"] = 
  Position[rdmOtlQ["la"], 
   x_String /; StringTake[x, 3] == "rdm" || x == "--"];
(matchPosGath["la"] = 
   Gather[matchPos["la"], First[#1] == First[#2] &]) // Length
(rdmOtlQTly["la"] = Tally[rdmOtlQ["la"]]) /. {"--" -> "rdm:--", 
   Part[List_, _] -> "_no-option_"} // TableForm
Map[#[[1, 3]] /. Map[#[[2]] &, rdmActivityToUS["la"]] &, 
 rdmOtlQTly["la"]]
Map[#[[1, 3]] /. Map[#[[2]] &, rdmObjectToUS["la"]] &, 
 rdmOtlQTly["la"]]
Cases[rdmOtlQTly["la"], x_ /; x[[1, 2]] != "system"]
Map[#[[2]] &, 
  Cases[rdmOtlQTly["la"], x_ /; x[[1, 2]] != "system"]] // Total
Cases[rdmOtlQTly["la"], 
 x_ /; x[[1, 2]] != 
    "system" && (StringMatchQ[x[[1, 3]], 
      RegularExpression["rdm:.*"]] || 
     StringMatchQ[x[[1, 4]], RegularExpression["rdm:.*"]])]
Map[#[[2]] &, 
  Cases[rdmOtlQTly["la"], 
   x_ /; x[[1, 2]] != 
      "system" && (StringMatchQ[x[[1, 3]], 
        RegularExpression["rdm:.*"]] || 
       StringMatchQ[x[[1, 4]], 
        RegularExpression["rdm:.*"]])]] // Total
(rdmOtlS["la"] = Map[#[[1, 2]] &, rdmOtlQTly["la"]])
rdmOtlSMP["sel", "la"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "la"], #] &, 
     rdmOtlS["la"]], {_, _}, {2}]] // Union
addPosS["la"] = Table[i, {i, Length[userStoryOtl["sel", "la"]]}]
rdmOtlSMP["sel", "la"] = Union[rdmOtlSMP["sel", "la"], addPosS["la"]]
matchSinLog["la", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "la"]]], 
  Map[# -> "S" &, rdmOtlSMP["sel", "la"]]]
rdmOtlV["la"] = Map[#[[1, 3]] &, rdmOtlQTly["la"]]
rdmOtlVMP["sel", "la"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "la"], #] &, 
     rdmOtlV["la"]], {_, _}, {2}]] // Union
matchVinLog["la", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "la"]]], 
  Map[# -> "V" &, rdmOtlVMP["sel", "la"]]]
rdmOtlO["la"] = Map[#[[1, 4]] &, rdmOtlQTly["la"]]
rdmOtlOMP["sel", "la"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "la"], #] &, 
     rdmOtlO["la"]], {_, _}, {2}]] // Union
matchOinLog["la", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "la"]]], 
  Map[# -> "O" &, rdmOtlOMP["sel", "la"]]]
userStoryOtl["sel", "la"][[
 Union[rdmOtlVMP["sel", "la"], rdmOtlOMP["sel", "la"]]]]
nonappUS["la"] = 
 Delete[userStoryOtl["sel", "la"], 
  Map[{#} &, Union[rdmOtlVMP["sel", "la"], rdmOtlOMP["sel", "la"]]]]
(usSVOMatch["sel", "la"] = {Map[#[[1]] &, userStoryOtl["sel", "la"]], 
    matchSinLog["la", date], matchVinLog["la", date], 
    matchOinLog["la", date]}) // TableForm

(** match wk **)
rdmMap["wk"][vocq_] := {vocq[[1]], 
  vocq[[2]] /. BaseRl["wk", "subject"], 
  vocq[[3]] /. BaseRl["wk", "activity"], 
  vocq[[4]] /. BaseRl["wk", "object"]}
(rdmOtlQ["wk"] = Map[rdmMap["wk"][#] &, vocQ["wk"]]) // Length
matchPos["wk"] = 
  Position[rdmOtlQ["wk"], 
   x_String /; StringTake[x, 3] == "rdm" || x == "--"];
(matchPosGath["wk"] = 
   Gather[matchPos["wk"], First[#1] == First[#2] &]) // Length
(rdmOtlQTly["wk"] = Tally[rdmOtlQ["wk"]]) /. {"--" -> "rdm:--", 
   Part[List_, _] -> "_no-option_"} // TableForm
Map[#[[1, 3]] /. Map[#[[2]] &, rdmActivityToUS["wk"]] &, 
 rdmOtlQTly["wk"]]
Map[#[[1, 3]] /. Map[#[[2]] &, rdmObjectToUS["wk"]] &, 
 rdmOtlQTly["wk"]]
Cases[rdmOtlQTly["wk"], x_ /; x[[1, 2]] != "system"]
Map[#[[2]] &, 
  Cases[rdmOtlQTly["wk"], x_ /; x[[1, 2]] != "system"]] // Total
Cases[rdmOtlQTly["wk"], 
 x_ /; x[[1, 2]] != 
    "system" && (StringMatchQ[x[[1, 3]], 
      RegularExpression["rdm:.*"]] || 
     StringMatchQ[x[[1, 4]], RegularExpression["rdm:.*"]])]
Map[#[[2]] &, 
  Cases[rdmOtlQTly["wk"], 
   x_ /; x[[1, 2]] != 
      "system" && (StringMatchQ[x[[1, 3]], 
        RegularExpression["rdm:.*"]] || 
       StringMatchQ[x[[1, 4]], 
        RegularExpression["rdm:.*"]])]] // Total
(rdmOtlS["wk"] = Map[#[[1, 2]] &, rdmOtlQTly["wk"]])
rdmOtlSMP["sel", "wk"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "wk"], #] &, 
     rdmOtlS["wk"]], {_, _}, {2}]] // Union
addPosS["wk"] = Table[i, {i, Length[userStoryOtl["sel", "wk"]]}]
rdmOtlSMP["sel", "wk"] = Union[rdmOtlSMP["sel", "wk"], addPosS["wk"]]
matchSinLog["wk", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "wk"]]], 
  Map[# -> "S" &, rdmOtlSMP["sel", "wk"]]]
rdmOtlV["wk"] = Map[#[[1, 3]] &, rdmOtlQTly["wk"]]
rdmOtlVMP["sel", "wk"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "wk"], #] &, 
     rdmOtlV["wk"]], {_, _}, {2}]] // Union
matchVinLog["wk", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "wk"]]], 
  Map[# -> "V" &, rdmOtlVMP["sel", "wk"]]]
rdmOtlO["wk"] = Map[#[[1, 4]] &, rdmOtlQTly["wk"]]
rdmOtlOMP["sel", "wk"] = 
 Map[#[[1]] &, 
   Cases[Map[Position[userStoryOtl["sel", "la"], #] &, 
     rdmOtlO["wk"]], {_, _}, {2}]] // Union
matchOinLog["wk", date] = 
 ReplacePart[Table["no-match", Length[userStoryOtl["sel", "wk"]]], 
  Map[# -> "O" &, rdmOtlOMP["sel", "wk"]]]
userStoryOtl["sel", "wk"][[
 Union[rdmOtlVMP["sel", "wk"], rdmOtlOMP["sel", "wk"]]]]
nonappUS["wk"] = 
 Delete[userStoryOtl["sel", "wk"], 
  Map[{#} &, Union[rdmOtlVMP["sel", "wk"], rdmOtlOMP["sel", "wk"]]]]
(usSVOMatch["sel", "wk"] = {Map[#[[1]] &, userStoryOtl["sel", "wk"]], 
    matchSinLog["wk", date], matchVinLog["wk", date], 
    matchOinLog["wk", date]}) // TableForm

(* match: large table *)
otlSVOMatchS[usS_, rdmotlS_] := 
 If[rdmotlS == "--", "S", If[usS == rdmotlS, "S", "no-match"], 
  "no-match"]
otlSVOMatchV[usV_, rdmotlV_] := If[usV == rdmotlV, "V", "no-match"]
otlSVOMatchO[usO_, rdmotlO_] := If[usO == rdmotlO, "O", "no-match"]
otlSVOMatchTri[us_, rdmotl_] :=
 {otlSVOMatchS[us[[4]], rdmotl[[1, 2]]],
  otlSVOMatchV[us[[5]], rdmotl[[1, 3]]],
  otlSVOMatchO[us[[6]], rdmotl[[1, 4]]]
  }
USrdmOtlMatchTri["ci"] = 
  Outer[otlSVOMatchTri, userStoryOtl["sel", "ci"], rdmOtlQTly["ci"], 
   1];
(RDMvsUSTri["ci"] = 
   MapThread[
     List, {Join[{{}, {}}, userStoryOtl["sel", "ci"]], 
      Join[rdmOtlQTly["ci"] // Transpose, USrdmOtlMatchTri["ci"]]}] //
     Transpose) // TableForm
USrdmOtlMatchTri["cs"] = 
  Outer[otlSVOMatchTri, userStoryOtl["sel", "cs"], rdmOtlQTly["cs"], 
   1];
(RDMvsUSTri["cs"] = 
   MapThread[
     List, {Join[{{}, {}}, userStoryOtl["sel", "cs"]], 
      Join[rdmOtlQTly["cs"] // Transpose, USrdmOtlMatchTri["cs"]]}] //
     Transpose) // TableForm
USrdmOtlMatchTri["la"] = 
  Outer[otlSVOMatchTri, userStoryOtl["sel", "la"], rdmOtlQTly["la"], 
   1];
(RDMvsUSTri["la"] = 
   MapThread[
     List, {Join[{{}, {}}, userStoryOtl["sel", "la"]], 
      Join[rdmOtlQTly["la"] // Transpose, USrdmOtlMatchTri["la"]]}] //
     Transpose) // TableForm
USrdmOtlMatchTri["wk"] = 
  Outer[otlSVOMatchTri, userStoryOtl["sel", "wk"], rdmOtlQTly["wk"], 
   1];
(RDMvsUSTri["wk"] = 
   MapThread[
     List, {Join[{{}, {}}, userStoryOtl["sel", "wk"]], 
      Join[rdmOtlQTly["wk"] // Transpose, USrdmOtlMatchTri["wk"]]}] //
     Transpose) // TableForm
basedir <> "D=" <> date <> "/T=4/_story/" <> "RDMvsUS_Match_Tbl" <> \
date <> ".json"
basedir <> "D=" <> date <> "/T=4/_story/" <> "RDMvsUS_Match_Tbl" <> \
date <> "_ci.json"
basedir <> "D=" <> date <> "/T=4/_story/" <> "RDMvsUS_Match_Tbl" <> \
date <> "_cs.json"
basedir <> "D=" <> date <> "/T=4/_story/" <> "RDMvsUS_Match_Tbl" <> \
date <> "_la.json"
basedir <> "D=" <> date <> "/T=4/_story/" <> "RDMvsUS_Match_Tbl" <> \
date <> "_wk.json"
Export[basedir <> "D=" <> date <> "/T=4/_story/" <> 
  "RDMvsUS_Match_Tbl" <> date <> ".json", {RDMvsUSTri["ci"], 
  RDMvsUSTri["cs"], RDMvsUSTri["la"], RDMvsUSTri["wk"]}]
Export[basedir <> "D=" <> date <> "/T=4/_story/" <> 
  "RDMvsUS_Match_Tbl" <> date <> "_ci.json", 
 TableForm[RDMvsUSTri["ci"]]]
Export[basedir <> "D=" <> date <> "/T=4/_story/" <> 
  "RDMvsUS_Match_Tbl" <> date <> "_cs.json", 
 TableForm[RDMvsUSTri["cs"]]]
Export[basedir <> "D=" <> date <> "/T=4/_story/" <> 
  "RDMvsUS_Match_Tbl" <> date <> "_la.json", 
 TableForm[RDMvsUSTri["la"]]]
Export[basedir <> "D=" <> date <> "/T=4/_story/" <> 
  "RDMvsUS_Match_Tbl" <> date <> "_wk.json", 
 TableForm[RDMvsUSTri["wk"]]]

(* Appearrance of us to log *)
userStoryOtlHead
userStoryOtlMatchHead = 
 Join[userStoryOtlHead, {"S-exist", "V-exist", "O-exist"}]
addMatch["gr"] = 
 Table["未調査", {Length[userStoryOtl["sel", "gr"]]}, {3}]
(userStoryOtlMatch["gr", date] = 
   Table[Join[userStoryOtl["sel", "gr"][[n]], 
     addMatch["gr"][[n]]], {n, 
     Length[userStoryOtl["sel", "gr"]]}]) // Dimensions
addMatch["dg"] = 
  Table["未調査", {Length[userStoryOtl["sel", "dg"]]}, {3}];
(userStoryOtlMatch["dg", date] = 
   Table[Join[userStoryOtl["sel", "dg"][[n]], 
     addMatch["dg"][[n]]], {n, 
     Length[userStoryOtl["sel", "dg"]]}]) // Dimensions
addMatch["dp"] = 
  Table["未調査", {Length[userStoryOtl["sel", "dp"]]}, {3}];
(userStoryOtlMatch["dp", date] = 
   Table[Join[userStoryOtl["sel", "dp"][[n]], 
     addMatch["dp"][[n]]], {n, 
     Length[userStoryOtl["sel", "dp"]]}]) // Dimensions
addMatch["ci"] = 
 Transpose[{matchSinLog["ci", date], matchVinLog["ci", date], 
   matchOinLog["ci", date]}]
(userStoryOtlMatch["ci", date] = 
   Table[Join[userStoryOtl["sel", "ci"][[n]], 
     addMatch["ci"][[n]]], {n, 
     Length[userStoryOtl["sel", "ci"]]}]) // Dimensions
addMatch["cs"] = 
 Transpose[{matchSinLog["cs", date], matchVinLog["cs", date], 
   matchOinLog["cs", date]}]
(userStoryOtlMatch["cs", date] = 
   Table[Join[userStoryOtl["sel", "cs"][[n]], 
     addMatch["cs"][[n]]], {n, 
     Length[userStoryOtl["sel", "cs"]]}]) // Dimensions
addMatch["la"] = 
 Transpose[{matchSinLog["la", date], matchVinLog["la", date], 
   matchOinLog["la", date]}]
(userStoryOtlMatch["la", date] = 
  Table[Join[userStoryOtl["sel", "la"][[n]], addMatch["la"][[n]]], {n,
     Length[userStoryOtl["sel", "la"]]}])
addMatch["wk"] = 
  Transpose[{matchSinLog["wk", date], matchVinLog["wk", date], 
    matchOinLog["wk", date]}];
(userStoryOtlMatch["wk", date] = 
  Table[Join[userStoryOtl["sel", "wk"][[n]], addMatch["wk"][[n]]], {n,
     Length[userStoryOtl["sel", "wk"]]}])
(userStoryOtlMatch["all", date] = Join[
    {userStoryOtlMatchHead},
    userStoryOtlMatch["gr", date],
    userStoryOtlMatch["dg", date],
    userStoryOtlMatch["dp", date],
    userStoryOtlMatch["ci", date],
    userStoryOtlMatch["cs", date],
    userStoryOtlMatch["la", date],
    userStoryOtlMatch["wk", date]
    ]) // Dimensions
(dupID = 
  Map[#[[1]] /. usDupRl["All"] &, userStoryOtlMatch["all", date]])
(userStoryOtlMatch["all", "dup", date] = 
   MapThread[
    Append, {userStoryOtlMatch["all", date], dupID}]) // TableForm
Export[basedir <> "D=" <> date <> "/T=4/_story/" <> 
  "userStoryOtlMatch_" <> date <> ".xlsx", 
 userStoryOtlMatch["all", "dup", date]]

(* triple which does note appear in us *)
nomatchSVOcount["ci"] = 
 Map[Count[#, "no-match"] &, Transpose[USrdmOtlMatchTri["ci"]], {2}]
nomatchLogpos["ci"] = 
 Flatten[Position[
   Map[Min, 
    Map[Count[#, "no-match"] &, 
     Transpose[USrdmOtlMatchTri["ci"]], {2}]], x_ /; x > 0]]
nomatchLogrdmTri["ci"] = rdmOtlQTly["ci"][[nomatchLogpos["ci"]]]
nomatchSVOcount["cs"] = 
 Map[Count[#, "no-match"] &, Transpose[USrdmOtlMatchTri["cs"]], {2}]
nomatchLogpos["cs"] = 
 Flatten[Position[
   Map[Min, 
    Map[Count[#, "no-match"] &, 
     Transpose[USrdmOtlMatchTri["cs"]], {2}]], x_ /; x > 0]]
nomatchLogrdmTri["cs"] = rdmOtlQTly["cs"][[nomatchLogpos["cs"]]]
nomatchSVOcount["la"] = 
 Map[Count[#, "no-match"] &, Transpose[USrdmOtlMatchTri["la"]], {2}]
nomatchLogpos["la"] = 
 Flatten[Position[
   Map[Min, 
    Map[Count[#, "no-match"] &, 
     Transpose[USrdmOtlMatchTri["la"]], {2}]], x_ /; x > 0]]
nomatchLogrdmTri["la"] = rdmOtlQTly["la"][[nomatchLogpos["la"]]]
nomatchSVOcount["wk"] = 
 Map[Count[#, "no-match"] &, Transpose[USrdmOtlMatchTri["wk"]], {2}]
nomatchLogpos["wk"] = 
 Flatten[Position[
   Map[Min, 
    Map[Count[#, "no-match"] &, 
     Transpose[USrdmOtlMatchTri["wk"]], {2}]], x_ /; x > 0]]
nomatchLogrdmTri["wk"] = rdmOtlQTly["wk"][[nomatchLogpos["wk"]]]
nomatchLogrdmTri["all"] = 
 Join[nomatchLogrdmTri["ci"], nomatchLogrdmTri["cs"], 
  nomatchLogrdmTri["la"], nomatchLogrdmTri["wk"]]
otlOnlyLogHead2 = {"基盤", "S", "V", "O"}
otlOnlyLogFooter = {"", "", "", "none:想定なし / UD:rdm-ontologyに定義なし"}
(otlOnlyLogTbl["all"] = 
   Append[Prepend[Map[#[[1]] &, nomatchLogrdmTri["all"]], 
     otlOnlyLogHead2], otlOnlyLogFooter]) // TableForm
Export[basedir <> "D=" <> date <> "/T=4/_story/" <> "otlOnlyLogTbl_" <>
   date <> ".xlsx", otlOnlyLogTbl["all"]]

(* US which does not appear in log *)
noMatchUShead = {{"番号", "基盤", "Role", "S", "V", "O"}}
(noMatchUS["all"] = 
   Join[noMatchUShead, nonappUS["ci"], nonappUS["cs"], nonappUS["la"],
     nonappUS["wk"]]) // TableForm

basedir <> "D=" <> date <> "/T=4/_story/" <> "noMatchUS_" <> date <> \
".xlsx"
Export[basedir <> "D=" <> date <> "/T=4/_story/" <> "noMatchUS_" <> 
  date <> ".xlsx", noMatchUS["all"]]

(* Summary *)
rdmTriinlogCount["ci"] = Dimensions[USrdmOtlMatchTri["ci"]][[2]]
rdmTriinlogCount["cs"] = Dimensions[USrdmOtlMatchTri["cs"]][[2]]
rdmTriinlogCount["la"] = Dimensions[USrdmOtlMatchTri["la"]][[2]]
rdmTriinlogCount["wk"] = Dimensions[USrdmOtlMatchTri["wk"]][[2]]
nomatchLogrdmTri["ci"] // Length
nomatchLogrdmTri["cs"] // Length
nomatchLogrdmTri["la"] // Length
nomatchLogrdmTri["wk"] // Length
nonappUS["ci"] // Length
nonappUS["cs"] // Length
nonappUS["la"] // Length
nonappUS["wk"] // Length
usCount["gr"] - usCount["gr", "uniq"]
usCount["dg"] - usCount["dg", "uniq"]
usCount["dp"] - usCount["dp", "uniq"]
usCount["ci"] - usCount["ci", "uniq"]
usCount["cs"] - usCount["cs", "uniq"]
usCount["la"] - usCount["la", "uniq"]
usCount["wk"] - usCount["wk", "uniq"]
(summaryUS = {{"基盤", "ログから検出されたrdmトリプルの種数"},
    {"ci", rdmTriinlogCount["ci"]},
    {"cs", rdmTriinlogCount["cs"]},
    {"la", rdmTriinlogCount["la"]},
    {"wk", rdmTriinlogCount["wk"]},
    {"基盤", "ログに現れるが現行のユーザーストーリー表に現れない(SVOが完全マッチしない)rdmトリプルの種数"},
    {"ci", nomatchLogrdmTri["ci"] // Length},
    {"cs", nomatchLogrdmTri["cs"] // Length},
    {"la", nomatchLogrdmTri["la"] // Length},
    {"wk", nomatchLogrdmTri["wk"] // Length},
    {"基盤", "重複ユーザーストーリー(SVOおよびroleが完全マッチ)の種数"},
    {"gr", usCount["gr"] - usCount["gr", "uniq"]},
    {"dg", usCount["dg"] - usCount["dg", "uniq"]},
    {"dp", usCount["dp"] - usCount["dp", "uniq"]},
    {"ci", usCount["ci"] - usCount["ci", "uniq"]},
    {"cs", usCount["cs"] - usCount["cs", "uniq"]},
    {"la", usCount["la"] - usCount["la", "uniq"]},
    {"wk", usCount["wk"] - usCount["wk", "uniq"]}
    }) // TableForm
Export[basedir <> "D=" <> date <> "/T=4/_story/" <> "summary_US_" <> date <> ".xlsx", summaryUS]


Export[basedir <> "D=" <> date <> "/T=4/_story/" <> "ws-us-procinfo.txt", {"PID:",$ProcessID,"PPID:",$ParentProcessID,"USER:",$UserName}]


Print["END"]

Quit[]
