"""arch linux set up"""

"""1. Kubeflow on AWS - Vanilla Installation - EKS"""

# 1. Install `kubectl` locally.
sudo pacman -S kubectl

# 2. Install `AWS-CLI`.
sudo pacman -S aws-cli

# 3. Configure the `aws-cli` to generate `config` and `credential` files.
aws configure

# 4. Install `eksctl`.
sudo pacman -S eksctl

# 5. Install the `aws-iam-authenticator`.
sudo pacman -S aws-iam-authenticator

# 6. Create an `EKS cluster` using `eksctl`.
#   6.1 Export environment variables: `cluster name, region, k8s version` and `EC2_instance type`.\
export AWS_CLUSTER_NAME=kubeflow
export AWS_REGION=eu-west-1
export K8S_VERSION=1.20
export EC2_INSTANCE_TYPE=m5.large 

# 7. Create a cluster config file for use with eksctl and confirm its creation. 
cat << EOF > cluster.yaml
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: ${AWS_CLUSTER_NAME}
  version: "${K8S_VERSION}"
  region: ${AWS_REGION}

managedNodeGroups:
- name: kubeflow-mng
  desiredCapacity: 3
  instanceType: ${EC2_INSTANCE_TYPE}
EOF

# save the .yaml config file to wd
eksctl create cluster -f cluster.yaml

# confirm cluster creation. 
kubectl get nodes --all-namespaces

# 8. Install kfcts/kubeflow
PLATFORM=$(uname)
export PLATFORM
mkdir -p ~/Kubeflow/bin
export KUBEFLOW_TAG=1.2.0
KUBEFLOW_BASE="https://api.github.com/repos/kubeflow/kfctl/releases"
KFCTL_URL=$(curl -s ${KUBEFLOW_BASE} | grep http | grep "${KUBEFLOW_TAG}" | grep -i "${PLATFORM}" | cut -d : -f 2,3 | tr -d '\" ' )

wget "${KFCTL_URL}"
KFCTL_FILE=${KFCTL_URL##*/}
tar -xvf "${KFCTL_FILE}"
mv ./kfctl ~/Kubeflow/bin

export PATH=$PATH:~/Kubeflow/bin
kfctl version # check version

# 9. Create a kubeflow project
MANIFEST_BRANCH=${MANIFEST_BRANCH:-v1.2-branch}
export MANIFEST_BRANCH
MANIFEST_VERSION=${MANIFEST_VERSION:-v1.2.0}
export MANIFEST_VERSION

KF_PROJECT_NAME=${KF_PROJECT_NAME:-hello-kf-${PLATFORM}}
export KF_PROJECT_NAME
mkdir "${KF_PROJECT_NAME}"

manifest_root=https://raw.githubusercontent.com/kubeflow/manifests
FILE_NAME=kfctl_k8s_istio.${MANIFEST_VERSION}.yaml
KFDEF=${manifest_root}${MANIFEST_BRANCH}/kfdef/${FILE_NAME}

kfctl apply -f $KFDEF -V
echo $?

kubectl get pods --all-namespaces -w

# access dashboard
kubectl port-forward svc/istio-ingressgateway -n istio-system 7777:80
