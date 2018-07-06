# ansible-kube-cluster

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

如果是证书更新操作，在ansible脚本跑完之后，我们可能需要删除掉/var/lib/etcd下的内容，否则，就会报错说没法配置网络，认证错误，我也不知道为啥，正在查这个问题，不过有一句说一句，证书的期限是10年，讲道理，10年之后，也许有新的产品出来了，所以更新证书这个操作有点扯啊
