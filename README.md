# Projeto: n8n + AWS CLI com Docker & Terraform

Este projeto demonstra a automação de fluxos utilizando n8n e AWS CLI em um container Docker provisionado via Terraform na AWS.

## Recursos

- **Infraestrutura automatizada:** Instância EC2 (`t2.micro`) criada e configurada com Terraform.
- **Container customizado:** Integração do n8n com AWS CLI para automações.
- **Persistência de dados:** Volume Docker para armazenamento dos dados do n8n.
- **Monitoramento:** Logs detalhados para acompanhamento e depuração.

## Como executar

1. Clone este repositório.
2. Configure suas credenciais AWS.
3. Execute os comandos abaixo:
    ```sh
    terraform init
    terraform apply
    ```
4. Acesse a aplicação: `http://<IP-da-instância>:5678`

## Pré-requisitos

- [Terraform](https://www.terraform.io/)
- Conta AWS com permissão para EC2

