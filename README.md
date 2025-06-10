# AKS Store Demo - DevOps

A demonstration project for deploying a Node.js order service application on Azure Kubernetes Service (AKS) with DevOps best practices.

## Project Structure

```
aks-store-demo-devops/
├── azure-pipelines-infra.yml     # Infrastructure pipeline (Terraform)
├── azure-pipelines-ci.yml         # CI pipeline (Build and Push)
├── azure-pipelines-cd.yml         # CD pipeline (Deploy to AKS)
├── order-service/                 # Order service application
│   ├── charts/                   # Helm charts for deployment
│   │   ├── Chart.yaml            # Helm chart configuration
│   │   ├── values.yaml           # Default values for Helm chart
│   │   └── templates/            # Kubernetes manifest templates
│   │       ├── deployment.yaml   # Kubernetes deployment configuration
│   │       ├── service.yaml      # Kubernetes service configuration
│   │       ├── ingress.yaml      # Kubernetes ingress configuration
│   │       └── networkpolicy.yaml # Network policy configuration
│   └── src/                      # Application source code
│       ├── app.js                # Main application file
│       ├── Dockerfile            # Container configuration
│       ├── package.json          # Node.js dependencies
│       └── routes/               # API routes
├── terraform/                    # Infrastructure as Code (IaC)
│   ├── main.tf                   # Main Terraform configuration
│   ├── variables.tf              # Terraform input variables
│   └── terraform.tfvars          # Example Terraform variables
└── README.md                    # Project documentation
```

## Prerequisites

- Azure CLI
- kubectl
- helm
- Docker
- Terraform
- Node.js 18.x

## Application

The order service is a Node.js application built with Fastify framework. It exposes:
- Health check endpoint at `/health`
- Orders API endpoints
- Runs on port 8080
- Uses environment variables for configuration

## Infrastructure

The infrastructure is managed using Terraform and includes:
- Azure Resource Group
- Azure Kubernetes Service (AKS) cluster
- Storage account for Terraform state
- Proper networking configuration

## Network Security

The application includes network policies to secure inter-service communication:

1. **Ingress Policy**:
   - Only allows incoming traffic on port 8080
   - Restricts access to pods within the same namespace
   - Prevents unauthorized access from other namespaces

2. **Egress Policy**:
   - Allows outbound traffic to other pods on port 8080
   - Enables necessary external connections:
     - HTTPS (port 443)
     - DNS resolution (ports 53 TCP/UDP)

3. **Security Features**:
   - Uses namespace isolation
   - Follows principle of least privilege
   - Prevents lateral movement within the cluster
   - Ensures proper DNS resolution and HTTPS connectivity

The network policies are configured using Kubernetes NetworkPolicy resources and are managed through Helm charts.

## Deployment Process

The application is deployed using Helm charts, which provides:

- Kubernetes deployment configuration
- Service configuration with health checks
- Ingress configuration
- Resource limits and requests
- Liveness and readiness probes

## CI/CD Pipelines

1. Infrastructure Pipeline (`azure-pipelines-infra.yml`)
   - Creates Azure resources
   - Sets up AKS cluster
   - Configures storage for Terraform state

2. CI Pipeline (`azure-pipelines-ci.yml`)
   - Builds Node.js application
   - Creates Docker image
   - Runs tests
   - Pushes image to Azure Container Registry

3. CD Pipeline (`azure-pipelines-cd.yml`)
   - Downloads artifacts from CI pipeline
   - Deploys to AKS using Helm
   - Configures HTTPS
   - Sets up health checks and probes

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

### 2. Application Deployment

1. Build and push Docker image:
```bash
az acr build --registry <your-acr> --image order-service:latest .
```

2. Deploy to AKS using Helm:
```bash
helm install order-service order-service/charts/ --set image.repository=<your-acr>/order-service,image.tag=latest
```

## Configuration

### Environment Variables

The application uses the following environment variables:
- `APP_VERSION`: Application version (set during Docker build)
- `NODE_ENV`: Node.js environment (development/production)

### Helm Values

The Helm chart can be configured using values.yaml:
- `replicaCount`: Number of replicas
- `image`: Docker image configuration
- `resources`: CPU and memory limits/requests
- `ingress`: Ingress configuration
- `service`: Service configuration
- `livenessProbe`: Liveness probe settings
- `readinessProbe`: Readiness probe settings

## Testing

The application includes:
- Unit tests using Tap
- Integration tests
- Health check endpoint
- Performance tests

To run tests:
```bash
npm test
```

## Monitoring

The application includes:
- Health check endpoint
- Resource usage monitoring
- Error tracking
- Performance metrics

## Security

The application implements:
- HTTPS
- Proper authentication
- Input validation
- Rate limiting
- Security headers

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Prerequisites

- Azure CLI
- kubectl
- helm
- Docker
- Terraform
- Node.js 18.x

## Getting Started

### 1. Infrastructure Setup

1. Initialize Terraform:
   ```bash
   cd terraform
   terraform init
   ```

2. Create a `terraform.tfvars` file from the example:
   ```bash
   cp terraform.tfvars envnameterraform.tfvars
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
- `ingress`: Ingress configuration (host)
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


- Resource limits are configured to prevent resource exhaustion
- Health checks ensure the application is running properly
- Docker images are built with security best practices
