# Simple Symfony Library

This project is a simple book library. Books can be imported from `datasources/books.json`. Books stored in the database can be exported and saved. Only an admin can perform import/export operations. The project includes only basic administration and supports a single role: `ROLE_ADMIN`.

---

## Local Development with Docker Compose
This project uses the **Docker** environment. Docker image for PHP is custom. Configuration and Dockerfile is stored in docker/ folder in project root. 

Developed on Docker version 27.5.1.

---

### 🚀 Getting Started

Clone project:

```
git clone git@github.com:siva01c/elibrary.git --branch=docker
```

**Create the `.env` file**:

```
cd elibrary/ && cp app/.env.default app/.env
```

#### Start the Project

#### Build docker images
```
docker compose build
```

#### Run containers
```
docker compose up -d 
```


---

### 👤 Create a New Administrator User

1. **Enter the container shell as root **:

   ```
   docker compose exec --user root php sh
   ```

2. **Navigate to the app folder**:

   ```
   cd app
   ```

3. **Install dependencies** (if not already installed):

   ```
   composer install
   ```

4. **Prepare migration**:

   ```
   bin/console doctrine:migrations:diff
   ```

   This command will create a migration object in the `app/migrations` folder.

5. **Create the database schema**:

   ```
   bin/console doctrine:migrations:migrate
   ```

   This will create database tables according to the migration object created in the previous step.

6. **Create an admin user**:

   ```
   bin/console app:create-user test@test.test ROLE_ADMIN password
   ```

   * Replace `test@test.test` with the desired email address.
   * `ROLE_ADMIN` is the user role.
   * `"password"` is the user password.

Now you can log in and add, edit, delete, or import new books from JSON.

---

### 🧱 Compile SASS and JS

This project uses **Compass** to build SASS.
CSS and JS can be built by running the script **build.sh** in the `app` folder. Run it as user 1000:1000, doesn't work for www-data user (don't run from docker)

```
/app$ ./build.sh 
```

---

### 🛑 Stop the Project

```bash
docker compose stop
```

