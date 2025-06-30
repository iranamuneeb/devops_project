# Flask Web Application with Advanced CI/CD Pipeline

This project demonstrates a complete CI/CD pipeline for a Flask web application using GitHub Actions with comprehensive secret management.

## 🚀 Features

### CI/CD Pipeline Features
- **Code Quality Checks**: Black formatting, Flake8 linting
- **Security Scanning**: Bandit (code), Safety (dependencies), Trivy (container)
- **Multi-Version Testing**: Tests across Python 3.9, 3.10, and 3.11
- **Docker Integration**: Automated building and pushing to Docker Hub
- **Blue-Green Deployment**: Zero-downtime production deployments
- **Health Checks**: Automated verification of deployments
- **Notifications**: Slack integration for deployment status
- **Artifact Management**: Test results and security reports

### Application Features
- Flask web application with Bootstrap UI
- Health check endpoint for monitoring
- Comprehensive test suite
- Docker containerization
- Production-ready configuration

## 🔧 Setup Instructions

### 1. Clone and Configure Repository

```bash
git clone <your-repo-url>
cd <your-repo-name>
```

### 2. Set Up GitHub Secrets

Follow the detailed guide in [`.github/SECRETS_SETUP.md`](.github/SECRETS_SETUP.md) to configure all required secrets.

**Essential Secrets:**
- `DOCKER_HUB_USERNAME` and `DOCKER_HUB_ACCESS_TOKEN`
- `FLASK_SECRET_KEY`
- Server access: `STAGING_HOST`, `STAGING_USERNAME`, `STAGING_SSH_KEY`
- Production: `PRODUCTION_HOST`, `PRODUCTION_USERNAME`, `PRODUCTION_SSH_KEY`

### 3. Server Preparation

Prepare your staging and production servers:

```bash
# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Create deployment user
sudo adduser deploy
sudo usermod -aG docker deploy

# Set up SSH access for GitHub Actions
sudo -u deploy mkdir -p /home/deploy/.ssh
# Add your public key to /home/deploy/.ssh/authorized_keys
```

### 4. Environment Configuration

Create environments in GitHub:
1. Go to Settings → Environments
2. Create `staging` and `production` environments
3. Add protection rules for production (require reviews, etc.)

## 🔄 Pipeline Workflow

### Trigger Events
- **Push to main/develop**: Full pipeline including deployment
- **Pull Requests**: Code quality, security checks, and testing only
- **Manual Trigger**: Full pipeline with manual approval

### Pipeline Stages

1. **Code Quality** 🧹
   - Black code formatting check
   - Flake8 linting
   - Bandit security analysis
   - Safety dependency check

2. **Testing** 🧪
   - Multi-version testing (Python 3.9, 3.10, 3.11)
   - Code coverage reporting
   - Test result artifacts

3. **Build & Push** 🐳
   - Multi-platform Docker image building
   - Push to Docker Hub with proper tagging
   - Image metadata and caching

4. **Security Scanning** 🔍
   - Trivy container vulnerability scanning
   - SARIF report upload to GitHub Security

5. **Staging Deployment** 🚀
   - Deploy to staging environment
   - Health check verification
   - Slack notification

6. **Production Deployment** 🌟
   - Blue-green deployment strategy
   - Load balancer updates
   - Health verification
   - Notifications

7. **Cleanup** 🧽
   - Remove old Docker images
   - Maintain system hygiene

## 🏃‍♂️ Local Development

### Run Locally
```bash
# Install dependencies
pip install -r requirements.txt

# Run the application
python runserver.py
```

### Run Tests
```bash
# Run tests with coverage
pytest FlaskWebProject1/tests/ --cov=FlaskWebProject1

# Run security checks
bandit -r .
safety check
```

### Docker Development
```bash
# Build image
docker build -t flask-app .

# Run container
docker run -p 8000:8000 -e SECRET_KEY="dev-secret" flask-app
```

## 📊 Monitoring and Health Checks

### Health Endpoint
The application provides a health check endpoint at `/health`:

```bash
curl http://localhost:8000/health
```

Response:
```json
{
  "status": "healthy",
  "timestamp": "2025-06-30T12:00:00",
  "version": "1.0.0"
}
```

### Monitoring Integration
- **Codecov**: Code coverage tracking
- **GitHub Security**: Vulnerability alerts
- **Slack**: Deployment notifications
- **Docker Hub**: Image repository

## 🔒 Security Features

### Secret Management
- All sensitive data stored as GitHub secrets
- Environment-specific secret isolation
- SSH key-based server access
- Docker Hub access tokens (not passwords)

### Security Scanning
- **Bandit**: Python code security analysis
- **Safety**: Dependency vulnerability checking
- **Trivy**: Container image scanning
- **GitHub Security**: Automated vulnerability alerts

### Deployment Security
- Blue-green deployments for zero downtime
- Health checks before traffic switching
- Rollback capabilities
- Environment protection rules

## 📝 Configuration Files

### Key Files
- `.github/workflows/cicd.yml`: Main CI/CD pipeline
- `.github/SECRETS_SETUP.md`: Detailed secrets configuration guide
- `.github/secrets.template`: Template for secret values
- `Dockerfile`: Container configuration
- `requirements.txt`: Python dependencies

### Environment Variables
The pipeline uses these environment variables:
- `SECRET_KEY`: Flask secret key (from secrets)
- `DATABASE_URL`: Database connection string (from secrets)
- `ENVIRONMENT`: Runtime environment (staging/production)

## 🚨 Troubleshooting

### Common Issues

1. **Pipeline Fails on Secrets**
   - Verify all required secrets are set
   - Check secret names match exactly
   - Ensure SSH keys have correct format

2. **Docker Push Fails**
   - Verify Docker Hub access token
   - Check repository permissions
   - Ensure username is correct

3. **Deployment Fails**
   - Test SSH connection manually
   - Verify server has Docker installed
   - Check deployment user permissions

4. **Health Checks Fail**
   - Verify application starts correctly
   - Check port bindings
   - Review application logs

### Debug Tips
- Check GitHub Actions logs for detailed errors
- Test SSH connections manually
- Verify Docker Hub credentials
- Monitor application logs during deployment

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests locally
5. Submit a pull request

The CI/CD pipeline will automatically run on your pull request to ensure code quality and security.

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
