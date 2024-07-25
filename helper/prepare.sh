#!/bin/bash

################ Chapter 1 Start #####################

# Function to execute commands for 'c1a'
function c1a_commands {
    echo "Preparing the Insecure Code "
    cp -r ~/s4cp/chapter1/. ~/playground/
    sleep 1
    echo "Starting Terraform to Deploy Chapter1 Code"
    cd ~/playground/infra
    export AWS_PROFILE=admin
    terraform init
    terraform validate
    terraform plan
    terraform apply --auto-approve
    echo "Chapter 1 Code Deployed"
}

# Function to execute commands for 'c1b'
function c1b_commands {
    echo "Preparing to Destroy"
    cd ~/playground/infra
    export AWS_PROFILE=admin
    terraform destroy --auto-approve
    echo "Deleted All Resources"
    cp ~/playground/notes.md ~/notes.md    
    find ~/playground -mindepth 1 -delete
    cp ~/notes.md ~/playground/notes.md 
}

################ Chapter 1 End #####################

################ Chapter 2 Start #####################

# Function to execute commands for 'c2a'
function c2a_commands {
    echo "Preparing code for Terraform State storage"
    cp -r ~/s4cp/chapter2/2A/. ~/playground/
    sleep 1
    echo "Starting Terraform to Create Terraform State Storage Infrastructure"
    cd ~/playground/state
    export AWS_PROFILE=admin
    terraform init 
    terraform validate
    terraform plan 
    terraform apply --auto-approve
}

# Function to execute commands for 'c2b'
function c2b_commands {
    cd ~/playground
    echo "Preparing code for Global Infrastructure "
    cp -r ~/s4cp/chapter2/2B/. ~/playground/
    echo "Open global/global.hcl and edit bucket name and dynamo db name before proceeding"
}

# Function to execute commands for 'c2c'
function c2c_commands {
    echo "Preparing code for AWS IAM Roles "
    cd ~/playground
    cp -r ~/s4cp/chapter2/2C/. ~/playground/
    git status
    git add .
    git commit -m 'adding aws IAM Roles'
    git push
    echo "Changes Pushed Please check Github Actions"
}

# Function to execute commands for 'c2d'
function c2d_commands {
    cd ~/playground
    echo "Preparing code for AWS IAM Users"
    cp -r ~/s4cp/chapter2/2D/. ~/playground/
}

# Function to execute commands for 'c2e'
function c2e_commands {
    echo "Ensure your GPG Keys have been generated"
    cd ~/playground/
    git status
    git add .
    git commit -m 'adding IAM Users'
    git push
    echo "Changes Pushed Please check Github Actions"
}

# Function to execute commands for 'c2f'
function c2f_commands {
    echo "Preparing for CI/CD in Dev and Prod"
    cd ~/playground
    cp -r ~/s4cp/chapter2/2E/. ~/playground/
    echo "Populate dev.hcl.dev.tfvars,prod.hcl and prod.tfvars with appropriate details"
}

# Function to execute commands for 'c2g'
function c2g_commands {
    echo "Checking out Dev branch"
    git checkout -b dev
    git add .
    git commit -m "first commit to dev"
    git push --set-upstream origin dev
    echo "Changes Pushed Please create a PR"
}

################ Chapter 2 End #####################

################ Chapter 3 Start #####################

# Function to execute commands for 'c3a'
function c3a_commands {
    cd ~/playground
    echo "Preparing code for Semgrep Practice"
    cd ~/s4cp/chapter3/3A/
}

# Function to execute commands for 'c3b'
function c3b_commands {
    echo "Re-Aligning Git to Main Branch"
    cd ~/playground/
    git checkout main
    git pull
    echo "Preparing code For Semgrep GHA"
    cp -r ~/s4cp/chapter3/3B/. ~/playground/
    echo "Checking Out Semgrep Github Action in semgrep branch"
    git checkout -b semgrep
    git status    
    git add .
    git commit -m "integrating semgrep"
    git push --set-upstream origin semgrep
    echo "Please create a Pull Request between branches main and semgrep "
}

# Function to execute commands for 'c3c'
function c3c_commands {
    echo "Re-Aligning Git to Main Branch"
    cd ~/playground/
    git checkout main
    git pull
    echo "Preparing code for integrating dependency-check in GHA "
    cp -r ~/s4cp/chapter3/3C/. ~/playground/
    echo "Checking Out Dependency Checker Github Action in sca branch"
    git checkout -b sca
    git status
    git add .
    git commit -m "integrating dependency-check in gha"
    git push --set-upstream origin sca
    echo "Please create a Pull Request between branches main and sca "
}

# Function to execute commands for 'c3ca'
function c3ca_commands {
    echo " Triggering SCA "
    cd ~/playground/app
    # Remove First line from pom.xml    
    tail -n +2 pom.xml > temp.xml && mv temp.xml pom.xml
    git status
    git add .
    git commit -m "triggering sca"
    git push --set-upstream origin sca
}

# Function to execute commands for 'c3d'
function c3d_commands {
    echo "Preparing Code for trigerring Gitleaks" 
    cd ~/playground/
    git checkout main
    git pull
    cp -r ~/s4cp/chapter3/3D/. ~/playground/
    git status
    git add .
    git commit -m "adding gitleaks"
    git push
}

# Function to execute commands for 'c3da'
function c3da_commands {
    echo "Checking out leaked secrets into gitleaks branch"
    cp -r ~/s4cp/chapter3/3DD/. ~/playground/
    cd ~/playground/
    git checkout -b gitleaks
    git status
    git add .
    git commit -m "triggering gitleaks"
    git push --set-upstream origin gitleaks
    echo "Please create a Pull Request between branches main and gitleaks "
}

# Function to execute commands for 'c3db'
function c3db_commands {
    echo "Git Leaks Won't Catch"
    cd ~/playground/
    cp -r ~/s4cp/chapter3/3DDD/. ~/playground/
    git status
    git add .
    git commit -m "gitleaks won’t catch"
    git push --set-upstream origin gitleaks
}

# Function to execute commands for 'c3dc'
function c3dc_commands {
    echo "Git Leaks Catches !"
    cd ~/playground/
    mv gitleaks.toml .gitleaks.toml
    sed -i'.bak' 's/testpassword/testpassword123/g' app/src/main/resources/application.properties
    rm app/src/main/resources/application.properties.bak
    git status
    git add .
    git commit -m "gitleaks will catch"
    git push --set-upstream origin gitleaks
}

# Function to execute commands for 'c3e'
function c3e_commands {
    echo "Reverting infra/providers.tf and application.properties"
    cd ~/playground/
    cp -r ~/s4cp/chapter3/3E/. ~/playground/
    echo "Checking out the changes in gitleaks branch "
    git status
    git add .
    git commit -m "removing leaks"
    git push --set-upstream origin gitleaks
    echo "Creating leak directory for git cleaning "
    cd ~
    mkdir leak
    cd leak
}

# Function to execute commands for 'c3ea'
function c3ea_commands {
    cd ~/leak
    echo "AKIAERKSDFASDFKASDMD" >> passwords.txt
    echo "CuNQE0DQBU1IrTX0K7HBuBTwBLyq0rp0Tm6J2dne" >> passwords.txt
    echo "testpassword123" >> passwords.txt
    echo "testpassword" >> passwords.txt
    cat passwords.txt
}

################ Chapter 3 End #####################

################ Chapter 4 Start #####################

# Function to execute commands for 'c4a'
function c4a_commands {
    echo "Re-Aligning Git"
    cd ~/playground/
    git checkout main
    git pull
    echo "Preparing code for Creating IAM Role for ECR "
    cp -r ~/s4cp/chapter4/4A/. ~/playground/
    git status
    git add .
    git commit -m "creating ecr iam role"
    git push
}

# Function to execute commands for 'c4b'
function c4b_commands {
    cd ~/playground/
    echo "Preparing code for Create ECR Repository "
    cp -r ~/s4cp/chapter4/4B/. ~/playground/
    git status
    git add .
    git commit -m "create ecr repository"
    git push
}

# Function to execute commands for 'c4c'
function c4c_commands {
    cd ~/playground/
    echo "Preparing code for Github Actions for ECR Images "
    cp -r ~/s4cp/chapter4/4C/. ~/playground/
    git status
    git add .
    git commit -m "create ecr images"
    git push
}

# Function to execute commands for 'c4d'
function c4d_commands {
    cd ~/playground/
    echo "Preparing code for Semgrep for Docker "
    cp -r ~/s4cp/chapter4/4D/. ~/playground/
    git checkout -b dockersec
    git status
    git add .
    git commit -m "checking semgrep dockerfiles"
    git push --set-upstream origin dockersec
    echo "Please create a Pull Request between branches main and dockersec "
}

# Function to execute commands for 'c4da'
function c4da_commands {
    cd ~/playground/
    echo "Checking in Secure Dockerfile "
    cp -r ~/s4cp/chapter4/4DD/. ~/playground/
    git status
    git add .
    git commit -m "checking in secure Dockerfile"
    git push --set-upstream origin dockersec
}

# Function to execute commands for 'c4e'
function c4e_commands {
    echo "Re-Aligning Git"
    cd ~/playground/
    git checkout main
    git pull
    echo "Preparing code for Trivy Integration "
    cp -r ~/s4cp/chapter4/4E/. ~/playground/
    git status
    git add .
    git commit -m "Integrating Trivy with GHA"
    git push
}

# Function to execute commands for 'c4ea'
function c4ea_commands {
    echo "Preparing code to Triggering Trivy "
    cd ~/playground/
    cp -r ~/s4cp/chapter4/4EE/. ~/playground/
    git checkout -b trivy
    git status
    git add .
    git commit -m "checking out trivy"
    git push --set-upstream origin trivy
    echo "Please create a Pull Request between branches main and trivy "

}

################ Chapter 4 End #####################

################ Chapter 5 Start #####################

# Function to execute commands for 'c5a'
function c5a_commands {
    echo "Re-Aligning Git"
    cd ~/playground/
    git checkout main
    git pull
    echo "Preparing for Chapter 5A - Setup Prod Environment "
    cp -r ~/s4cp/chapter5/5A/. ~/playground/
}

# Function to execute commands for 'c5ab'
function c5ab_commands {
    read -p " Have you added the docker image in app_docker_img in infra/prod.tfvars (yes/no)? " user_input

    if [[ "$user_input" == "yes" ]]; then
        cd ~/playground/
        echo "Starting the Prod Environment "
        git status
        git add .
        git commit -m "checking out prod"
        git push
        echo "Changes Pushed please check Github Actions "
    elif [[ "$user_input" == "no" ]]; then
        echo "Please add the docker image in infra/prod.tfvars "        
    else
        echo "Invalid input. Please enter 'yes' or 'no'."
    fi

}

# Function to execute commands for 'c5b'
function c5b_commands {
    echo "Preparing code for creating K8s IAM Roles "
    cd ~/playground/
    cp -r ~/s4cp/chapter5/5B/. ~/playground/
    git status
    git add .
    git commit -m "aws iam roles for k8s"
    git push
}

# Function to execute commands for 'c5c'
function c5c_commands {
    echo "Preparing code for creating K8s RBAC "
    cd ~/playground/
    cp -r ~/s4cp/chapter5/5C/. ~/playground/
    git status
    git add .
    git commit -m "creating k8s rbac objects"
    git push
}

# Function to execute commands for 'c5d'
function c5d_commands {
    echo "Preparing code for EKS Encryption "
    cd ~/playground/
    cp -r ~/s4cp/chapter5/5D/. ~/playground/
    git status
    git add .
    git commit -m "eks encryption"
    git push
}

# Function to execute commands for 'c5e'
function c5e_commands {
    echo "Preparing code for Secrets Management  "
    cd ~/playground/
    cp -r ~/s4cp/chapter5/5E/. ~/playground/
    git status
    git add .
    git commit -m "secrets management"
    git push
}

# Function to execute commands for 'c5f'
function c5f_commands {
    echo "Preparing code for Installing Kyverno "
    cd ~/playground/
    cp -r ~/s4cp/chapter5/5F/. ~/playground/
    git status
    git add .
    git commit -m "installing kyverno"
    git push
}

# Function to execute commands for 'c5fa'
function c5fa_commands {
    echo "Preparing code for testing Kyverno "
    cd ~/playground/
    cp -r ~/s4cp/chapter5/5FF/. ~/playground/
    git status
    git add .
    git commit -m "testing kyverno"
    git push
}

# Function to execute commands for 'c5g'
function c5g_commands {
    echo "Preparing code for Installing Calico "
    cd ~/playground/
    cp -r ~/s4cp/chapter5/5G/. ~/playground/
    git status
    git add .
    git commit -m "installing calico"
    git push
}

# Function to execute commands for 'c5i'
function c5i_commands {
    echo "Preparing for Installing Network Security Policy "
    cd ~/playground/
    cp -r ~/s4cp/chapter5/5I/. ~/playground/
    git status
    git add .
    git commit -m "installing nsps"
    git push
}

################ Chapter 5 End #####################

################ Chapter 6 Start #####################

# Function to execute commands for 'c6a'
function c6a_commands {
    echo "Preparing code for Installing SCPs "
    cd ~/playground/
    cp -r ~/s4cp/chapter6/6A/. ~/playground/
    git status
    git add .
    git commit -m "installing scps"
    git push
}

# Function to execute commands for 'c6b'
function c6b_commands {
    echo "Preparing code for Understanding OPA "
    cd ~/playground/
    cp -r ~/s4cp/chapter6/6B/. ~/playground/
    cd test
    export AWS_PROFILE=admin
}

# Function to execute commands for 'c6ba'
function c6ba_commands {
    echo "Preparing code for Two More EC2s for OPA "
    cd ~/playground/
    cp -r ~/s4cp/chapter6/6BB/. ~/playground/
    cd test
    export AWS_PROFILE=admin
}

# Function to execute commands for 'c6bc'
function c6bc_commands {
    echo "Preparing code to check for Proper IMDSv2 Checks "
    cd ~/playground/
    cp -r ~/s4cp/chapter6/6BC/. ~/playground/
    cd test
    export AWS_PROFILE=admin
}

# Function to execute commands for 'c6c'
function c6c_commands {
    echo "Preparing code for Integrating OPA with Github Actions "
    cd ~/playground/
    cp -r ~/s4cp/chapter6/6C/. ~/playground/
    git checkout -b opa
    git status
    git add .
    git commit -m "checking out opa"
    git push --set-upstream origin opa
    echo "Please create a Pull Request between branches main and opa "
}

# Function to execute commands for 'c6d'
function c6d_commands {
    echo "Preparing code for Rolling back changes "
    cd ~/playground/
    cp -r ~/s4cp/chapter6/6D/. ~/playground/
    git status
    git add .
    git commit -m "rolling back changes"
    git push --set-upstream origin opa
}

################ Chapter 6 End #####################

# Set the script to exit immediately on error
set -e

# Main script starts here
case "$1" in
    c1a)
        c1a_commands
        ;;
    c1b)
        c1b_commands
        ;;  
    c2a)
        c2a_commands
        ;;
    c2b)
        c2b_commands
        ;;   
    c2c)
        c2c_commands
        ;;  
    c2d)
        c2d_commands
        ;;   
    c2e)
        c2e_commands
        ;;
    c2f)
        c2f_commands
        ;;
    c2g)
        c2g_commands
        ;;
    c3a)
        c3a_commands
        ;;
    c3b)
        c3b_commands
        ;;
    c3c)
        c3c_commands
        ;;         
    c3ca)
        c3ca_commands
        ;;  
    c3d)
        c3d_commands
        ;;     
    c3da)
        c3da_commands
        ;;                           
    c3db)
        c3db_commands
        ;;                           
    c3dc)
        c3dc_commands
        ;;                       
    c3e)
        c3e_commands
        ;;                       
    c3ea)
        c3ea_commands
        ;;                       
    c4a)
        c4a_commands
        ;;                       
    c4b)
        c4b_commands
        ;;                       
    c4c)
        c4c_commands
        ;;                       
    c4d)
        c4d_commands
        ;;                       
    c4da)
        c4da_commands
        ;;                       
    c4e)
        c4e_commands
        ;;                       
    c4ea)
        c4ea_commands
        ;;                       
    c5a)
        c5a_commands
        ;;                       
    c5ab)
        c5ab_commands
        ;;                       
    c5b)
        c5b_commands
        ;;                       
    c5c)
        c5c_commands
        ;;                       
    c5d)
        c5d_commands
        ;;                       
    c5e)
        c5e_commands
        ;;                       
    c5f)
        c5f_commands
        ;;
    c5fa)
        c5fa_commands
        ;;                       
    c5g)
        c5g_commands
        ;;                       
    c5i)
        c5i_commands
        ;;                       
    c6a)
        c6a_commands
        ;;                       
    c6b)
        c6b_commands
        ;;                       
    c6ba)
        c6ba_commands
        ;;                       
    c6bc)
        c6bc_commands
        ;;                       
    c6c)
        c6c_commands
        ;;                       
    c6d)
        c6d_commands
        ;;            
    *)
        echo "Usage: $0 {c1a}"
        exit 1
        ;;
esac

# End of script