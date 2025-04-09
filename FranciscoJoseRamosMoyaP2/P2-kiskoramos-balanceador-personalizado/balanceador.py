from flask import Flask, request, Response
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


@app.route("/", defaults={"path": ""})
@app.route("/<path:path>")
def balancear(path):
    backend = random.choice(BACKENDS)
    try:
        url = f"{backend}/{path}"
        headers = {k: v for k, v in request.headers if k != 'Host'}
        resp = requests.request(
            method=request.method,
            url=url,
            headers=headers,
            data=request.get_data(),
            cookies=request.cookies,
            allow_redirects=False,
        )
        return Response(
            resp.content,
            status=resp.status_code,
            headers=dict(resp.headers),
            content_type=resp.headers.get("Content-Type", "text/html")
        )

    except Exception as e:
        return f"Error conectando con backend {backend}: {str(e)}", 502

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
