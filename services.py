from joblib import load
from sklearn.feature_extraction.text import TfidfVectorizer
from model_training.training import vectorizer

# Load the model from a file
model = load('model_training/model.joblib')
# vectorizer = TfidfVectorizer()

def need_suggestion(text: str):
    sample = vectorizer.transform([text])
    prediction = model.predict(sample)
    if prediction == ['suggestion_yes']:
        return True
    return False



# need_suggestion("Hello, how is it going")