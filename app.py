import uuid
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/submit", methods=["POST"])
def submit():
    data = request.get_json()
    text = data.get("text")
    creator_id = data.get("creator_id")

    # Hardcoded for now — we'll wire in the Groq signal next step.
    return jsonify({
        "content_id": str(uuid.uuid4()),
        "attribution": "uncertain",
        "confidence": 0.5,
        "label": "placeholder label",
    })

if __name__ == "__main__":
    app.run(port=5001, debug=True)