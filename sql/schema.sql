
CREATE TABLE IF NOT EXISTS regions (
                                       id SERIAL PRIMARY KEY,
                                       name VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS cities (
                                      id SERIAL PRIMARY KEY,
                                      region_id INT NOT NULL REFERENCES regions(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL
    );

CREATE TABLE IF NOT EXISTS streets (
                                       id SERIAL PRIMARY KEY,
                                       city_id INT NOT NULL REFERENCES cities(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL
    );


-- Regions
INSERT INTO regions (name) VALUES
                               ('Московская область'),
                               ('Ленинградская область'),
                               ('Новосибирская область'),
                               ('Свердловская область'),
                               ('Краснодарский край'),
                               ('Республика Татарстан'),
                               ('Республика Башкортостан'),
                               ('Ростовская область'),
                               ('Воронежская область'),
                               ('Самарская область')
    ON CONFLICT DO NOTHING;

-- Cities
INSERT INTO cities (region_id, name) VALUES
                                         ((SELECT id FROM regions WHERE name='Московская область'), 'Москва'),
                                         ((SELECT id FROM regions WHERE name='Московская область'), 'Химки'),
                                         ((SELECT id FROM regions WHERE name='Московская область'), 'Королев'),
                                         ((SELECT id FROM regions WHERE name='Ленинградская область'), 'Санкт-Петербург'),
                                         ((SELECT id FROM regions WHERE name='Ленинградская область'), 'Всеволожск'),
                                         ((SELECT id FROM regions WHERE name='Новосибирская область'), 'Новосибирск'),
                                         ((SELECT id FROM regions WHERE name='Новосибирская область'), 'Бердск'),
                                         ((SELECT id FROM regions WHERE name='Свердловская область'), 'Екатеринбург'),
                                         ((SELECT id FROM regions WHERE name='Свердловская область'), 'Нижний Тагил'),
                                         ((SELECT id FROM regions WHERE name='Краснодарский край'), 'Краснодар'),
                                         ((SELECT id FROM regions WHERE name='Краснодарский край'), 'Сочи'),
                                         ((SELECT id FROM regions WHERE name='Республика Татарстан'), 'Казань'),
                                         ((SELECT id FROM regions WHERE name='Республика Татарстан'), 'Набережные Челны'),
                                         ((SELECT id FROM regions WHERE name='Республика Башкортостан'), 'Уфа'),
                                         ((SELECT id FROM regions WHERE name='Ростовская область'), 'Ростов-на-Дону'),
                                         ((SELECT id FROM regions WHERE name='Воронежская область'), 'Воронеж'),
                                         ((SELECT id FROM regions WHERE name='Самарская область'), 'Самара')
    ON CONFLICT DO NOTHING;

-- Streets
INSERT INTO streets (city_id, name) VALUES
                                        ((SELECT id FROM cities WHERE name='Москва'), 'Арбат'),
                                        ((SELECT id FROM cities WHERE name='Москва'), 'Тверская'),
                                        ((SELECT id FROM cities WHERE name='Москва'), 'Лубянка'),
                                        ((SELECT id FROM cities WHERE name='Химки'), 'Ленинградская'),
                                        ((SELECT id FROM cities WHERE name='Химки'), 'Молодёжная'),
                                        ((SELECT id FROM cities WHERE name='Королев'), 'Пионерская'),
                                        ((SELECT id FROM cities WHERE name='Санкт-Петербург'), 'Невский проспект'),
                                        ((SELECT id FROM cities WHERE name='Санкт-Петербург'), 'Литейный'),
                                        ((SELECT id FROM cities WHERE name='Всеволожск'), 'Московская'),
                                        ((SELECT id FROM cities WHERE name='Новосибирск'), 'Красный проспект'),
                                        ((SELECT id FROM cities WHERE name='Новосибирск'), 'Ленина'),
                                        ((SELECT id FROM cities WHERE name='Бердск'), 'Советская'),
                                        ((SELECT id FROM cities WHERE name='Екатеринбург'), 'Ленина'),
                                        ((SELECT id FROM cities WHERE name='Екатеринбург'), 'Малышева'),
                                        ((SELECT id FROM cities WHERE name='Нижний Тагил'), 'Гагарина'),
                                        ((SELECT id FROM cities WHERE name='Краснодар'), 'Красная'),
                                        ((SELECT id FROM cities WHERE name='Краснодар'), 'Чехова'),
                                        ((SELECT id FROM cities WHERE name='Сочи'), 'Навагинская'),
                                        ((SELECT id FROM cities WHERE name='Казань'), 'Баумана'),
                                        ((SELECT id FROM cities WHERE name='Казань'), 'Пушкина'),
                                        ((SELECT id FROM cities WHERE name='Набережные Челны'), 'Мира'),
                                        ((SELECT id FROM cities WHERE name='Уфа'), 'Ленина'),
                                        ((SELECT id FROM cities WHERE name='Уфа'), 'Комсомольская'),
                                        ((SELECT id FROM cities WHERE name='Ростов-на-Дону'), 'Станиславского'),
                                        ((SELECT id FROM cities WHERE name='Ростов-на-Дону'), 'Будённого'),
                                        ((SELECT id FROM cities WHERE name='Воронеж'), 'Фридриха Энгельса'),
                                        ((SELECT id FROM cities WHERE name='Воронеж'), 'Кольцовская'),
                                        ((SELECT id FROM cities WHERE name='Самара'), 'Куйбышева'),
                                        ((SELECT id FROM cities WHERE name='Самара'), 'Галактионовская')
    ON CONFLICT DO NOTHING;

