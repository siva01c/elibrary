# Simple Symfony Library

This project is a simple book library. Books can be imported from `datasources/books.json`. Books stored in the database can be exported and saved. Only an admin can perform import/export operations. The project includes only basic administration and supports a single role: `ROLE_ADMIN`.

---

## Local Development with DDEV

This project uses the **DDEV** environment: an open-source tool that simplifies setting up and managing local web development environments for PHP, Node.js, and more.

The project can also run in any PHP environment that supports PHP 8.3 and Composer.**

📚 **Documentation**: [DDEV Installation Guide](https://ddev.readthedocs.io/en/stable/users/install/ddev-installation/)

---

### 🚀 Getting Started

Clone project: 
```
git clone git@github.com:siva01c/elibrary.git
```

**Create the `.env` file**:

```bash
cd elibrary/ && cp app/.env.default app/.env
```

#### Start the Project

```bash
ddev start && ddev describe
```

Example output of `ddev describe`:

┌───────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Project: elibrary ~/projects/elibrary https://elibrary.ddev.site                                              │
│ Docker platform: linux-docker                                                                                 │
│ Router: traefik                                                                                               │
├──────────────┬──────┬─────────────────────────────────────────────────────────────────┬───────────────────────┤
│ SERVICE      │ STAT │ URL/PORT                                                        │ INFO                  │
├──────────────┼──────┼─────────────────────────────────────────────────────────────────┼───────────────────────┤
│ web          │ OK   │ https://elibrary.ddev.site                                      │ php PHP 8.3           │
│              │      │ InDocker -> Host:                                               │ Server: nginx-fpm     │
│              │      │  - web:80 -> 127.0.0.1:32868                                    │ Docroot: 'app/public' │
│              │      │  - web:443 -> 127.0.0.1:32869                                   │ Perf mode: none       │
│              │      │  - web:8025 -> 127.0.0.1:32870                                  │ Node.js: 22           │
├──────────────┼──────┼─────────────────────────────────────────────────────────────────┼───────────────────────┤
│ db           │ OK   │ InDocker -> Host:                                               │ mariadb:10.11         │
│              │      │  - db:3306 -> 127.0.0.1:32871                                   │ User/Pass: 'db/db'    │
│              │      │                                                                 │ or 'root/root'        │
├──────────────┼──────┼─────────────────────────────────────────────────────────────────┼───────────────────────┤
│ adminer      │ OK   │ InDocker -> Host:                                               │                       │
│              │      │  - adminer:8080 -> 127.0.0.1:8080                               │                       │
├──────────────┼──────┼─────────────────────────────────────────────────────────────────┼───────────────────────┤
│ Mailpit      │      │ Mailpit: https://elibrary.ddev.site:8026                        │                       │
│              │      │ Launch: ddev mailpit                                            │                       │
├──────────────┼──────┼─────────────────────────────────────────────────────────────────┼───────────────────────┤
│ Project URLs │      │ https://elibrary.ddev.site, https://127.0.0.1:32869,            │                       │
│              │      │ http://elibrary.ddev.site, http://127.0.0.1:32868               │                       │
└──────────────┴──────┴─────────────────────────────────────────────────────────────────┴───────────────────────┘


By default, the website should be accessible at:
👉 [https://elibrary.ddev.site/](https://elibrary.ddev.site/)
(*This assumes the project folder name hasn't been changed.*)

The DDEV project includes **MariaDB** (available at `127.0.0.1:32826`) and **Adminer** (accessible at [http://127.0.0.1:8080/](http://127.0.0.1:8080/)).
The database username and password are both `"db"`.

---

### 👤 Create a New Administrator User

1. **Enter the container shell**:

   ```
   ddev ssh
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

### Compile SASS and JS

This project uses **Compass** to build SASS.
CSS and JS can be built by running the script **build.sh** in the `app` folder:

```
./build.sh
```

---

### Stop the Project

```
ddev stop
```

