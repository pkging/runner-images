# Runner Image Publish

Dieses Repo baut und publisht das ARC Runner-Image nach GHCR.

## Dateien

- Dockerfile
- .github/workflows/publish-runner-image.yml

## Image

- ghcr.io/lbetz/runner-images/actions-runner-homelab:latest

## Publish-Workflow

Der Workflow publisht bei:

- Push auf main mit Aenderungen an Dockerfile oder dem Workflow
- workflow_dispatch (manuell)

Authentifizierung erfolgt ueber das eingebaute GitHub Token (`github.token`).

Voraussetzung im Repo:

- Settings -> Actions -> General -> Workflow permissions = Read and write permissions

## Lokal testen

```bash
docker build -t ghcr.io/lbetz/runner-images/actions-runner-homelab:latest .
```

## Hinweise

- Das Image ist fuer ARC dind-Betrieb gedacht.
- Fuer reproduzierbare Rollouts in k3s kann statt `latest` ein SHA-Tag aus dem Workflow verwendet werden.
