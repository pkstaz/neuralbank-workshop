# Financial Risk Evaluation AI Application Demo

This repository contains the components for the Financial Risk Evaluation AI Application Demo. It bundles backend services, workshop code, frontend, database scripts and a Helm chart that models the core banking architecture.

## Overview

- `customer-service` (backend): core backend service implemented in Java (Maven). See [`customer-service/`](customer-service/) and [`customer-service/pom.xml`](customer-service/pom.xml).  
- `customer-service-mcp` (workshop): code and exercises used for the workshop/activity. See [`customer-service-mcp/`](customer-service-mcp/).  
- `credit-approval-service` (in development): credit approval microservice currently under development. See [`credit-approval-service/`](credit-approval-service/) and [`credit-approval-service/pom.xml`](credit-approval-service/pom.xml).  
- `credit-approval-mcp`: workshop variant of the credit approval code. See [`credit-approval-mcp/`](credit-approval-mcp/).  
- `neuralbank-front` (frontend): customer-facing UI implemented as a web frontend (Node / JS or TS stack). See [`neuralbank-front/`](neuralbank-front/).  
- `database`: SQL scripts and DB resources. These scripts live in [`database/`](database/) but are optional if you deploy using the Helm chart.  
- `charts`: Helm chart describing the core banking architecture (customer-service, frontend, database and nginx proxy). The chart sources are in [`charts/`](charts/) and primary metadata in [`charts/Chart.yaml`](charts/Chart.yaml). A precompiled chart image is published to Quay for quick deployment.

## Directory structure (high level)

- [`charts/`](charts/) — Helm chart (YAML) for deploying the core stack: backend, frontend, DB, nginx proxy.  
- [`database/`](database/) — SQL / DB scripts (optional when using the Helm chart).  
- [`customer-service/`](customer-service/) — Java (Maven) backend service.  
- [`customer-service-mcp/`](customer-service-mcp/) — Workshop code and exercises for the backend.  
- [`credit-approval-service/`](credit-approval-service/) — Java service (marked as in development).  
- [`credit-approval-mcp/`](credit-approval-mcp/) — Workshop code for credit approval.  
- [`neuralbank-front/`](neuralbank-front/) — Frontend application (Node / JS/TS).

## Notes

- If you deploy via the Helm chart in [`charts/`](charts/), the DB scripts in [`database/`](database/) are not required.  
- Services that include Maven wrappers and `pom.xml` are Java-based (Maven). See each service folder for build/run instructions.

## Quick links

- Helm chart: [`charts/Chart.yaml`](charts/Chart.yaml)  
- Backend: [`customer-service/`](customer-service/) — [`customer-service/pom.xml`](customer-service/pom.xml)  
- Workshop backend: [`customer-service-mcp/`](customer-service-mcp/)  
- Credit approval (in development): [`credit-approval-service/`](credit-approval-service/) — [`credit-approval-service/pom.xml`](credit-approval-service/pom.xml)  
- Frontend: [`neuralbank-front/`](neuralbank-front/)  
- Database scripts: [`database/`](database/)
