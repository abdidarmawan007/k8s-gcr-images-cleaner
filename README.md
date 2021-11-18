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
docker tag cron-gcr-cleaner asia.gcr.io/zeus-14235464232132/cron-gcr-cleaner:v7
docker push asia.gcr.io/zeus-14235464232132/cron-gcr-cleaner:v7
```

### deploy cron k8s
```
kubectl apply -f cron-k8s.yaml 
```

#### Source tool: https://github.com/GoogleCloudPlatform/gcr-cleaner

