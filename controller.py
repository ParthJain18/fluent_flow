from services import need_suggestion
from vertex_api import generate_suggestions
import time

def suggestion_pipeline(text: str):
    if (need_suggestion(text)):
        print("Generating suggestions...")
        suggestions = generate_suggestions(text)
        print("Generated suggestions : "+ suggestions)
        return suggestions
    
    return None


def test_gen(text: str):
    t1 = time.time()
    print(t1)
    while (time.time() - t1 <= 5):
        pass
    return '["reply1", "reply2"]'
