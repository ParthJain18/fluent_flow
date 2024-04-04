import pandas as pd
import json
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from nltk.stem import PorterStemmer
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from joblib import dump


with open('model_training/augmented_dataset.json', 'r') as f:
    data = json.load(f)

rows = []
for item in data:
    tag = item['tag']
    for sentence in item['examples']:
        rows.append({'tag': tag, 'text': sentence})

df = pd.DataFrame(rows)

stemmer = PorterStemmer()

def preprocess_text(text):
    words = word_tokenize(text)
    
    words = [word for word in words if word not in stopwords.words('english')]
    
    words = [stemmer.stem(word) for word in words]
    
    return ' '.join(words)

df['text'] = df['text'].apply(preprocess_text)

vectorizer = TfidfVectorizer()
X = vectorizer.fit_transform(df['text'])

X_train, X_test, y_train, y_test = train_test_split(X, df['tag'], test_size=0.0001, random_state=42)

model = LogisticRegression()
model.fit(X_train, y_train)

sample = "Hello, how is it going"
sample = vectorizer.transform([sample])
prediction = model.predict(sample)

# print(prediction)

dump(model, 'model_training/model.joblib') 