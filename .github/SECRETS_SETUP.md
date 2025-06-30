# GitHub Secrets Configuration Guide

This document outlines all the GitHub secrets required for the CI/CD pipeline to function properly.

## Required Secrets

### Docker Hub Integration
- **DOCKER_HUB_USERNAME**: Your Docker Hub username
- **DOCKER_HUB_ACCESS_TOKEN**: Docker Hub access token (not password) - create this in Docker Hub Settings > Security

### Application Configuration
- **FLASK_SECRET_KEY**: Secret key for Flask application (generate a secure random string)
- **TEST_DATABASE_URL**: Database URL for testing environment (optional)
- **STAGING_DATABASE_URL**: Database URL for staging environment
- **PRODUCTION_DATABASE_URL**: Database URL for production environment

### Server Access (SSH)
- **STAGING_HOST**: IP address or hostname of staging server
- **STAGING_USERNAME**: SSH username for staging server
- **STAGING_SSH_KEY**: Private SSH key for staging server access
- **STAGING_SSH_PASSPHRASE**: Passphrase for staging SSH key (if applicable)

- **PRODUCTION_HOST**: IP address or hostname of production server
- **PRODUCTION_USERNAME**: SSH username for production server
- **PRODUCTION_SSH_KEY**: Private SSH key for production server access
- **PRODUCTION_SSH_PASSPHRASE**: Passphrase for production SSH key (if applicable)
- **PRODUCTION_DOMAIN**: Domain name for production application

### External Services
- **CODECOV_TOKEN**: Token for Codecov integration (optional but recommended)
- **SLACK_WEBHOOK**: Slack webhook URL for deployment notifications

## How to Add Secrets to GitHub

1. Go to your GitHub repository
2. Click on "Settings" tab
3. Click on "Secrets and variables" → "Actions"
4. Click "New repository secret"
5. Add the secret name and value
6. Click "Add secret"

## Environment-Specific Secrets

For production deployment, you may want to use environment-specific secrets:

1. Go to Settings → Environments
2. Create environments: `staging` and `production`
3. Add environment-specific secrets and protection rules

## Security Best Practices

### SSH Key Generation
```bash
# Generate SSH key pair
ssh-keygen -t ed25519 -C "github-actions@yourdomain.com" -f github-actions-key

# Add public key to server's authorized_keys
cat github-actions-key.pub >> ~/.ssh/authorized_keys

# Use private key content as secret value
cat github-actions-key
```

### Flask Secret Key Generation
```python
import secrets
print(secrets.token_urlsafe(32))
```

### Docker Hub Access Token
1. Go to Docker Hub → Account Settings → Security
2. Click "New Access Token"
3. Give it a descriptive name like "GitHub Actions"
4. Select appropriate permissions
5. Copy the token immediately (you won't see it again)

## Optional Secrets

These secrets are optional but enhance the pipeline:

- **CODECOV_TOKEN**: For code coverage reporting
- **SLACK_WEBHOOK**: For deployment notifications
- **STAGING_SSH_PASSPHRASE**: Only if SSH key has a passphrase
- **PRODUCTION_SSH_PASSPHRASE**: Only if SSH key has a passphrase

## Environment Variables vs Secrets

The pipeline uses both secrets and environment variables:

### Environment Variables (public):
- `PYTHON_VERSION`: Python version to use
- `DOCKER_IMAGE_NAME`: Name of the Docker image
- `REGISTRY`: Docker registry URL

### Secrets (private):
- All authentication tokens, keys, and sensitive configuration

## Testing the Pipeline

1. Set up all required secrets
2. Push to main branch or create a pull request
3. Monitor the Actions tab for pipeline execution
4. Check each job for any missing secrets or configuration issues

## Troubleshooting

### Common Issues:
1. **SSH connection fails**: Check SSH key format and server access
2. **Docker push fails**: Verify Docker Hub credentials
3. **Deployment fails**: Check server connectivity and permissions
4. **Tests fail**: Verify test database configuration

### Debug Tips:
- Use `echo` commands to verify environment variables (never echo secrets!)
- Check action logs for detailed error messages
- Test SSH connections manually before using in pipeline
- Verify Docker Hub access token permissions

## Security Considerations

1. **Principle of Least Privilege**: Only grant necessary permissions
2. **Regular Rotation**: Rotate SSH keys and tokens regularly
3. **Environment Separation**: Use different credentials for staging/production
4. **Audit Trail**: Monitor secret usage in action logs
5. **Branch Protection**: Restrict who can push to main branch

## Pipeline Features

This CI/CD pipeline includes:

- ✅ Code quality checks (Black, Flake8)
- ✅ Security scanning (Bandit, Safety, Trivy)
- ✅ Multi-version testing
- ✅ Docker image building and pushing
- ✅ Blue-green production deployment
- ✅ Health checks
- ✅ Slack notifications
- ✅ Artifact uploads
- ✅ Environment protection rules
