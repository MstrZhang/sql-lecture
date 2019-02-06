# MTA-UTSC SQL Lecture

## Overview

The following is a lecture I did for MTA-UTSC. The lecture is intended to be viewed by participants who have absolutely no knowledge in SQL
and requires very little to pick up and learn. The only dependencies needed for the lecture were [SQLite](https://sqlitebrowser.org/) and 
[Python](https://www.python.org/downloads/release/python-370/) (only for Flask to run the backend)

If you're interested in using my slides for your own use, please feel free although be sure to credit me when you do so

---

## Project Details

The **secret-project** is a stripped down version of the Pokédex from the Pokémon franchise. It requires [Flask](http://flask.pocoo.org/) and
[SQLAlchemy](https://www.sqlalchemy.org/) to run. The project is essentially a fully completed web application with all of the SQL queries
removed as an exercise. The full code is also available to look at and explore. An experienced student with some web development experience
can extend the project to implement more functionality

A lot of the inherent power of SQLAlchemy (namely things like the Class/Model structure) are being overlooked in order to get the workshop
participants to see how the embedded SQL work. I would not recommend using these resources as an example of making a Flask web application as
there are much better implementation strategies than this

### Installation

1. Install Python
2. Install Flask: `pip install flask`
3. Install SQLAlchemy: `pip install flask-sqlalchemy`
4. Serve the app: `python3 app.py`
    - The app opens on `localhost:5000`

---

## Course Recommendations

If you are a student at UTSC and would like to learn more about SQL or web design, I suggest taking the following courses:

- **CSCC43**: Introduction to Databases
- **CSCC09**: Programming on the Web

You have to be in either the computer science department or have a 3.0 cGPA however these courses are a wealth of information and can teach you
much more than you can absorb in a two-hour workshop

---

## Credits

- Sample database from the [Chinook database project](https://github.com/lerocha/chinook-database)
- General app structure from the [Flaskr tutorial](http://flask.pocoo.org/docs/1.0/tutorial/)
- Some HTML and CSS layouts and style snippets from [Thierry Sans](https://github.com/ThierrySans/CSCC09)
- SQL information from CSCC43 notes by Marzieh Ahmadzadeh
- This entire project would not exist without [StackOverflow](https://stackoverflow.com)