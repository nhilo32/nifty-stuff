
# SonarQube Installation on RHEL EC2 with RDS PostgreSQL

This document outlines the steps to install SonarQube on a Red Hat Enterprise Linux (RHEL) EC2 instance using an Amazon RDS PostgreSQL database.

## Prerequisites
- **RHEL EC2 Instance**: Running and accessible.
- **Java**: SonarQube requires Java (OpenJDK 11 is recommended).
- **Amazon RDS PostgreSQL Instance**: Set up and accessible.
- **Minimum Hardware Requirements**: At least 2GB of RAM and 1GB of free disk space on the EC2 instance.

## Installation Steps

### 1. Update Your System
```bash
sudo yum update
```

### 2. Install Java (if not already installed)
Install OpenJDK 11:
```bash
sudo yum install java-11-openjdk-devel
```

### 3. Verify Java Installation
```bash
java -version
```

### 4. Download SonarQube
Download the latest Community Edition from the SonarQube Downloads page:
https://binaries.sonarsource.com/?prefix=Distribution/sonarqube/
```bash
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.0.0.68432.zip
```
(Note: Replace `x.y.z` with the actual version number)

### 5. Unzip SonarQube
```bash
sudo yum install unzip
unzip sonarqube-x.y.z.zip -d /opt
```

### 6. Configure SonarQube
Install psql to connect to the database
```bash
sudo yum install -y https://download.postgresql.org/pub/repos/yum/repo-files/pgdg-redhat-repo-latest.noarch.rpm
```
```bash
sudo yum install -y postgresql12
```
```bash
psql --version
```

Edit the configuration file:
```bash
sudo vi /opt/sonarqube-x.y.z/conf/sonar.properties
```
Configure the database settings to point to your RDS PostgreSQL instance:
```
sonar.jdbc.username=<RDS_DB_USERNAME>
sonar.jdbc.password=<RDS_DB_PASSWORD>
sonar.jdbc.url=jdbc:postgresql://<RDS_ENDPOINT>:5432/<DB_NAME>
```
(Replace placeholders with your RDS instance details)

### 7. Start SonarQube
Switch to a non-root user (as SonarQube cannot run as root) and start it:
```bash
cd /opt/sonarqube-x.y.z/bin/linux-x86-64
./sonar.sh start
```

### 8. Access SonarQube
Open a web browser and navigate to `http://<your-ec2-instance-public-ip>:9000`. The default username and password is `admin`.

## Additional Configurations
- Adjust firewall and security group settings in your AWS environment to allow access to port 9000.
- Consider setting SonarQube to start automatically on boot.
- For production use, it is recommended to run SonarQube behind a web server and set up a reverse proxy with SSL/TLS.

## Troubleshooting
Check the logs in `/opt/sonarqube-x.y.z/logs` for any issues during start-up or operation.
