## Images for cli (gcr-cleaner-cli) not http
FROM us-docker.pkg.dev/gcr-cleaner/gcr-cleaner/gcr-cleaner-cli:latest

ENV GOOGLE_APPLICATION_CREDENTIALS=/root/gcr-cleaner.json

COPY gcr-cleaner.json /root/gcr-cleaner.json