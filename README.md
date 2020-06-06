# ubuntu-elixir-build-release

## Build Docker Image

```console
$ docker build -t elixir-ubuntu:latest .
```

You can choose elixir or erlang version for this image by changing ```ERLANG_VERSION``` , ```ELIXIR_VERSION``` env in Dockerfile

## Run building script in container

```console
$ docker run -v $(pwd):/opt/build/build-elixir --rm -it elixir-ubuntu:latest /opt/build/build-elixir/build 
```

produced release tarball in ```rel/artifacts```