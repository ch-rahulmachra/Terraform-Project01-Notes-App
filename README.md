# Serverless Notes App

A modern serverless full-stack notes application with a clean frontend and a scalable AWS backend. Designed with best practices for infrastructure-as-code, cloud services, and API-driven development.  

## 🚀 Features

- **Create, Read, Update, Delete (CRUD)** notes seamlessly.
- **Serverless backend** with AWS Lambda for compute and DynamoDB for data storage.
- **API Gateway** to expose REST endpoints.
- **Frontend** built with HTML, CSS, and JavaScript.
- **Infrastructure as Code (IaC)** using Terraform for reproducible and automated deployments.
- **CORS-enabled** API integration for frontend-backend communication.
- **UUID-based unique note identifiers** for reliable data management.

## ⚙️ Tech Stack

- **Frontend:** HTML, CSS, JavaScript  
- **Backend:** AWS Lambda (Node.js 18.x)  
- **Database:** AWS DynamoDB  
- **API:** AWS API Gateway  
- **Infrastructure:** Terraform  
- **ID Generation:** UUID  

## 💻 Setup & Deployment

### Prerequisites

- AWS CLI configured with credentials
- Terraform installed
- Node.js and npm installed

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/ch-rahulmachra/Terraform-Project01-Notes-App.git

2.	**Install dependencies for Lambda functions**
    cd build/createNote && npm install
    cd ../updateNote && npm install
    cd ../getNote && npm install
    cd ../deleteNote && npm install

3.	**Zip Lambda functions**
    for dir in createNote updateNote getNote deleteNote; 
    do
        cd build/$dir
        zip -r index.zip .
        cd ../../
    done

4.	**Deploy infrastructure using Terraform**
    terraform init
    terraform plan
    terraform apply

5.	**Serve frontend**
    Open modules/frontend/index.html in a browser or host it on S3.


## 🔗 API Endpoints
Method              Endpoint            Description
POST                /create             Create a new note
POST                /get                Fetch a note by ID
POST                /update             Update a note by ID
POST                /delete             Delete a note by ID

Note: All endpoints are CORS-enabled for frontend access.

## 📈 Why this Project Stands Out
	•	Full serverless architecture: minimal maintenance, auto-scaling backend.
	•	Terraform IaC ensures reproducible deployments and professionalism.
	•	Demonstrates API integration and frontend-backend interaction.
	•	Implements best practices for AWS IAM roles, permissions, and Lambda functions.

## 📝 Future Improvements
	•	User authentication with AWS Cognito
	•	Rich text editor for notes
	•	Tagging and search functionality
	•	Frontend hosted on S3 with CloudFront