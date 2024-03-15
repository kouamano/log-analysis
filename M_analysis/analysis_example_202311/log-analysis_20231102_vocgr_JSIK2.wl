tID = 33

(* start inf *)
Print["--- Start ---"]
Print["tID="<>ToString[tID]]
Now

(* Basic Program *)
gatherDistributeUniqRl[l_] := Module[{first, target},
  first = l[[1, 1]];
  target = Map[#[[2]] &, l];
  first -> {first, target}
  ];

addVertexAccTime[g_] := Module[{gatherTimeV, gatherTimeVRl},
  gatherTimeV = 
   Gather[Map[{#[[2]], #[[3, 1]]} &, 
     EdgeList[g]], #1[[1]] == #2[[1]] &];
  gatherTimeVRl = Map[gatherDistributeUniqRl, gatherTimeV];
  VertexReplace[g, gatherTimeVRl]
  ];

timeEdgeTest[e_] := 
 Module[{sourceNode, sourceTime, edgeTime, trueCountTest, 
   sourceNodeTest},
  sourceNode = e[[1]];
  sourceTime = e[[1]][[2]];
  edgeTime = e[[3]][[1]];
  trueCountTest = Length[Select[edgeTime - sourceTime, # >= 0 &]] >= 1;
  sourceNodeTest = Head[sourceNode] === String;
  (*{trueCountTest,sourceNodeTest};*);
  trueCountTest || sourceNodeTest
  ];

timeGraphTest[g_] := Module[{el},
  el = EdgeList[g];
  Map[timeEdgeTest, el]
  ];

timeoutEdgeDelete[g_Graph] := Module[{el, test, deletePosition},
  el = EdgeList[g];
  test = Map[timeEdgeTest, el];
  deletePosition = Position[test, False];
  Graph[Delete[el, deletePosition], VertexLabels -> "Name", 
   EdgeLabels -> "EdgeTag"]
  ];

timeoutGraphSplit[g_Graph] := 
 WeaklyConnectedGraphComponents[timeoutEdgeDelete[g]];

edgeTimeList[gIdx_] := Map[#[[3, 1]] &, EdgeList[gIdx]];

exist[0] := 0;
exist[a_ /; a > 0] := 1;

Protect[undefined];

(* Settings *)
(*basedir = "/Volumes/home/NII/togo-log/rcoslogs/log/M=202310-202312/";*)
basedir = "/mnt/home/amano/notebooks/data/rcoslogs/log/"
datadir = basedir <> "D=*/T=4/_story/"
files = FileNames[datadir <> "storyGrIdxFlDs3*save"]

fileDirs = 
  Map[StringReplace[#, RegularExpression["/[^/]*$"] -> ""] &, files];
fileDates = Map[StringSplit[#, {"/", "="}][[9]] &, files]

(*test*)
(*FileNames[files[[1]]]*)
(*FileNames["hogehoge"]*)

vocdir = "/Volumes/home/NII/togo-log/rcoslogs/voc/"


(* Data load *)
AbsoluteTiming[Get[files[[tID]]];]

AbsoluteTiming[(storyGrTS[4][fileDates[[tID]]] = 
    Map[addVertexAccTime[#[[3]]] &, 
     storyGrIdxFlDs3[4][fileDates[[tID]]]]) // Length]

(* Graph selection *)
(** Graph split **)
Off[timeoutGraphSplit, timeEdgeTest];
AbsoluteTiming[(storyGrTSS[4][fileDates[[tID]]] = 
    Map[timeoutGraphSplit, storyGrTS[4][fileDates[[tID]]]]) // Length];
(storyGrTSSF[4][fileDates[[tID]]] = 
   Flatten[storyGrTSS[4][fileDates[[tID]]]]) // Length

(storyGrSel[4][fileDates[[tID]]] = 
   Select[storyGrTSSF[4][fileDates[[tID]]], 
    EdgeCount[#] >= 1 && VertexCount[#] >= 2 &]) // Length

(* voc data *)
Print["voc data"]

vocRlFiles = FileNames[vocdir <> "/*.wl"]

vocRlList = Map[Get, vocRlFiles];
(vocRl["all:path"] = Apply[Join, vocRlList]) // Dimensions

voclist = 
 Sort[Union[Join[Map[#[[2]] &, vocRl["all:path"]], {undefined[]}]]]

(* voc-label graph *)
Print["create voc-label graph"]

addVocLabel[gr_, rl_] := 
 Module[{vl, getvname, vname, vrename, vrenameRl},
  (*Print["it may cause StringMatchQ warn."];*)
  vl = VertexList[gr];
  getvname[v_List] := v[[1]];
  getvname[v_String] := v;
  vname = Map[getvname[#] &, vl];
  vrename = (vname /. rl);
  vrenameRl = Map[Apply[Rule, #] &, Transpose[{vl, vrename}]];
  Graph[gr, VertexLabels -> vrenameRl]
  ];

vocNodeProp[n_] := If[Head[n] === List, n[[1]], "Undefined"];

vertexLabelList[g_] := Module[{gs, defg},
  gs = ToString[InputForm[g]];
  defg = ToExpression[StringReplace[gs, "Graph" -> "defGraph"]];
  Cases[defg, _voc, Infinity]
  ];

countvoc[vocNodeProp_, voclist_] := 
 Map[Count[vocNodeProp, #] &, voclist];

(** voc-label graph **)
AbsoluteTiming[(storyVocLGrSel[4, "voc"][fileDates[[tID]]] = 
    Map[addVocLabel[#, vocRl["all:path"]] &, 
     storyGrSel[4][fileDates[[tID]]]]) // Length]

(** edge **)
(storyEdgeLSel[4, "voc"][fileDates[[tID]]] = 
   Map[EdgeList, 
    storyVocLGrSel[4, "voc"][fileDates[[tID]]]]) // Length

(storyEdgeSel[4, "voc-edgecount"][fileDates[[tID]]] = 
   Map[Length, storyEdgeLSel[4, "voc"][fileDates[[tID]]]]) // Length

tallysort[4, "voc-edgecount-prod"][fileDates[[tID]]] = 
 Sort[Tally[
   storyEdgeSel[4, "voc-edgecount"][
    fileDates[[tID]]]], #1[[2]] > #2[[2]] &]

Remove[a, c];
zipf[r_] := c r^(-a);
zipffit[4, "edge"][fileDates[[tID]]] = 
 FindFit[Map[#[[2]] &, 
   tallysort[4, "voc-edgecount-prod"][fileDates[[tID]]]], 
  zipf[r], {c, a}, r]

(** vertex **)
(storyNodeLSel[4, "voc"][fileDates[[tID]]] = 
   Map[VertexList, 
    storyVocLGrSel[4, "voc"][fileDates[[tID]]]]) // Length

(storyNodeSel[4, "voc-nodecount"][fileDates[[tID]]] = 
   Map[Length, storyNodeLSel[4, "voc"][fileDates[[tID]]]]) // Length

tallysort[4, "voc-nodecount-prod"][fileDates[[tID]]] = 
 Sort[Tally[
   storyNodeSel[4, "voc-nodecount"][
    fileDates[[tID]]]], #1[[2]] > #2[[2]] &]

Remove[a, c];
zipf[r_] := c r^(-a);
zipffit[4, "node"][fileDates[[tID]]] = 
 FindFit[Map[#[[2]] &, 
   tallysort[4, "voc-nodecount-prod"][fileDates[[tID]]]], 
  zipf[r], {c, a}, r]

(** time sorted vertex **)
timeSortVLMin[g_] := Module[{vl, notimeV, timeV},
  vl = VertexList[g];
  notimeV = Cases[vl, _String];
  timeV = Complement[vl, notimeV];
  Join[Sort[notimeV], Sort[timeV, Min[#1[[2]]] < Min[#2[[2]]] &]]
  ];

timeSortVLMax[g_] := Module[{vl, notimeV, timeV},
  vl = VertexList[g];
  notimeV = Cases[vl, _String];
  timeV = Complement[vl, notimeV];
  Join[Sort[notimeV], Sort[timeV, Max[#1[[2]]] < Max[#2[[2]]] &]]
  ];

vocDetailReport01[vl_] := Module[{l, p},
  l = Length[vl];
  p = Position[vl, voc["ci:*,confirm,detail"]];
  {l, Map[#[[1]] &, p]}
  ];

(storyNodeLSel[4, "acctimesort"][fileDates[[tID]]] = 
   Map[timeSortVLMax, 
    storyVocLGrSel[4, "voc"][fileDates[[tID]]]]) // Length

AbsoluteTiming[(storyNodeLSel[4, "acctimesort", "voc"][
     fileDates[[tID]]] = 
    Map[ReplaceAll[#, vocRl["all:path"]] &, 
     storyNodeLSel[4, "acctimesort"][fileDates[[tID]]]]) // Length]

(vocDetailPos[4][fileDates[[tID]]] = 
   Map[vocDetailReport01, 
    storyNodeLSel[4, "acctimesort", "voc"][
     fileDates[[tID]]]]) // Length

(** first-in last-out **)
firstINlastOUT[g_] := Module[{vl, notimeV, timeV, minV, maxV},
  vl = VertexList[g];
  notimeV = Cases[vl, _String];
  timeV = Complement[vl, notimeV];
  minV = Sort[timeV, Min[#1[[2]]] < Min[#2[[2]]] &][[1]];
  maxV = Sort[timeV, Max[#1[[2]]] < Max[#2[[2]]] &][[-1]];
  If[notimeV != {}, minV = notimeV[[1]]];
  {minV, maxV}
  ];

(storyNodePSel[4, "firstANDlast"][fileDates[[tID]]] = 
   Map[firstINlastOUT, 
    storyVocLGrSel[4, "voc"][fileDates[[tID]]]]) // Dimensions

dropAcctime[v_] := Module[{vocnode},
  vocnode[n_String] := n;
  vocnode[n_voc] := n;
  vocnode[n_List] := vocnode[n[[1]]];
  vocnode[v]
  ];

dropQuery[v_] := If[Head[v] === String, StringSplit[v, "?"][[1]], v];

domainExtract[v_] := 
 If[Head[v] === String, StringSplit[v, "/"][[3]], v];

AbsoluteTiming[(storyNodePSel[4, "firstANDlast", "voc"][
     fileDates[[tID]]] = 
    Map[ReplaceAll[#, vocRl["all:path"]] &, 
     storyNodePSel[4, "firstANDlast"][fileDates[[tID]]]]) // 
  Dimensions]

(storyNodePSel[4, "firstANDlast", "voc", "dropAccT"][
    fileDates[[tID]]] = 
   Map[dropAcctime, 
    storyNodePSel[4, "firstANDlast", "voc"][
     fileDates[[tID]]], {2}]) // Dimensions

(storyNodePSel[4, "firstANDlast", "voc", "dropAccT", "domain"][
    fileDates[[tID]]] = 
   Map[domainExtract, 
    storyNodePSel[4, "firstANDlast", "voc", "dropAccT"][
     fileDates[[tID]]], {2}]) // Dimensions

(*** in-out ***)
(storyNodeInOutClass[4][fileDates[[tID]]] = 
   Sort[Tally[
     storyNodePSel[4, "firstANDlast", "voc", "dropAccT", "domain"][
      fileDates[[tID]]]], #1[[2]] > #2[[2]] &]) // Dimensions

(*** in ***)
(storyNodeInClass[4][fileDates[[tID]]] = 
   Sort[Tally[
     Map[#[[1]] &, 
      storyNodePSel[4, "firstANDlast", "voc", "dropAccT", "domain"][
       fileDates[[tID]]]]], #1[[2]] > #2[[2]] &]) // Length

(*** out ***)
(storyNodeOutClass[4][fileDates[[tID]]] = 
   Sort[Tally[
     Map[#[[2]] &, 
      storyNodePSel[4, "firstANDlast", "voc", "dropAccT", "domain"][
       fileDates[[tID]]]]], #1[[2]] > #2[[2]] &]) // Length

(** voc vector **)
AbsoluteTiming[(storyVocNodeSel[4, "voc-only"][fileDates[[tID]]] = 
    Map[vertexLabelList, 
     storyVocLGrSel[4, "voc"][fileDates[[tID]]]]) // Length]

(storyVocCVecSel[4, "voc-only"][fileDates[[tID]]] = 
   Map[countvoc[#, voclist] &, 
    storyVocNodeSel[4, "voc-only"][fileDates[[tID]]]]) // Length

(storyVocAVecSel[4, "voc-only"][fileDates[[tID]]] = 
   Map[exist, 
    storyVocCVecSel[4, "voc-only"][fileDates[[tID]]], {2}]) // Length

(** voc vec class **)
classSize = (storyVocAVecClass[4, "voc-only"][fileDates[[tID]]] = 
    Sort[Tally[
      storyVocAVecSel[4, "voc-only"][
       fileDates[[tID]]]], #1[[2]] >= #2[[2]] &]) // Length

(** voc vec clusteringは行わない **)

(** 滞留時間 **)
(edgeAccTimeList[4][fileDates[[tID]]] = 
   Map[edgeTimeList, 
    storyVocLGrSel[4, "voc"][fileDates[[tID]]]]) // Dimensions

(edgeAccTimeList[4, "stay"][fileDates[[tID]]] = 
   Map[Max[#] - Min[#] &, 
    edgeAccTimeList[4][fileDates[[tID]]]]) // Dimensions

(** ページ滞在時間 **)
visitTime[tl_] := Module[{sorted, parted},
  sorted = Sort[tl, #1 > #2 &];
  parted = Partition[sorted, 2, 1];
  Map[#[[1]] - #[[2]] &, parted]
  ];

(edgeAccTimeList[4, "pagevisit"][
    fileDates[[
     tID]]] = ((Map[visitTime, 
       edgeAccTimeList[4][fileDates[[tID]]]]) /. {} -> 0)) // Length

(* voc graph *)
toVocGraph[gr_, rl_] := Module[{el},
  el = EdgeList[gr];
  Graph[el /. rl, VertexLabels -> "Name"]
  ];

dropAcctimeFromEdge[e_] := Module[{dropAcctime, h},
  h = Head[e];
  dropAcctime[n_List] := If[Head[n[[1]]] === voc, n[[1]], undefined[]];
  dropAcctime[n_voc] := n;
  dropAcctime[n_String] := undefined[];
  (*h[dropAcctime[e[[1]]],dropAcctime[e[[2]]],e[[3]]];*)
  h[dropAcctime[e[[1]]], dropAcctime[e[[2]]]]
  ];

dropAcctimeFromEdgeUD[e_] := Module[{dropAcctime, h},
  h = Head[e];
  dropAcctime[n_List] := If[Head[n[[1]]] === voc, n[[1]], undefined[]];
  dropAcctime[n_voc] := n;
  dropAcctime[n_String] := undefined[];
  (*UndirectedEdge[dropAcctime[e[[1]]],dropAcctime[e[[2]]],e[[3]]];*)
  UndirectedEdge[dropAcctime[e[[1]]], dropAcctime[e[[2]]]]
  ];

dropAcctimeFromGraph[g_Graph] := Module[{el},
  el = EdgeList[g];
  Graph[Map[dropAcctimeFromEdge, el]]
  ];

dropAcctimeFromGraph[g_Graph, vl_] := Module[{el},
  el = EdgeList[g];
  Graph[vl, Map[dropAcctimeFromEdge, el]]
  ];

dropAcctimeFromGraphUD[g_Graph] := Module[{el},
  el = EdgeList[g];
  Graph[Map[dropAcctimeFromEdgeUD, el]]
  ];

dropAcctimeFromGraphUD[g_Graph, vl_] := Module[{el},
  el = EdgeList[g];
  Graph[vl, Map[dropAcctimeFromEdgeUD, el]]
  ];

AbsoluteTiming[(storyVocGraphSel[4][fileDates[[tID]]] = 
    Map[toVocGraph[#, vocRl["all:path"]] &, 
     storyGrSel[4][fileDates[[tID]]]]) // Length]

AbsoluteTiming[(storyVocGraphDASel[4][fileDates[[tID]]] = 
    Map[dropAcctimeFromGraph, 
     storyVocGraphSel[4][fileDates[[tID]]]]) // Length]

AbsoluteTiming[(storyVocGraphDAUDSel[4][fileDates[[tID]]] = 
    Map[dropAcctimeFromGraphUD, 
     storyVocGraphSel[4][fileDates[[tID]]]]) // Length]

AbsoluteTiming[(storyVocGraphDAUDSel59ex[4][fileDates[[tID]]] = 
    Map[dropAcctimeFromGraphUD[#, voclist] &, 
     storyVocGraphSel[4][fileDates[[tID]]]]) // Length]

(storyVocGraphDAUDSel59ex[4, "vcount"][fileDates[[tID]]] = 
   Map[VertexCount, storyVocGraphDAUDSel59ex[4][fileDates[[tID]]]]);

(storyVocGraphDAUDSel59[4][fileDates[[tID]]] = 
   Cases[storyVocGraphDAUDSel59ex[4][fileDates[[tID]]], 
    x_ /; VertexCount[x] == 59]) // Dimensions

AbsoluteTiming[(storyVocGraphKM59[4][fileDates[[tID]]] = 
    Map[KirchhoffMatrix, 
     storyVocGraphDAUDSel59[4][fileDates[[tID]]]]) // Dimensions]

(storyVocGraphEva59[4][fileDates[[tID]]] = 
   Map[Eigenvalues[N[#]] &, 
    storyVocGraphKM59[4][fileDates[[tID]]]]) // Dimensions

(** KM class **)
(storyVocGraphEva59Class[4][fileDates[[tID]]] = 
   Tally[storyVocGraphEva59[4][fileDates[[tID]]]]) // Dimensions


(** voc graph clusteringは行わない **)

(* Save *)
vocLGraphSaveFile = 
 fileDirs[[tID]] <> "/log-analysis_" <> fileDates[[tID]] <> 
  "_vocLGraph.save"

AbsoluteTiming[Save[vocLGraphSaveFile, storyVocLGrSel]]

vocGraphSaveFile = 
 fileDirs[[tID]] <> "/log-analysis_" <> fileDates[[tID]] <> 
  "_vocGraph.save"

AbsoluteTiming[
 Save[vocGraphSaveFile, {storyVocGraphSel, storyVocGraphDAUDSel59}]]

EVcountSaveFile = 
 fileDirs[[tID]] <> "/log-analysis_" <> fileDates[[tID]] <> 
  "_EVcount.save"

AbsoluteTiming[
 Save[EVcountSaveFile, {storyEdgeSel, storyNodeSel, storyNodePSel, 
   storyNodeInOutClass, vocDetailPos}]]

vocVecSaveFile = 
 fileDirs[[tID]] <> "/log-analysis_" <> fileDates[[tID]] <> 
  "_vocVec.save"

AbsoluteTiming[
 Save[vocVecSaveFile, {storyVocCVecSel, storyVocAVecSel}]]

accTimeSaveFile = 
 fileDirs[[tID]] <> "/log-analysis_" <> fileDates[[tID]] <> 
  "_accTime.save"

AbsoluteTiming[Save[accTimeSaveFile, edgeAccTimeList]]

KMSaveFile = 
 fileDirs[[tID]] <> "/log-analysis_" <> fileDates[[tID]] <> "_KM.save"

AbsoluteTiming[
 Save[KMSaveFile, {storyVocGraphKM59, storyVocGraphEva59}]]



(* Finalize *)
Now
Print["--- All Done. ---"]
