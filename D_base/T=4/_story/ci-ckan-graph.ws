start = AbsoluteTime[Date[]]
(*date = "20231120"*)
(*mountdir = "/Volumes/home/NII/togo-log/rcoslogs/"*)
dirstr = Directory[]
mountdir = StringReplace[dirstr,RegularExpression["log/D=[0-9]+.*"]->""]
vocdir = mountdir <> "voc"
case = {"ci", "cs", "la", "wk"}
base["ci"] = "T=ci"
base["cs"] = "T=cs"
base["la"] = "T=la"
base["wk"] = "T=wk"
base["all"] = "T=4"
fileliststr = 
 Import[mountdir <> "log/D=" <> date <> "/" <> "filenames", "String"]
filelist = StringSplit[fileliststr]
logwc = Import[mountdir <> "log/D=" <> date <> "/logfiles.wc", 
  "String"]
ckanfile = 
 mountdir <> "crid/CIRDEV-1067_crid_list/ckan_product_crid_list.txt"
ckanSt = Import[ckanfile, "String"];
(ckanName = StringSplit[ckanSt, "\n"]) // Dimensions
(ckanCridAC = 
   Apply[Association, Map[# -> # &, ckanName]]) // Dimensions
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
fqdnFromPath[s_] := StringJoin[StringSplit[s, "/"]〚{1, 3}〛]
fqdnFromGraph[g_Graph] := 
 Union[Sort[Map[fqdnFromPath, VertexList[g]]]]
dir["ci"] = mountdir <> "log/D=" <> date <> "/" <> base["ci"]
file["ci"] = "self.1"
str["ci"] = Import[dir["ci"] <> "/" <> file["ci"], "String"];
(strSplt["ci"] = StringSplit[str["ci"], "\n"]) // Length
(strSplt1["ci"] = 
   Map[StringSplit[#, "\t"] &, strSplt["ci"]]) // Dimensions
strSplt1C["ci"] = 
  Map[ReplacePart[#, 
     8 -> "https://cir.nii.ac.jp/" <> StringDrop[#[[8]], 8]] &, 
   strSplt1["ci"]];
strSplt1CC["ci"] = 
  Map[ReplacePart[#, 11 -> StringDrop[#[[11]], 10]] &, 
   strSplt1C["ci"]];
logdateToTime["ci"][s_String] := 
 AbsoluteTime[DateList[StringTake[s, {8, -6}]]]
logdateToTime["ci"][strSplt1CC["ci"][[1]][[6]]]
strSplt1CCC["ci"] = 
  Map[ReplacePart[#, 6 -> logdateToTime["ci"][#[[6]]]] &, 
   strSplt1CC["ci"]];
ip["ci"][str_] := StringSplit[str, "\":\""][[2]]
strSplt1CCCCpre["ci"] = 
  Map[ReplacePart[#, 3 -> ip["ci"][#[[3]]]] &, strSplt1CCC["ci"]];
strSplt1CCCCpre["ci"][[10]] // TableForm
toCRID[s_String /; 
   StringMatchQ[s, 
    RegularExpression["https://cir.nii.ac.jp/crid/.*"]]] := 
 StringTake[StringSplit[s, "/"][[5]], 19]
strSplt1CCCC["ci"] = 
  Map[Join[#, {toCRID[#[[8]]], toCRID[#[[11]]]}] &, 
   strSplt1CCCCpre["ci"]];
strSplt1CCCC["ci"][[8]] // TableForm
accessTime["ci"] = Map[#[[6]] &, strSplt1CCCC["ci"]];
Timing[(strSplt1CCCC["ci"] = 
    SortBy[strSplt1CCCC["ci"], {#[[3]], #[[12]], #[[6]]} &]) // 
  Dimensions]
apIdx["ci"] = Table[i, {i, Length[strSplt1CCCC["ci"]]}];
idxLog["ci"] = 
  Map[Append[#[[1]], #[[2]]] &, 
   Transpose[{strSplt1CCCC["ci"], apIdx["ci"]}]];
idxLog["ci"][[1]] // TableForm
(ckanPathE["ci"] = 
   Map[ckanCridAC[#[[-3]]] &, idxLog["ci"]]) // Dimensions
(ckanCridPLogPos["ci"] = 
   Flatten[Position[ckanPathE["ci"], _String, {1}]]) // Length
(ckanCridPLogPosAC["ci"] = 
   Association[Map[# -> # &, ckanCridPLogPos["ci"]]]) // Length
ckanCridPlist = Cases[ckanPathE["ci"], _String]
ckanRefE["ci"] = Map[ckanCridAC[#[[-2]]] &, idxLog["ci"]];
(ckanCridRLogPos["ci"] = 
   Flatten[Position[ckanRefE["ci"], _String, {1}]]) // Length
(ckanCridRLogPosAC["ci"] = 
   Association[Map[# -> # &, ckanCridRLogPos["ci"]]]) // Length
ckanCridRlist = Cases[ckanRefE["ci"], _String]
(ckanCridPRLogPos["ci"] = 
   Union[ckanCridPLogPos["ci"], ckanCridRLogPos["ci"]]) // Length
(ckanCridPRLogPosAC["ci"] = 
   Association[Map[# -> # &, ckanCridPRLogPos["ci"]]]) // Length
ckanCridPRU = Union[ckanCridPlist, ckanCridRlist]
ckanCridPRACQ = Association[Map[# -> True &, ckanCridPRU]]
((idxLogS["ci"] = 
    Split[idxLog[
      "ci"], #1[[3]] == #2[[3]] && #1[[12]] == #2[[12]] &]) // Length)
idxLogLen["ci"] = Length[idxLog["ci"]]
Timing[(idxLogSinf["ci"] = 
    Map[Split[#, #2[[6]] - #1[[6]] <= Infinity &] &, idxLogS["ci"]]) //
   Dimensions]
idxLogS[4][[1]]
refstglog["ci"][g_] := {g[[1]], g[[3]], 
  Part[idxLogSinf["ci"], g[[2, 1]], g[[2, 2]]]}
userGrER["ci"] = 
  Map[Map[DirectedEdge[#[[11]], #[[8]], {#[[6]], #[[-1]]}] &, #] &, 
   idxLogSinf["ci"], {2}];
userGrER["ci"][[2]]
(userGr["ci"] = 
   Map[Graph[#, VertexLabels -> Automatic] &, 
    userGrER["ci"], {2}]) // Length
userGrIdx["ci"] = MapIndexed[{date, #2, #1} &, userGr["ci"], {2}]; 
Timing[(user2GrIdx["ci"] = 
    Map[{#[[1]], #[[2]], WeaklyConnectedGraphComponents[#[[3]]]} &, 
     userGrIdx["ci"], {2}]) // Dimensions] 
Timing[(storyGrIdx["ci"] = 
    Map[vertexInGraph, user2GrIdx["ci"], {4}]) // Dimensions ]
(storyGrIdxFl["ci"] = 
   Map[{#[[1]], #[[2]], Flatten[#[[3]]]} &, 
    Flatten[storyGrIdx["ci"], 1]]) // Dimensions
storyGrIdxFl["ci"][[1]][[3]][[1]] // EdgeList
(storyGrIdxFlDs["ci"] = 
   Flatten[Map[distributeIdxGr, storyGrIdxFl["ci"]], 1]) // Dimensions
storyGrIdxFlDs["ci"][[2]]
(storyGrIdxFlDsVD1["ci"] = 
   Map[{#[[1]], #[[2]], 
      If[VertexQ[#[[3]], "-"], VertexDelete[#[[3]], "-"], #[[3]]]} &, 
    storyGrIdxFlDs["ci"]]) // Dimensions
rmpattAll[
   4] = {rmpatt[4][1] = 
    RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/hub/static.*"],
   rmpatt[4][2] = 
    RegularExpression["https://jdcat.jsps.go.jp/api.*"],
   rmpatt[4][3] = 
    RegularExpression["https://jupyter.cs.rcos.nii.ac.jp/hub/.*api.*"],
   rmpatt[4][4] = 
    RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/api.*"],
   rmpatt[4][5] = 
    RegularExpression["https://jupyter.cs.rcos.nii.ac.jp/img.*"],
   rmpatt[4][6] = RegularExpression["https://.*/.*\\.svg"],
   rmpatt[4][7] = RegularExpression["https://.*/.*\\.js"],
   rmpatt[4][8] = 
    RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/.*\\.js\\?.*"],
   rmpatt[4][9] = 
    RegularExpression["https://jdcat.jsps.go.jp/.*\\.js\\?.*"],
   rmpatt[4][10] = RegularExpression["https://.*/.*\\.woff2.*"],
   rmpatt[4][11] = RegularExpression["https://.*/.*\\.css"],
   rmpatt[4][12] = RegularExpression["https://.*/css/.*"],
   rmpatt[4][13] = RegularExpression["https://.*/.*\\.favicon.ico"],
   rmpatt[4][14] = "https://jdcat.jsps.go.jp/get_search_setting",
   rmpatt[4][15] = 
    "https://jdcat.jsps.go.jp/facet-search/get-title-and-order"
   };
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
(storyGrIdxFlDsVD2["ci"] = 
   Map[{#[[1]], #[[2]], rmV[#[[3]], rmpattAll[4]]} &, 
    storyGrIdxFlDsVD1["ci"]]) // Dimensions
pickPos["ci"][1] = 
  Flatten[Position[
    Map[VertexCount[#[[3]]] &, storyGrIdxFlDsVD2["ci"]], 
    x_ /; x >= 2]];
(storyGrIdxFlDs2["ci"] = 
   storyGrIdxFlDsVD2["ci"][[pickPos["ci"][1]]]) // Dimensions
pickPos["ci"][2] = 
  Flatten[Position[Map[EdgeCount[#[[3]]] &, storyGrIdxFlDs2["ci"]], 
    x_ /; x >= 1]];
(storyGrIdxFlDs3["ci"] = 
   storyGrIdxFlDs2["ci"][[pickPos["ci"][2]]]) // Dimensions
storyGrIdxFlDs3["ci",date] = storyGrIdxFlDs3["ci"];
storyGrIdxFlDs3["ci"][[1]]
savedir = mountdir <> "log/D=" <> date <> "/" <> base["ci"]
SetDirectory[savedir]
Directory[]
Timing[Save["storyGrIdxFlDs3."<>date<>".ci.save", storyGrIdxFlDs3]]
Timing[Save["storyGrIdxFlDs3."<>date<>".ci.save", toCRID]]
Timing[Save["ckan."<>date<>".save", ckanName]]
Timing[Save["ckan."<>date<>".save", ckanCridAC]]
Timing[Save["ckan."<>date<>".save", ckanCridPLogPosAC]]
Timing[Save["ckan."<>date<>".save", ckanCridRLogPosAC]]
Timing[Save["ckan."<>date<>".save", ckanCridPRLogPosAC]]
Timing[Save["ckan."<>date<>".save", ckanCridPRACQ]]
(eltbl["ci"] = 
   Table[EdgeList[storyGrIdxFlDs3["ci"][[i]][[3]]], {i, 
     Length[storyGrIdxFlDs3["ci"]]}]) // Dimensions
Histogram[Map[Length, eltbl["ci"]], {5}]
(vltbl["ci"] = 
   Table[VertexList[storyGrIdxFlDs3["ci"][[i]][[3]]], {i, 
     Length[storyGrIdxFlDs3["ci"]]}]) // Dimensions
Histogram[Map[Length, vltbl["ci"]], {5}]
(acct["ci"] = Map[#[[3, 1]] &, eltbl["ci"], {2}]) // Dimensions
(accspanMin["ci"] = 
   Map[Max[#] - Min[#] &, acct["ci"]]/60) // Dimensions
Histogram[accspanMin["ci"], {1}]
(ratioEV["ci"] = 
   Map[Length, eltbl["ci"]]/Map[Length, vltbl["ci"]] // 
    N) // Dimensions
(ratioTV["ci"] = acct["ci"]/Map[Length, vltbl["ci"]]) // Dimensions
(ratioTE["ci"] = acct["ci"]/Map[Length, eltbl["ci"]]) // Dimensions
(GrBases["ci"] = 
   Map[fqdnFromGraph[#[[3]]] &, storyGrIdxFlDs3["ci"]]) // Dimensions
niidnpos = 
 Flatten[Position[
   Map[StringMatchQ[#, RegularExpression[".*nii.ac.jp.*"]] || 
      StringMatchQ[#, RegularExpression[".*jdcat.jsps.go.jp.*"]] &, 
    Flatten[GrBases["ci"]] // Union], True]]
(Flatten[GrBases["ci"]] // Union)[[niidnpos]]
(GrNiiBases["ci"] = 
   Map[Cases[#, 
      x_ /; StringMatchQ[x, RegularExpression[".*nii.ac.jp.*"]] || 
        StringMatchQ[x, RegularExpression[".*jdcat.jsps.go.jp.*"]]] &,
     GrBases["ci"]]) // Dimensions
Map[Length, GrBases["ci"]] // Tally
(GrBasesTly["ci"] = Tally[GrBases["ci"]]) // Dimensions
Map[Length, GrNiiBases["ci"]] // Tally
(GrNiiBasesTly["ci"] = Tally[GrNiiBases["ci"]]) // Dimensions
GrNiiBasesTly["ci"] // TableForm
accessFirst = (Cases[accessTime["ci"], x_ /; x > 0] // Min)
accessLast = (Cases[accessTime["ci"], x_ /; x > 0] // Max)
Sort[accessTime["ci"]] // Length
BC600["ci"] = 
 BinCounts[Sort[accessTime["ci"]], {accessFirst, accessLast, 60*10}]
ListPlot[BC600["ci"], PlotRange -> Full, Joined -> True]
stayTime[g_Graph] := Module[{elist, tlist},
  elist = EdgeList[g];
  tlist = Map[#[[3, 1]] &, elist];
  Max[tlist] - Min[tlist]
  ]
logGraphQ[gr_Graph, asc_Association] := 
 Module[{elist, logposlist, res},
  elist = EdgeList[gr];
  logposlist = Map[#[[3, 2]] &, elist];
  res = Map[asc[#] &, logposlist];
  Position[res, _Integer, {1}] /. {{} -> False, {__} -> True}
  ]
ckanVertexHighlihgt[g_Graph, asc_Association] := 
 Module[{vlist, pos, targetv, op},
  vlist = VertexList[g];
  pos = Flatten[
    Position[Map[ckanCridPRACQ[toCRID[#]] &, VertexList[g]], True]];
  targetv = vlist[[pos]];
  op = VertexStyle -> Map[# -> Red &, targetv];
  Graph[g, op]
  ]
(ckanGrP["ci"] = 
   Map[If[logGraphQ[#[[3]], ckanCridPLogPosAC["ci"]], #, Null] &, 
    storyGrIdxFlDs3["ci"]]) // Dimensions
(ckanGrR["ci"] = 
   Map[If[logGraphQ[#[[3]], ckanCridRLogPosAC["ci"]], #, Null] &, 
    storyGrIdxFlDs3["ci"]]) // Dimensions
(ckanGrPR["ci"] = 
   Map[If[logGraphQ[#[[3]], ckanCridPRLogPosAC["ci"]], #, Null] &, 
    storyGrIdxFlDs3["ci"]]) // Dimensions
(ckanGrPsel["ci"] = Cases[ckanGrP["ci"], {__}, {1}]) // Dimensions
ckanGrPselVL["ci"] = Map[VertexList[#[[3]]] &, ckanGrPsel["ci"]];
ckanGrPselEL["ci"] = Map[EdgeList[#[[3]]] &, ckanGrPsel["ci"]];
(ckanGrRsel["ci"] = Cases[ckanGrR["ci"], {__}, {1}]) // Dimensions
ckanGrRselVL["ci"] = Map[VertexList[#[[3]]] &, ckanGrRsel["ci"]];
ckanGrRselEL["ci"] = Map[EdgeList[#[[3]]] &, ckanGrRsel["ci"]];
(ckanGrPRsel["ci"] = Cases[ckanGrPR["ci"], {__}, {1}]) // Dimensions
ckanGrPRselVL["ci"] = Map[VertexList[#[[3]]] &, ckanGrPRsel["ci"]];
ckanGrPRselEL["ci"] = Map[EdgeList[#[[3]]] &, ckanGrPRsel["ci"]];
(ckanGrPRselHL["ci"] = 
   Map[{#[[1]], #[[2]], ckanVertexHighlihgt[#[[3]], ckanCridPRACQ]} &,
     ckanGrPRsel["ci"]]) // Dimensions
ckanGrPRVcount["ci"] = Map[VertexCount[#[[3]]] &, ckanGrPRselHL["ci"]]
accTimeList[g_Graph] := Module[{elist, tlist},
  elist = EdgeList[g];
  tlist = Sort[Map[#[[3, 1]] &, elist], #1 > #2 &]
  ]
timeSpan[tlist_] := Map[(#[[1]] - #[[2]]) &, Partition[tlist, 2, 1]]
ckanGrPRstayTime["ci"] = Map[stayTime[#[[3]]] &, ckanGrPRselHL["ci"]]
gatherDistributeUniq[l_] := Module[{first, target},
  first = l[[1, 1]];
  target = Map[#[[2]] &, l];
  {first, target}
  ]
gatherDistributeUniqRl[l_] := Module[{first, target},
  first = l[[1, 1]];
  target = Map[#[[2]] &, l];
  first -> {first, target}
  ]
addVertexAccTime[g_] := Module[{gatherTimeV, gatherTimeVRl},
  gatherTimeV = 
   Gather[Map[{#[[2]], #[[3, 1]]} &, 
     EdgeList[g]], #1[[1]] == #2[[1]] &];
  gatherTimeVRl = Map[gatherDistributeUniqRl, gatherTimeV];
  VertexReplace[g, gatherTimeVRl]
  ]
guessVertexCoorGr[g_, timeshift_] := 
 Module[{allAccTime, baseTime, repPos, target, repRl},
  allAccTime = Cases[Flatten[Map[#[[2]] &, g // VertexList]], _Real];
  baseTime = Min[allAccTime] + timeshift;
  repPos = Flatten[Position[Map[Head, VertexList[g]], String]];
  target = Map[VertexList[g][[#]] &, repPos];
  repRl = Map[# -> {#, {baseTime}} &, target];
  VertexReplace[g, repRl]
  ]
accTimeMinGr[g_] := 
 Min[Cases[Flatten[Map[#[[2]] &, g // VertexList]], _Real]]
reformCoorGr[g_, baseTime_, f_] := 
 f[Map[{Max[#[[2]]], Min[#[[2]]]} &, VertexList[g]] - baseTime]
timeLineGr[g_, timeshift_, f_] := Module[{gnew, btime, coornew},
  gnew = guessVertexCoorGr[g, timeshift];
  btime = accTimeMinGr[gnew];
  coornew = reformCoorGr[gnew, btime, f];
  Graph[gnew, VertexSize -> Automatic, VertexCoordinates -> coornew]
  ]
(ckanGrPRselHLAT["ci"] = 
   Map[{#[[1]], #[[2]], addVertexAccTime[#[[3]]]} &, 
    ckanGrPRselHL["ci"]]) // Dimensions
loggroupCKAN = Map[#[[2]] &, ckanGrPRselHLAT["ci"]]
vcCKAN = Map[VertexCount[#[[3]]] &, ckanGrPRselHLAT["ci"]]
ecCKAN = Map[EdgeCount[#[[3]]] &, ckanGrPRselHLAT["ci"]]
(accCKAN = 
   Map[Map[#[[3, 1]] &, EdgeList[#[[3]]]] &, 
    ckanGrPRselHLAT["ci"]]) // Dimensions
maxTimeSpan[l_] := 
 Max[Map[#[[1]] - #[[2]] &, Partition[Sort[l, #1 > #2 &], 2, 1]]]
(maxtimespanCKAN = Map[maxTimeSpan, accCKAN] /. {-Infinity -> 0})/60
staytimeCKAN = Map[Max[#] - Min[#] &, accCKAN]
staytimeCKAN/60
f[x_] = Log[x + 1]
(ckanGrPRselHLTL["ci"] = 
   Map[timeLineGr[#[[3]], -60, f] &, 
    ckanGrPRselHLAT["ci"]]) // Dimensions
ckanGrPRselHLTL["ci"] // TableForm
vocRlFiles = FileNames[vocdir <> "/*.wl"]
vocRlList = Map[Get, vocRlFiles];
(vocRl["all:path"] = Apply[Join, vocRlList]) // Dimensions
vocRl["all:path"][[1]]
toVocGraph[gr_, rl_] := Module[{vl, vname, vrename, vrenameRl},
  Print["it may cause StringMatchQ warn."];
  vl = VertexList[gr];
  vname = Map[#[[1]] &, vl];
  vrename = (vname /. rl);
  vrenameRl = Map[Apply[Rule, #] &, Transpose[{vl, vrename}]];
  Graph[gr, VertexLabels -> vrenameRl]
  ]
toVocGraph[ckanGrPRselHLTL["ci"][[1]], vocRl["all:path"]]
Map[toVocGraph[#, vocRl["all:path"]] &, 
  ckanGrPRselHLTL["ci"]] // TableForm
(logTotal = {{"- ログ件数 -", "述べログ件数"}, {"全件数", 
     ToExpression[StringSplit[logwc][[1]]]}, {"ユーザーアクセス件数", 
     idxLogLen["ci"]}}) // TableForm
(ckanLogTotal = {{"- CKAN-cridを含むログ件数 -", "述べログ件数", "cridのユニーク件数"},
    {"リクエストにCKAN-crid含む", ckanCridPLogPos["ci"] // Length, 
     Union[ckanCridPlist] // Length},
    {"リファラーにCKAN-crid含む", ckanCridRLogPos["ci"] // Length, 
     Union[ckanCridRlist] // Length},
    {"いずれか含む", ckanCridPRLogPos["ci"] // Length, ckanCridPRU // Length}
    }) // TableForm
(ckanChainTotal = {{"- アクション連鎖数 -", "件数"},
    {"全件数", storyGrIdxFlDs3["ci"] // Length},
    {"ノードにCKAN-crid含む", ckanGrPRselHL["ci"] // Length}
    }) // TableForm
(ckanGraphSummary = 
   Prepend[Transpose[{Table[i, {i, Length[loggroupCKAN]}], 
      loggroupCKAN, vcCKAN, ecCKAN, maxtimespanCKAN/60, 
      staytimeCKAN/60}], {"アクセスグラフ通し番号", "ロググループ", "ノード数", "エッジ数", 
     "最大滞在時間(分)", "滞留時間(分)"}]) // TableForm
(ckanEL = 
   Map[MapApply[List, EdgeList[#]] &, 
    ckanGrPRselHLTL["ci"]]) // Dimensions
ckanELexp = Map[{#[[1, 1]], #[[2, 1]]} &, ckanEL, {2}];
ckanVocELexp =
 Map[List[#, ToString[ReplaceAll[#, vocRl["all:path"]]]] &,
  ckanELexp, {3}];
expdir = mountdir <> "log/D=" <> date <> "/" <> base["ci"]
SetDirectory[expdir]
Export["ckanedgelist" <> "." <>date<> ".json", ckanELexp]
Export["ckanvocedgelist" <> "." <>date<> ".json",ckanVocELexp]
Export["graphProperty."<>date<>".xlsx", {logTotal, ckanLogTotal, ckanChainTotal, 
  ckanGraphSummary}]
end = AbsoluteTime[Date[]]
end - start

Quit[]
