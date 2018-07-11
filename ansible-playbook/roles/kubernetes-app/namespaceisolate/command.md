cfssl gencert -ca=/tmp/release/certs/ca.pem -ca-key=/tmp/release/certs/ca-key.pem -config=/tmp/release/certs/config.json -profile=kubernetes devadmin.json | cfssljson -bare devadmin



```bash
export KUBE_APISERVER="https://127.0.0.1:8443"

# 设置集群参数
kubectl config set-cluster kubernetes \
 --certificate-authority=/tmp/release/certs/ca.pem \
 --embed-certs=true \
 --server=${KUBE_APISERVER} \
 --kubeconfig=qaadmin.conf

# 设置客户端认证参数
kubectl config set-credentials qaadmin \
  --client-certificate=/tmp/release/certs/qaadmin.pem \
  --embed-certs=true \
  --client-key=/tmp/release/certs/qaadmin-key.pem \
  --kubeconfig=qaadmin.conf

# 设置上下文参数
kubectl config set-context qaadmin \
  --cluster=kubernetes \
  --user=qaadmin \
  --namespace=qa \
  --kubeconfig=qaadmin.conf

# 设置默认上下文
kubectl config use-context qaadmin --kubeconfig=qaadmin.conf

# cp成~/.kube/config
cp /tmp/release/certs/qaadmin.conf /home/dev/.kube/config

```
