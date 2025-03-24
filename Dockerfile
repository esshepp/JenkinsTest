# Step 1: Pull/Download Postgres Docker Image
docker pull postgres

# Step 2: Start and Run Postgres Container
docker run -d --name postgres6010 -p 5432:5432 -e POSTGRES_PASSWORD='pgpass123' postgres

# Step 3: Pull/Download pgAdmin4 Docker Image
docker pull dpage/pgadmin4

# Step 4: Build and Run pgAdmin4 Container
docker run --name pgadmin6010 -p 82:80 -e 'PGADMIN_DEFAULT_EMAIL=herndonn19@ecu.edu' -e 'PGADMIN_DEFAULT_PASSWORD=pgapass123' -d dpage/pgadmin4

# Step 5: Verify Executing Containers
docker ps

# Step 6: Access pgAdmin4 on Browser
Go to to http://localhost:82/ and provide the required login credentials that we have configured in step 4.

# Step 7: Establish a Connection Between pgAdmin and Docker Postgres Instance
# General>Name: PostgreSQL for 6010
# Connection>Host name/address: 
# Connection>Username: postgres
# Connection>Password: pgpass123
