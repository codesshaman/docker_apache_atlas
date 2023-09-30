1. Скачать репозиторий и перейти в папку.

2. Править docker-compose.yml, указав внизу правильный путь к volumes (папки должны существовать в системе).

3. Запустить билд контейнера:

- в unix: ``make build``
- windows: ``docker-compose up -d --build``

После успешного билда в папке, которая смонтирована в /tmp/atlas_src появится исходный код apache atlas, папка смонтированная в локальный репозиторий m2 будет пуста.

4. Перейти внутрь контейнера:

- в unix: ``make connect``
- windows: ``docker exec -it apache_atlas bash``

5. Находясь внутри контейнера, перейти в /tmp/atlas_src:

``cd /tmp/atlas_src``

Здесь можно править pom.xml, подкидывать репозитории. А можно делать это извне в примонтированной папке (в юникс с рут правами)

Можно так же копировать pom.xml из корня данного репозитория. В нём есть ряд изменений, перепробовал разные репозитории.

6. Выполнить внутри /tmp/atlas_src команду для сборки. Например:

```
mvn -U \
-DskipTests \
-Drat.skip=true \
-Drat.numUnapprovedLicenses=200 \
-Dmaven.wagon.http.ssl.insecure=true \
-Dmaven.wagon.http.ssl.ignore.validity.dates=true \
clean install
```

В результате билда в volume примонтированном к разделу .m2/repository появятся локальные пакеты.
