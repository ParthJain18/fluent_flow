import nlpaug.augmenter.word as naw
import json

# Load your data
with open('model_training/dataset.json', 'r') as f:
    data = json.load(f)

# Initialize a synonym augmenter
aug = naw.SynonymAug(aug_src='wordnet')

# Augment each sentence in your data
for item in data:
    original_sentences = item['examples']
    augmented_sentences = []
    for sentence in original_sentences:
        augmented_sentences.append(aug.augment(sentence))
    item['examples'].extend(augmented_sentences)

# Save your augmented data
with open('model_training/augmented_dataset.json', 'w') as f:
    json.dump(data, f)