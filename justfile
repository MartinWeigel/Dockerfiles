REPOSITORY := 'docker.io/martinweigel'
TAG := `date +'%Y-%m'`

[private]
@default:
    just --list

# Builds all images
build: build-graphviz build-plantuml build-texlive build-ytdlp
    echo "Finished building all images"

# Builds graphviz image
build-graphviz:
    podman build --no-cache -t {{REPOSITORY}}/graphviz:{{TAG}} -f Dockerfile-graphviz
    podman tag {{REPOSITORY}}/graphviz:{{TAG}} {{REPOSITORY}}/graphviz:latest

# Builds plantuml image
build-plantuml:
    podman build --no-cache -t {{REPOSITORY}}/plantuml:{{TAG}} -f Dockerfile-plantuml
    podman tag {{REPOSITORY}}/plantuml:{{TAG}} {{REPOSITORY}}/plantuml:latest

# Builds texlive image
build-texlive:
    podman build --no-cache -t {{REPOSITORY}}/texlive:{{TAG}} -f Dockerfile-texlive
    podman tag {{REPOSITORY}}/texlive:{{TAG}} {{REPOSITORY}}/texlive:latest

# Builds ytdlp image
build-ytdlp:
    podman build --no-cache -t localhost/ytdlp:latest -f Dockerfile-ytdlp


# Pushes all current images (requires `just build`!)
push: push-graphviz push-plantuml push-texlive
    echo "Finished pushing all images"

# Pushes current graphviz image (requires build!)
push-graphviz: login
    podman push {{REPOSITORY}}/graphviz:{{TAG}} {{REPOSITORY}}/graphviz:{{TAG}}
    podman push {{REPOSITORY}}/graphviz:latest {{REPOSITORY}}/graphviz:latest

# Pushes current plantuml image (requires build!)
push-plantuml: login
    podman push {{REPOSITORY}}/plantuml:{{TAG}} {{REPOSITORY}}/plantuml:{{TAG}}
    podman push {{REPOSITORY}}/plantuml:latest {{REPOSITORY}}/plantuml:latest

# Pushes current texlive image (requires build!)
push-texlive: login
    podman push {{REPOSITORY}}/texlive:{{TAG}} {{REPOSITORY}}/texlive:{{TAG}}
    podman push {{REPOSITORY}}/texlive:latest {{REPOSITORY}}/texlive:latest

[private]
login:
    podman login -u martinweigel docker.io
