from services import need_suggestion
from vertex_api import generate_suggestions

def suggestion_pipeline(text: str):
    if (need_suggestion(text)):
        suggestions = generate_suggestions(text)
        return suggestions
    
    return None



