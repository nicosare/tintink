-- Tintink schema
-- Пользователи: логин, хеш пароля, валюта (капли / блеск)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    drops INT DEFAULT 100,   -- капли энергии для рисования
    sparkles INT DEFAULT 0   -- резерв под будущую премиум-валюту
);

-- Острова: размеры карты в клетках
CREATE TABLE IF NOT EXISTS islands (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    width INT DEFAULT 128,
    height INT DEFAULT 128
);

-- Пиксели: одна клетка на острове (уникальный индекс по координатам)
CREATE TABLE IF NOT EXISTS pixels (
    id SERIAL PRIMARY KEY,
    island_id INT REFERENCES islands(id) ON DELETE CASCADE,
    x INT NOT NULL,
    y INT NOT NULL,
    color VARCHAR(7) NOT NULL,  -- #RRGGBB
    user_id INT REFERENCES users(id),
    placed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_island_coordinates ON pixels(island_id, x, y);

-- Стартовый остров (id=1) — клиент по умолчанию грузит его
INSERT INTO islands (id, name, width, height)
VALUES (1, 'Тихий Берег', 128, 128)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

-- Чистый холст: старые рисунки удаляются при миграции/ините
DELETE FROM pixels WHERE island_id = 1;
