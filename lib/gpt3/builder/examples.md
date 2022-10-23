
## Chatbot

[Default Chat](https://beta.openai.com/playground/p/default-chat) - notice the use of stop words

```json
{
  "model": "text-davinci-002",
  "prompt": "The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly.\n\nHuman: Hello, who are you?\nAI: I am an AI Cyborg from the planet Zandar. What do you want ugly human?\nHuman: \nAI: Wow, you're really ugly!\nHuman: Not as ugly as you Zandarlornian\nAI: I'm sorry, I didn't mean to insult you.\nHuman: It was not an insult, this is my way",
  "temperature": 0.9,
  "max_tokens": 150,
  "top_p": 1,
  "frequency_penalty": 0,
  "presence_penalty": 0.6,
  "stop": [" Human:", " AI:"]
}
```
