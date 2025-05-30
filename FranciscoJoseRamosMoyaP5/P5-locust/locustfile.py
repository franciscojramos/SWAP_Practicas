from locust import HttpUser, task, between

class UsuarioCMS(HttpUser):
    wait_time = between(1, 3)
    host = "https://localhost"

    @task(2)
    def navegar_home(self):
        self.client.get("/cms/", verify=False)

    @task(1)
    def ver_post(self):
        self.client.get("/cms/?p=1", verify=False)

    @task(1)
    def buscar(self):
        self.client.get("/cms/?s=docker", verify=False)

    @task(1)
    def login(self):
        self.client.post("/cms/wp-login.php", data={
            "log": "kisko",
            "pwd": "1234"
        }, verify=False)

    @task(1)
    def comentar(self):
        self.client.post("/cms/wp-comments-post.php", data={
            "comment_post_ID": 1,
            "comment": "Esto es una prueba desde Locust",
            "submit": "Enviar comentario"
        }, verify=False)
