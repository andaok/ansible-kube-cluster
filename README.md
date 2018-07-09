# ansible-kube-cluster

**前提：你的deploybox能够连接Google等国外的网站，否则的话，这些对应的二进制包和images没法下载下来，当然，你可以尝试一下，毕竟我没有在没法连接外网的情况下测试过，手动笑脸**

```bash
cd ansible-playbook
ansible-playbook -i environment/prod/inventory  cluster.yaml
```


### 初次部署

在deploybox上安装ansible，并且配置deploybox和master、node节点的互信，具体操作方式，就不在这里赘述了，具体可参考[ansible客配置](https://kevinguo.me/2017/07/06/ansible-client/)

版本确认以及参数修改

> 如果这是你第一次部署k8s，那么问题不大，确认好版本以及一些关键参数即可，比如说k8s的版本，docker的版本，etcd的版本等，第一次部署一定要把`skip_downloads`关掉，否则，你是没法部署成功的

```bash
skip_downloads: false
etcd_version: v3.3.8
kube_version: v1.9.9
docker_version: 18.03.0
docker_compose_version: 1.21.2
kube_cni_version: v0.6.0
```

其他参数，看看就好了，我相信，既然你准备来部署k8s cluster了，这些基本的键值参数，你还是能看懂的


### 第二次或者更多次的部署

> 第二次部署，一般来说，是版本更新，或者说证书更新，这时候如果是版本更新，那么你只需要修改对于的版本参数，然后重新部署即可；如果是证书更新，那么你需要将`/tmp/release/certs`下的证书都删掉之后，重新deploy，才会生成新的证书。

如果是证书更新操作，证书更新之后，我们需要将服务组件重启，并且重新创建对应的serviceaccount，然后将对应的服务的pods进行delete，使其重新创建，大致步骤如下：


重启所有组件

```bash
# on master
systemctl restart kube-apiserver kube-controller-manager kube-scheduler

# on node
rm -rf /etc/kubernetes/ssl/kubelet*
systemctl restart kubelet kube-proxy
```

删除所有相关的sa

```bash
kubectl delete sa --all -n kube-system
```

重新创建除了默认sa之外的所有sa

```bash
kubectl apply -f sa.yaml
```

删除所有相关的pod

```bash
kubectl delete pods --all -n kube-system
```

接着，你就会发现，你的所有业务都正常了

```bash
kubectl get pods --all-namespaces
```


**PS：一般来说，咱们的自签名证书都是10年起，10年之后，咱们还用不用k8s这个技术都难说，所以一般证书更新的操作基本上是不会有的**
