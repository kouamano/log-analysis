dirstr = Directory[]
mountdir = StringReplace[dirstr,RegularExpression["log/D=[0-9]+.*"]->""]
(*mountdir = "/Volumes/IODATA/NII/togo-log/rcoslogs/"*)
vocdir = mountdir <> "voc"

Print["- preproc -"]
case = {"ci", "cs", "la", "wk"}

base["ci"] = "T=ci"
base["cs"] = "T=cs"
base["la"] = "T=la"
base["wk"] = "T=wk"
base["all"] = "T=4"

Print["- file stat -"]
fileliststr = 
 Import[mountdir <> "log/D=" <> date <> "/" <> "filenames", "String"]
filelist = StringSplit[fileliststr]
logwc = Import[mountdir <> "log/D=" <> date <> "/logfiles.wc", 
  "String"]
Print["- ckan file load -"]
ckanfile = 
 mountdir <> "crid/CIRDEV-1067_crid_list/ckan_product_crid_list.txt"
ckanSt = Import[ckanfile, "String"];
(ckanName = StringSplit[ckanSt, "\n"]) // Dimensions
(ckanCridAC = 
   Apply[Association, Map[# -> # &, ckanName]]) // Dimensions
Print["- voc file load -"]
vocRlFiles = FileNames[vocdir <> "/*.wl"]
vocRlList = Map[Get, vocRlFiles];
(vocRl["all:path"] = Apply[Join, vocRlList]) // Dimensions

directedConnectedGraphComponent[g_, v_] := 
 Module[{vAll, vOther, addEdge},
  vAll = VertexList[g];
  vOther = Complement[vAll, {v}];
  addEdge = Map[# -> v &, vOther];
  Subgraph[g, 
   ConnectedComponents[Flatten[{EdgeList[g], addEdge}, 1], v][[1]]]
  ]
vertexInGraph[g_Graph] := Module[{deg, pos, vname},
  deg = VertexInDegree[g];
  pos = Position[deg, 0] // Flatten // Union;
  vname = VertexList[g][[pos]];
  Map[directedConnectedGraphComponent[g, #] &, vname]
  ]
vertexInGraph[g_Integer] := g
distributeIdxGr[idxGr_] := Module[
  {date, idx, gr},
  date = idxGr[[1]];
  idx = idxGr[[2]];
  gr = idxGr[[3]];
  Map[{date, idx, #} &, gr]
  ]
fqdnFromPath[s_] := StringJoin[StringSplit[s, "/"][[{1, 3}]]]
fqdnFromGraph[g_Graph] := 
 Union[Sort[Map[fqdnFromPath, VertexList[g]]]]

Print["- import/reform 4 bases -"]
Print["-- ci --"]
dir["ci"] = mountdir <> "log/D=" <> date <> "/" <> base["ci"]
SetDirectory[dir["ci"]]
file["ci"] = "self.1"
(str["ci"] = Import[dir["ci"] <> "/" <> file["ci"], "String"])//StringLength
(strSplt["ci"] = StringSplit[str["ci"], "\n"]) // Length
(strSplt1["ci"] = 
   Map[StringSplit[#, "\t"] &, strSplt["ci"]]) // Dimensions
strSplt1C["ci"] = 
  Map[ReplacePart[#, 
     8 -> "https://cir.nii.ac.jp/" <> StringDrop[#[[8]], 8]] &, 
   strSplt1["ci"]];
(strSplt1CC["ci"] = 
  Map[ReplacePart[#, 11 -> StringDrop[#[[11]], 10]] &, 
   strSplt1C["ci"]])//Dimensions
logdateToTime["ci"][s_String] := 
 AbsoluteTime[DateList[StringTake[s, {8, -6}]]]
(strSplt1CCC["ci"] = 
  Map[ReplacePart[#, 6 -> logdateToTime["ci"][#[[6]]]] &, 
   strSplt1CC["ci"]])//Dimensions
ip["ci"][str_] := StringSplit[str, "\":\""][[2]]
(strSplt1CCCCpre["ci"] = 
  Map[ReplacePart[#, 3 -> ip["ci"][#[[3]]]] &, strSplt1CCC["ci"]])//Dimensions
toCRID[s_String /; 
   StringMatchQ[s, 
    RegularExpression["https://cir.nii.ac.jp/crid/.*"]]] := 
 StringTake[StringSplit[s, "/"][[5]], 19]
Print["It may cause warning."]
(strSplt1CCCC["ci"] = 
  Map[Join[#, {toCRID[#[[8]]], toCRID[#[[11]]]}] &, 
   strSplt1CCCCpre["ci"]])//Dimensions
strSplt1CCCC["ci"][[8]] // TableForm
accessTime["ci"] = Map[#[[6]] &, strSplt1CCCC["ci"]];

Print["-- cs --"]
dir["cs"] = mountdir <> "log/D=" <> date <> "/" <> base["cs"]
SetDirectory[dir["cs"]]
file["cs"] = "self.1"
str["cs"] = Import[dir["cs"] <> "/" <> file["cs"], "String"];
(strSplt["cs"] = StringSplit[str["cs"], "\n"]) // Dimensions
(strSplt1["cs"] = 
   Map[StringSplit[#, "\t"] &, strSplt["cs"]]) // Dimensions
rp["cs"] = {1, 2, 5, 4, 6, 3, 7, 9, 8, 10, 12, 13, 11, 14}
(strSplt1R["cs"] = Map[#[[rp["cs"]]] &, strSplt1["cs"]]) // Dimensions
pathhead["cs"] = "https://jupyter.cs.rcos.nii.ac.jp"
pathreplace["cs"][path_] := Module[{pathhead, epath},
  pathhead = "https://jupyter.cs.rcos.nii.ac.jp";
  epath = StringDrop[path, 7];
  If[StringTake[epath, 1] == "/", pathhead <> epath, epath]
  ]
strSplt1C["cs"] = 
  Map[ReplacePart[#, 8 -> pathreplace["cs"][#[[8]]]] &, 
   strSplt1R["cs"]];
strSplt1CC["cs"] = 
  Map[ReplacePart[#, 11 -> StringDrop[#[[11]], 10]] &, 
   strSplt1C["cs"]];
logdateToTime["cs"][s_String] := 
 AbsoluteTime[DateList[StringTake[s, {16, -7}]]]
strSplt1CCC["cs"] = 
  Map[ReplacePart[#, 6 -> logdateToTime["cs"][#[[6]]]] &, 
   strSplt1CC["cs"]];
ip["cs"][str_] := StringSplit[str, "\":\""][[2]]
(strSplt1CCCC["cs"] = 
  Map[ReplacePart[#, 3 -> ip["cs"][#[[3]]]] &, strSplt1CCC["cs"]])//Dimensions
strSplt1CCCC["cs"][[10]] // TableForm
accessTime["cs"] = Map[#[[6]] &, strSplt1CCCC["cs"]];

Print["-- la --"]
dir["la"] = mountdir <> "log/D=" <> date <> "/" <> base["la"]
file["la"] = "self.1"
str["la", "pre"] = Import[dir["la"] <> "/" <> file["la"], "String"];
(strSplt["la", "pre"] = StringSplit[str["la", "pre"], "\n"]) // Length
(strSplt1["la", "pre"] = 
   Map[StringSplit[#, "\t"] &, strSplt["la", "pre"]]) // Dimensions
(strSplt1["la", "log.la0001.aws.wa01.yobi"] = 
   Select[strSplt1["la", 
     "pre"], #[[2]] == "log.la0001.aws.wa01.yobi" &]) // Dimensions
(strSplt1["la", "log.la0002.aws.wa01.yobi"] = 
   Select[strSplt1["la", 
     "pre"], #[[2]] == "log.la0002.aws.wa01.yobi" &]) // Dimensions
(strSplt1["la", "log.la0003.aws.wa01.yobi"] = 
   Select[strSplt1["la", 
     "pre"], #[[2]] == "log.la0003.aws.wa01.yobi" &]) // Dimensions
rp["la", "log.la0001.aws.wa01.yobi"] = {1, 2, 11, 8, 5, 4, 7, 6, 3, 
  12, 9, 10}
(strSplt1R["la", "log.la0001.aws.wa01.yobi"] = 
   Map[#[[rp["la", "log.la0001.aws.wa01.yobi"]]] &, 
    strSplt1["la", "log.la0001.aws.wa01.yobi"]]) // Dimensions
rp["la", "log.la0002.aws.wa01.yobi"] = {1, 2, 11, 8, 5, 4, 7, 6, 3, 
  12, 9, 10}
(strSplt1R["la", "log.la0002.aws.wa01.yobi"] = 
   Map[#[[rp["la", "log.la0002.aws.wa01.yobi"]]] &, 
    strSplt1["la", "log.la0002.aws.wa01.yobi"]]) // Dimensions
rp["la", "log.la0003.aws.wa01.yobi"] = {1, 2, 11, 8, 5, 4, 7, 6, 3, 
  12, 9, 10}
(strSplt1R["la", "log.la0003.aws.wa01.yobi"] = 
   Map[#[[rp["la", "log.la0003.aws.wa01.yobi"]]] &, 
    strSplt1["la", "log.la0003.aws.wa01.yobi"]]) // Dimensions
(strSplt1R["la"] = 
   Join[strSplt1R["la", "log.la0001.aws.wa01.yobi"], 
    strSplt1R["la", "log.la0002.aws.wa01.yobi"], 
    strSplt1R["la", "log.la0003.aws.wa01.yobi"]]) // Dimensions
pathhead["la"] = "https://lms.nii.ac.jp"
pathreplace["la"][path_] := Module[{pathhead, epath},
  pathhead = "https://lms.nii.ac.jp";
  epath = StringDrop[path, 7];
  If[StringTake[epath, 1] == "/", pathhead <> epath, epath]
  ]
strSplt1C["la"] = 
  Map[ReplacePart[#, 8 -> pathreplace["la"][#[[8]]]] &, 
   strSplt1R["la"]];
strSplt1CC["la"] = 
  Map[ReplacePart[#, 11 -> StringDrop[#[[11]], 10]] &, 
   strSplt1C["la"]];
logdateToTime["la"][s_String] := 
 AbsoluteTime[DateList[StringTake[s, {13, -6}]]]
strSplt1CCC["la"] = 
  Map[ReplacePart[#, 6 -> logdateToTime["la"][#[[6]]]] &, 
   strSplt1CC["la"]];
ip["la"][str_] := StringSplit[str, "\":\""][[2]]
(strSplt1CCCC["la"] = 
   Map[ReplacePart[#, 3 -> ip["la"][#[[3]]]] &, 
    strSplt1CCC["la"]]) // Dimensions
strSplt1CCCC["la"][[1]] // TableForm
accessTime["la"] = Map[#[[6]] &, strSplt1CCCC["la"]];

Print["-- wk --"]
dir["wk"] = mountdir <> "log/D=" <> date <> "/" <> base["wk"]
file["wk"] = "self.1"
str["wk"] = Import[dir["wk"] <> "/" <> file["wk"], "String"];
(strSplt["wk"] = StringSplit[str["wk"], "\n"]) // Length
(strSplt1["wk"] = 
   Map[StringSplit[#, "\t"] &, strSplt["wk"]]) // Dimensions
rp["wk"] = {1, 2, 3, 4, 6, 5, 8, 7, 9, 12, 10, 11}
(strSplt1R["wk"] = Map[#[[rp["wk"]]] &, strSplt1["wk"]]) // Dimensions
pathhead["wk"] = "https://jdcat.jsps.go.jp"
pathreplace["wk"][path_] := Module[{pathhead, epath},
  pathhead = "https://jdcat.jsps.go.jp";
  epath = StringDrop[path, 7];
  If[StringTake[epath, 1] == "/", pathhead <> epath, epath]
  ]
strSplt1C["wk"] = 
  Map[ReplacePart[#, 8 -> pathreplace["wk"][#[[8]]]] &, 
   strSplt1R["wk"]];
strSplt1CC["wk"] = 
  Map[ReplacePart[#, 11 -> StringDrop[#[[11]], 10]] &, 
   strSplt1C["wk"]];
(strSplt1CCC["wk", "pre"] = 
   Cases[strSplt1CC["wk"], 
    x_ /; StringTake[x[[6]], 9] == "date_time"]) // Dimensions
logdateToTime["wk"][s_String] := 
 AbsoluteTime[DateList[StringTake[s, {13, -6}]]] + (9*60*60)
strSplt1CCC["wk"] = 
  Map[ReplacePart[#, 6 -> logdateToTime["wk"][#[[6]]]] &, 
   strSplt1CCC["wk","pre"]];
ip["wk"][str_] := StringSplit[str, "\":\""][[2]]
strSplt1CCCC["wk"] = 
  Map[ReplacePart[#, 3 -> ip["wk"][#[[3]]]] &, strSplt1CCC["wk"]];
strSplt1CCCC["wk"][[26]] // TableForm
accessTime["wk"] = Map[#[[6]] &, strSplt1CCCC["wk"]];

Print["-- link 4 bases --"]
Timing[(strSplt1CCCC[4] = 
    SortBy[Join[strSplt1CCCC["ci"], strSplt1CCCC["cs"], 
      strSplt1CCCC["la"], 
      strSplt1CCCC["wk"]], {#[[3]], #[[12]], #[[6]]} &]) // 
  Dimensions]
apIdx[4] = Table[i, {i, Length[strSplt1CCCC[4]]}];
(idxLog[4] = 
   Map[Append[#[[1]], #[[2]]] &, 
    Transpose[{strSplt1CCCC[4], apIdx[4]}]]) // Dimensions
idxLogLen[4] = Length[idxLog[4]]

Print["-- link ckan data --"]
(ckanPathE[4] = Map[ckanCridAC[#[[-3]]] &, idxLog[4]]) // Dimensions
(ckanCridPLogPos[4] = 
   Flatten[Position[ckanPathE[4], _String, {1}]]) // Length
(ckanCridPLogPosAC[4] = 
   Association[Map[# -> # &, ckanCridPLogPos[4]]]) // Length
(ckanRefE[4] = Map[ckanCridAC[#[[-2]]] &, idxLog[4]]) // Dimensions
(ckanCridRLogPos[4] = 
   Flatten[Position[ckanRefE[4], _String, {1}]]) // Length
(ckanCridRLogPosAC[4] = 
   Association[Map[# -> # &, ckanCridRLogPos[4]]]) // Length
(ckanCridPRLogPos[4] = 
   Union[ckanCridPLogPos[4], ckanCridRLogPos[4]]) // Length
(ckanCridPRLogPosAC[4] = 
   Association[Map[# -> # &, ckanCridPRLogPos[4]]]) // Length
accessTime[4] = Map[#[[6]] &, idxLog[4]];

Print["- import/reform CiNii data -"]
Print["-- ci base --"]
Timing[(strSplt1CCCC["ci"] = 
    SortBy[strSplt1CCCC["ci"], {#[[3]], #[[12]], #[[6]]} &]) // 
  Dimensions]
apIdx["ci"] = Table[i, {i, Length[strSplt1CCCC["ci"]]}];
idxLog["ci"] = 
  Map[Append[#[[1]], #[[2]]] &, 
   Transpose[{strSplt1CCCC["ci"], apIdx["ci"]}]];

Print["-- link ckan data --"]
(ckanPathE["ci"] = 
   Map[ckanCridAC[#[[-3]]] &, idxLog["ci"]]) // Dimensions
ckanCridPlist = Cases[ckanPathE["ci"], _String];
ckanRefE["ci"] = Map[ckanCridAC[#[[-2]]] &, idxLog["ci"]];
ckanCridRlist = Cases[ckanRefE["ci"], _String];
ckanCridPRU = Union[ckanCridPlist, ckanCridRlist];
ckanCridPRACQ = Association[Map[# -> True &, ckanCridPRU]];

Print["- user estimate -"]
(idxLogS[4] = 
   Split[idxLog[
     4], #1[[3]] == #2[[3]] && #1[[12]] == #2[[12]] &]) // Length

Print["-- graph generation --"]
Timing[(idxLogSinf[4] = 
    Map[Split[#, #2[[6]] - #1[[6]] <= Infinity &] &, idxLogS[4]]) // 
  Dimensions]
refstglog[4][g_] := {g[[1]], g[[3]], 
  Part[idxLogSinf[4], g[[2, 1]], g[[2, 2]]]}

Print["--- 1. user graph ---"]
userGrER[4] = 
  Map[Map[DirectedEdge[#[[11]], #[[8]], {#[[6]], #[[-1]]}] &, #] &, 
   idxLogSinf[4], {2}];
(userGr[4] = 
   Map[Graph[#, VertexLabels -> Automatic] &, 
    userGrER[4], {2}]) // Length
userGrIdx[4] = MapIndexed[{date, #2, #1} &, userGr[4], {2}];

Print["--- 2. independent graph ---"]
Timing[(user2GrIdx[4] = 
    Map[{#[[1]], #[[2]], WeaklyConnectedGraphComponents[#[[3]]]} &, 
     userGrIdx[4], {2}]) // Dimensions]

Print["--- 3. initial node graph ---"]
Timing[(storyGrIdx[4] = Map[vertexInGraph, user2GrIdx[4], {4}]) // 
  Dimensions ]
(storyGrIdxFl[4] = 
   Map[{#[[1]], #[[2]], Flatten[#[[3]]]} &, 
    Flatten[storyGrIdx[4], 1]]) // Dimensions
(storyGrIdxFlDs[4] = 
   Flatten[Map[distributeIdxGr, storyGrIdxFl[4]], 1]) // Dimensions

Print["--- 4.(1) remove extra vertex ---"]
(storyGrIdxFlDsVD1[4] = 
   Map[{#[[1]], #[[2]], 
      If[VertexQ[#[[3]], "-"], VertexDelete[#[[3]], "-"], #[[3]]]} &, 
    storyGrIdxFlDs[4]]) // Dimensions
Print["--- 5.(2) remove non-user access ---"]
rmpattAll[
  4] = {rmpatt[4][1] = 
   RegularExpression["https://jupyter.cs.rcos.nii.ac.jp/hub/static.*"],
  rmpatt[4][2] = RegularExpression["https://jdcat.jsps.go.jp/api.*"],
  rmpatt[4][3] = 
   RegularExpression[
    "https://jupyter.cs.rcos.nii.ac.jp/hub/.*api.*"],
  rmpatt[4][4] = 
   RegularExpression[
    "https://jupyter.cs.rcos.nii.ac.jp/user/.*/api.*"],
  rmpatt[4][5] = 
   RegularExpression["https://jupyter.cs.rcos.nii.ac.jp/img.*"],
  rmpatt[4][6] = RegularExpression["https://.*/.*\\.svg"],
  rmpatt[4][7] = RegularExpression["https://.*/.*\\.js"],
  rmpatt[4][8] = 
   RegularExpression["https://jupyter.cs.rcos.nii.ac.jp/.*\\.js\\?.*"],
  rmpatt[4][9] = 
   RegularExpression["https://jdcat.jsps.go.jp/.*\\.js\\?.*"],
  rmpatt[4][10] = RegularExpression["https://.*/.*\\.woff2.*"],
  rmpatt[4][11] = RegularExpression["https://.*/.*\\.css"],
  rmpatt[4][12] = RegularExpression["https://.*/css/.*"],
  rmpatt[4][13] = RegularExpression["https://.*/.*\\.favicon.ico"],
  rmpatt[4][14] = "https://jdcat.jsps.go.jp/get_search_setting",
  rmpatt[4][15] = 
   "https://jdcat.jsps.go.jp/facet-search/get-title-and-order"
  }
createRmList[gr_, rmpatt_] := Module[{vlist},
  vlist = VertexList[gr];
  Union[Flatten[
    Table[Cases[vlist, x_ /; StringMatchQ[x, rmpatt[[n]]]], {n, 
      Length[rmpatt]}]]]
  ]
rmV[gr_, rmpatt_] := Module[{vlist, pathlist},
  vlist = VertexList[gr];
  pathlist = 
   Union[Flatten[
     Table[Cases[vlist, x_ /; StringMatchQ[x, rmpatt[[n]]]], {n, 
       Length[rmpatt]}]]];
  VertexDelete[gr, pathlist]
  ]
(storyGrIdxFlDsVD2[4] = 
   Map[{#[[1]], #[[2]], rmV[#[[3]], rmpattAll[4]]} &, 
    storyGrIdxFlDsVD1[4]]) // Dimensions

Print["--- 6. cleaning  ---"]
pickPos[4][1] = 
  Flatten[Position[Map[VertexCount[#[[3]]] &, storyGrIdxFlDsVD2[4]], 
    x_ /; x >= 2]];
(storyGrIdxFlDs2[4] = 
   storyGrIdxFlDsVD2[4][[pickPos[4][1]]]) // Dimensions
pickPos[4][2] = 
  Flatten[Position[Map[EdgeCount[#[[3]]] &, storyGrIdxFlDs2[4]], 
    x_ /; x >= 1]];
(storyGrIdxFlDs3[4][date] = 
   storyGrIdxFlDs2[4][[pickPos[4][2]]]) // Dimensions

Print["-- edges --"]
(eltbl[4] =
   Table[EdgeList[storyGrIdxFlDs3[4][date][[i]][[3]]],
     {i, Length[storyGrIdxFlDs3[4][date]]}]) // Dimensions
(eltblList[4] = Map[Apply[List, #] &, eltbl[4], {2}]) // Dimensions

Print["-- voc edges --"]
vocELexp[4] =
 Map[List[#, ToString[ReplaceAll[#, vocRl["all:path"]]]] &,
  eltblList[4], {3}];

Print["-- save / export --"]
savedir = mountdir <> "log/D=" <> date <> "/T=4/_story"
savefile = "storyGrIdxFlDs3."<>date<>".save"
savetarget=savedir<>"/"<>savefile
Run["rm "<>savetarget]
Timing[Save[savetarget,storyGrIdxFlDs3]]
Timing[Save[savetarget,idxLogLen]]
Timing[Save[savetarget,accessTime]]
Timing[Save[savetarget,ckanName]]
Timing[Save[savetarget,ckanCridAC]]
Timing[Save[savetarget,ckanCridPLogPos]]
Timing[Save[savetarget,ckanCridRLogPos]]
Timing[Save[savetarget,ckanCridPRLogPos]]
Timing[Save[savetarget,ckanCridPlist]]
Timing[Save[savetarget,ckanCridRlist]]
Timing[Save[savetarget,ckanCridPRU]]
Timing[Save[savetarget,ckanCridPLogPosAC]]
Timing[Save[savetarget,ckanCridRLogPosAC]]
Timing[Save[savetarget,ckanCridPRLogPosAC]]
Timing[Save[savetarget,ckanCridPRACQ]]
Timing[Export[savedir <> "/edgelist-4" <> "." <> date <> ".json", eltblList[4]]]
Timing[Export[savedir <> "/vocedgelist-4" <> "." <> date <> ".json", vocELexp[4]]]

Export[savedir <> "ws-procinfo.txt",{"PID:",$ProcessID,"PPID:",$ParentProcessID,"USER:",$UserName}]

Print["END:graph.ws"]

Quit[]
