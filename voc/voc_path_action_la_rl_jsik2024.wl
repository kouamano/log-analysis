(* Created with the Wolfram Language : www.wolfram.com *)
{x_String /; StringMatchQ[x, RegularExpression["https://lms.nii.ac.jp/"]] -> 
  voc["la:*,view,top"], 
 x_String /; StringMatchQ[x, RegularExpression["https://lms.nii.ac.jp/auth/.*"]] -> 
  voc["la:*,authenticate,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/login/.*"]] -> voc["la:*,login,"], 
 x_String /; StringMatchQ[x, RegularExpression["https://lms.nii.ac.jp/my/"]] -> 
  voc["la:*,view,dashboard"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/my/courses.php"]] -> 
  voc["la:*,view,course_list"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/pluginfile.php/.*"]] -> 
  voc["la:system,internalsystem_access,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/theme/.*"]] -> 
  voc["la:system,internalsystem_access,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/local/.*"]] -> 
  voc["la:system,internalsystem_access,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/lib/.*\\.php/.*js"]] -> 
  voc["la:system,internalsystem_access,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/lib/ajax/.*"]] -> 
  voc["la:system,internalsystem_access,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/admin/.*"]] -> voc["la:Management,monitor,"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/.*/view.php.*"]] -> voc["la:*,view,content"], 
 x_String /; StringMatchQ[x, RegularExpression["https://lms.nii.ac.jp/mod/.*"]] -> 
  voc["la:*,view,content"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/message/.*"]] -> voc["la:*,view,content"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/badges/.*"]] -> voc["la:*,view,content"], 
 x_String /; StringMatchQ[x, RegularExpression["https://lms.nii.ac.jp/user/.*"]] -> 
  voc["la:*,view,profile"], 
 x_String /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/enrol/index.php\\?.*"]] -> voc["la:*,resister,"]}
