# EC2 Configuration

## Instance Details
- **Instance Type:** t3a.xlarge
- **Availability Zone:** us-gov-west-1a
- **Role:** ManagedInstanceRole
- **AMI:** 20230728-RHEL8_GI_ami_devsecops-platform

## RDS Configuration
- **Class:** db.t3.small
- **Postgresql Engine Version:** 15.4

# Installation Procedure

1. Download the LTS version from [SonarSource](https://www.sonarsource.com/). Ensure you download the version corresponding to your license (Enterprise in this case). eg.
   ```
   wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.4.1.88267.zip
   ```
3. Unzip and place onto `/opt/sonarqube/`.
    ```
    [root@dsopsonar sonarqube]# pwd
    /opt/sonarqube
    [root@dsopsonar sonarqube]# ls
    bin  conf  COPYING  data  dependency-license.json  elasticsearch  extensions  lib  logs  temp  web
    ```
4. Install Java OpenJDK 17.
    ```
    yum install java-17-openjdk.x86_64
    ```
5. Edit `/etc/sysctl.conf` to add the following additional parameters to the end of the file:
    ```
    # Increase the maximum number of memory map areas per process (needed for Elasticsearch)
    vm.max_map_count=524288

    # Increase the system-wide limit for the number of open file handles
    fs.file-max=131072
    ```
6. Add the `sonar` user and set file limits.
    ```
    useradd sonar
    vim /etc/security/limits.d/99-sonarqube.conf
    sonar   -   nofile   131072
    sonar   -   nproc    8192
    ```
7. Configure File Access Policy.
    ```
    vim /etc/fapolicyd/rules.d/5-sonar.rules
    ## UID of sonar user
    allow perm=any uid=1006 : dir=/opt/sonarqube/
    allow perm=any uid=1006 trust=1 : all
    sysctl -p ; systemctl restart fapolicyd
    ```
8. Edit `/opt/sonarqube/conf/sonar.properties` for database configuration.
    ```
    sonar.jdbc.username=postgres
    sonar.jdbc.password=CHANGE_ME
    sonar.jdbc.url=jdbc:postgresql://CHANGE_ME.us-gov-west-1.rds.amazonaws.com/sonarqube
    sonar.path.data=/var/sonarqube/data
    sonar.path.temp=/var/sonarqube/temp
    ```
   Ensure `/var/sonarqube` has sufficient space (50G to 100G recommended), preferably using LVM.

9. Create a systemd service file for SonarQube.
    ```
    vim /etc/systemd/system/sonar.service
    [Unit]
    Description=SonarQube service
    After=syslog.target network.target

    [Service]
    Type=forking
    ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
    ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
    LimitNOFILE=131072
    LimitNPROC=8192
    User=sonar
    Group=sonar
    Restart=on-failure

    [Install]
    WantedBy=multi-user.target
    ```
10. Set ownership and start SonarQube service.
    ```
    chown -R sonar:sonar /opt/sonarqube/ ; restorecon -vR /opt/sonarqube/
    systemctl enable sonar.service ; systemctl start sonar.service
    ```
   Check `/opt/sonarqube/logs` to review the startup process.

11. Set up an Application Load Balancer (ALB) for SSL termination.

