        easyTimePro/easyWDMS INSTALLATION PROCEDURE
        Version:9.0.6 and above
                  
Supported OS/Databases
 
	1. Centos 7, Ubuntu, Fedora, Debian(10 and above) and MAC
	2. PostgreSQL, MySQL and Oracle

Installation Steps

	MAC

	1. Download and Install the docker based on the Chipset.
		# https://www.docker.com/
	2. Run “sudo su” in the terminal first. It will let you to enter the root user's password.
	3. After entering the password, continue to the next step in the terminal.
	4. Extract zip file by using the following command:
		# unzip easytimepro-linux-9.0.7.zip
	5. Open the directory and Run the Following the command.
		# docker-compose build
	6. After build finished.
		# docker-compose up -d
 
	Linux(Centos 7, Ubuntu, Fedora, Debian)

	1. Run “sudo su” in the terminal first. It will let you to enter the root user's password.
	2. After entering the password, continue to the next step in the terminal.
	3. Extract zip file by using the following command:
		# unzip easytimepro-linux-9.0.7.zip
	4. Open the directory where the setup.sh file is located.
		Example:
		 # chmod 777 setup.sh
		 # bash setup.sh install
         
		If the # sh setup.sh install is not working and if it returns error, please try in the terminal using the following command:
		 # docker-compose  up -d --build

Command List	

		# docker-compose ps
		Check whether the service is working or not by using the above command.
		If the status shows “UP”, it means the service status is working.
        Otherwise, please check the logs of each service.
	
		# docker-compose down
		Stop all the services of easy TimePro Linux package.
        
		# docker-compose up -d
		Restart the service by using this command.
        
		# docker-compose start	 
		Start the software command.
        
		# docker-compose stop
		Stop the software command.
        
		# docker-compose restart	 
		Restart the software command.	 
	
		# docker-compose logs service_name
		Check the logs for each service.
        
        service_name:beat/worker/web/redis/nginx 
		Example: 
		 # docker-compose logs web
         
       
	When you enter this, all the logs will be printed from the terminal.
	If the number of logs is less, this method works well.
    If the number of logs is more, it will be very hard to check. 
    So, you can save one service logs to one file, and then check the logs in the file. You can use the following command:
		# docker-compose logs service_name > log_name.txt
		Example: # docker-compose logs web > web_logs.txt
		It will save all the logs to log_name.txt file. Then you can open this file and check the error log and start to debug.

Configuration of MySQL Database

	1. Edit the ‘attsite.ini’ file.	
	2. In the [DATABASE] column, fill in the configuration details of the MySQL database.
		Example:
		[DATABASE]
		# database configure
		# supported engine type: mysql/oracle/postgresql
		ENGINE=mysql
		NAME=easytime_linux
		USER=root
		PASSWORD=my_secrete_password
		PORT=3306
		HOST=192.168.10.1
        
	Note: Ensure that this configuration can be successfully connected to the MySQL Database externally after testing.
	
	3. Check the db connection by using the following command:
		#docker-compose exec web bash
		Example
			"""[root@localhost EasyTimePro]# docker-compose exec web bash
				root@0d261ca84e24:/app# python ConnDb.py
				mac=0242ac150005
				mysql connection is successful
				root@0d261ca84e24:/app# exit
				exit
			"""

Configuration of Oracle Database

	1. To support the Oracle database, we must install the Oracle Client driver initially.
	   	1. Open the Docker file(compose\production\web\Dockerfile)
		2. Uncomment the oracle client installation code.
	2. When connecting to oracle, you can use the SID or Service Name. When the Service Name is used, SERVICE_NAME_ must be added.
		Example: Service Name =orcl in attsite.ini	
        NAME=SERVICE_NAME_orcl
		       
Steps to change the Port

	The default port number of the software is 80. If you wants to change to other port, follow the below steps:
	Example: If you wants to change to port "8090":
		1. Open the ‘.env’ file.
		2. The file path is ‘easytimepro-linux-9.0.2/.env’.
		3. Change the port number as given below:
			web_port=“new port”
			Example:
			web_port=8090
		4. Run the following command again:
		 # docker-compose down         (if installed)
		 # docker-compose up -d        (if installed)
		 # bash setup.sh install       (if not installed)
	<Done>

## Open the link http://127.0.0.1:newport in the browser and then check.

Note:
	1.Make sure internet is working fine.
    2.When you install the software for the first time, please wait for a minute after installation and then login.
    3.Do not change anything in .yml file.

    
    
    
    