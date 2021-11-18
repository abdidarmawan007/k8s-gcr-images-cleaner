# GCR Images cleaner with k8s cron 

### Create Service via UI GCP or Terraform, Account Google Cloud + Iam Rules for support delete images recursive
![alt text](https://i.imgur.com/ja43Zup.png)
![alt text](https://i.imgur.com/gQBJG1K.png)


### Download service account key json
```
gcloud iam service-accounts keys create gcr-cleaner.json \
  --iam-account=gcr-cleaner@zeus-14235464232132.iam.gserviceaccount.com
```
### Add permission to bucket GCR
```
gsutil iam ch serviceAccount:gcr-cleaner@zeus-14235464232132.iam.gserviceaccount.com:objectCreator,objectAdmin,legacyBucketReader gs://asia.artifacts.zeus-14235464232132.appspot.com
```

### Build Docker Images
```
docker build --no-cache -t cron-gcr-cleaner .
docker tag cron-gcr-cleaner asia.gcr.io/zeus-14235464232132/cron-gcr-cleaner:v1
docker push asia.gcr.io/zeus-14235464232132/cron-gcr-cleaner:v1
```

### deploy cron k8s
```
kubectl apply -f cron-k8s.yaml 
```

### Parameters
- `repo` - Full name of the repository to clean, in the format
  `gcr.io/project/repo`. This field is required.

- `allow_tagged` - If set to true, will check all images including tagged.
  If unspecified, the default will only delete untagged images.

- `keep` - If an integer is provided, it will always keep that minimum number
  of images. Note that it will not consider images inside the `grace` duration.

- `recursive` - If set to true, will recursively search all child repositories.

### Best practices structure GCR repo
- create 2 cron for staging and production
- for prodcution `asia.gcr.io/zeus-14235464232132/production-gcr`
- for staging `asia.gcr.io/zeus-14235464232132/staging-gcr`
![alt text](https://i.imgur.com/FRdyiC6.png)



#### Source tool: https://github.com/GoogleCloudPlatform/gcr-cleaner

