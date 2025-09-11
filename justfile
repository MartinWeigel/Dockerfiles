REPOSITORY := 'docker.io/martinweigel'
TAG := `date +'%Y-%m'`
HUGO_VERSION := '0.150.0'

[private]
@default:
    just --list

[private]
login:
    podman login -u martinweigel docker.io


# Builds charts image
build-charts:
    podman build --no-cache -t {{REPOSITORY}}/charts:{{TAG}} -f Dockerfile-charts
    podman tag {{REPOSITORY}}/charts:{{TAG}} {{REPOSITORY}}/charts:latest

# Pushes current charts image (requires build!)
push-charts: login
    podman push {{REPOSITORY}}/charts:{{TAG}}
    podman push {{REPOSITORY}}/charts:latest


# Builds hugo image
build-hugo:
    podman build --no-cache -t {{REPOSITORY}}/hugo:{{HUGO_VERSION}} --build-arg HUGO_VERSION={{HUGO_VERSION}} -f Dockerfile-hugo
    podman tag {{REPOSITORY}}/hugo:{{HUGO_VERSION}} {{REPOSITORY}}/hugo:latest

# Pushes current hugo image (requires build!)
push-hugo: login
    podman push {{REPOSITORY}}/hugo:{{HUGO_VERSION}} {{REPOSITORY}}/hugo:{{HUGO_VERSION}}
    podman push {{REPOSITORY}}/hugo:latest {{REPOSITORY}}/hugo:latest


# Builds texlive image
build-texlive:
    podman build --no-cache -t {{REPOSITORY}}/texlive:{{TAG}} -f Dockerfile-texlive
    podman tag {{REPOSITORY}}/texlive:{{TAG}} {{REPOSITORY}}/texlive:latest

# Pushes current texlive image (requires build!)
push-texlive: login
    podman push {{REPOSITORY}}/texlive:{{TAG}} {{REPOSITORY}}/texlive:{{TAG}}
    podman push {{REPOSITORY}}/texlive:latest {{REPOSITORY}}/texlive:latest


# Builds ytdlp image
build-ytdlp:
    podman build --no-cache -t localhost/ytdlp:{{TAG}} -f Dockerfile-ytdlp
    podman tag localhost/ytdlp:{{TAG}} localhost/ytdlp:latest
