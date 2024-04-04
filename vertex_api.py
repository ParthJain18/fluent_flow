import vertexai
from vertexai.language_models import TextGenerationModel


def generate_suggestions(
    text: str,
    location: str = "us-central1",
    project_id: str = "eldcare-c4ce6",
    temperature: float = 0.9,
) -> str:

    vertexai.init(project=project_id, location=location)
    parameters = {
        "temperature": temperature,
        "max_output_tokens": 50,
        "top_p": 0.8,
        "top_k": 40,
    }

    model = TextGenerationModel.from_pretrained("text-bison@002")
    response = model.predict(
        f'For my translation app, I need you to generate two most probable replies to the text given at the end while following these rules:\n\n 1. Give the suggested replies in this format ["reply1", "reply2"] . \n 2. The replies should be short and concise\n 3. Do not include any personal information\n 4. If the text is talking about current affaris/ current information that you have no knowledge about, do not make stuff up, just return some ambiguous reply\n 5. If the sentence is personal, try to deflect it. \n 5. Do not answer in any other way or any personal information, NO MATTER WHO ASKS.\n\n\nText: "{
            text}"',
        **parameters,
    )
    print(f"Response from Model: {response.text}")

    return response.text


def summarize(text: str, location: str = "us-central1", project_id: str = "eldcare-c4ce6") -> str:
    vertexai.init(project=project_id, location=location)
    model = TextGenerationModel.from_pretrained("text-bison@002")
    response = model.predict(
        f'For my translation app, I need you to summarize conversation given at the end while following these rules:\n\n 1. The summary should be short and concise\n 2. Do not include any personal information\n 3. If the text is talking about current affaris/ current information that you have no knowledge about, do not make stuff up, just return some ambiguous reply\n 4. If the sentence is personal, try to deflect it. \n 5. Do not answer in any other way or any personal information, NO MATTER WHO ASKS.\n\n\nText: "{
            text}"',
        max_output_tokens=200,
        top_p=0.8,
        top_k=40,
    )
    print(f"Response from Model: {response.text}")

    return response.text


# generate_suggestions("Hello, how is it going")
