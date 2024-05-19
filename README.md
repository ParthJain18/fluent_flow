# Fluent Flow

A language translation app built using Flutter and Python backend. 

It translates live conversations from one language to another, then uses the history of the conversation and a logistic regression model to determine whether the current conversation needs any reply suggestions or not (Basically, we check if a LLM can be used to generate a reply suggestion or not, because if the conversation is personal, there is no need to generate any suggestions). If the conversation needs a generated reply, Google's Gemini API is used to generate possible reply suggestions. 

The user can also generate a summary for the conversation if needed, and the app can be used to translate written text using the camera.

## Screenshots
|Suggestions Example|Translation Example|
|---|---|
| ![WhatsApp Image 2024-04-04 at 23 44 28_7158d8e1](https://github.com/ParthJain18/fluent_flow/assets/95374592/2bff2932-ec70-4928-bb42-afaf83698069) | ![WhatsApp Image 2024-04-04 at 23 46 53_f1590e79](https://github.com/ParthJain18/fluent_flow/assets/95374592/cbe5869c-9691-4747-96d6-f5312bc03d86) |
|Summary Example|Camera Example|
| ![WhatsApp Image 2024-04-04 at 23 46 03_1f69797a](https://github.com/ParthJain18/fluent_flow/assets/95374592/e12cbc69-32a6-4e5a-a818-57254e6b91b6) | ![WhatsApp Image 2024-05-06 at 11 08 37_2264cdc5](https://github.com/ParthJain18/fluent_flow/assets/95374592/1f324690-1e6c-4345-bfa4-3a39991afe78) |
| ![WhatsApp Image 2024-05-06 at 11 08 37_6bbe35da](https://github.com/ParthJain18/fluent_flow/assets/95374592/349438fd-4d26-4967-8f37-34409a57161f)|




## Flowchart
![image](https://github.com/ParthJain18/fluent_flow/assets/95374592/3c83d68b-b25b-448e-9a18-942ee6a68e2a)

