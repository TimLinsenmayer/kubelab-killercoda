while [ ! -f "/tmp/kubelab/prompt.sh" ]; do
    sleep 1
done

chmod +x /tmp/kubelab/prompt.sh
/tmp/kubelab/prompt.sh