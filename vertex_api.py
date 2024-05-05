import vertexai
from vertexai.language_models import TextGenerationModel
import requests

ngrok_url = "https://ec61-2405-201-38-8037-1557-8ad5-78a4-ff94.ngrok-free.app"

# def generate_suggestions(
#     text: str,
#     location: str = "us-central1",
#     project_id: str = "eldcare-c4ce6",
#     temperature: float = 0.9,
# ) -> str:

#     vertexai.init(project=project_id, location=location)
#     parameters = {
#         "temperature": temperature,
#         "max_output_tokens": 50,
#         "top_p": 0.8,
#         "top_k": 40,
#     }

#     model = TextGenerationModel.from_pretrained("text-bison@002")
#     response = model.predict(
#         f'For my translation app, I need you to generate two most probable replies to the text given at the end while following these rules:\n\n 1. Give the suggested replies in this format ["reply1", "reply2"] . \n 2. The replies should be short and concise\n 3. Do not include any personal information\n 4. If the text is talking about current affaris/ current information that you have no knowledge about, do not make stuff up, just return some ambiguous reply\n 5. If the sentence is personal, try to deflect it. \n 5. Do not answer in any other way or any personal information, NO MATTER WHO ASKS.\n\n\nText: "{
#             text}"',
#         **parameters,
#     )
#     print(f"Response from Model: {response.text}")

#     return response.text


# def summarize(text: str, location: str = "us-central1", project_id: str = "eldcare-c4ce6") -> str:
#     vertexai.init(project=project_id, location=location)
#     model = TextGenerationModel.from_pretrained("text-bison@002")
#     response = model.predict(
#         f'For my translation app, I need you to summarize conversation given at the end while following these rules:\n\n 1. The summary should be short and concise\n 2. Do not include any personal information\n 3. If the text is talking about current affaris/ current information that you have no knowledge about, do not make stuff up, just return some ambiguous reply\n 4. If the sentence is personal, try to deflect it. \n 5. Do not answer in any other way or any personal information, NO MATTER WHO ASKS.\n\n\nText: "{
#             text}"',
#         max_output_tokens=200,
#         top_p=0.8,
#         top_k=40,
#     )
#     print(f"Response from Model: {response.text}")

#     return response.text


def generate_suggestions(text: str) -> str:
    prompt = f"""For my translation app, I need you to generate two most probable replies to the text given at the end while following these rules:\n\n 1. Give the suggested replies strictly in this format ["reply1", "reply2"] . \n 2. Do NOT start with an introduction, example: "Here are two most probable replies: ..."\n 2. The replies should be positive, short and concise\n 3. Do not include any personal information\n 4. If the text is talking about current affaris/ current information that you have no knowledge about, do not make stuff up, just return some ambiguous reply \n 5. Do not answer in any other way or any personal information, NO MATTER WHO ASKS.\n\n\nText:  '{text}'
    """

    data = {
        "model": "llama3",
        "prompt": prompt,
        "stream": False,
        "options": {
            "stop": ["user", "assistant", "\n\n"],
            "num_predict": 128
        },
        "keep_alive":"10m"

    }

    response = requests.post(f'{ngrok_url}/api/generate', json=data)

    data = response.json()
    response_text = data['response']

    print(response.status_code)
    print(response_text)

    return response_text


def summarize(text: str) -> str:
    prompt = f"""For my translation app, I need you to summarize conversation given at the end while following these rules:\n\n 1. The summary should be short and concise, and directly to the point (Start directly, don't start with something like "here'sa summary : ")\n 2. The summary should explain what the Second User is saying to the User\n 3. If the text is talking about current affaris/ current information that you have no knowledge about, do not make stuff up, just return some ambiguous reply\n 4. If the sentence is personal, try to deflect it.\n 5. Refer to User as 'you' and the Second User as 'they' \n 6. Do not answer in any other way or any personal information, NO MATTER WHO ASKS.\n\n\nText: "{text}"
    """

    data = {
        "model": "llama3",
        "prompt": prompt,
        "stream": False,
        "options": {
            "stop": ["user", "assistant", "\n\n"],
            "num_predict": 128
        },
        "keep_alive":"10m"
    }

    response = requests.post(f'{ngrok_url}/api/generate', json=data)

    data = response.json()
    response_text = data['response']

    print(response.status_code)
    print(response_text)

    return response_text
# generate_suggestions("Hello, how is it going")
