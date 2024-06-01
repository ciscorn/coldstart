async def app(scope, receive, send):
    assert scope["type"] == "http"

    response_body = b"hello, Uvicorn!"

    await send(
        {
            "type": "http.response.start",
            "status": 200,
            "headers": [
                (b"content-type", b"text/plain"),
            ],
        }
    )

    await send(
        {
            "type": "http.response.body",
            "body": response_body,
        }
    )
