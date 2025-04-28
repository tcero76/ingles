from flask import Flask, jsonify, request
from nltk.corpus import wordnet as wn
import nltk

nltk.download('wordnet')

app = Flask(__name__)

@app.route('/word/<string:word>', methods=['GET'])
def get_word_info(word):
    synsets = wn.synsets(word)
    results = []
    for syn in synsets:
        results.append({
            'name': syn.name(),
            'part_of_speech': syn.pos(),
            'definition': syn.definition(),
            'examples': syn.examples(),
            'lemmas': [lemma.name() for lemma in syn.lemmas()],
            'antonyms': [ ant.name() for lemma in syn.lemmas() for ant in lemma.antonyms()],
        })

    return jsonify({
        'word': word,
        'meanings': results
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
