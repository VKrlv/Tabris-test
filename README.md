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

Фронт сразу будет доступен: http://localhost:8080
