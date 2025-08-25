# n8n + AWS CLI Docker Container via Terraform

Este projeto utiliza Terraform para provisionar uma instância EC2 na AWS que executa um container Docker com o [n8n](https://n8n.io/) e o AWS CLI instalados.

## Funcionalidades

- **Provisionamento automatizado:** Utiliza Terraform para criar e configurar a infraestrutura na AWS.
- **Container customizado:** O container inclui o n8n e o AWS CLI, permitindo automações que interagem diretamente com serviços AWS.
- **Persistência de dados:** Os dados do n8n são armazenados em um volume Docker.
- **Logs detalhados:** Toda a configuração é registrada para facilitar depuração.

## Como funciona

1. O Terraform cria uma instância EC2 e aplica um script de inicialização (user-data).
2. O script instala Docker, Docker Compose e configura o ambiente.
3. Um Dockerfile customizado instala o AWS CLI dentro do container n8n.
4. O docker-compose.yml define o serviço n8n, expõe a porta 5678 e monta o volume de dados.
5. O container é iniciado automaticamente.

## Pré-requisitos

- [Terraform](https://www.terraform.io/)
- Conta AWS com permissões para criar recursos EC2

## Uso

1. Clone este repositório.
2. Configure suas credenciais AWS.
3. Execute `terraform init` e `terraform apply`.
4. Acesse o n8n via `http://<IP-da-instância>:5678`.

