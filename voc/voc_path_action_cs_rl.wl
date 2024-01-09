(* Created with the Wolfram Language : www.wolfram.com *)
{x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/hub/home.*"]] -> 
  voc["cs:*,view,top"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/hub/{1,2}"]] -> voc["cs:*,view,top"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/{1,2}"]] -> voc["cs:*,view,top"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/hub/token.*"]] -> 
  voc["cs:*,confirm,token"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/rstudio/.*"]] -> 
  voc["cs:resercher,develop,rstudio"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/clusters.*"]] -> 
  voc["cs:researcher,develop,cluster"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/notebooks.*"]] -> 
  voc["cs:researcher,develop,notebook"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/terminals.*"]] -> 
  voc["cs:researcher,develop,terminal"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/tree.*"]] -> 
  voc["cs:researcher,confirm,item_list"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/shiny.*"]] -> 
  voc["cs:researcher,confirm,item_list"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/api/.*"]] -> voc["cs:*,request,api"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/auth/.*"]] -> 
  voc["cs:*,authenticate,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/Shibboleth.sso/.*"]] -> 
  voc["cs:*,authenticate,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/hub/login.*"]] -> 
  voc["cs:*,authenticate,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/login.*"]] -> 
  voc["cs:*,authenticate,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/suite-auth/login"]] -> 
  voc["cs:*,authenticate,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/login.*"]] -> 
  voc["cs:*,login,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/hub/static.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/custom/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/static/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/nbextensions/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/lab.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/v2/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/f{0,1}ckeditor/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/static/base/images.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/rdm-binderhub/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/server-proxy/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/offlinenotebook/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/files/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/tree/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/uuid/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*/lc/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/build/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/hub/logo"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/webtools/.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/version.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/arcgis.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/mifs.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/functionRouter.*"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/favicon.ico"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*\\.ico"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/hub/.*\\.ico"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*\\.svg"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/.*\\.svg"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/user/.*\\.txt"]] -> 
  voc["cs:system,internalsystem_access,"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://jupyter.cs.rcos.nii.ac.jp/service.*"]] -> 
  voc["cs:*,confirm,additional_service"]}
