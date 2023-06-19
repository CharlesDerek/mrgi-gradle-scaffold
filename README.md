# Gradle Docker pre-athernex implimentation:

##      To run the project

```bash
docker-compose up
```

And then visit http://localhost:<SPRING_LOCAL_PORT> in your browser.


<br>

---

# Old MRGI-Portal implementation:

##      Create a multi-stage docker image

    To compile and package using Docker multi-stage builds

    ```bash
    cd springbootapp; docker build . -t this-is-a-test;
    ```

##      Create a Docker image packaging an existing jar

    ```bash
    cd springbootapp; ./gradlew build; docker build . -t this-is-a-pre-packaged-test -f Dockerfile.only-package;
    ```

##      To run the docker image

    ```bash
    cd springbootapp; docker run -p 8080:8080 this-is-a-test;
    ```

    And then visit http://localhost:8080 in your browser.

##      To use this project at Athernex and MRGI Project - Gradle Scaffold

    More details can be found in [Athernex documentation](https://athernex.com/documentation/index/)

    Notes {
        State: 200
    }
