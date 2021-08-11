# Sievert Web Application
A pharmaceuticacl themed web application that emulates administrative function on a DMBS through provided console.<br>
Basic CRUD functions and misc functions are implemented, though there would be some other functions might be missing that alters the details.

Web Server: `Jboss` or `WildFly v17`<br>
Database System: `PostgreSQL`<br>
Connection: `JDBC JPA Persistence API`<br>
JavaEE Enviroment IDE: `Eclipse`<br>
Java version: `11.0.7`

**Important Notes**<br>
The SQL for generating the database schema can be found under the folder named `employees_backup.sql`<br>
The database follows the directory: `database/schema/tables` - `employees/employees/<tables>`<br><br>
For JavaEE Environment, the `<jta-data-source>` attribute in `persistence.xml` is named `java:/employeedeptsys`<br>
Please make sure the connection details are correct.
