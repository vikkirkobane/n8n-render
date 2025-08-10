# Use the official n8n image as base
FROM n8nio/n8n:latest

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Keep original n8n entrypoint
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["tini -- /docker-entrypoint.sh"]