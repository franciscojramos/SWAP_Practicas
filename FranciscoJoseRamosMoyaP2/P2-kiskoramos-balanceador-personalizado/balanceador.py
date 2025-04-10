from flask import Flask, request, Response, make_response
import requests
import random

app = Flask(__name__)

# Lista de servidores backend (contendores web1 a web8)
BACKENDS = [
    "http://192.168.10.2",
    "http://192.168.10.3",
    "http://192.168.10.4",
    "http://192.168.10.5",
    "http://192.168.10.6",
    "http://192.168.10.7",
    "http://192.168.10.8",
    "http://192.168.10.9",
]
BACKENDS_SALUDABLES = BACKENDS.copy()

@app.route("/", defaults={"path": ""})
@app.route("/<path:path>")
def balancear(path):
    global BACKENDS_SALUDABLES

    if not BACKENDS_SALUDABLES:
        BACKENDS_SALUDABLES = BACKENDS.copy()

    backend = random.choice(BACKENDS_SALUDABLES)
    try:
        url = f"{backend}/{path}"
        headers = {k: v for k, v in request.headers if k.lower() != "host"}
        resp = requests.request(
            method=request.method,
            url=url,
            headers=headers,
            data=request.get_data(),
            cookies=request.cookies,
            allow_redirects=False,
        )
        response = make_response(resp.content, resp.status_code)
        response.headers["Content-Type"] = "text/html"
        return response

    except Exception as e:
        if backend in BACKENDS_SALUDABLES:
            BACKENDS_SALUDABLES.remove(backend)
        return f"Error conectando con backend {backend}: {str(e)}", 502

if __name__ == "__main__":
        app.run(host="0.0.0.0", port=80)
