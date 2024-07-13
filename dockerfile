FROM alpine:latest

RUN apk add --no-cache git openssh-client git-lfs

# Configure SSH
RUN mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh

# Copy your SSH private and public key into the container
COPY id_ed25519 /root/.ssh/id_ed25519
COPY id_ed25519.pub /root/.ssh/id_ed25519.pub
RUN chmod 600 /root/.ssh/id_ed25519 && \
    chmod 644 /root/.ssh/id_ed25519.pub

# Add known hosts to prevent man-in-the-middle attacks
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

# Install and configure Git LFS
RUN git lfs install

WORKDIR /workspace
