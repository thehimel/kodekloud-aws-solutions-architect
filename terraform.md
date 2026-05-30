# AWS + Terraform Lab Setup

Quick-start Terraform setup for temporary AWS lab environments. Credentials reset periodically; this workflow keeps friction minimal.

---

## Prerequisites

Install dependencies with Homebrew:

```bash
brew install awscli
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

Verify:

```bash
aws --version
terraform -version
```

### References

- [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

---

## Project Structure

```
.
├── .env                  # AWS credentials (gitignored)
├── update-creds.sh       # Refresh creds after each lab reset
├── new-lab.sh            # Scaffold a new lab folder
├── update-provider.sh    # Sync root provider.tf to all labs
├── provider.tf           # Source of truth for AWS provider config
└── 02-services-networking/
    └── 17-elastic-ip-demo/
        ├── provider.tf   # copied from root
        └── main.tf
```

---

## First-Time Setup

```bash
chmod +x update-creds.sh
chmod +x new-lab.sh
chmod +x update-provider.sh
```

---

## Every Credential Reset

1. Log into the AWS Console with your lab credentials
2. Go to **IAM > Users > `iam_lab_user` > Security credentials** tab
3. Click **Create access key**, choose **CLI**, copy the key ID and secret
4. Run the updater and paste the values when prompted:

```bash
./update-creds.sh
```

It writes `.env`, loads the vars into your shell, and verifies them with `aws sts get-caller-identity`.

If you open a **new terminal** after running the script, reload manually:

```bash
source .env
```

---

## Environment Variables

| Variable | Required | Notes |
|---|---|---|
| `AWS_ACCESS_KEY_ID` | yes | From IAM > Security credentials |
| `AWS_SECRET_ACCESS_KEY` | yes | From IAM > Security credentials |
| `AWS_SESSION_TOKEN` | optional | Only needed for temporary/STS credentials, leave blank otherwise |
| `AWS_DEFAULT_REGION` | yes | Defaults to `us-east-1` if left blank |

---

## Creating a New Lab

```bash
./new-lab.sh 02-services-networking/17-elastic-ip-demo
```

This creates the folder, copies `provider.tf` from root, and adds a blank `main.tf`.

---

## Updating the Provider Version

Edit the root `provider.tf`, then sync it to all existing labs:

```bash
./update-provider.sh
```

---

## Running a Lab

`provider.tf` is pre-configured to read credentials purely from env vars, no hardcoded values anywhere. Each lab has its own isolated Terraform state.

```bash
cd 02-services-networking/17-elastic-ip-demo
terraform init
terraform plan
terraform apply -auto-approve
```

Tear down when done:

```bash
terraform destroy -auto-approve
```
