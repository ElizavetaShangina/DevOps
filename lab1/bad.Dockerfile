# 1. Использование тега latest и тяжелого базового ОС-образа
FROM ubuntu:latest

# 2. Отсутствие WORKDIR (работаем прямо в корневой файловой системе /)

# 3. Разделение update и install, а также отсутствие очистки кэша пакетов
RUN apt-get update
RUN apt-get install -y python3 python3-pip

# 4. Хардкод чувствительных данных в файле
ENV API_KEY="super_secret_key_123"

# 5. Использование ADD вместо COPY для обычных файлов
ADD . /

# 6. Установка зависимостей после копирования всего кода (ломает кэш сборки)
RUN pip3 install -r requirements.txt

# 7. Запуск от суперпользователя - по умолчанию
CMD ["python3", "app.py"]