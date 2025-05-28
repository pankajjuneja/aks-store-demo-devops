# AKS Store Demo - DevOps

A demonstration project for deploying a store application on Azure Kubernetes Service (AKS) with DevOps best practices.

## Project Structure

```
aks-store-demo-devops/
├── order-service/          # Order service application
│   ├── charts/            # Helm charts for deployment
│   │   ├── Chart.yaml     # Helm chart configuration
│   │   └── values.yaml    # Default values for Helm chart
│   └── templates/         # Kubernetes manifest templates
│       ├── deployment.yaml
│       ├── service.yaml
│       └── ingress.yaml
├── terraform/            # Infrastructure as Code (IaC)
│   ├── main.tf           # Main Terraform configuration
│   ├── variables.tf      # Terraform input variables
│   └── terraform.tfvars.example  # Example Terraform variables
└── README.md            # Project documentation
```

## Prerequisites

- Azure CLI
- kubectl
- helm
- Docker
- Terraform

## Getting Started

### 1. Infrastructure Setup

1. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```

2. Create a `terraform.tfvars` file from the example:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

3. Update `terraform.tfvars` with your Azure credentials and configuration

4. Apply the infrastructure:
   ```bash
   terraform plan
   terraform apply
   ```

### 2. Build and Push Docker Image

1. Build the Docker image:
   ```bash
   cd order-service
   docker build -t orderserviceregistry.azurecr.io/order-service:latest .
   ```

2. Push to Azure Container Registry:
   ```bash
   docker push orderserviceregistry.azurecr.io/order-service:latest
   ```

### 3. Deploy to AKS

1. Install Helm chart:
   ```bash
   helm install order-service ./order-service/charts
   ```

2. Verify deployment:
   ```bash
   kubectl get pods
   kubectl get service
   ```

## Configuration

### Helm Values

The Helm chart can be configured through `values.yaml`. Key configurable parameters include:

- `replicaCount`: Number of pods to deploy
- `image.repository`: Docker image repository
- `image.tag`: Docker image tag
- `resources`: Resource limits and requests
- `service`: Service configuration (type, ports)
- `ingress`: Ingress configuration (host, TLS)
- `livenessProbe`: Liveness probe settings
- `readinessProbe`: Readiness probe settings

### Terraform Variables

Key Terraform variables are defined in `variables.tf`. Update these in your `terraform.tfvars` file:

- `resource_group_name`: Name of the Azure resource group
- `aks_cluster_name`: Name of the AKS cluster
- `location`: Azure region
- `node_count`: Number of AKS nodes
- `node_size`: Size of AKS nodes

## Health Checks

The application includes both liveness and readiness probes:

- Liveness probe: Checks if the application is running
- Readiness probe: Checks if the application is ready to serve traffic

Both probes check the `/health` endpoint of the application.

## Security

- TLS is enabled for the ingress controller
- Resource limits are configured to prevent resource exhaustion
- Health checks ensure the application is running properly
- Docker images are built with security best practices

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.