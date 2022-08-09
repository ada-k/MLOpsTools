# MLOpsTools
MLOps tools, pipelines and frameworks for flexibility and scalability in ML workflows.

**Building blocks of an ML system in production:**

1. Data prep:\
  1.1 Data Ingestion.\
  1.2 Data Analysis.\
  1.3 Data Transformation.\
  1.4 Data Validation.
  1.5 Data Splitting.
 
2. Model development + training at scale:\
  2.1 Model training.\
  2.2 Model Validation.\
  2.3 MOdel training at scale.
 

3. Deployment and Monitoring:\
  3.1 Deployment.\
  3.2 Serving.\
  3.1 Monitoring.\
  3.2 Logging.


## [Kubeflow](kubeflow.sh)
**Pros:**
- Composability.
- Portability.
- Scaling.

![image](https://user-images.githubusercontent.com/50487929/183337684-f48dbb48-24de-4c3a-bfdb-ef9d0426c58f.png)

**Amazon EKS\
Pros:**
1. Fully managed kubernetes control plane.
2. UI.
3. Scheduling engine for multi-step ML workflows.
4. SDK for pipeline and components manipulation.
5. Pre packaged optimised deep learning docker containers are offered by EC2, SageMaker, EKS. (No need for further tuning).

**Kubeflow on AWS (EKS) Set up:**
1. Install `kubectl` locally.
2. Install `AWS-CLI`.
3. Configure the `aws-cli` to generate `config` and `credential` files.
4. Install `eksctl`.
5. Install the `aws-iam-authenticator`.
6. Create an `EKS cluster` using `eksctl`.\
  6.1 Export environment variables: `cluster name, region, k8s version` and `EC2_instance type`.
7. Create a cluster config file for use with eksctl and confirm its creation.
9. Install Kubeflow.
10. Create a kubeflow project
11. Access the kubeflow UI.


## [MLFlow]()
