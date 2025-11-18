# Адреса (Regions / Cities / Streets)

## Как запустить

Поднять контейнеры и собрать фронт:

```bash
docker compose up -d --build
```

## Контейнеры:

db — PostgreSQL с тестовыми данными

php — API на PHP (MVC)

nginx — отдаёт фронт и проксирует API

node — сборка Vue-фронта 

Фронт будет доступен без доп.действий, но не сразу (пока не загрузятся node_modules): http://localhost:8080
<img width="1200" height="634" alt="image" src="https://github.com/user-attachments/assets/338ffb90-addc-4318-aa3a-4bd97e094c61" />
