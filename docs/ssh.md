# Connecting to EC2 via SSM Session Manager

No SSH keys or open ports required. Access is managed via IAM.

---

## Prerequisites

### 1. AWS CLI

```bash
brew install awscli
```

Verify:
```bash
aws --version
```

### 2. Session Manager Plugin

```bash
brew install --cask session-manager-plugin
```

Verify:
```bash
session-manager-plugin --version
```

---

## Connect

### Public EC2

```bash
aws ssm start-session \
  --target $(terraform output -raw public_ec2_instance_id) \
  --region $AWS_DEFAULT_REGION
```

### Private EC2

```bash
aws ssm start-session \
  --target $(terraform output -raw private_ec2_instance_id) \
  --region $AWS_DEFAULT_REGION
```

---

## Troubleshooting

| Symptom                                     | Cause                             | Fix                                                         |
|---------------------------------------------|-----------------------------------|-------------------------------------------------------------|
| `TargetNotConnected`                        | SSM Agent not registered yet      | Wait 1-2 min after `terraform apply` and retry              |
| `AccessDeniedException`                     | IAM user lacks SSM permissions    | Attach `AmazonSSMFullAccess` to your IAM user               |
| Session drops immediately                   | SSM Agent not running on instance | Run `sudo systemctl start amazon-ssm-agent` via AWS Console |
| `session-manager-plugin: command not found` | Plugin not installed              | Re-run the install step above                               |
