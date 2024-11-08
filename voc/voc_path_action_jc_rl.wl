(* Created with the Wolfram Language : www.wolfram.com *)
{x_String /; StringMatchQ[x, RegularExpression["https://[^/]*/"]] -> 
  voc["jc:*,view,top"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/\\?.*"]] -> voc["jc:*,search,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/search.*"]] -> voc["jc:*,search,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/facet-search/.*"]] -> 
  voc["jc:*,search,facet"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/get_search_setting.*"]] -> 
  voc["jc:*,search,setting"], 
 x_String /; StringMatchQ[x, RegularExpression["https://[^/]*/robots.txt\
"]] -> voc["jc:robot,view,robot.txt"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/get_child_list.*"]] -> 
  voc["jc:system,internalsystem_access,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/journal_info.*"]] -> 
  voc["jc:system,internalsystem_access,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/get_path_name_dict.*"]] -> 
  voc["jc:system,internalsystem_access,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/accounts.*"]] -> 
  voc["jc:system,internalsystem_access,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/records/[0-9\\.]+$"]] -> voc["jc:*,view,detail"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/records/[0-9\\.]+/file_details/.*"]] -> voc["jc:*,view,detail"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/records/[0-9\\.]+\\?.*"]] -> voc["jc:*,view,detail"], 

 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9\\.]+/files/.*[pP][dD][fF].*"]] -> voc["jc:*,view,document"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9\\.]+/files/.*xlsx"]] -> voc["jc:*,view,document"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9\\.]+/files/.*pptx"]] -> voc["jc:*,view,document"], 

 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9\\.]+.*pdf"]] -> voc["jc:*,view,document"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9\\.]+.*\\.pdf.*"]] -> voc["jc:*,view,document"], 

 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/records/[0-9\\.]+/export.*"]] -> 
  voc["jc:*,export,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/oai\\?.*"]] -> voc["jc:*,export,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/items.*"]] -> 
  voc["jc:Management,confirm,item"], 
 x_String /; StringMatchQ[x, RegularExpression["https://[^/]*/workflow.*\
"]] -> voc["jc:Management,confirm,workflow"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/admin.*"]] -> 
  voc["jc:Management,confirm,admin"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/login.*"]] -> voc["jc:*,authenticate,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/.*/shib/login.*"]] -> voc["jc:*,login,none"], 

 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/JDCatmetadata.html"]] -> 
  voc["jc:*,view,scheme"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/inform.html"]] -> 
  voc["jc:*,view,information"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/page/[0-9]*"]] -> 
  voc["jc:*,view,information"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/weko/sitemaps.*"]] -> 
  voc["jc:*,view,information"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*//*rss/.*"]] -> 
  voc["jc:*,view,rss"], 


 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9]+/files/.*\\.Z"]] -> 
  voc["jc:*,get,data"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9]+/files/.*\\.zip"]] -> 
  voc["jc:*,get,data"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9]+/files/.*\\.mp4"]] -> 
  voc["jc:*,get,data"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9]+/files/.*\\.csv"]] -> 
  voc["jc:*,get,data"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9]+/files/.*\\.docx"]] -> 
  voc["jc:*,get,data"], 


 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/data/.*\\.jpe*g"]] -> 
  voc["jc:system,internalaccess,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/.*\\.jpg"]] -> 
  voc["jc:system,internalaccess,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/data/.*\\.gif"]] -> 
  voc["jc:system,internalaccess,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/data/.*\\.png"]] -> 
  voc["jc:system,internalaccess,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9]+/files/.*\\.png"]] -> 
  voc["jc:system,internalaccess,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9]*/files/.*\\.html"]] -> 
  voc["jc:system,internalaccess,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9]*/files/.*\\.html{0,1}"]] -> 
  voc["jc:system,internalaccess,none"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/record/[0-9]*/.*\\.txt"]] -> 
  voc["jc:system,internalaccess,none"], 

 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/about"]] -> voc["jc:*,view,about"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/manual.html"]] -> voc["jc:*,view,manual"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/link.html"]] -> voc["jc:*,view,link_list"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/guidance.html"]] -> voc["jc:*,view,guide"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://[^/]*/analysis.html"]] -> voc["jc:*,view,analisys"]

}
