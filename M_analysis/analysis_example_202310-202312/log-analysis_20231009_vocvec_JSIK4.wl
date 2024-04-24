(*Log analysis 20231009*)
start = Now
tID = 9 

(*basic programs*)
(**vertexにaccess時刻を付与する**)
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
(**access時刻よりあとのreferer-accessを持つEdgeをテストする/落とす**)
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
(**graphからedgeの時刻を抽出**)
edgeTimeList[gIdx_] := Map[#[[3, 1]] &, EdgeList[gIdx]];
(**1回以上のカウントを1とする**)
exist[0] := 0;
exist[a_ /; a > 0] := 1;
(**予約**)
Protect[undefined]

(*Settings*)
basedir = "/Volumes/home/NII/togo-log/rcoslogs/log/M=202310-202312/"

datadir = basedir <> "D=*/T=4/_story/"

files = FileNames[datadir <> "storyGrIdxFlDs3*save"]

fileDirs = 
  Map[StringReplace[#, RegularExpression["/[^/]*$"] -> ""] &, files]

fileDates = Map[StringSplit[#, {"/", "="}][[10]] &, files]

vocdir = "/Volumes/home/NII/togo-log/rcoslogs/voc/"

fileDates[[tID]]

AbsoluteTiming[Get[files[[tID]]];]

AbsoluteTiming[(storyGrTS[4][fileDates[[tID]]] = 
    Map[addVertexAccTime[#[[3]]] &, 
     storyGrIdxFlDs3[4][fileDates[[tID]]]]) // Length]

Off[timeoutGraphSplit, timeEdgeTest]

AbsoluteTiming[(storyGrTSS[4][fileDates[[tID]]] = 
    Map[timeoutGraphSplit, storyGrTS[4][fileDates[[tID]]]]) // Length]

(storyGrTSSF[4][fileDates[[tID]]] = 
   Flatten[storyGrTSS[4][fileDates[[tID]]]]) // Length

(storyGrSel[4][fileDates[[tID]]] = 
   Select[storyGrTSSF[4][fileDates[[tID]]], 
    EdgeCount[#] >= 1 && VertexCount[#] >= 2 &]) // Length

vocrldir = "/Users/kouamano/gitsrc/log-analysis/voc"

vocRlFiles = FileNames[vocrldir <> "/*.wl"]

vocRlList = Map[Get, vocRlFiles];

(vocRl["all:path"] = Apply[Join, vocRlList]) // Dimensions

(voclist = 
   Sort[Union[
     Join[Map[#[[2]] &, 
       vocRl["all:path"]], {undefined[]}]]]) // TableForm

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

AbsoluteTiming[(storyVocLGrSel[4, "voc"][fileDates[[tID]]] = 
    Map[addVocLabel[#, vocRl["all:path"]] &, 
     storyGrSel[4][fileDates[[tID]]]]) // Length]

AbsoluteTiming[(storyVocNodeSel[4, "voc-only"][fileDates[[tID]]] = 
    Map[vertexLabelList, 
     storyVocLGrSel[4, "voc"][fileDates[[tID]]]]) // Length]

(storyVocCVecSel[4, "voc-only"][fileDates[[tID]]] = 
   Map[countvoc[#, voclist] &, 
    storyVocNodeSel[4, "voc-only"][fileDates[[tID]]]]) // Length

(storyVocAVecSel[4, "voc-only"][fileDates[[tID]]] = 
   Map[exist, 
    storyVocCVecSel[4, "voc-only"][fileDates[[tID]]], {2}]) // Length

classSize = (storyVocAVecClass[4, "voc-only"][fileDates[[tID]]] = 
    Sort[Tally[
      storyVocAVecSel[4, "voc-only"][
       fileDates[[tID]]]], #1[[2]] >= #2[[2]] &]) // Length

storyVocAVecClass[4, "voc-only"][fileDates[[tID]]][[1]]

vocLGraphSaveFile = 
 fileDirs[[tID]] <> "/log-analysis_" <> fileDates[[tID]] <> 
  "_JSIK4_vocLGraph.save"

AbsoluteTiming[Save[vocLGraphSaveFile, storyVocLGrSel]]

vocVecSaveFile = 
 fileDirs[[tID]] <> "/log-analysis_" <> fileDates[[tID]] <> 
  "_JSIK4_vocVec.save"

AbsoluteTiming[
 Save[vocVecSaveFile, {storyVocCVecSel, storyVocAVecSel}]]

end = Now
end - start

Print["Finish"]
