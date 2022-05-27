Docker Commands
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=SpikePrototype2016" -e "MSSQL_PID=Express" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-latest