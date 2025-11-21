# Grant Scraper MVP

CS 665 Project 1 - Grant Discovery SaaS.

## Features
* **User Auth:** Login/Logout functionality.
* **Database:** PostgreSQL hosted on Neon.tech.
* **CRUD:** Save and remove grants from a personal list.
* **Viz:** Real-time charts using Chart.js.

## Setup
1. Create a `.env` file with `DATABASE_URL`.
2. Run `pip install flask flask-sqlalchemy flask-login psycopg2-binary python-dotenv`.
3. Start server: `flask run`.