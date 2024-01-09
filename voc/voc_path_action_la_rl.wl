(* Created with the Wolfram Language : www.wolfram.com *)
{x_ /; StringMatchQ[x, RegularExpression["https://lms.nii.ac.jp/"]] -> 
  voc["top"], x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/auth/.*"]] -> voc["authenticate"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/login/.*"]] -> voc["login"], 
 x_ /; StringMatchQ[x, RegularExpression["https://lms.nii.ac.jp/my/"]] -> 
  voc["dashboard"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/my/courses.php"]] -> voc["course_list"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/pluginfile.php/.*"]] -> 
  voc["internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/theme/.*"]] -> voc["internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/local/.*"]] -> voc["internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/lib/.*\\.php/.*js"]] -> 
  voc["internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/lib/ajax/.*"]] -> voc["internalsystem_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/admin/.*"]] -> voc["admin_access"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/.*/view.php.*"]] -> voc["content"], 
 x_ /; StringMatchQ[x, RegularExpression["https://lms.nii.ac.jp/mod/.*"]] -> 
  voc["content"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/message/.*"]] -> voc["content"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/badges/.*"]] -> voc["content"], 
 x_ /; StringMatchQ[x, RegularExpression["https://lms.nii.ac.jp/user/.*"]] -> 
  voc["profile"], 
 x_ /; StringMatchQ[x, RegularExpression[
     "https://lms.nii.ac.jp/enrol/index.php\\?.*"]] -> voc["resister"]}
