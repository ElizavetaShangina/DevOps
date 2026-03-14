# fix 1: Легковесный образ и определенная версия
FROM python:3.10-slim

# fix 2: Заданная рабочая директория
WORKDIR /app

# fix 3: Объединение RUN-команды и чистка мусора
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    rm -rf /var/lib/apt/lists/*

# fix 4: Вместо хранения секретных данных -  пустая переменная
ENV API_KEY=""

# fix 6: Сначала копируется только requirements.txt, чтобы закэшировать установку библиотек
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# fix 5: Использование COPY для переноса остального кода
COPY . .

# fix 7: Создание обычного пользователя и отдаем ему права на папку
RUN useradd -m justuser && chown -R justuser /app
USER justuser

CMD ["python", "app.py"]