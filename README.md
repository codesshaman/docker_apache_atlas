1. Скачать репозиторий и перейти в папку.

2. Править docker-compose.yml, указав внизу правильный путь к volume (папка должна существовать в системе).

3. Запустить билд контейнера:

- в unix: ``make build``
- windows: ``docker-compose up -d --build``

После успешного билда в папке, которая смонтирована в volume появится исходный код apache atlas

4. Перейти внутрь контейнера:

- в unix: ``make connect``
- windows: ``docker exec -it apache_atlas bash``

5. Находясь внутри контейнера, перейти в /tmp/atlas_src:

``cd /tmp/atlas_src``

Здесь можно править pom.xml, подкидывать репозитории. А можно делать это извне в примонтированной папке (в юникс с рут правами)

6. Выполнить внутри /tmp/atlas_src команду для сборки. Например:

``mvn -DskipTests -Dmaven.wagon.http.ssl.ignore.validity.dates=true -Dmaven.wagon.http.ssl.allowall=true -Dmaven.wagon.http.ssl.insecure=true clean install -U -Drat.numUnapprovedLicenses=200``