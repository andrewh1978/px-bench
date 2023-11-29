# README for AWS
## Suggestions and breadcrumbs for testing on AWS

See https://docs.aws.amazon.com/eks/latest/userguide/storage.html for links to various drivers available in EKS.

EBS: Since Portworx would consume EBS volumes as Portworx Clouddrives, attempting "apples to apples" comparisons between AWS native storage and Portworx should be done with EBS volumes that are the same size as the Portworx clouddrive used for the pool.

Installation of the EBS CSI is documented here: https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html

Update `px-bench-env.yml` to your desired AWS storageclass. For example, benchmark the EBS native storageclass "ebs-csi" vs. the Portworx storageclass "px-csi-db"
