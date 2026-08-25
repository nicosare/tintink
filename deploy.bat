@echo off
chcp 65001 > nul
echo --------------------------------------------------
echo  Отправка обновлений Tintink на сервер Рег.ру...
echo --------------------------------------------------

:: Точка входа + исходники бэкенда
scp index.js root@195.208.3.48:/root/tintink-backend/
scp -r src root@195.208.3.48:/root/tintink-backend/
scp package.json root@195.208.3.48:/root/tintink-backend/

:: Фронтенд целиком (html / css / js)
scp -r public root@195.208.3.48:/root/tintink-backend/

echo --------------------------------------------------
echo  Перезапуск игрового бэкенда через PM2...
echo --------------------------------------------------
ssh root@195.208.3.48 "pm2 restart tintink-backend"

echo --------------------------------------------------
echo  Деплой успешно завершен! Сайт tintink.ru обновлен.
echo --------------------------------------------------
pause
