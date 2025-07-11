🏥 BC Student Wellness Management System






A full‑stack solution empowering Belgium Campus students to book wellness appointments, connect with counsellors, and share feedback — from any device, anywhere.

📑 Table of Contents

Overview

Tech Stack

Project Structure

Milestones & Mark Allocation

Features

Setup & Installation

Database Schema

Contributing

License

Overview

The BC Student Wellness Management System (BC‑SWMS) is an academic project (Programming 37(8)1 — Project 2025, 50 Marks) that assesses your ability to apply:

Core Java & Object‑Oriented Programming (OOP)

GUI development with Swing

Web development with JSP/Servlets

Database integration using JavaDB (Apache Derby) and PostgreSQL

Version control & collaboration via GitHub

Tech Stack

Layer

Technology

Why?

Front‑end (Web)

JSP & HTML 5 / CSS 3 / Bootstrap 5

Rapid server‑side rendering, responsive UI

Back‑end (Web)

Java Servlets (Jakarta EE 10)

Robust session & request handling

Desktop Client

Java Swing

Cross‑platform GUI, quick prototyping

Databases

PostgreSQL 16 (production) · JavaDB (Apache Derby) (embedded)

Reliable RDBMS · Lightweight local storage

Build Tool

Maven 3.9

Dependency management, multi‑module build

Version Control

Git & GitHub

Team collaboration, CI/CD hooks

Project Structure

bc-swms/
├─ web-app/                # Milestone 1 — JSP/Servlet module
│  ├─ src/main/java/
│  │  └─ edu/bc/swms/
│  │     ├─ controller/
│  │     │  ├─ LoginServlet.java
│  │     │  └─ RegisterServlet.java
│  │     └─ util/DBUtil.java
│  └─ src/main/webapp/
│     ├─ index.jsp
│     ├─ login.jsp
│     ├─ register.jsp
│     └─ dashboard.jsp
├─ desktop-app/            # Milestone 2 — Swing module
│  └─ src/main/java/
│     └─ edu/bc/swms/
│        ├─ model/
│        ├─ view/
│        └─ controller/
└─ docs/                   # UML, SQL scripts, presentation assets

Milestones & Mark Allocation

Milestone

Description

Due Date

Marks

1

Web Application — Login & Registration System

14‑07‑25

20

2

Desktop Application — Wellness Management System

17‑07‑25

30

Total





50

Features

🌐 Milestone 1 — Web Application

JSP Pages: index.jsp, register.jsp, login.jsp, dashboard.jsp

Servlets: RegisterServlet, LoginServlet

Registration Flow

Field validation (email format, password strength, phone pattern)

Duplicate check (username/email)

Secure storage (BCrypt‑hashed passwords)

Login Flow

Credential validation against PostgreSQL

Clear error messages on failure

Session management via HttpSession

Dashboard

Personalised greeting — “Welcome, 👋 [Student Name]”

One‑click logout (session invalidation)

Database Schema — users table with UNIQUE, NOT NULL constraints

💻 Milestone 2 — Desktop Application

Architecture: MVC, OOP (inheritance, polymorphism, encapsulation, abstraction)

GUI: Swing JTabbedPane or sidebar menu

Modules

Appointment Management

Book, view, update, cancel appointments

Counselor Management

CRUD counselors (name, specialisation, availability)

Feedback Management

Submit, edit, delete feedback (rating 1‑5, comments)

Persistence: JavaDB (Apache Derby) tables — appointments, counselors, feedback

Collections for in‑memory operations; robust exception handling

Setup & Installation

# 1 . Clone the repository
$ git clone https://github.com/<your‑org>/bc-swms.git
$ cd bc-swms

# 2 . Create PostgreSQL database & user
$ psql -U postgres -c "CREATE DATABASE bc_swms;"
$ psql -U postgres -d bc_swms -f docs/sql/postgres-schema.sql

# 3 . Build & run the web module (Milestone 1)
$ mvn -pl web-app clean package
$ mvn -pl web-app jetty:run
# Visit http://localhost:8080/bc-swms

# 4 . Run the desktop client (Milestone 2)
$ mvn -pl desktop-app exec:java

Note: Java 17+ is required. Use sdkman, homebrew, or your package manager of choice.

Database Schema

PostgreSQL — users table

CREATE TABLE users (
    student_number VARCHAR(20) PRIMARY KEY,
    name           VARCHAR(50) NOT NULL,
    surname        VARCHAR(50) NOT NULL,
    email          VARCHAR(100) UNIQUE NOT NULL,
    phone          VARCHAR(15) NOT NULL,
    password       VARCHAR(255) NOT NULL -- BCrypt hash
);

JavaDB (Derby) — Embedded

Scripts for appointments, counselors, and feedback tables live under docs/sql/derby/.

Contributing

Fork the repo & create your branch: git checkout -b feature/awesome

Commit your changes: git commit -m "feat: add awesome feature"

Push to the branch: git push origin feature/awesome

Open a Pull Request — cheers! 🍻

Please follow the Conventional Commits style and keep PRs focused.

License

Distributed under the MIT License. See LICENSE for details.

Made with ❤️ by the Belgium Campus Programming 37(8)1 Team — 2025.
