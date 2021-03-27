# springmvc-todolist-genericdao
A simple Spring MVC web application use JSP and GenericDAO

### General Description
* Spring MVC + Spring Security (customer UserDetails)
* Front-End: JSP/HTML/Bootstrap4/jQuery-DataTable
* Backend: Spring and MySQL-ORM by GenericDAO
* Connection Pool provided by GenericDAO
* Maven as package manager tool
* In PROD - AWS deployment, Tomcat 8.5.23 as container
* In DEV - Jetty can serve as the container as well
* Email Function - JavaMailSender only work for local dev, as smtp.gmail.com got issue in AWS instance. 
    Amazon AES will be implemented if time is allowed in the future

### Install GenericDAO with Maven for local dev
* Download genericdao-3.0.2.jar from http://www.genericdao.org/GenericDAO/ (created by Prof. Jeff Eppinge) or http://www.genericdao.org/GenericDAO/genericdao-3.0.2.jar
* Move genericdao-3.0.2.jar file to [project_root]=springmvc-todolist-genericdao
```bash
~springmvc-todolist-genericdao $ mvn install:install-file -Dfile=genericdao-3.0.2.jar -DgroupId=org.genericdao 
  -DartifactId=genericdao -Dversion=3.0.2 -Dpackaging=jar
```

### Run it
Create mysql database:
```sql
CREATE DATABASE db_todolist_generic CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;
```
in project root directory
```bash
~springmvc-todolist-genericdao $ mvn jetty:run
```

### Authentication & Authorization

Role-Authority System implemented here:
* one-to-many: each role can have multiple ROLE_ACTION
* in UserToAuthority table we have (uid, aid) pair
* this can be improved by using (role, aid) system, which can minimize the size of UserToAuthority or RoleToAuthority table

### Tomcat configuration

Tomcat configuration Windows 10 examples
* `CATALINA_HOME=D:\Programs\apache-tomcat-8.5.23`
* `CLASSPATH=C:\Program Files\Java\jdk-1.8.xxx\bin`

### Style-check
in project root directory
```bash
~springmvc-todolist-genericdao $ mvn checkstyle:checkstyle
```

TestUser: (Super Admin)
* username: sa
* password: password

---
Last updated in Jan-2020
