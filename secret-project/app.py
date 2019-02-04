from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///pokedex.db'
type_lookup = {
    1: 'NORMAL',
    2: 'FIGHTING',
    3: 'FLYING',
    4: 'POISON',
    5: 'GROUND',
    6: 'ROCK',
    7: 'BUG',
    8: 'GHOST',
    9: 'STEEL',
    10: 'FIRE',
    11: 'WATER',
    12: 'GRASS',
    13: 'ELECTRIC',
    14: 'PSYCHIC',
    15: 'ICE',
    16: 'DRAGON',
    17: 'DARK',
    18: 'FAIRY'
}

db = SQLAlchemy(app)

class Typelookup(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(), nullable=False)

    def __repr__(self):
        return f"Post('{self.id}', '{self.title}')"

class Pokemon(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(30), unique=True, nullable=False)
    description = db.Column(db.String(120), unique=True, nullable=False)
    image_url = db.Column(db.String(), nullable=False)
    type_id = db.Column(db.Integer, db.ForeignKey('typelookup.id'), nullable=False)

    def __repr__(self):
        return f"Pokemon('{self.name}', '{self.description}', '{self.type_id}')"

@app.route('/')
def index():
    sql = text("""
        SELECT * FROM pokemon
        ORDER BY id DESC
        LIMIT 1
    """)
    result = db.engine.execute(sql)
    pokemon = list(result)[0]
    result.close()

    sql = text("""
        SELECT * FROM typelookup
    """)
    result = db.engine.execute(sql)
    pokemon_types = list(result)
    result.close()

    return render_template(
        'index.html',
        pokemon_name=pokemon[1],
        pokemon_description=pokemon[2],
        pokemon_image=pokemon[3],
        pokemon_type=type_lookup[pokemon[4]],
        typelookup=pokemon_types)

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

if __name__ == '__main__':
    app.run(debug=True)