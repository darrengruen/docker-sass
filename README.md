# Docker Sass

Run sass in a docker container

See the [sass Homepage](http://sass-lang.com/) for more info

## Usage

```shell
docker run -it --rm \
    -v "${PWD}":/sass \
    -v /etc/localtime:/etc/localtime:ro \
    --user "$(id -u):$(id -g)" \
    --name sass_"$(date -u +%s)" \
    gruen/sass [options] {INPUT} {OUTPUT}
```

Run all commands you would with it installed locally

`sass [options] [INPUT] [OUTPUT]`

For convenince you can add a shell function in your path. Something like:

```shell
sass(){
    docker run -it --rm \
        -v [path/to/sass/dir]:/sass \
        --name sass \
        gruen/sass:[tag] \
            "${@}"
}
```

Restart your terminal.

Once updated you should be able to run `sass -v` and see something like `Sass 3.5.5 (Bleeding Edge)`

