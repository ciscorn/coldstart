def app(environ, start_response):
    response_body = b"hello, Gunicorn!"
    status = "200 OK"
    response_headers = [("Content-Type", "text/plain")]

    start_response(status, response_headers)

    return [response_body]
