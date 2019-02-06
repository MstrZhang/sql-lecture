from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

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

@app.route('/')
def index():
    sql = text("""
        SELECT * FROM pokemon
        ORDER BY id ASC
    """)
    result = db.engine.execute(sql)
    pokemon = result.fetchall()
    result.close()

    sql = text("""
        SELECT * FROM typelookup
    """)
    result = db.engine.execute(sql)
    pokemon_types = result.fetchall()
    type_lookup = dict(pokemon_types)
    result.close()

    if len(pokemon) > 0:
        return render_template('index.html', pokemon=pokemon, pokemon_types=pokemon_types, type_lookup=type_lookup)
    else:
        return render_template('index.html', pokemon=None, pokemon_types=pokemon_types, type_lookup=type_lookup)

@app.route('/add', methods=['POST'])
def add_pokemon():
    sql = text("""
        INSERT INTO pokemon (name, description, image_url, type_id)
        VALUES (:name, :description, :image_url, :type_id)
    """).bindparams(
        name=request.form['pokemon-name'],
        description=request.form['pokemon-description'],
        image_url=request.form['pokemon-image'],
        type_id=request.form['pokemon-type']
    )
    result = db.engine.execute(sql)
    result.close()

    return redirect(url_for('index'))

@app.route('/pokemon')
def get_pokemon():
    pokemon_id = request.args.get('id')
    sql = text("""
        SELECT name, description, image_url, title 
        FROM pokemon
        INNER JOIN typelookup
        ON typelookup.id = pokemon.type_id
        WHERE pokemon.id = :id
    """).bindparams(
        id=pokemon_id
    )
    result = db.engine.execute(sql)
    pokemon = result.fetchall()[0]
    result.close()

    print(pokemon)

    return render_template('pokemon.html',
        pokemon_name=pokemon[0],
        pokemon_description=pokemon[1],
        pokemon_image=pokemon[2],
        pokemon_type=pokemon[3].upper())

if __name__ == '__main__':
    app.run(debug=True)