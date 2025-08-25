# n8n + AWS CLI via Docker & Terraform

Automatize fluxos com n8n e AWS CLI em um container Docker provisionado via Terraform na AWS.

## Principais Recursos

- **Infraestrutura automatizada:** EC2 (tipo: `t2.micro`) criada e configurada com Terraform.
- **Container customizado:** n8n + AWS CLI para automações integradas.
- **Persistência:** Dados do n8n salvos em volume Docker.
- **Logs detalhados:** Facilita monitoramento e depuração.

## Como Usar

1. Clone o repositório.
2. Configure suas credenciais AWS.
3. Execute:
    ```sh
    terraform init
    terraform apply
    ```
4. Acesse: `http://<IP-da-instância>:5678`

## Pré-requisitos

- [Terraform](https://www.terraform.io/)
- Conta AWS com permissão para EC2

