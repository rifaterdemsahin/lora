# 🧠 LoRA Lab

An educational site that explains how **LoRA** adapters work on **open-weight** large language models, how that differs from **closed weights**, and how to recalibrate a model's refusals safely. Every concept uses **Tell → Show → Do → Apply**.

## 🗺️ What's inside

| Emoji | Page | What it teaches |
|---|---|---|
| 🏛️ | `site/index.html` | Architecture: the layers of behaviour and one LoRA update, plus a parameter calculator |
| 📚 | `site/concepts.html` | LLM, closed weights, open weights, LoRA from first principles |
| 🛠️ | `site/sop.html` | 8-step standard operating procedure, goal to monitoring |
| 🔀 | `site/alternatives.html` | Prompting, RAG, vendor tuning, QLoRA, DPO, full fine-tune, representation editing |
| ⚖️ | `site/responsible.html` | What "uncensored" honestly means, and the limits that stay |
| 🤖 | `BOT_SPEC.md` | Delivery Pilot Google Chat bot specification |

## 🎓 The teaching pattern

- 🗣️ **Tell**: say the idea plainly
- 👀 **Show**: a diagram, table or snippet
- ✋ **Do**: a small hands-on exercise
- 🚀 **Apply**: use it on a real decision

## 🧩 Core ideas in one line each

- 🔢 **LLM**: a function from tokens to next-token probabilities
- 🔒 **Closed weights**: you rent behaviour through an API
- 🔓 **Open weights**: you hold the numbers, so you can change the behaviour
- 🪶 **LoRA**: freeze `W`, learn a tiny update `B·A`; `y = Wx + (α/r)·BAx`
- 🛡️ **"Uncensored"**: recalibrated refusals with limits you chose, tested and guarded, not "no limits"

## ☁️ Deploy

Static site served by nginx on [Fly.io](https://fly.io). The Fly token is read from Azure Key Vault at deploy time and is never stored in the repo. 🔐

```bash
az login
AZ_KEYVAULT_NAME=dp-kv-deliverypilot ./deploy.sh   # secret defaults to FLY-API-TOKEN
```

Files: `Dockerfile` 🐳 · `nginx.conf` ⚙️ · `fly.toml` 🪁 · `deploy.sh` 🚢

> ⚠️ The sandbox this was built in blocks `api.depot.dev`, so run the deploy from a machine that can reach Fly's builder.

## 📖 References

### 🔬 Papers
- 🪶 LoRA: Hu et al., *LoRA: Low-Rank Adaptation of Large Language Models*, https://arxiv.org/abs/2106.09685
- 🗜️ QLoRA: Dettmers et al., *QLoRA: Efficient Finetuning of Quantized LLMs*, https://arxiv.org/abs/2305.14314
- ⚖️ DPO: Rafailov et al., *Direct Preference Optimization*, https://arxiv.org/abs/2305.18290
- 🧭 Refusal direction: Arditi et al., *Refusal in Language Models Is Mediated by a Single Direction*, https://arxiv.org/abs/2406.11717
- 🏗️ Transformer: Vaswani et al., *Attention Is All You Need*, https://arxiv.org/abs/1706.03762
- 🎓 InstructGPT / RLHF: Ouyang et al., *Training language models to follow instructions with human feedback*, https://arxiv.org/abs/2203.02155

### 🧰 Libraries and docs
- 🤗 Hugging Face PEFT: https://huggingface.co/docs/peft
- 🤗 Hugging Face TRL: https://huggingface.co/docs/trl
- 🤗 Transformers: https://huggingface.co/docs/transformers
- ⚡ vLLM LoRA serving: https://docs.vllm.ai/en/latest/features/lora.html
- 🔢 bitsandbytes: https://github.com/bitsandbytes-foundation/bitsandbytes

### 🚢 Platform
- 🪁 Fly.io docs: https://fly.io/docs/
- 🔐 Azure Key Vault CLI: https://learn.microsoft.com/azure/key-vault/secrets/quick-create-cli
- 💬 Google Chat API: https://developers.google.com/workspace/chat

## 🔐 Security notes

- 🚫 No secrets in the repo; all come from Key Vault (`dp-kv-deliverypilot`)
- 👤 Least privilege: read only the named secrets
- 🧾 Rotate any token that is ever exposed
