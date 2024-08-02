
# GKE Terraform and Containerized API Service Helm Project

This project demonstrates the ability to manage GCP resources using Terraform and Helm.

## Prerequisites

- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Helm](https://helm.sh/docs/intro/install/)
- [Docker](https://docs.docker.com/get-docker/)
- A GCP account with billing enabled

## Setup Instructions

### 1. Configure GCP Project

1. Create a new GCP project.
2. Enable the Kubernetes Engine API and Compute Engine API.
3. Authenticate using the Google Cloud SDK:
   ```sh
   gcloud auth login
   gcloud config set project <your-project-id>
   ```

### 2. Deploy GKE Cluster using Terraform

1. Clone the repository:
   ```sh
   git clone <repository-url>
   cd <repository-directory>/terraform
   ```
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Apply the Terraform configuration:
   ```sh
   terraform apply
   ```

### 3. Build and Push Docker Image

1. Build the Docker image:
   ```sh
   cd ../docker
   docker build -t gcr.io/<your-project-id>/api-service:latest .
   ```
2. Push the image to Google Container Registry:
   ```sh
   gcloud auth configure-docker
   docker push gcr.io/<your-project-id>/api-service:latest
   ```

### 4. Deploy API Service using Helm

1. Update the `values.yaml` file in the `helm/api-service` directory with your project-specific values.
2. Deploy the application to the GKE cluster:
   ```sh
   cd ../helm
   helm install api-service ./api-service
   ```

### 5. Verify Deployment

1. Get the external IP of the service:
   ```sh
   kubectl get services
   ```
2. Test the API service:
   ```sh
   ./scripts/test-api.sh <external-ip>
   ```

### 6. Monitoring

Basic monitoring is set up using Google Cloud Monitoring. You can view metrics in the Google Cloud Console under the Monitoring section.

## Cleanup

To destroy the resources created by Terraform:
```sh
cd ../terraform
terraform destroy
```

To uninstall the Helm chart:
```sh
helm uninstall api-service
```

## Security Notes

- SSL/TLS is configured using cert-manager and Let's Encrypt.
- Network policies are implemented to restrict traffic between pods.
- RBAC is used to define roles and permissions.
- Secrets are managed using Kubernetes secrets.

Note: Some advanced security features may not be implemented in this basic setup. In a production environment, additional security measures should be considered.
