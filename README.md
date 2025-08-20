1. Install kubectl (Kubernetes Command-Line Tool)
What it is: kubectl is how you will interact with your Kubernetes cluster. You'll use it to view running applications, check logs, and manage resources.

Install Chocolatey before using in windows

On macOS (using Homebrew):
brew install kubectl/

On Windows (using Chocolatey) in PowerShell:
choco install kubernetes-cli

✅ Verification:
Run the following command. It should output the client version without any errors.
kubectl version --client

2. Install helm (The Kubernetes Package Manager)
What it is: Helm helps you install and manage complex applications on Kubernetes. We will use it to install most of our core services like Argo CD and Prometheus.

On macOS (using Homebrew):
brew install helm

On Windows (using Chocolatey) in powershell:
choco install kubernetes-helm

✅ Verification:
Check the installed version.
helm version

3. Install terraform (Infrastructure as Code Tool)
What it is: Terraform is the tool we will use to write code that defines and creates our cloud infrastructure, including the Kubernetes cluster itself.

On macOS (using Homebrew):
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

On Windows (using Chocolatey):
choco install terraform

✅ Verification:
Check the installed version.
terraform version

4. Install Your Cloud Provider's CLI
What it is: This tool lets you interact with your cloud account (AWS or Google Cloud) from the command line. You only need to install the one for the cloud provider you choose in the next phase.

Google Cloud CLI (gcloud)

Installation:
The best way to install gcloud is by following the official, interactive installer for your OS.
Go to: https://cloud.google.com/sdk/docs/install and follow the instructions.

Authentication (Crucial Step):
After installation, you need to log in to your Google account and set your project.
# This will open a browser window for you to log in
gcloud auth login

# Set the project you will be working on (get the Project ID from your team)
gcloud config set project bricbybric-platform

✅ Verification:

For gcloud: $ gcloud config list


5. Install istioctl (Istio Command-Line Tool)
What it is: istioctl is a specific tool for installing, analyzing, and debugging your Istio service mesh.

Installation (All Operating Systems):
This command downloads Istio and istioctl.

curl -L https://istio.io/downloadIstio | sh -

Configuration (Crucial Step):
The command above downloads Istio into a new directory (e.g., istio-1.23.0). You need to add the istioctl tool from that directory to your system's PATH.

Navigate into the new directory: cd istio-1.23.0

Add the bin folder to your PATH.

# This adds it to your PATH for the current terminal session
export PATH="$PWD/bin:$PATH"
To make this permanent, add that same line to your shell profile file (~/.bashrc, ~/.zshrc, or ~/.profile), then restart your terminal.

✅ Verification:
Check the installed version.

Bash

istioctl version
Congratulations! Once all these tools are installed and verified, your local environment is fully prepared. 

Then
git clone <this repo?
cd infra-repo

open terminal
terraform init
terraform plan
terraform apply
