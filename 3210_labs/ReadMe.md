# Terraform Module ReadMe

## Requirements

- Terraform v1.0 or later
- AWS account credentials
- Access to an existing EC2 key pair in the target region (or create a new one)

## Computer Setup

### Step 1: Download the Repo

1. Open a web browser and go to https://github.com/AndyGreenPhD/ksu_labs
2. Click the green "Code" button on the right side of the repository page.
3. Choose "Download ZIP" to download the repository as a ZIP file.
4. Save the ZIP file to Documents

#### Windows

1. Find the downloaded ZIP file in Documents
2. Right-click the ZIP file and select "Extract All..."
3. Choose Documents as the location for the extracted files and click "Extract."
4. A new folder with the repository's name will be created.

#### macOS

1. Find the downloaded ZIP file in Documents
2. Double-click the ZIP file to extract its contents.
3. A new folder with the repository's name will be created.

#### Linux

1. Open the terminal.
2. Navigate to the directory where the downloaded ZIP file is located using the `cd` command.
3. Use the `unzip` command to extract the contents of the ZIP file:
   ```
   unzip repository-folder.zip
   ```
4. A new folder with the repository's name will be created.
5. Use the `mv` command to move the extracted folder to the Documents folder:
   ```
   mv repository-folder ~/Documents/
   ```

Replace "repository-folder" with the actual name of the folder that was created after extracting the ZIP file, and adjust file paths and folder names as needed. After following these steps, the repository contents should be in your Documents folder.

### Step 2: Installing Terraform

To install Terraform, follow the appropriate steps for your operating system:

#### Windows

1. Download the appropriate package for your system from the [Terraform downloads page](https://www.terraform.io/downloads.html).
2. Extract the downloaded archive to `$HOME\terraform`.
3. Open a command prompt and run `cd terraform`
4. Rrun `./terraform version` to verify that Terraform is installed and in your system's PATH.
5. Open the Windows start menu and type "Environment Variables".
6. Choose "Edit the system environment variables".
7. Click on the "Environment Variables" button.
8. Modify the PATH ariable to include the `$HOME\terraform` directory

#### Mac

1. Use [Homebrew](https://brew.sh/) to install Terraform: `brew install terraform`
2. Open a terminal and run `terraform version` to verify that Terraform is installed and in your system's PATH.

#### Linux

1. Follow the instructions for your specific Linux distribution on the [Terraform downloads page](https://www.terraform.io/downloads.html).
2. Extract the downloaded archive to a directory in your system's PATH.
3. Open a terminal and run `terraform version` to verify that Terraform is installed and in your system's PATH.

### Step 3: Creating AWS Account

1. Open your web browser and go to the AWS Management Console website at https://console.aws.amazon.com.
2. Click on the "Create a new AWS account" button. 
3. On the "Create a Free Account" page, select the "Personal" account type, depending on your needs. 
4. Fill in the required information, including your email address and a password for your AWS account. Make sure to choose a strong password. 
5. Read and accept the AWS Customer Agreement, as well as the AWS Service Terms, by checking the corresponding boxes. 
6. Choose the free Basic Plan for Support
7. Provide your contact information, including your name, address, and phone number. 
8. Enter your credit card information. AWS requires a valid credit card for account verification purposes. Note that certain services may incur charges, so make sure to monitor your usage and costs.
9. Review the information you provided and ensure everything is accurate. 
10. Click on the "Create Account and Continue" button.
11. AWS will now perform a verification process to confirm your identity. This may involve a phone call or SMS message verification. Follow the instructions provided to complete this step.

### Step 4: Generate AWS Keys

1. Sign in to the [AWS Management Console](https://console.aws.amazon.com/).
2. Click the drop down in the top right and select Security Credentials
3. In the "Access keys" section, choose "Create access key".
4. Save the access key ID and secret access key to a secure location on your computer, such as a password manager or encrypted file.
5. Within the `KSU_LABS/3210_labs` folder in your Documents open the `_init.tf` file in the `module` directory
6. Paste your access key and secret key into the provider block on lines 3 and 4. 

### Step 5: Generating SSH Keys

#### Windows

1. Ensure that OpenSSH is installed (https://phoenixnap.com/kb/generate-ssh-key-windows-10)
2. Open the Command Prompt by typing "cmd" in the Windows search bar and clicking on the "Command Prompt" application.
3. Type `ssh-keygen` and press enter.
4. Follow the prompts to specify the file name and location of the key pair.
5. Press enter twice to accept the default passphrase, or enter a new passphrase if desired.

#### Mac

1. Open the Terminal app by typing "Terminal" in the Spotlight search bar and clicking on the "Terminal" application.
2. Type `ssh-keygen` and press enter.
3. Follow the prompts to specify the file name and location of the key pair.
4. Press enter twice to accept the default passphrase, or enter a new passphrase if desired.

#### Linux

1. Open a terminal window.
2. Type `ssh-keygen` and press enter.
3. Follow the prompts to specify the file name and location of the key pair.
4. Press enter twice to accept the default passphrase, or enter a new passphrase if desired.

After generating the SSH key pair, you'll need to copy the public key to the clipboard so that you can paste it into the `public_key` variable in the Terraform module. To do this, follow these steps:

1. Open the terminal or command prompt where you generated the key pair.
2. Type `cat <public_key_file>` and press enter, replacing `<public_key_file>` with the name of the public key file you generated.
3. Highlight the entire output of the command, including the "ssh-rsa" header and the email address at the end.
4. Copy the highlighted text to the clipboard.

## Running the Lab

### Step 1: Initializing the Terraform Module

Once you have installed Terraform, follow these steps to initialize the module:

1. Clone or download the Terraform module from the repository.
2. Open a terminal and navigate to the root directory of the module.
3. Run `terraform init` to download any necessary dependencies.
4. Copy the public key that was generated earlier as the value on line 4 in the `main.tf` file
    * NOTE: With Windows you will need to remove the `domain\username` piece or you will recieve an error*
5. Update the public_key and AMI in the `main.tf` file.

### Step 2: Deploying the Infrastructure

Once you have initialized the module, follow these steps to deploy the infrastructure:

1. Open a terminal and navigate to the root directory of the module.
2. Run `terraform apply` to preview the changes that Terraform will make.
3. Review the changes and type `yes` when prompted to confirm the changes.
4. Wait for Terraform to provision the instances and output their public IP addresses.

### Step 3: Run the Lab

1. Log into the AWS Console
2. Navigate to the EC2 tab (you may have to search for it in the top bar)
3. In the top right it may say "N. Virigina", "Ohio", etc. Click the drop down and choose `us-east-2`
4. Click instances on the EC2 page
5. You should see 2 machines running. From here you can get the Public IPv4 Address for the instance
6. SSH into the instance
``` bash
ssh -i <<PATH TO YOUR SSH KEY>> ubuntu@<<PUBLIC IPv4 ADDRESS>>
```
7. From within the SSH session Run `sudo apt-get update`
8. Run `sudo apt-get install net-tools`
9. Refer to the lab assignment available to you in D2L

### Step 4: Destroying the Infrastructure

To tear down the infrastructure and release any associated resources, follow these steps:

1. Open a terminal and navigate to the root directory of the module.
2. Run `terraform destroy` to preview the changes that Terraform will make.
3. Review the changes and type `yes` when prompted to confirm the changes.
4. Wait for Terraform to destroy the instances and release any associated resources.

