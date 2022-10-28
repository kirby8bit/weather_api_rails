# Weather api

<p align="center">
      <a href="https://ibb.co/T8xLq9j"><img src="https://i.ibb.co/KqpwzT4/kisspng-weather-forecasting-computer-icons-weather-5ace7698320550-2720845715234802162049.png" alt="kisspng-weather-forecasting-computer-icons-weather-5ace7698320550-2720845715234802162049" border="0" width="100"/></a>
</p>

<p align="center">
   <img src="https://img.shields.io/badge/ruby%20version-3.1.2-green" alt="Ruby Version">
   <img src="https://img.shields.io/badge/rails%20version-7.0.4-brightgreen" alt="Rails Version">
</p>

Как источник данных можно использовать https://developer.accuweather.com/apis. Город можно использовать любой (можно захардкодить). Законченный код передать в виде приватного репозитория на GitHub. API открыт для всех, авторизация не нужна. Ожидаемая нагрузка на любой эндпоинт: 5 RPS

### Endpoints:

* wheather/current - Текущая температура

* /wheather/historical - Почасовая температура за последние 24 часа [ссылка](https://developer.accuweather.com/accuweather-current-conditions-api/apis/get/currentconditions/v1/%7BlocationKey%7D/historical/24)

* /wheather/historical/max - Максимальная темперетура за 24 часа

* /wheather/historical/min - Минимальная темперетура за 24 часа

* /wheather/historical/avg - Средняя темперетура за 24 часа

* /wheather/by_time - Найти температуру ближайшую к переданному timestamp (например 1621823790 должен отдать температуру за 2021-05-24 08:00. Из имеющихся данных, если такого времени нет вернуть 404)

* /health - Статус бекенда (Можно всегда отвечать OK)

Должны быть интеграционные тесты на эндпоинты и юнит тесты на общие классы/модули. Рекомендуется хранить данные о температуре локально для снижения нагрузки на сторонний API.

Приветствуется использование swagger документации, Docker, использование кэширования и Trailblazer.

### Ruby version

```
ruby 3.1.2
```

### Rails version

```
rails 7.0.4
```

Postgresql version

```
PostgreSQL 12.9
```

## Первый запуск

```
gem install bundler
bundle install
bundle exec rails db:create
bundle exec rails db:migrate
copy .env.template .env
```

Заполнить переменные окружения в `.env`

### Загрузить данные с [AccuWeather](https://developer.accuweather.com/)

```
bundle exec rake indications:update
```

### Запуск сервера

```
bundle exec rails s
```

### Тесты

```
bundle exec rspec
```

## Документация API

Примеры запросов доступны по адресу http://localhost:3000/api-docs
