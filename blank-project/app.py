from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

import json
import math

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///pokedex.db'

db = SQLAlchemy(app)

class Typelookup(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(), nullable=False)

    def __repr__(self):
        return f"Post('{self.id}', '{self.title}')"

class Pokemon(db.Model):
    id = db.Column(db.Integer, unique=True, primary_key=True)
    name = db.Column(db.String(30), nullable=False)
    description = db.Column(db.String(120), nullable=False)
    image_url = db.Column(db.String(), nullable=False)
    type_id = db.Column(db.Integer, db.ForeignKey('typelookup.id'), nullable=False)

    def __repr__(self):
        return f"Pokemon('{self.name}', '{self.description}', '{self.type_id}')"

@app.route('/', methods=['GET', 'POST'])
# default rendering for index
def index():
    page = 1 if not request.args.get('page') else int(request.args.get('page'))
    limit = 5
    default = "you've seen absolutely no pokemon. you really suck at this..."

    # sql = text("""
    #   TODO: get all pokemon types
    # """)
    # result = db.engine.execute(sql)
    # pokemon_types = result.fetchall()
    # type_lookup = dict(pokemon_types)
    # result.close()
    pokemon_types = []
    type_lookup = {}

    # sql = text("""
    #   TODO: get total number of pokemon
    # """)
    # result = db.engine.execute(sql)
    # total = result.fetchall()[0][0]
    # result.close()
    total = 0

    # if request.method == 'GET':
    #     sql = text("""
    #           TODO: get all pokemon; include pagination
    #     """)
    #
    #     result = db.engine.execute(sql)
    #     pokemon = result.fetchall()
    #     result.close()
    # else:
    #     description = request.form['s-pokemon-description'] if len(request.form['s-pokemon-description']) > 0 else None
    #     sql = text("""
    #           TODO: get all pokemon after a search; include pagination
    #     """)
    #     result = db.engine.execute(sql)
    #     pokemon = result.fetchall()
    #     result.close()
    #     default = 'your search turned up no results...'
    pokemon = []

    total_pages = math.ceil(total / limit)

    if len(pokemon) > 0:
        return render_template(
            'index.html', 
            pokemon=pokemon, 
            pokemon_types=pokemon_types, 
            type_lookup=type_lookup,
            page=page,
            total=total,
            total_pages=total_pages,
            default=default)
    else:
        return render_template(
            'index.html', 
            pokemon=None, 
            pokemon_types=pokemon_types, 
            type_lookup=type_lookup,
            page=page,
            total=total,
            total_pages=total_pages,
            default=default)

@app.route('/add', methods=['POST'])
# add a new pokemon to the pokedex
def add_pokemon():
    # sql = text("""
    #       TODO: add a new pokemon to the pokedex
    # """)
    # result = db.engine.execute(sql)
    # result.close()

    return redirect(url_for('index'))

@app.route('/pokemon')
# get a pokemon from the pokedex by id
def get_pokemon():
    pokemon_id = request.args.get('id')
    # sql = text("""
    #       TODO: get the page of the selected pokemon
    # """)
    # result = db.engine.execute(sql)
    # pokemon = result.fetchall()[0]
    # result.close()
    pokemon = []

    return render_template('pokemon.html',
        pokemon_name=pokemon[0],
        pokemon_description=pokemon[1],
        pokemon_image=pokemon[2],
        pokemon_type=pokemon[3].upper())

if __name__ == '__main__':
    app.run(debug=True)