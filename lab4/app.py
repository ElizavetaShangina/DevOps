import hvac

client = hvac.Client(url='http://localhost:8200', token='my-root-token')
if client.is_authenticated():
    print("Успешная авторизация в Vault!")
read_response = client.secrets.kv.read_secret_version(path='my-app-db')
db_password = read_response['data']['data']['password']
masked_password = f"{db_password[0]}{'*' * (len(db_password)-2)}{db_password[-1]}"
print(f"Подключение к базе данных установлено.")
print(f"Используемый пароль (masked): {masked_password}")