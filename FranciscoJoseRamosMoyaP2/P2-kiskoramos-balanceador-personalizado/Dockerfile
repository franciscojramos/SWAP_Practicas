FROM python:3.11-slim

WORKDIR /app

COPY balanceador.py .

RUN pip install flask requests

EXPOSE 80

CMD ["python", "balanceador.py"]
