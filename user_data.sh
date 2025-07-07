#!/bin/bash

# Redireciona toda a saída para um arquivo de log para depuração
exec > /home/ubuntu/user-data.log 2>&1
echo "Iniciando script user-data..."

# Atualiza os pacotes e instala Docker e Docker Compose
echo "Atualizando pacotes e instalando Docker..."
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker ubuntu
echo "Docker instalado e habilitado. Usuário 'ubuntu' adicionado ao grupo 'docker'."

echo "Instalando Docker Compose..."
sudo apt install docker-compose -y
echo "Docker Compose instalado."

# Muda para o diretório onde os arquivos Dockerfile e docker-compose.yml serão criados
echo "Mudando para o diretório /home/ubuntu..."
cd /home/ubuntu || { echo "Falha ao mudar para /home/ubuntu. Saindo."; exit 1; }
echo "Diretório atual: $(pwd)"

# Cria o Dockerfile
echo "Criando Dockerfile..."
cat > Dockerfile <<EOF
FROM n8nio/n8n:latest

# Trocar para root temporariamente para instalar
USER root

# Instalar dependências e awscli em venv
RUN apk add --no-cache \\
      curl \\
      unzip \\
      python3 \\
      py3-pip && \\
    python3 -m venv /home/node/awscli-venv && \\
    /home/node/awscli-venv/bin/pip install --no-cache-dir awscli && \\
    chown -R node:node /home/node/awscli-venv

# Volta para o usuário padrão "node"
USER node

# Atalho opcional: tornar aws acessível sempre ao entrar no container
ENV PATH="/home/node/awscli-venv/bin:\$PATH"
EOF
echo "Dockerfile criado."

# Cria o docker-compose.yml
echo "Criando docker-compose.yml..."
cat > docker-compose.yml <<EOF
version: "3.8"

services:
  n8n:
    build: .
    container_name: n8n
    ports:
      - "5678:5678"
    environment:
      - N8N_SECURE_COOKIE=false
    volumes:
      - n8n_data:/home/node/.n8n
    restart: unless-stopped

volumes:
  n8n_data:
EOF
echo "docker-compose.yml criado."

# Constrói a imagem e inicia o contêiner n8n
echo "Construindo imagem Docker e iniciando o serviço n8n..."
sudo docker-compose up -d
if [ $? -eq 0 ]; then
    echo "n8n iniciado com sucesso!"
else
    echo "ERRO: Falha ao iniciar n8n com docker-compose."
fi

echo "Script user-data concluído."