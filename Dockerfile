FROM ghcr.io/actions/actions-runner:latest

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      curl \
      git \
      gnupg \
      jq \
      python3 \
      python3-pip \
      python3-venv \
      rpm \
      software-properties-common \
      sudo \
      docker.io \
      qemu-user-static \
      binfmt-support \
      debsigs && \
    (apt-get install -y --no-install-recommends dpkg-sig || true) && \
    rm -rf /var/lib/apt/lists/*

# Keep behavior consistent with VM bootstrap: passwordless sudo and docker group membership.
RUN echo "runner ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-github-runner && \
    chmod 0440 /etc/sudoers.d/90-github-runner && \
    groupadd -f docker && \
    usermod -aG docker runner

USER runner

ENTRYPOINT ["/home/runner/run.sh"]
