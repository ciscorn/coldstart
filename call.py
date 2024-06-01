import asyncio
import json
import time
from datetime import datetime, timezone

import httpx

UTC = timezone.utc

with open("urls.json") as f:
    URLS = json.load(f)
    CLOUD_RUN = URLS["CLOUD_RUN"]
    LAMBDA = URLS["LAMBDA"]


async def get(client: httpx.AsyncClient, url: str) -> float:
    t = time.time()
    await client.get(url)
    return time.time() - t


async def parallel_request(client: httpx.AsyncClient, url: str, num: int):
    tasks = [asyncio.ensure_future(get(client, url)) for _ in range(num)]
    res, _ = await asyncio.wait(tasks)
    return [result.result() for result in res]


async def main():
    client = httpx.AsyncClient()

    with open("result.jsonl", "a+") as f:
        for name, url in CLOUD_RUN.items():
            concurrency = 10
            res = await parallel_request(client, url, concurrency)
            f.write(
                json.dumps(
                    {
                        "service": "cloud_run",
                        "lang": name,
                        "datetime": datetime.now(tz=UTC).isoformat(),
                        "latencies": res,
                    },
                )
            )
            f.write("\n")

        for name, url in LAMBDA.items():
            concurrency = 10
            res = await parallel_request(client, url, concurrency)
            f.write(
                json.dumps(
                    {
                        "service": "lambda",
                        "lang": name,
                        "datetime": datetime.now(tz=UTC).isoformat(),
                        "latencies": res,
                    },
                )
            )
            f.write("\n")


if __name__ == "__main__":
    asyncio.run(main())
