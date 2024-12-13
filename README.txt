docker compose build

docker-compose up

docker-compose run web bin/rails db:migrate

docker-compose run web bin/rails db:fixtures:load

docker-compose up


docker-compose down


SELECT * FROM users;
SELECT * FROM productos;
SELECT * FROM carritos;