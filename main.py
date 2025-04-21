from fastapi import FastAPI, Request
from pydantic import BaseModel
from transformers import AutoTokenizer, AutoModelForCausalLM, TextGenerationPipeline
import torch

app = FastAPI()

class Prompt(BaseModel):
    prompt: str

tokenizer = AutoTokenizer.from_pretrained(
    "teknium/OpenHermes-2.5-Mistral-7B",
    trust_remote_code=True
)
model = AutoModelForCausalLM.from_pretrained(
    "teknium/OpenHermes-2.5-Mistral-7B",
    torch_dtype=torch.float16,
    device_map="auto",
    trust_remote_code=True
)
pipe = TextGenerationPipeline(model=model, tokenizer=tokenizer)

@app.post("/generate")
async def generate(prompt: Prompt):
    output = pipe(prompt.prompt, max_new_tokens=100, do_sample=True, temperature=0.7)[0]["generated_text"]
    return { "response": output }
