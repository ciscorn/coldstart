# import matplotlib.pyplot as plt

import json

import pandas as pd
import seaborn as sns
from matplotlib import pyplot as plt

LANG_MAP = {
    "go": "Go",
    "rust": "Rust",
    "uvicorn": "Py Uvicorn",
    "gunicorn": "Py Gunicorn",
    "bun": "Bun",
}

SERVICE_MAP = {
    "cloud_run": "Cloud Run",
    "lambda": "AWS Lambda",
}


services = []
langs = []
latencies = []

with open("result.jsonl", encoding="utf-8") as f:
    for line in f:
        if line := line.strip():
            data = json.loads(line)

            service = SERVICE_MAP[data["service"]]
            lang = LANG_MAP[data["lang"]]
            for latency in data["latencies"]:
                services.append(service)
                langs.append(lang)
                latencies.append(latency)


df = pd.DataFrame({"Service": services, "Latency": latencies, "Image": langs})


fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)

sns.violinplot(x="Image", y="Latency", hue="Service", data=df, dodge=True, ax=ax)

plt.grid()
plt.xlabel("")
plt.ylabel("Latency [sec]")
plt.tight_layout()
plt.show()

