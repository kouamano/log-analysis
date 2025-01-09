echo '<- apply_code_base.sh ->'
git --no-pager diff main:D_base/apply_code_base.sh linux:D_base/apply_code_base.sh 
echo '<- exec-analysis ->'
git --no-pager diff main:D_base/exec-analysis linux:D_base/exec-analysis 
echo '<- exec-ckan-analysis ->'
git --no-pager diff main:D_base/exec-ckan-analysis linux:D_base/exec-ckan-analysis 
echo '<- exec-preproc ->'
git --no-pager diff main:D_base/exec-preproc linux:D_base/exec-preproc 
echo '<- exec-us-analysis ->'
git --no-pager diff main:D_base/exec-us-analysis linux:D_base/exec-us-analysis
echo '<- init ->'
git --no-pager diff main:D_base/init linux:D_base/init
echo '<- date.ws ->'
git --no-pager diff main:D_base/T=4/_story/date.ws linux:D_base/T=4/_story/date.ws
echo '<- graph.ws ->'
git --no-pager diff main:D_base/T=4/_story/graph.ws linux:D_base/T=4/_story/graph.ws
echo '<- ci-ckan-graph.ws ->'
git --no-pager diff main:D_base/T=4/_story/ci-ckan-graph.ws linux:D_base/T=4/_story/ci-ckan-graph.ws
echo '<- us.ws ->'
git --no-pager diff main:D_base/T=4/_story/us.ws linux:D_base/T=4/_story/us.ws
