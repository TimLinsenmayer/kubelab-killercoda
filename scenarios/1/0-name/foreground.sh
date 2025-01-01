while [ ! -f /tmp/kubelab/prompt.sh ]; do
  sleep 0.1
done

source /tmp/kubelab/prompt.sh 

echo "Please press START on the left to continue."